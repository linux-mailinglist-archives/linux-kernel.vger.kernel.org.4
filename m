Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398D15EADD1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiIZROF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiIZRNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:13:38 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8B32C65F;
        Mon, 26 Sep 2022 09:25:07 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-12803ac8113so9907760fac.8;
        Mon, 26 Sep 2022 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kv5pLuppf3Jboc0nPEbTk92/XrIUrH3iSpM0s9qu3m0=;
        b=jeLhtYiej8UHVnbavpph9cCYqFRvLXK6HNzBi4JL+8w73mvbvVosEOx7MYxoSTo6Fd
         Rraiox1S0yoKt7AT0/ZG2AD7+KMKm7gEU6be1jaKLWhMqZy4VveTy0aEexAqN79E2O9R
         YzX/D3Jusa+1plPiCdLucm6PQjTXW1qZyOn7aQwLYJLFv9dbJEqVsqK+onpvgFF+32XL
         EPAVLo7tT5biKdw5YZM4JqRXmICDeRVTthvQOcGut/CicjvKia6tAvUDN+bgcZ/CW30s
         Bp+wKf2aU9R5xEgEkKU6q56GvY25XLPJSqr4V202FWPbf+s45LwhPR2y9WEBnvjyXYAE
         g2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kv5pLuppf3Jboc0nPEbTk92/XrIUrH3iSpM0s9qu3m0=;
        b=fnKBsWb/568/fVe7g881QTUJInxts9A/k5ei3I8j6eDstD5ey3fL1TnTZRWtiXzpDn
         lpzngcU6TrfbQ21PdhObAqZ52xXsDc/acC2kbKE/a1N8GAgpy37vSxlqOBrIo5p+y5as
         0tVjYMNPLyhTfZqnH6aMlS6yV3iQW3CYxwqxIPJ+X82lE34QcTTCWXI6pLCivP01Z9kW
         Qybiy28PhkAbHNvYwu1frq3Kwq/yn4+QopSuP0aiNU86EvEhIFcKBWq9eyO7Glo+OomZ
         m5Okk5QwwDtF1k5CHPXvCEg1EuQZ92tgObrF+AgOKkyKgkOWMp1lsiYANOtuH+Hi9sVl
         Li+A==
X-Gm-Message-State: ACrzQf07squhIB0cRXBj+a+1ppYcmbHLJkT4rGBoefu/ZsQnCupFNVia
        czuXJLSTlLM8G27g4pDhtZ0=
X-Google-Smtp-Source: AMsMyM7dK2sXVm+pfzvhBERbQsT6zZ9QpmA86kv1qUubXGxHLYe5W0W3xzA7J0gBkQIX9QDNY6hjYA==
X-Received: by 2002:a05:6870:d1c9:b0:127:2df9:b459 with SMTP id b9-20020a056870d1c900b001272df9b459mr19557160oac.168.1664209506408;
        Mon, 26 Sep 2022 09:25:06 -0700 (PDT)
Received: from ian.penurio.us ([47.184.52.85])
        by smtp.gmail.com with ESMTPSA id k7-20020a4ab287000000b004762a830156sm6789097ooo.32.2022.09.26.09.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 09:25:05 -0700 (PDT)
From:   Ian Pilcher <arequipeno@gmail.com>
To:     pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        kabel@kernel.org, torvic9@mailbox.org
Subject: [PATCH v12 1/2] docs: Add block device (blkdev) LED trigger documentation
Date:   Mon, 26 Sep 2022 11:25:02 -0500
Message-Id: <20220926162503.451320-2-arequipeno@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220926162503.451320-1-arequipeno@gmail.com>
References: <20220926162503.451320-1-arequipeno@gmail.com>
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
index cd14ecb3c9a5..853cb2601242 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -101,6 +101,16 @@ Description:
 		devices that support receiving integrity metadata.
 
 
+What:		/sys/block/<disk>/linked_leds
+Date:		October 2022
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
index 000000000000..45275eb0bad3
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-blkdev
@@ -0,0 +1,78 @@
+What:		/sys/class/leds/<led>/blink_time
+Date:		October 2022
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Time (in milliseconds) that the LED will be on during a single
+		"blink".
+
+What:		/sys/class/leds/<led>/check_interval
+Date:		October 2022
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Interval (in milliseconds) between checks of the block devices
+		linked to this LED.  The LED will be blinked if the correct type
+		of activity (see blink_on_{read,write,discard,flush} attributes)
+		has occurred on any of the linked devices since the previous
+		check.
+
+What:		/sys/class/leds/<led>/blink_on_read
+Date:		October 2022
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Boolean that determines whether the LED will blink in response
+		to read activity on any of its linked block devices.
+
+What:		/sys/class/leds/<led>/blink_on_write
+Date:		October 2022
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Boolean that determines whether the LED will blink in response
+		to write activity on any of its linked block devices.
+
+What:		/sys/class/leds/<led>/blink_on_discard
+Date:		October 2022
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Boolean that determines whether the LED will blink in response
+		to discard activity on any of its linked block devices.
+
+What:		/sys/class/leds/<led>/blink_on_flush
+Date:		October 2022
+Contact:	Ian Pilcher <arequipeno@gamil.com>
+Description:
+		Boolean that determines whether the LED will blink in response
+		to cache flush activity on any of its linked block devices.
+
+What:		/sys/class/leds/<led>/link_dev_by_path
+Date:		October 2022
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Associate a block device with this LED by writing the path to
+		the device special file (e.g. /dev/sda) to this attribute.
+		Symbolic links are followed.
+
+What:		/sys/class/leds/<led>/unlink_dev_by_path
+Date:		October 2022
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Remove the association between this LED and a block device by
+		writing the path to the device special file (e.g. /dev/sda) to
+		this attribute.  Symbolic links are followed.
+
+What:		/sys/class/leds/<led>/unlink_dev_by_name
+Date:		October 2022
+Contact:	Ian Pilcher <arequipeno@gmail.com>
+Description:
+		Remove the association between this LED and a block device by
+		writing the kernel name of the device (e.g. sda) to this
+		attribute.
+
+What:		/sys/class/leds/<led>/linked_devices
+Date:		October 2022
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
2.37.3

