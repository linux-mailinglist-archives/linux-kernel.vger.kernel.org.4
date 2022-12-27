Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1F0657052
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 23:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiL0Wwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 17:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiL0Wwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 17:52:50 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0569C626E;
        Tue, 27 Dec 2022 14:52:49 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id i26-20020a9d68da000000b00672301a1664so8976110oto.6;
        Tue, 27 Dec 2022 14:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Hy02dE9rUJFK6kI8PzR+c6B4NEehbSa+E54dKo42Ls=;
        b=omEAKLbnaMB5Q6uXkqjaKumEc4FYd5ljft5nWM/cPwvSpXPKuq8y7ee6b8RKl+kOet
         b3gbYAYs1Omev/M8tEvUl3uwihvfyG+142ioXd0M9fsNt01Furx4UhgBJRc92iuGKsbE
         WUVyWueoGAzlLyiDTZzLX9yAFPFgC3w0yA60q/q5Nf4BKmURsiZ/nRP40gj7aF0Lh3bs
         Y2i46nwQN6WKPyCGj1TdqwuMCxPoPktGuRybp7FjyOtJaB0Y7pN7TPKSk28j24D4QU3h
         zXsCsVxJcmFmsIIAWDidBmjUrbxKVeaYcTEnWIkJuyLiARkkge0gKKAro+bAwFCjaXH/
         y4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Hy02dE9rUJFK6kI8PzR+c6B4NEehbSa+E54dKo42Ls=;
        b=hqAe9/cl0HfZEnAr6zA4DNm+wNhWv3ouhX24Uiaxf1+euG1zbMtQXaJDGCedAMjgB5
         WUQojrkiU9/egvMvFPotQJKZb7KWVvf4cKfIb8JjNKJfIHEda79L2gapmpX6D002Mugb
         vXEcFCjrnEnnTcklTZs+d0DM5s/Spz5jpet5gP4AkDStPPiNT8Gejz5DPbswYj97mZyZ
         QSwF/kHHepCqSemxd0cLa3yJDvRTH2A4WE2XSa7E7GINb7aB9HiD+qSPuyf6vdzLqhEf
         M33qrWrn+JGYljMpWZQ9d47UM5ceWsK89TZC2DYd6snGFLC6a3lGYT9IoNKieJLbR4gf
         Thdg==
X-Gm-Message-State: AFqh2kpOcMVTPhuYfJH0MxXaWvYvMZ+kx+/Bpo6zy1z0EnGPUXwvzGpP
        cgotjHPK+lZCaqY87AQ1ssY=
X-Google-Smtp-Source: AMrXdXvqJYs9C3EXhAatiehIjcgyIikexp4FnTFUQwiYEOfVFMyO15slPqL2+/rP3FpAn0tBmP03PQ==
X-Received: by 2002:a05:6830:2681:b0:683:f753:ee1 with SMTP id l1-20020a056830268100b00683f7530ee1mr2557006otu.5.1672181568254;
        Tue, 27 Dec 2022 14:52:48 -0800 (PST)
Received: from ian.penurio.us (192-063-109-134.res.spectrum.com. [192.63.109.134])
        by smtp.gmail.com with ESMTPSA id z7-20020a9d65c7000000b00661a3f4113bsm7105773oth.64.2022.12.27.14.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 14:52:48 -0800 (PST)
From:   Ian Pilcher <arequipeno@gmail.com>
To:     pavel@ucw.cz, lee@kernel.org
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        kabel@kernel.org
Subject: [PATCH v13 1/2] docs: Add block device (blkdev) LED trigger documentation
Date:   Tue, 27 Dec 2022 16:52:25 -0600
Message-Id: <20221227225226.546489-2-arequipeno@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221227225226.546489-1-arequipeno@gmail.com>
References: <20221227225226.546489-1-arequipeno@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Documentation/ABI/testing/sysfs-class-led-trigger-blkdev to
document:

  * /sys/class/leds/<led>/blink_time
  * /sys/class/leds/<led>/check_interval
  * /sys/class/leds/<led>/blink_on_{read,write,discard,flush}
  * /sys/class/leds/<led>/link_dev_by_path
  * /sys/class/leds/<led>/unlink_dev_by_path
  * /sys/class/leds/<led>/unlink_dev_by_name
  * /sys/class/leds/<led>/linked_devices

Add /sys/block/<disk>/linked_leds to
Documentation/ABI/stable/sysfs-block.

Add overview in Documentation/leds/ledtrig-blkdev.rst.

Signed-off-by: Ian Pilcher <arequipeno@gmail.com>
---
 Documentation/ABI/stable/sysfs-block          |  10 ++
 .../testing/sysfs-class-led-trigger-blkdev    |  78 +++++++++
 Documentation/leds/index.rst                  |   1 +
 Documentation/leds/ledtrig-blkdev.rst         | 158 ++++++++++++++++++
 4 files changed, 247 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-blkdev
 create mode 100644 Documentation/leds/ledtrig-blkdev.rst

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index cd14ecb3c9a5..ad47337ac75a 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -101,6 +101,16 @@ Description:
 		devices that support receiving integrity metadata.
 
 
+What:		/sys/block/<disk>/linked_leds
+Date:		January 2023
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Directory that contains symbolic links to all LEDs that
+		are associated with (linked to) this block device by the
+		blkdev LED trigger.  Only present when at least one LED
+		is linked.  (See Documentation/leds/ledtrig-blkdev.rst.)
+
+
 What:		/sys/block/<disk>/<partition>/alignment_offset
 Date:		April 2009
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-blkdev b/Documentation/ABI/testing/sysfs-class-led-trigger-blkdev
new file mode 100644
index 000000000000..28ce8c814fb7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-blkdev
@@ -0,0 +1,78 @@
+What:		/sys/class/leds/<led>/blink_time
+Date:		January 2023
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Time (in milliseconds) that the LED will be on during a single
+		"blink".
+
+What:		/sys/class/leds/<led>/check_interval
+Date:		January 2023
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Interval (in milliseconds) between checks of the block devices
+		linked to this LED.  The LED will be blinked if the correct type
+		of activity (see blink_on_{read,write,discard,flush} attributes)
+		has occurred on any of the linked devices since the previous
+		check.
+
+What:		/sys/class/leds/<led>/blink_on_read
+Date:		January 2023
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Boolean that determines whether the LED will blink in response
+		to read activity on any of its linked block devices.
+
+What:		/sys/class/leds/<led>/blink_on_write
+Date:		January 2023
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Boolean that determines whether the LED will blink in response
+		to write activity on any of its linked block devices.
+
+What:		/sys/class/leds/<led>/blink_on_discard
+Date:		January 2023
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Boolean that determines whether the LED will blink in response
+		to discard activity on any of its linked block devices.
+
+What:		/sys/class/leds/<led>/blink_on_flush
+Date:		January 2023
+Contact:	Ian Pilcher <arequipeno@gamil.com>
+Description:
+		Boolean that determines whether the LED will blink in response
+		to cache flush activity on any of its linked block devices.
+
+What:		/sys/class/leds/<led>/link_dev_by_path
+Date:		January 2023
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Associate a block device with this LED by writing the path to
+		the device special file (e.g. /dev/sda) to this attribute.
+		Symbolic links are followed.
+
+What:		/sys/class/leds/<led>/unlink_dev_by_path
+Date:		January 2023
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Remove the association between this LED and a block device by
+		writing the path to the device special file (e.g. /dev/sda) to
+		this attribute.  Symbolic links are followed.
+
+What:		/sys/class/leds/<led>/unlink_dev_by_name
+Date:		January 2023
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Remove the association between this LED and a block device by
+		writing the kernel name of the device (e.g. sda) to this
+		attribute.
+
+What:		/sys/class/leds/<led>/linked_devices
+Date:		January 2023
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Directory containing links to all block devices that are
+		associated with this LED.  (Note that the names of the
+		symbolic links in this directory are *kernel* names, which
+		may not match the device special file paths written to
+		link_device and unlink_device.)
diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index e5d63b940045..e3c24e468cbc 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -10,6 +10,7 @@ LEDs
    leds-class
    leds-class-flash
    leds-class-multicolor
+   ledtrig-blkdev
    ledtrig-oneshot
    ledtrig-transient
    ledtrig-usbport
diff --git a/Documentation/leds/ledtrig-blkdev.rst b/Documentation/leds/ledtrig-blkdev.rst
new file mode 100644
index 000000000000..9ff5b99de451
--- /dev/null
+++ b/Documentation/leds/ledtrig-blkdev.rst
@@ -0,0 +1,158 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
+Block Device (blkdev) LED Trigger
+=================================
+
+Available when ``CONFIG_LEDS_TRIGGER_BLKDEV=y`` or
+``CONFIG_LEDS_TRIGGER_BLKDEV=m``.
+
+See also:
+
+* ``Documentation/ABI/testing/sysfs-class-led-trigger-blkdev``
+* ``Documentation/ABI/stable/sysfs-block`` (``/sys/block/<disk>/linked_leds``)
+
+Overview
+========
+
+.. note::
+	The examples below use ``<LED>`` to refer to the name of a
+	system-specific LED.  If no suitable LED is available on a test
+	system (in a virtual machine, for example), it is possible to
+	use a userspace LED.  (See ``Documentation/leds/uleds.rst``.)
+
+Verify that the ``blkdev`` LED trigger is available::
+
+	# grep blkdev /sys/class/leds/<LED>/trigger
+	... rfkill-none blkdev
+
+(If the previous command produces no output, you may need to load the trigger
+module - ``modprobe ledtrig_blkdev``.  If the module is not available, check
+the value of ``CONFIG_LEDS_TRIGGER_BLKDEV`` in your kernel configuration.)
+
+Associate the LED with the ``blkdev`` LED trigger::
+
+	# echo blkdev > /sys/class/leds/<LED>/trigger
+
+	# cat /sys/class/leds/<LED>/trigger
+	... rfkill-none [blkdev]
+
+Note that several new device attributes are available in the
+``/sys/class/leds/<LED>`` directory.
+
+* ``link_dev_by_path``, ``unlink_dev_by_path``, and ``unlink_dev_by_name`` are
+  used to manage the set of block devices associated with this LED.  The LED
+  will blink when activity occurs on any of its linked devices.
+
+* ``blink_on_read``, ``blink_on_write``, ``blink_on_discard``, and
+  ``blink_on_flush`` are boolean values that determine whether the LED will
+  blink when a particular type of activity is detected on one of its linked
+  block devices.
+
+* ``blink_time`` is the duration (in milliseconds) of each blink of this LED.
+  (The minimum value is 10 milliseconds.)
+
+* ``check_interval`` is the frequency (in milliseconds) with which block devices
+  linked to this LED will be checked for activity and the LED blinked (if the
+  correct type of activity has occurred).
+
+* The ``linked_devices`` directory will contain a symbolic link to every device
+  that is associated with this LED.
+
+Link a block device to the LED::
+
+	# echo /dev/sda > /sys/class/leds/<LED>/link_dev_by_path
+
+	# ls /sys/class/leds/<LED>/linked_devices
+	sda
+
+(The value written to ``link_dev_by_path`` must be the path of the device
+special file, such as ``/dev/sda``, that represents the block device - or the
+path of a symbolic link to such a device special file.)
+
+Activity on the device will now cause the LED to blink.  The duration of each
+blink (in milliseconds) can be adjusted by setting
+``/sys/class/leds/<LED>/blink_time``.  (But see **check_interval and
+blink_time** below.)
+
+Associate a second device with the LED::
+
+	# echo /dev/sdb > /sys/class/leds/<LED>/link_dev_by_path
+
+	# ls /sys/class/leds/<LED>/linked_devices
+	sda  sdb
+
+When a block device is linked to one or more LEDs, the LEDs are linked from
+the device's ``linked_leds`` directory::
+
+	# ls /sys/class/block/sd{a,b}/linked_leds
+	/sys/class/block/sda/linked_leds:
+	<LED>
+
+	/sys/class/block/sdb/linked_leds:
+	<LED>
+
+(The ``linked_leds`` directory only exists when the block device is linked to
+at least one LED.)
+
+``check_interval`` and ``blink_time``
+=====================================
+
+* By default, linked block devices are checked for activity every 100
+  milliseconds.  This frequency can be changed for an LED via the
+  ``/sys/class/leds/<led>/check_interval`` attribute.  (The minimum value is 25
+  milliseconds.)
+
+* All block devices associated with an LED are checked for activity every
+  ``check_interval`` milliseconds, and a blink is triggered if the correct type
+  of activity (as determined by the LED's ``blink_on_*`` attributes) is
+  detected.  The duration of an LED's blink is determined by its ``blink_time``
+  attribute.  Thus (when the correct type of activity is detected), the LED will
+  be on for ``blink_time`` milliseconds and off for
+  ``check_interval - blink_time`` milliseconds.
+
+* The LED subsystem ignores new blink requests for an LED that is already in
+  in the process of blinking, so setting a ``blink_time`` greater than or equal
+  to ``check_interval`` will cause some blinks to be missed.
+
+* Because of processing times, scheduling latencies, etc., avoiding missed
+  blinks actually requires a difference of at least a few milliseconds between
+  the ``blink_time`` and ``check_interval``.  The required difference is likely
+  to vary from system to system.  As a  reference, a Thecus N5550 NAS requires a
+  difference of 7 milliseconds (e.g. ``check_interval == 100``,
+  ``blink_time == 93``).
+
+* The default values (``check_interval == 100``, ``blink_time == 75``) cause the
+  LED associated with a continuously active device to blink rapidly.  For a more
+  "always on" effect, increase the ``blink_time`` (but not too much; see the
+  previous bullet).
+
+Other Notes
+===========
+
+* Many (possibly all) types of block devices work with this trigger, including:
+
+  * SCSI (including SATA and USB) hard disk drives and SSDs
+  * SCSI (including SATA and USB) optical drives
+  * NVMe SSDs
+  * SD cards
+  * loopback block devices (``/dev/loop*``)
+  * device mapper devices, such as LVM logical volumes
+  * MD RAID devices
+  * zRAM compressed RAM-disks
+  * partitions on block devices that support them
+
+* The names of the symbolic links in ``/sys/class/leds/<LED>/linked_devices``
+  are **kernel** names, which may not match the paths used for
+  ``link_dev_by_path`` and ``unlink_dev_by_path``.  This is most likely when a
+  symbolic link is used to refer to the device (as is common with logical
+  volumes), but it can be true for any device, because nothing prevents the
+  creation of device special files with arbitrary names (e.g.
+  ``sudo mknod /foo b 8 0``).
+
+  Kernel names can be used to unlink block devices from LEDs by writing them to
+  the LED's ``unlink_dev_by_name`` attribute.
+
+* The ``blkdev`` LED trigger supports many-to-many device/LED associations.
+  A device can be associated with multiple LEDs, and an LED can be associated
+  with multiple devices.
-- 
2.38.1

