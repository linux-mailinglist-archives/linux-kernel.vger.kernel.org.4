Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2082B67DDEB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjA0GmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjA0Gk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63E174C32;
        Thu, 26 Jan 2023 22:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0tBu6Erz+dlIKmi6Fcf2PLuhswsM+Mn8+mdPYDo4x14=; b=2SuElG0dZjMUm+IcyMMWh43ge6
        7wfgozINmdWGJA/BmCuooKFLOzUf6abx+CRWJVB/nrCj8dIalHAgBTH9e88wpmFrnK65/M+YHUlC6
        EqexX3bTfz+aJ2udkWFgNeS+OPJVIxQk1sj6KgQbWaIkX186kM6vw9a5+h8R6+L4GqZ/zRD8TnIlt
        y9kF7cTpjm0PK1p+aXmmj4OyRcYdWfUAyRI8/k58ShYkspQ3EKyhe8cNJCLKX7RsR8jDE3kuxN/qi
        KrhD26P2QeKQ92+WKZtDsxWtLQiRamsfZGcBU5cbArNGcWcFuvoeRCB+odep4AIi++lSm8H7ITNly
        Qx2DryIw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPR-00DM0u-1E; Fri, 27 Jan 2023 06:40:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 32/35] Documentation: usb: correct spelling
Date:   Thu, 26 Jan 2023 22:40:02 -0800
Message-Id: <20230127064005.1558-33-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/usb/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/usb/chipidea.rst       |   19 ++++++++++---------
 Documentation/usb/gadget-testing.rst |    2 +-
 Documentation/usb/mass-storage.rst   |    2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff -- a/Documentation/usb/chipidea.rst b/Documentation/usb/chipidea.rst
--- a/Documentation/usb/chipidea.rst
+++ b/Documentation/usb/chipidea.rst
@@ -35,10 +35,10 @@ which can show otg fsm variables and som
 1) Power up 2 Freescale i.MX6Q sabre SD boards with gadget class driver loaded
    (e.g. g_mass_storage).
 
-2) Connect 2 boards with usb cable with one end is micro A plug, the other end
+2) Connect 2 boards with usb cable: one end is micro A plug, the other end
    is micro B plug.
 
-   The A-device(with micro A plug inserted) should enumerate B-device.
+   The A-device (with micro A plug inserted) should enumerate B-device.
 
 3) Role switch
 
@@ -54,18 +54,19 @@ which can show otg fsm variables and som
 
 	echo 0 > /sys/bus/platform/devices/ci_hdrc.0/inputs/b_bus_req
 
-   or, by introducing HNP polling, B-Host can know when A-peripheral wish
-   to be host role, so this role switch also can be trigged in A-peripheral
-   side by answering the polling from B-Host, this can be done on A-device::
+   or, by introducing HNP polling, B-Host can know when A-peripheral wishes to
+   be in the host role, so this role switch also can be triggered in
+   A-peripheral side by answering the polling from B-Host. This can be done on
+   A-device::
 
 	echo 1 > /sys/bus/platform/devices/ci_hdrc.0/inputs/a_bus_req
 
    A-device should switch back to host and enumerate B-device.
 
-5) Remove B-device(unplug micro B plug) and insert again in 10 seconds,
+5) Remove B-device (unplug micro B plug) and insert again in 10 seconds;
    A-device should enumerate B-device again.
 
-6) Remove B-device(unplug micro B plug) and insert again after 10 seconds,
+6) Remove B-device (unplug micro B plug) and insert again after 10 seconds;
    A-device should NOT enumerate B-device.
 
    if A-device wants to use bus:
@@ -105,7 +106,7 @@ July 27, 2012 Revision 2.0 version 1.1a"
 2. How to enable USB as system wakeup source
 --------------------------------------------
 Below is the example for how to enable USB as system wakeup source
-at imx6 platform.
+on an imx6 platform.
 
 2.1 Enable core's wakeup::
 
@@ -128,6 +129,6 @@ at imx6 platform.
 	echo enabled > /sys/bus/usb/devices/1-1/power/wakeup
 
 If the system has only one usb port, and you want usb wakeup at this port, you
-can use below script to enable usb wakeup::
+can use the below script to enable usb wakeup::
 
 	for i in $(find /sys -name wakeup | grep usb);do echo enabled > $i;done;
diff -- a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -813,7 +813,7 @@ the user must provide the following:
 	================== ====================================================
 
 Each frame description contains frame interval specification, and each
-such specification consists of a number of lines with an inverval value
+such specification consists of a number of lines with an interval value
 in each line. The rules stated above are best illustrated with an example::
 
   # mkdir functions/uvc.usb0/control/header/h
diff -- a/Documentation/usb/mass-storage.rst b/Documentation/usb/mass-storage.rst
--- a/Documentation/usb/mass-storage.rst
+++ b/Documentation/usb/mass-storage.rst
@@ -150,7 +150,7 @@ Module parameters
   - bcdDevice     -- USB Device version (BCD) (16 bit integer)
   - iManufacturer -- USB Manufacturer string (string)
   - iProduct      -- USB Product string (string)
-  - iSerialNumber -- SerialNumber string (sting)
+  - iSerialNumber -- SerialNumber string (string)
 
 sysfs entries
 =============
