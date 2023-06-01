Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4227271A412
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjFAQJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjFAQJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:09:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C01AC0;
        Thu,  1 Jun 2023 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685635741; x=1717171741;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NbH0oSUUj5UZLS1hq4IjYG2wDxtkDvSBLYMKBssoAKU=;
  b=UR34xo8J1v7zVx+MWQI4CKr89CSRMpS4DGGPlq0TcRSGPMCTXCwkXG6z
   HnKlEXlh1F1p1fxZhE+Ly+QxqAVwjAYk9Ynpxd3LOeJJtA0DOMVxY1IXe
   q6xauI46wasdn3ZYYBvoKDJbk1laWrgoyUfcByKoMuIixkrmNfAwWwIJ+
   FeqqXc+djU13zHswkCSrCTkSkw5gvygLqAdxcXWkG3Hxv/2qKIgYXfvI0
   zpfsUXR+U4EB7r0r9PX9KDgi1OSfAyzotVyy5eru52fDhUI/7BF3+SRxj
   nEEThS9fHoxRzRe5BtPLqFn0qH5IXLzC1kTD8A34PTW/5oBvi1Jeh2EKI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="335223461"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="335223461"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:08:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="819882198"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="819882198"
Received: from dperchan-mobl1.ger.corp.intel.com (HELO terminus) ([10.214.197.5])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:08:48 -0700
Message-ID: <944dd3c67fc7e9c1b8d6bd0491d61fdbb9489e70.camel@intel.com>
Subject: [PATCH v4] media: uapi: v4l: Intel metadata format update
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, linux-kernel@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@intel.com,
        Evgeni Raikhel <evgeni.raikhel@intel.com>, demisrael@gmail.com,
        Nir Azkiel <nir.azkiel@intel.com>
Date:   Thu, 01 Jun 2023 19:08:46 +0300
In-Reply-To: <7e0e6a37eee28185ec2fbd4f1d42569c8da6726d.camel@intel.com>
References: <7e0e6a37eee28185ec2fbd4f1d42569c8da6726d.camel@intel.com>
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 .../media/v4l/pixfmt-meta-d4xx.rst            | 52 ++++++++++++++++---
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst b/D=
ocumentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
index 4e437ba97a0e..7482f298d0cc 100644
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

+This document implements Intel Configuration version 3 [9_].
+
 Below are proprietary Microsoft style metadata types, used by D4xx cameras,
 where all fields are in little endian order:
 =

@@ -43,7 +45,7 @@ where all fields are in little endian order:
     * - __u32 ID
       - 0x80000000
     * - __u32 Size
-      - Size in bytes (currently 56)
+      - Size in bytes, include ID (all protocol versions: 60)
     * - __u32 Version
       - Version of this structure. The documentation herein corresponds to
         version xxx. The version number will be incremented when new field=
s are
@@ -72,13 +74,17 @@ where all fields are in little endian order:
       - Bottom border of the AE Region of Interest
     * - __u32 Preset
       - Preset selector value, default: 0, unless changed by the user
-    * - __u32 Laser mode
-      - 0: off, 1: on
+    * - __u8 Emitter mode (v3 only) (__u32 Laser mode for v1) [8_]
+      - 0: off, 1: on, same as __u32 Laser mode for v1
+    * - __u8 RFU byte (v3 only)
+      - Spare byte for future use
+    * - __u16 LED Power (v3 only)
+      - Led power value 0-360 (F416 SKU)
     * - :cspan:`1` *Capture Timing*
     * - __u32 ID
       - 0x80000001
     * - __u32 Size
-      - Size in bytes (currently 40)
+      - Size in bytes, include ID (all protocol versions: 40)
     * - __u32 Version
       - Version of this structure. The documentation herein corresponds to
         version xxx. The version number will be incremented when new field=
s are
@@ -101,7 +107,7 @@ where all fields are in little endian order:
     * - __u32 ID
       - 0x80000002
     * - __u32 Size
-      - Size in bytes (currently 40)
+      - Size in bytes, include ID (v1:36, v3:40)
     * - __u32 Version
       - Version of this structure. The documentation herein corresponds to
         version xxx. The version number will be incremented when new field=
s are
@@ -124,6 +130,14 @@ where all fields are in little endian order:
       - Requested frame rate per second
     * - __u16 Trigger
       - Byte 0: bit 0: depth and RGB are synchronised, bit 1: external tri=
gger
+    * - __u16 Calibration count (v3 only)
+      - Calibration counter, see [4_] below
+    * - __u8 GPIO input data (v3 only)
+      - GPIO readout, see [4_] below (Supported from FW 5.12.7.0)
+    * - __u32 Sub-preset info (v3 only)
+      - Sub-preset choice information, see [4_] below
+    * - __u8 reserved (v3 only)
+      - RFU byte.
 =

 .. _1:
 =

@@ -140,6 +154,8 @@ where all fields are in little endian order:
   0x00000010 Exposure priority
   0x00000020 AE ROI
   0x00000040 Preset
+  0x00000080 Emitter mode
+  0x00000100 LED Power
 =

 .. _3:
 =

@@ -165,6 +181,8 @@ where all fields are in little endian order:
   0x00000040 Framerate
   0x00000080 Trigger
   0x00000100 Cal count
+  0x00000200 GPIO Input Data
+  0x00000400 Sub-preset Info
 =

 .. _5:
 =

@@ -211,3 +229,25 @@ Left sensor: ::
 Fish Eye sensor: ::
 =

   1 RAW8
+
+.. _8:
+
+[8] The "Laser mode" is replaced by three different fields.
+"Laser" renamed to "Emitter" as there multiple technologies
+for camera projectors. As we have another field for "Laser Power"
+we introduced "LED Power" for extra emitter.
+
+The __u32 "Laser mode" integer is divided by two bytes and short: ::
+   1 __u8 Emitter mode
+   2 __u8 RFU byte
+   3 __u16 LED Power
+
+This is a change between versions 1 and 3. All versions 1,2 and 3
+are backward compatible with same data format and they are supported.
+See [2_] for which attributes are valid.
+
+.. _9:
+
+[9]
+LibRealSense SDK metadata source:
+https://github.com/IntelRealSense/librealsense/blob/master/src/metadata.h
-- =

2.25.1


---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

