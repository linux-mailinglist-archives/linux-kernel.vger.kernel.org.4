Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389F85EBB9C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiI0Hfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiI0Hf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:35:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1738913DE0;
        Tue, 27 Sep 2022 00:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664264115;
        bh=1x7HbUsQ3ey99dmL64dIN6yeQHS2Dt+yYJnddHu7+B4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=FPYH/cB3dxDRl8c2A5gOy6Kwo0Z7woIqeVgLyCFFGudnfamYihCfloDZ1nRim9zIA
         R00mjAaO2rmVttFpCwvk4oBWO921//zkNq4YefTeKh1TgYCILmfHDmnwRwqNJZxfsh
         MRW/yH/og5y6RTzouFqyIg/+6w5yJZHvtR9bOkAo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from silverpad ([5.147.48.140]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzhnH-1pPhUh3UMT-00vcoW; Tue, 27
 Sep 2022 09:35:14 +0200
From:   Jean-Francois Le Fillatre <jflf_kernel@gmx.com>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jean-Francois Le Fillatre <jflf_kernel@gmx.com>
Subject: [PATCH v4] usb: add quirks for Lenovo OneLink+ Dock
Date:   Tue, 27 Sep 2022 09:34:07 +0200
Message-Id: <20220927073407.5672-1-jflf_kernel@gmx.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qebkPPIJl0UeSfknw3ShCLC1qbIkKB2khy+KsVlIs833AmPorrW
 /QADP83LpOLYt18n199IRRo8tC8fi3w3pESID+ENLP+aTXHFxgVgYpMmFNagPjDcSVTxMml
 LL7FMteHLLWqI4mA/GSbnPARh1/wa0JMGB0ebzUUMn/gTsj5JTx1+RGgEPsa47GoGfExGRv
 WRI8TM4WsuOulnI3i6WYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lbzu8JTUqqo=:oWjmY9YYh69wr+86gi0JbZ
 V0D+UF+Ra1ro2BG3x05IvP/7hSIamgv9PYfxTlya8qBr4HtsPdJN57UiCPMVuTVHNp/3r9XxN
 EhQ8dVSSpbACPri5Bsx/4FZeVUTN68ka2dRcxEZnj/Ss9+GVZTx2EKXKd8fhoXYg8enYEU4q3
 2NUPWOy04Ilq1ZiqaLUvFWO4wl9ebh7CepT3fNfVQktxZLCnrcCC3zSg8NekgLF3VtdHmbUjr
 2n8uabl97kA1QUP3ZwzpnW1mklWIoExg2YKEFjQBJOG+NpeMtwSnJHM+4jC/0Ak6ATXZtG0JB
 hXcvEGNOoUIHu1Pwyj2k5sbPhYcUseEkeYV0rZAQBT3nrBuIw9W4J3cuA7ePtMORtpfuCqHUE
 dsalbqUZCKFc6XLB3X6I3G1YMls+HL8o7Hrb+BjfxIawh+odICv8wVlHBy9vz096WRfa/3XqJ
 MHK9lxD09oEldrElbO7UJuU6xNA6bViNEEVJ8lfPqicDrNtlTPJS1sc2JGYBOl3TesPUEYf/0
 eXZ1CZyqXNC9roNzaOAyoYsUo3kcnqIpZR1cAMy4yi4hWznwz/LeiVxzNYE1HTetHPsvEjZEu
 wEVBGWa2fTE557tdMI4051MbHaA1VN27cqL7dQOAf3zbb2D+/kHtKUoEFBpz7r4ggFQSEHbEq
 1BcYgFFoosrffgUGvGdjehzo7GF3BQuhyPtVKmgs79cxdCSR8ZQndPffj/0JURW55TkhkLacs
 cBT0eFp8oDdwFhx68Yv7BK6C2GGBpJVhr/gmW1UNCzAxoCb7VVa6/HEI41VwGla6TdU7bJ5s7
 hI3nZRdlypCIEz12Tn+a5+ZHnJYEmIT955MAWgdxofUFplwK6gL31WfhsAIaNf6TPfWraiRew
 cndbyqiCE+zcnK968tCimXfz0xIkVejS/yfdU7emwCO+LfJc1aoycvgj19VzyEwnQXVcNap+w
 FF9buYBRBMA5Eb31Cfk7VbKsjhLPfyY/of96hQmCB5iESyR1K0k95wtFyMB2kZ0HX3/TLyeQG
 MqaxmfIXVRM6Ca701ytC0jWFMVGDGHkujQjEfxfqhgM7UF8lvTTcF3b6/D8GADGRXaC8Uv2x0
 BoTYgE+OqA/xnYcvECqDcsWnkOGc4FDo4BXM3t+DEvHaQvfGbnWpx8tyZ1mspOC3HbX2MHfUZ
 T6cY/N9EStGTQuGA5dwMghq80T
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_H2,RCVD_IN_MSPIKE_ZBI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo OneLink+ Dock contains two VL812 USB3.0 controllers:
17ef:1018 upstream
17ef:1019 downstream

These hubs suffer from two separate problems:

1) After the host system was suspended and woken up, the hubs appear to
   be in a random state. Some downstream ports (both internal to the
   built-in audio and network controllers, and external to USB sockets)
   may no longer be functional. The exact list of disabled ports (if
   any) changes from wakeup to wakeup. Ports remain in that state until
   the dock is power-cycled, or until the laptop is rebooted.

   Wakeup sources connected to the hubs (keyboard, WoL on the integrated
   gigabit controller) will wake the system up from suspend, but they
   may no longer work after wakeup (and in that case will no longer work
   as wakeup source in a subsequent suspend-wakeup cycle).

   This issue appears in the logs with messages such as:

     usb 1-6.1-port4: cannot disable (err =3D -71)
     usb 1-6-port2: cannot disable (err =3D -71)
     usb 1-6.1: clear tt 1 (80c0) error -71
     usb 1-6-port4: cannot disable (err =3D -71)
     usb 1-6.4: PM: dpm_run_callback(): usb_dev_resume+0x0/0x10 [usbcore] =
returns -71
     usb 1-6.4: PM: failed to resume async: error -71
     usb 1-7: reset full-speed USB device number 5 using xhci_hcd
     usb 1-6.1-port1: cannot reset (err =3D -71)
     usb 1-6.1-port1: cannot reset (err =3D -71)
     usb 1-6.1-port1: cannot reset (err =3D -71)
     usb 1-6.1-port1: cannot reset (err =3D -71)
     usb 1-6.1-port1: cannot reset (err =3D -71)
     usb 1-6.1-port1: Cannot enable. Maybe the USB cable is bad?
     usb 1-6.1-port1: cannot disable (err =3D -71)
     usb 1-6.1-port1: cannot reset (err =3D -71)
     usb 1-6.1-port1: cannot reset (err =3D -71)
     usb 1-6.1-port1: cannot reset (err =3D -71)
     usb 1-6.1-port1: cannot reset (err =3D -71)
     usb 1-6.1-port1: cannot reset (err =3D -71)
     usb 1-6.1-port1: Cannot enable. Maybe the USB cable is bad?
     usb 1-6.1-port1: cannot disable (err =3D -71)

2) Some USB devices cannot be enumerated properly. So far I have only
   seen the issue with USB 3.0 devices. The same devices work without
   problem directly connected to the host system, to other systems or to
   other hubs (even when those hubs are connected to the OneLink+ dock).

   One very reliable reproducer is this USB 3.0 HDD enclosure:
   152d:9561 JMicron Technology Corp. / JMicron USA Technology Corp. Mobiu=
s

   I have seen it happen sporadically with other USB 3.0 enclosures,
   with controllers from different manufacturers, all self-powered.

   Typical messages in the logs:

     xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
     xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
     usb 2-1.4: device not accepting address 6, error -62
     xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
     xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
     usb 2-1.4: device not accepting address 7, error -62
     usb 2-1-port4: attempt power cycle
     xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
     xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
     usb 2-1.4: device not accepting address 8, error -62
     xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
     xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
     usb 2-1.4: device not accepting address 9, error -62
     usb 2-1-port4: unable to enumerate USB device

Through trial and error, I found that the USB_QUIRK_RESET_RESUME solved
the second issue. Further testing then uncovered the first issue. Test
results are summarized in this table:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Settings                        USB2 hotplug    USB3 hotplug    State afte=
r waking up
=2D-----------------------------------------------------------------------=
---------------

power/control=3Dauto              works           fails           broken

usbcore.autosuspend=3D-1          works           works           broken
OR power/control=3Don

power/control=3Dauto              works (1)       works (1)       works
and USB_QUIRK_RESET_RESUME

power/control=3Don                works           works           works
and USB_QUIRK_RESET_RESUME

HUB_QUIRK_DISABLE_AUTOSUSPEND   works           works           works
and USB_QUIRK_RESET_RESUME

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

In those results, the power/control settings are applied to both hubs,
both on the USB2 and USB3 side, before each test.

=46rom those results, USB_QUIRK_RESET_RESUME is required to reset the hubs
properly after a suspend-wakeup cycle, and the hubs must not autosuspend
to work around the USB3 issue.

A secondary effect of USB_QUIRK_RESET_RESUME is to prevent the hubs'
upstream links from suspending (the downstream ports can still suspend).
This secondary effect is used in results (1). It is enough to solve the
USB3 problem.

Setting USB_QUIRK_RESET_RESUME on those hubs is the smallest patch that
solves both issues.

Prior to creating this patch, I have used the USB_QUIRK_RESET_RESUME via
the kernel command line for over a year without noticing any side
effect.

Thanks to Oliver Neukum @Suse for explanations of the operations of
USB_QUIRK_RESET_RESUME, and requesting more testing.

Signed-off-by: Jean-Francois Le Fillatre <jflf_kernel@gmx.com>
=2D--
v3 -> v4: update commit message to include new test results
v2 -> v3: fix commit email address, add revision details
v1 -> v2: use full author name
=2D--
 drivers/usb/core/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index f99a65a64..999b7c969 100644
=2D-- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -437,6 +437,10 @@ static const struct usb_device_id usb_quirk_list[] =
=3D {
 	{ USB_DEVICE(0x1532, 0x0116), .driver_info =3D
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },

+	/* Lenovo ThinkPad OneLink+ Dock twin hub controllers (VIA Labs VL812) *=
/
+	{ USB_DEVICE(0x17ef, 0x1018), .driver_info =3D USB_QUIRK_RESET_RESUME },
+	{ USB_DEVICE(0x17ef, 0x1019), .driver_info =3D USB_QUIRK_RESET_RESUME },
+
 	/* Lenovo USB-C to Ethernet Adapter RTL8153-04 */
 	{ USB_DEVICE(0x17ef, 0x720c), .driver_info =3D USB_QUIRK_NO_LPM },

=2D-
2.34.1

