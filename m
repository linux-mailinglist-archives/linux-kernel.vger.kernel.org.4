Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808C3701CA5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjENJhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjENJg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:36:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417FE173C;
        Sun, 14 May 2023 02:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684057016; x=1715593016;
  h=message-id:subject:from:to:cc:date:mime-version:
   content-transfer-encoding;
  bh=/FH779mYdpB+LFj6EuS/GjHHvnnTcCJIHv0NT/8s19Y=;
  b=kEcDs9ofeCQZAJ8L8ELk2L7P/elU5Z+6pclUkLgIdRWwOpBmOoHxJ98P
   o17N14mJp7nDUw8z86G3yjNl/Hfr42GWF7ztY1LBrzza9+/wqF3WJMNH5
   fBt/6wrIC7tMRcNK4lNDjE3agte82ktunITar7FwEKjBLeh/tm9a3RKXd
   yrZ3oOuGMDCb5JDA6S7/W61CF4VF0akJuFD3jiKne8bLrALOnas5fZTsh
   gd2iebkNq9WurwLO/96LdCfMtqyx/1+h9Kwu1k34GBpTPW9/Sg1JWuDj2
   eXy/V3n/88j5DU6jwdNP0QNkczpN3RM5FtuMJgqfY29ocfmTtbUQFEDXw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="351056151"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="351056151"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="790317612"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="790317612"
Received: from aamerfar-mobl.ger.corp.intel.com (HELO terminus) ([10.214.193.218])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:36:53 -0700
Message-ID: <7e0e6a37eee28185ec2fbd4f1d42569c8da6726d.camel@intel.com>
Subject: [PATCH v3] media: uapi: v4l: Intel metadata format update
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, linux-kernel@vger.kernel.org,
        sakari.ailus@iki.fi, laurent.pinchart@ideasonboard.com,
        evgeni.raikhel@intel.com, demisrael@gmail.com
Date:   Sun, 14 May 2023 12:36:50 +0300
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update metadata structure for Intel RealSense UVC/MIPI cameras.
Compliant to Intel Configuration version 3.

Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
---
 .../media/v4l/pixfmt-meta-d4xx.rst            | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst b/D=
ocumentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
index 4e437ba97a0e..01f7e624ab6f 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
@@ -12,7 +12,7 @@ Intel D4xx UVC Cameras Metadata
 Description
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-Intel D4xx (D435 and other) cameras include per-frame metadata in their UVC
+Intel D4xx (D435, D455 and others) cameras include per-frame metadata in t=
heir UVC
 payload headers, following the Microsoft(R) UVC extension proposal [1_]. T=
hat
 means, that the private D4XX metadata, following the standard UVC header, =
is
 organised in blocks. D4XX cameras implement several standard block types,
@@ -26,6 +26,8 @@ V4L2_META_FMT_UVC with the only difference, that it also =
includes proprietary
 payload header data. D4xx cameras use bulk transfers and only send one pay=
load
 per frame, therefore their headers cannot be larger than 255 bytes.
 =

+This document implements Intel Configuration version 3.
+
 Below are proprietary Microsoft style metadata types, used by D4xx cameras,
 where all fields are in little endian order:
 =

@@ -43,7 +45,7 @@ where all fields are in little endian order:
     * - __u32 ID
       - 0x80000000
     * - __u32 Size
-      - Size in bytes (currently 56)
+      - Size in bytes (currently 60)
     * - __u32 Version
       - Version of this structure. The documentation herein corresponds to
         version xxx. The version number will be incremented when new field=
s are
@@ -72,8 +74,12 @@ where all fields are in little endian order:
       - Bottom border of the AE Region of Interest
     * - __u32 Preset
       - Preset selector value, default: 0, unless changed by the user
-    * - __u32 Laser mode
+    * - __u8 Emitter mode
       - 0: off, 1: on
+    * - __u8 RFU byte
+      - Spare byte for future use
+    * - __u16 LED Power
+      - Led power value 0-360 (F416 SKU)
     * - :cspan:`1` *Capture Timing*
     * - __u32 ID
       - 0x80000001
@@ -124,6 +130,14 @@ where all fields are in little endian order:
       - Requested frame rate per second
     * - __u16 Trigger
       - Byte 0: bit 0: depth and RGB are synchronised, bit 1: external tri=
gger
+    * - __u16 Calibration count
+      - Calibration counter
+    * - __u8 GPIO input data
+      - GPIO readout (Supported from FW 5.12.7.0)
+    * - __u32 Sub-preset info
+      - Sub-preset choice information
+    * - __u8 reserved
+      - RFU byte.
 =

 .. _1:
 =

-- =

2.25.1


---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

