Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACD8611F19
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 03:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJ2Ba7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 21:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiJ2Ba5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 21:30:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D37E202716;
        Fri, 28 Oct 2022 18:30:56 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r18so6227147pgr.12;
        Fri, 28 Oct 2022 18:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ljlq0wzNYgqZzF5mdTWeFZiAlKPfpNDbugOhA1C4lDM=;
        b=Usvn4pjF8UaseNiP1nOoO16Ro9ZiA0ZOISOYmwgLehKa4bT2egg41osfClkVncVUQy
         4NfKfO8o4bK5UnxAb4H9XvjKODdFuK4+idk3dKS+wjCQsnKCtJQ5uDLVCqNxDCHeSnVJ
         lyhVMlcu7aibWoRgO6A3/FwsZNe48B5EnYyMBFdZCSpHdBl84r59UBYKkiAsF7fCRgO0
         D+WlD2rBYnK+Ff48EJf1xOgJQHiFO7T0AJbF8EG4Uv8Ugmb17v6dZJtY9ft2mXGdACRU
         +ho2IhzRkZx7XdXCuuyV8PbEF39c537enhvePSB6EE/V1RHroFJZ1I8Klf3q5Tk/scBU
         y8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ljlq0wzNYgqZzF5mdTWeFZiAlKPfpNDbugOhA1C4lDM=;
        b=ww3GlX7K5Wb/VgDWzEnnClybHLADHX3l089GMqpBDtuxwx9jRPyZ5F/D+aVaTwwXtN
         +PwDY96/JdI6AjK5+PP11yAz2O6Lu9enyfMBILZod0ufkfUG8RfFj/+vKGYBMcWS2IdK
         oP9sl94YzZ/xjh4yssxYaSypZzuPCHhEKjowlDyJPjFCxSa6MgLbQGNMcP0DsNqEFlAQ
         vGNSlmDtjuORahlWdjhw/oHVAA8/RSuHlgRvbVyS4bnGOogHbAVQSp/zj6BjgOi8AtOV
         klARwIqqB5UR3W49B9cSPG5B7rNfJRMI4mciD9J+cwpSmNfER332zy3KmGQ1qY4TEMFB
         WY3g==
X-Gm-Message-State: ACrzQf1BeuNmXeFi02L6W97v35nlW6FwlPtD+1Reomo4wR6EhZNSmB3E
        9uo6E0CZralwseoA451l0Ho=
X-Google-Smtp-Source: AMsMyM5syXaucmQoxfMV0w2n6EFA7QVHRHRLVaD6hhVGmXqZgpqqfhy3f/oHTSCt85ZKkJzWadmI4A==
X-Received: by 2002:a63:cc43:0:b0:43a:2f12:d326 with SMTP id q3-20020a63cc43000000b0043a2f12d326mr2084263pgi.320.1667007055418;
        Fri, 28 Oct 2022 18:30:55 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090a4b4700b002137d3da760sm70187pjl.39.2022.10.28.18.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 18:30:54 -0700 (PDT)
Date:   Sat, 29 Oct 2022 14:30:44 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Claudio Suarez <cssk@net-c.es>,
        Harry Wentland <harry.wentland@amd.com>,
        Grigory Vasilyev <h0tc0d3@gmail.com>,
        Slark Xiao <slark_xiao@163.com>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH v2] [next] drm/amdgpu: Replace one-element array with
 flexible-array member
Message-ID: <Y1yCRHgx15ZOiCL4@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1x3MtRJ8ckXxlJn@mail.google.com>
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
flexible-array member in struct _ATOM_FAKE_EDID_PATCH_RECORD and
refactor the rest of the code accordingly.

Important to mention is that doing a build before/after this patch
results in no binary output differences.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/238
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Changelog:

v2: no binary output differences patch; report binary changes findings
    on commit log. Res: Kees Cook
v1: https://lore.kernel.org/lkml/Y1tkWdwPUp+UdpM0@mail.google.com/
---
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 7 +++++--
 drivers/gpu/drm/amd/include/atombios.h         | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index 6be9ac2b9c5b..18ae9433e463 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -2081,8 +2081,11 @@ amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
 						}
 					}
 					record += fake_edid_record->ucFakeEDIDLength ?
-						fake_edid_record->ucFakeEDIDLength + 2 :
-						sizeof(ATOM_FAKE_EDID_PATCH_RECORD);
+						  struct_size(fake_edid_record,
+							      ucFakeEDIDString,
+							      fake_edid_record->ucFakeEDIDLength) :
+						  /* empty fake edid record must be 3 bytes long */
+						  sizeof(ATOM_FAKE_EDID_PATCH_RECORD) + 1;
 					break;
 				case LCD_PANEL_RESOLUTION_RECORD_TYPE:
 					panel_res_record = (ATOM_PANEL_RESOLUTION_PATCH_RECORD *)record;
diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index 15943bc21bc5..b5b1d073f8e2 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -4107,7 +4107,7 @@ typedef struct _ATOM_FAKE_EDID_PATCH_RECORD
 {
   UCHAR ucRecordType;
   UCHAR ucFakeEDIDLength;       // = 128 means EDID length is 128 bytes, otherwise the EDID length = ucFakeEDIDLength*128
-  UCHAR ucFakeEDIDString[1];    // This actually has ucFakeEdidLength elements.
+  UCHAR ucFakeEDIDString[];     // This actually has ucFakeEdidLength elements.
 } ATOM_FAKE_EDID_PATCH_RECORD;
 
 typedef struct  _ATOM_PANEL_RESOLUTION_PATCH_RECORD
-- 
2.37.3

