Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0E8719FDB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjFAOZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjFAOZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:25:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0233134;
        Thu,  1 Jun 2023 07:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685629539; x=1717165539;
  h=message-id:subject:from:to:cc:date:mime-version:
   content-transfer-encoding;
  bh=E1YPGafeiY3au6KyGXwKPZ76ccBBAyWy7loKu0FIwgM=;
  b=fhiwIoeJ9PduDi8ilDfx8XKbYX8/zcwy/e4Wz9G8YMNIAvPQHaQ3IDeP
   cK0TX6vi01kLqkgTmdkfaDJ3GiIKEZDt6W1yUuYvU0mJ2pLjztIrDiu48
   xZCMkWRCaCTy8AfXcbnyySPUtQvz4qqTJqCaEMT/oTsn0AjJxy7bM+UI4
   3sGzqNfQ1SzfOvF5pv5dkoxS21oyDSBiGFUFBVPEyalf5nNJ3P3D304JS
   WBDn/Roy50wZxg6SFkbzibr2cw/owIiYHkTIasF46TkkVWm5HAO44oQcp
   uuqQpevgBagpR921G6rHqPhd2MQcEz1hSazwEImuFiOqcRCTSu9uhma9a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="335922348"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="335922348"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:25:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="701560133"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="701560133"
Received: from dperchan-mobl1.ger.corp.intel.com (HELO terminus) ([10.214.197.5])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:25:36 -0700
Message-ID: <03b01662ed63f6088141e80965291e27db835100.camel@intel.com>
Subject: [PATCH v3] media: uapi: v4l: Intel metadata format update
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, linux-kernel@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, evgeni.raikhel@intel.com,
        demisrael@gmail.com, sakari.ailus@intel.com,
        Nir Azkiel <nir.azkiel@intel.com>
Date:   Thu, 01 Jun 2023 17:25:33 +0300
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 .../media/v4l/pixfmt-meta-d4xx.rst            | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst b/D=
ocumentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
index 4e437ba97a0e..6e35ca9934b3 100644
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
+    * - __u8 Emitter mode [8_]
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

@@ -211,3 +225,15 @@ Left sensor: ::
 Fish Eye sensor: ::
 =

   1 RAW8
+
+.. _8:
+
+[8] The "Laser mode" is replaced by three different fields.
+
+The __u32 "Laser mode" integer is divided by two bytes and short: ::
+   1 __u8 Emitter mode
+   2 __u8 RFU byte
+   3 __u16 LED Power
+
+This is a change between versions 1 and 3. All versions 1,2 and 3
+are backward compatible with same data format and they are supported.
-- =

2.25.1


---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

