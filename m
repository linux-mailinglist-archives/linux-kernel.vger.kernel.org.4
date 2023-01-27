Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4C167DDA1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjA0Gky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjA0GkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2386A71B;
        Thu, 26 Jan 2023 22:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KcKsJtC6oOKWkifb5+Em1PMtEImD0uDWB79dBqTOMOQ=; b=j6RhCeb0whQCBOOCmTgtyFqBDL
        9bR8clDs+E1glbxGJmq5uzFTq3vtrweZNUuwgv42OnNoE28sOhe1m0w2GTZ7xcSxLF2SELD+28kal
        u21vZo7BaOjjZuPkOlw0szbGlkfoLCp8aBguY3lr5KdANLaIPJ9GGEkrt6y3kWRU5iCbIBAvFIiZD
        1RdBEOfQIozuz0lz6r20kG6H5eC5M0WJoF01iyNNBdx1j0i/g6jxtjuVzhSpUEDK4zCBJ1dJKSnEe
        JFxwyFjBZysMctLU05fjavEpqee/tTDXy6iFI+Gw8oSgeRxuEX6Bzfgjkrc934B13Iu5m2mKbLu9j
        U2jC8v7g==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPF-00DM0u-RS; Fri, 27 Jan 2023 06:40:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-input@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 10/35] Documentation: hid: correct spelling
Date:   Thu, 26 Jan 2023 22:39:40 -0800
Message-Id: <20230127064005.1558-11-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/hid/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/hid/hid-alps.rst      |    2 +-
 Documentation/hid/hid-bpf.rst       |    2 +-
 Documentation/hid/hiddev.rst        |    2 +-
 Documentation/hid/hidraw.rst        |    2 +-
 Documentation/hid/intel-ish-hid.rst |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff -- a/Documentation/hid/hid-alps.rst b/Documentation/hid/hid-alps.rst
--- a/Documentation/hid/hid-alps.rst
+++ b/Documentation/hid/hid-alps.rst
@@ -9,7 +9,7 @@ Currently ALPS HID driver supports U1 To
 U1 device basic information.
 
 ==========	======
-Vender ID	0x044E
+Vendor ID	0x044E
 Product ID	0x120B
 Version ID	0x0121
 ==========	======
diff -- a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-bpf.rst
--- a/Documentation/hid/hid-bpf.rst
+++ b/Documentation/hid/hid-bpf.rst
@@ -307,7 +307,7 @@ sysfs path: ``/sys/bus/hid/devices/xxxx:
 
 We can not rely on hidraw to bind a BPF program to a HID device. hidraw is an
 artefact of the processing of the HID device, and is not stable. Some drivers
-even disable it, so that removes the tracing capabilies on those devices
+even disable it, so that removes the tracing capabilities on those devices
 (where it is interesting to get the non-hidraw traces).
 
 On the other hand, the ``hid_id`` is stable for the entire life of the HID device,
diff -- a/Documentation/hid/hiddev.rst b/Documentation/hid/hiddev.rst
--- a/Documentation/hid/hiddev.rst
+++ b/Documentation/hid/hiddev.rst
@@ -8,7 +8,7 @@ Introduction
 In addition to the normal input type HID devices, USB also uses the
 human interface device protocols for things that are not really human
 interfaces, but have similar sorts of communication needs. The two big
-examples for this are power devices (especially uninterruptable power
+examples for this are power devices (especially uninterruptible power
 supplies) and monitor control on higher end monitors.
 
 To support these disparate requirements, the Linux USB system provides
diff -- a/Documentation/hid/hidraw.rst b/Documentation/hid/hidraw.rst
--- a/Documentation/hid/hidraw.rst
+++ b/Documentation/hid/hidraw.rst
@@ -163,7 +163,7 @@ HIDIOCGOUTPUT(len):
 	Get an Output Report
 
 This ioctl will request an output report from the device using the control
-endpoint.  Typically, this is used to retrive the initial state of
+endpoint.  Typically, this is used to retrieve the initial state of
 an output report of a device, before an application updates it as necessary either
 via a HIDIOCSOUTPUT request, or the regular device write() interface.  The format
 of the buffer issued with this report is identical to that of HIDIOCGFEATURE.
diff -- a/Documentation/hid/intel-ish-hid.rst b/Documentation/hid/intel-ish-hid.rst
--- a/Documentation/hid/intel-ish-hid.rst
+++ b/Documentation/hid/intel-ish-hid.rst
@@ -199,7 +199,7 @@ the sender that the memory region for th
 DMA initialization is started with host sending DMA_ALLOC_NOTIFY bus message
 (that includes RX buffer) and FW responds with DMA_ALLOC_NOTIFY_ACK.
 Additionally to DMA address communication, this sequence checks capabilities:
-if thw host doesn't support DMA, then it won't send DMA allocation, so FW can't
+if the host doesn't support DMA, then it won't send DMA allocation, so FW can't
 send DMA; if FW doesn't support DMA then it won't respond with
 DMA_ALLOC_NOTIFY_ACK, in which case host will not use DMA transfers.
 Here ISH acts as busmaster DMA controller. Hence when host sends DMA_XFER,
