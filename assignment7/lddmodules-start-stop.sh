#!/bin/sh
#
# /etc/init.d/S98lddmodules
#

case "$1" in
    start)
        echo "Loading LDD modules..."

        # hello module
        modprobe hello || exit 1

        # faulty module via provided script
        if [ -x /usr/bin/ldd/module_load ]; then
            /usr/bin/ldd/module_load faulty || exit 1
        else
            echo "module_load script not found"
            exit 1
        fi

        # scull module via provided script
        if [ -x /usr/bin/ldd/scull_load ]; then
            /usr/bin/ldd/scull_load || exit 1
        else
            echo "scull_load script not found"
            exit 1
        fi
        ;;

    stop)
        echo "Unloading LDD modules..."

        # reverse order is usually safer
        if [ -x /usr/bin/ldd/scull_unload ]; then
            /usr/bin/ldd/scull_unload || true
        fi

        if [ -x /usr/bin/ldd/module_unload ]; then
            /usr/bin/ldd/module_unload faulty || true
        fi

        rmmod hello 2>/dev/null || true
        ;;

    restart)
        $0 stop
        $0 start
        ;;

    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac

exit 0

