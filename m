Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD85647F28
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiLIIY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLIIYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:24:20 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14395E9E7;
        Fri,  9 Dec 2022 00:24:17 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 142so3073814pga.1;
        Fri, 09 Dec 2022 00:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nfGR+A3eKXKMGqzBUlCOhIFQ9p7mfUwRScCRtlT3bf8=;
        b=oO8+wfEfvd9QPgp5U+Xc+raLr2ynWq6lrWRQBd6ze6L5f0Zw8OprN20XgP6aVlIG3J
         8KxFEzRo51qErLo4hwYTbHz76cFxAmdtff/vc6Z0seEJiY5W0ZNiwttOiNiF7aNY3czi
         iNHdMJ3CKXJ4UWIn1melvLVMBml2PqyUbe/HlrFYptCxOEG/AgTc9Sibc+gk1JJudVUO
         jS/6HkyTU1GS1/Fw4k1647Fhlr8KjYcdym03tYQ+oPMiq6Hkp6bOFsBsnwphzegkKVk/
         EVDWq5TT+GzGD4zcisz2tqlTEkd2Hwn6u4mJu1YeMQIG9GRD8Gvxz0vf5TLhaoJBIHkm
         bxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfGR+A3eKXKMGqzBUlCOhIFQ9p7mfUwRScCRtlT3bf8=;
        b=4TunkNbhZibQUdxLnJapfbILUYF4fCuFNwI4ZGU2ZyMHwqzizZOKtCGeTdNnlxl07t
         4cwl5sSzaSGi2exp957dVDAwVBtLISRQo3RUzE/QrmRfGV/1xPkhtEeHnQMmebQcYmSH
         uDhsRTwdSJRIRRyeZ416C1DTHhlvgisQdZSzOGmcndor/q5Gzc7HwtATsoIz415fI2BQ
         PKtXm8DDb0idtVR9CdONrnlVBEzersHTOpmGX6tQalfTnawFz08sbdg7O7vUTsSpymIi
         SVCTAEp4oyL7X6i1XXRRwE6Rqz+Felel7QzJHN4bvWm0pWD44YfSfgzzFIDTfXwBY8nU
         bI0w==
X-Gm-Message-State: ANoB5pmeJKWAFQj3wseTOsrJ27VKLWKl7wiqNRD0fLeHzmLlUpnlryBf
        YvWhBM+B0FeX5f2cMKE7+5w=
X-Google-Smtp-Source: AA0mqf5PLyz3drF93OwJwfC6NN9jyNWVp3Kvc0nGTPqxXEc76j7+IoFGUj1YIvIhHSUl0EiQ19B4mg==
X-Received: by 2002:aa7:848a:0:b0:56b:b113:9d09 with SMTP id u10-20020aa7848a000000b0056bb1139d09mr1030403pfn.2.1670574257105;
        Fri, 09 Dec 2022 00:24:17 -0800 (PST)
Received: from mail.google.com (125-237-37-88-fibre.sparkbb.co.nz. [125.237.37.88])
        by smtp.gmail.com with ESMTPSA id c79-20020a621c52000000b005772d55df03sm728098pfc.35.2022.12.09.00.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 00:24:16 -0800 (PST)
Date:   Fri, 9 Dec 2022 21:24:09 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH] [next] drm/radeon: Replace 1-element arrays with
 flexible-array members
Message-ID: <Y5LwqRCPcYLizJFt@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with
flexible array members instead. So, replace one-element array with
flexible-array member in structs _ATOM_DISPLAY_OBJECT_PATH,
_ATOM_DISPLAY_OBJECT_PATH_TABLE, _ATOM_OBJECT_TABLE, GOP_VBIOS_CONTENT
_ATOM_GPIO_VOLTAGE_OBJECT_V3 and refactor the rest of the code accordingly.

It's worth mentioning that doing a build before/after this patch
results in no binary output differences.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/239
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Notes for the maintainer:

- These are all fake-flexible arrays with references in source code for
  the radeon driver. Given the way they are used, no change to *.c files
  were required.
---
 drivers/gpu/drm/radeon/atombios.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios.h b/drivers/gpu/drm/radeon/atombios.h
index 235e59b547a1..8a6621f1e82c 100644
--- a/drivers/gpu/drm/radeon/atombios.h
+++ b/drivers/gpu/drm/radeon/atombios.h
@@ -4020,7 +4020,7 @@ typedef struct  _ATOM_DISPLAY_OBJECT_PATH
   USHORT    usSize;                                        //the size of ATOM_DISPLAY_OBJECT_PATH
   USHORT    usConnObjectId;                                //Connector Object ID 
   USHORT    usGPUObjectId;                                 //GPU ID 
-  USHORT    usGraphicObjIds[1];                             //1st Encoder Obj source from GPU to last Graphic Obj destinate to connector.
+  USHORT    usGraphicObjIds[];                             //1st Encoder Obj source from GPU to last Graphic Obj destinate to connector.
 }ATOM_DISPLAY_OBJECT_PATH;
 
 typedef struct  _ATOM_DISPLAY_EXTERNAL_OBJECT_PATH
@@ -4037,7 +4037,7 @@ typedef struct _ATOM_DISPLAY_OBJECT_PATH_TABLE
   UCHAR                           ucNumOfDispPath;
   UCHAR                           ucVersion;
   UCHAR                           ucPadding[2];
-  ATOM_DISPLAY_OBJECT_PATH        asDispPath[1];
+  ATOM_DISPLAY_OBJECT_PATH        asDispPath[];
 }ATOM_DISPLAY_OBJECT_PATH_TABLE;
 
 
@@ -4053,7 +4053,7 @@ typedef struct _ATOM_OBJECT_TABLE                         //Above 4 object table
 {
   UCHAR               ucNumberOfObjects;
   UCHAR               ucPadding[3];
-  ATOM_OBJECT         asObjects[1];
+  ATOM_OBJECT         asObjects[];
 }ATOM_OBJECT_TABLE;
 
 typedef struct _ATOM_SRC_DST_TABLE_FOR_ONE_OBJECT         //usSrcDstTableOffset pointing to this structure
@@ -4615,7 +4615,7 @@ typedef struct  _ATOM_GPIO_VOLTAGE_OBJECT_V3
    UCHAR    ucPhaseDelay;                // phase delay in unit of micro second
    UCHAR    ucReserved;   
    ULONG    ulGpioMaskVal;               // GPIO Mask value
-   VOLTAGE_LUT_ENTRY_V2 asVolGpioLut[1];   
+   VOLTAGE_LUT_ENTRY_V2 asVolGpioLut[];
 }ATOM_GPIO_VOLTAGE_OBJECT_V3;
 
 typedef struct  _ATOM_LEAKAGE_VOLTAGE_OBJECT_V3
@@ -7964,7 +7964,7 @@ typedef struct {
 
 typedef struct {
   VFCT_IMAGE_HEADER	VbiosHeader;
-  UCHAR	VbiosContent[1];
+  UCHAR	VbiosContent[];
 }GOP_VBIOS_CONTENT;
 
 typedef struct {
-- 
2.38.1

