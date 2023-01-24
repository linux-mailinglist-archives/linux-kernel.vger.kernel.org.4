Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0197567A257
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbjAXTFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbjAXTFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:05:09 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFC34FCFD;
        Tue, 24 Jan 2023 11:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674587052; x=1706123052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OOqiYKfmWDTAp+2e6ZBSGTgyOhzF068SxglszHxUP28=;
  b=DbQCLA43W7uZiC23d6ii0Y7/wfZEFnF7BqGYLNf2d+bH2euuRofTjk5X
   jKZU3QQQ8uIGMNCvW6S7+nLuhqbhDSyDN+drPlyA1tQ9NABFlUmCwn5ep
   kk3XrtG4PGtiGBxM3HtgTbL9xjeHamXqlfM99N9S/UouaC451nuUCtzy7
   kkgWYF0Ufe8bA/z9wYO+yQzUuobCtzgoI1wGP1KqzMln1VqsSbSCRXjp1
   JjrE3jBNV6uc1tLfIoOfT/XtBAa5G01qbQx7gCWJIQQ6AkC7lTdSLS1Jy
   AzPIGY+r/6rtNTFe6gEGbDuz2Dx91n47gBHgCiGiP4qH6HJB04svflogi
   w==;
X-IronPort-AV: E=Sophos;i="5.97,243,1669046400"; 
   d="scan'208";a="221472992"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2023 03:04:11 +0800
IronPort-SDR: xR9iu7IKWzhmLgsT9J72gZcikp0axPQQH4kDGrMikRIqGtT1T0O5eRoJU3ZtIYmd3kdp7b9he7
 mBnCwOx2O+SdRhHfkOSBABpyTSTUVYUFNz/FHc6lQDvDi+2lRpE2qlK2lAtbOOym02l6oxIadO
 IX3tf+gSB3alA2IQq910UBprfGwL1QCd4npDy1nJtnuKUdvIoewn7aiIfC4V/IulMYM9qfVBI8
 Kck0u6qPIRwSvb9bLXzdiB8NxDFc/spvEt0gbNEvZ6s2juWJrPQxJDCgIM4dW0XnhQ4umRU5fK
 Upc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 10:16:00 -0800
IronPort-SDR: yvox5jcHKJanTm6+tqUTC5eJy6q85LJ2+66/Lv7Twnq4g5JuwnTiKLtmgSMQ/Ds14KgfO+x5kU
 NEEueRAcxYamWS3JJf/z10bawlgkHMmXRRzhgzdWwJHGSf+l7RekM813Zofc2XmigmgTT1401T
 TEm+/ivBrNW7GbIT5PKAZRMDZ0kkXea3bAOrYXGaROrG4wXxBKdQ2mbMJrA/OlVlSZukJQkcNr
 Ul4CbI9iSQ0vxJP+hrX50mRw/0HG2+upeh2YueMZQ6FUHF2TKDxVhpw0YPH7DRD+dwMhCSJt7n
 jU8=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.164.48])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Jan 2023 11:04:09 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v3 18/18] Documentation: sysfs-block-device: document command duration limits
Date:   Tue, 24 Jan 2023 20:03:04 +0100
Message-Id: <20230124190308.127318-19-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124190308.127318-1-niklas.cassel@wdc.com>
References: <20230124190308.127318-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Document ABI/testing/sysfs-block-device the sysfs attributes present
under /sys/block/*/device/duration_limits for ATA and SCSI devices
supporting the command duration limits feature.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 Documentation/ABI/testing/sysfs-block-device | 150 +++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block-device b/Documentation/ABI/testing/sysfs-block-device
index 7ac7b19b2f72..3a32c86942f5 100644
--- a/Documentation/ABI/testing/sysfs-block-device
+++ b/Documentation/ABI/testing/sysfs-block-device
@@ -95,3 +95,153 @@ Description:
 		This file does not exist if the HBA driver does not implement
 		support for the SATA NCQ priority feature, regardless of the
 		device support for this feature.
+
+
+What:		/sys/block/*/device/duration_limits/enable
+Date:		Dec, 2022
+KernelVersion:	v6.3
+Contact:	linux-scsi@vger.kernel.org
+Description:
+		(RW) For ATA and SCSI devices supporting the command duration
+		limits feature, write to the file to turn on or off the
+		feature. By default this feature is turned off. If the device
+		does not support the command duration limits feature, this
+		attribute does not exist (the directory
+		"/sys/block/\*/device/duration_limits" does not exist).
+		Writing "1" to this file enables the use of command duration
+		limits for read and write commands in the kernel and turns on
+		the feature on the device. Writing "0" disables the feature.
+
+
+What:		/sys/block/*/device/duration_limits/read/[1-7]/*
+Date:		Dec, 2022
+KernelVersion:	v6.3
+Contact:	linux-scsi@vger.kernel.org
+Description:
+		(RO) For ATA and SCSI devices supporting the command duration
+		limits feature, this shows the set of 7 command duration limits
+		descriptors for read commands currently set on the device. For
+		each of the 7 descritors, the following read-only attributes
+		are present:
+
+		  - duration_guideline: specifies the preferred length of time
+		    in microseconds for the completion of a command.
+
+		  - duration_guideline_policy: specifies the policy action
+		    taken if the duration_guideline attribute specifies a
+		    non-zero command duration guideline that the device is
+		    unable to achieve for a command.
+
+		    Possible values are:
+
+		      - 0x0: The device will complete the command at the
+			earliest possible time consistent with the specified
+			command duration guideline.
+
+		      - 0x1: If the specified command duration guideline has not
+			been achieved and the command duration guideline policy
+			field is not in the seventh command duration limits
+			descriptor, then the device continues processing that
+			command using the command duration limits descriptor
+			that has the next higher number.
+
+		      - 0x2: The device will continue processing the command as
+			with no command duration limits descriptor being used.
+
+		      - 0xD: The device will complete the command and an IO
+			failure will be reported to the user with the ETIME
+			error code.
+
+		      - 0xF: Same as 0xD.
+
+		  - max_active_time: specifies an upper limit in microseconds
+		    on the time that elapses from the time at which the device
+		    initiates actions to access, transfer, or act upon the
+		    specified data until the time the device returns status for
+		    the command.
+
+		  - max_active_time_policy: specifies the policy action taken
+		    if the time used to process a command exceeds a non-zero
+		    time specified by the max_active_time attribute.
+
+		    Possible values are:
+
+		      - 0x0: The device will complete the command at the
+			earliest possible time (i.e, do nothing based on the max
+			time limit not being met).
+
+		      - 0xD: The device will complete the command and an IO
+			failure will be reported to the user with the ETIME
+			error code.
+
+		      - 0xE: Same as 0xD.
+
+		      - 0xF: Same as 0xD.
+
+		  - max_inactive_time: specifies an upper limit in microseconds
+		    on the time that elapses from the time at which the device
+		    receives the command until the time at which the device
+		    initiates actions to access, transfer, or act upon the
+		    specified data.
+
+		  - max_inactive_time_policy: specifies the policy action taken
+		    if a non-zero max_inactive_time limit is not met.
+
+		    Possible values are:
+
+		      - 0x0: The device will complete the command at the
+			earliest possible time (i.e, do nothing based on the max
+			time limit not being met).
+
+		      - 0xD: The device will complete the command and an IO
+			failure will be reported to the user with the ETIME
+			error code.
+
+		      - 0xF: Same as 0xD.
+
+
+What:		/sys/block/*/device/duration_limits/read/page
+Date:		Dec, 2022
+KernelVersion:	v6.3
+Contact:	linux-scsi@vger.kernel.org
+Description:
+		(RO) For ATA and SCSI devices supporting the command duration
+		limits feature, this shows the name of the device VPD page
+		specifying the set of 7 command duration limits descriptors for
+		read commands. Possible values are "T2A" and "T2B".
+
+
+What:		/sys/block/*/device/duration_limits/write/[1-7]/*
+Date:		Dec, 2022
+KernelVersion:	v6.3
+Contact:	linux-scsi@vger.kernel.org
+Description:
+		(RO) For ATA and SCSI devices supporting the command duration
+		limits feature, this shows the set of 7 command duration limits
+		descriptors for write commands currently set on the device. For
+		each of the 7 descritors, the same set of read-only attributes
+		as for read commands is present.
+
+
+What:		/sys/block/*/device/duration_limits/write/page
+Date:		Dec, 2022
+KernelVersion:	v6.3
+Contact:	linux-scsi@vger.kernel.org
+Description:
+		(RO) For ATA and SCSI devices supporting the command duration
+		limits feature, this shows the name of the device VPD page
+		specifying the set of 7 command duration limits descriptors for
+		write commands. Possible values are "T2A" and "T2B".
+
+
+What:		/sys/block/*/device/duration_limits/perf_vs_duration_guideline
+Date:		Dec, 2022
+KernelVersion:	v6.3
+Contact:	linux-scsi@vger.kernel.org
+Description:
+		(RO) For ATA and SCSI devices supporting the command duration
+		limits feature, this specifies the maximum percentage increase
+		in average command completion times (reduction in IOPS) that
+		is allowed for the device to perform actions based on the
+		contents of the duration guideline field in every command
+		duration limit descriptor for both read and write commands.
-- 
2.39.1

