Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABAB6109C8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 07:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJ1Fli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 01:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ1Flf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 01:41:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C4716DC1B;
        Thu, 27 Oct 2022 22:41:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b11so3807690pjp.2;
        Thu, 27 Oct 2022 22:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5h1uqHInDk0I1emW0j0vM0oqjvApQuj+THRSewTlOpA=;
        b=SbzX8SLGaIh2otqVVFv5ZIRm42Vm/IZn26w2jy0c3lFOlh7No0+2E9QVPHm4o5gNnh
         JGgzYKd3OKxHwNTzDHDWdlCjTdlGft8P+VLjbdUanaDb0G/dIFoRvWDHjusRyb/AuW5f
         GDc/ktimhgqu9frifKdT7qsUiTP2KAJBxRfTtsHuUlXA9hpR5l6bKAvUqeO3xw2+xril
         vEfPjByXk4QPkWvOyd0ROFz9LMfsf5O+SXwcd6T5wmpQ6wFHh0tfYYdLZCAVuJuUXxmx
         Ks8jr3+Niz1BhqZgOrvZTgy8kApxnAkM1H1TM0XahdN5Y5wCGZdKczg5Sr+UAQiwIO+L
         ktKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5h1uqHInDk0I1emW0j0vM0oqjvApQuj+THRSewTlOpA=;
        b=n+rYKZaHeyx9VO4hfDZ13s1uOfK4spYd88oTc59O3x2ig+zOQomrHOOiVkQ/EGhtk6
         UAntMpDYWz9lvTaC6i0vFiOrMzys9oMaHYUM8/VSx0A3MiAR98128sZIasJ38kbxkOFW
         WAYdaQldgh9nuln4CRKTdb/SzVrzILz3M9WVlKqAuYFC5rxAZTVg1mP5qBZwBlXgmfSP
         ZG5ZF5t58GDbXQ4v8JDC2nw0qGRwvIZ/1tUa3VkASbkkcuczEjGtUsBeV5yZKYYnz3KV
         DWIwwZbHNAwlzwma049dWy/dzdion4GE4F7hr/Kd+x9iYoTWzlujErMliDwe6mFdJgBP
         FVmA==
X-Gm-Message-State: ACrzQf1v+G2ApXrsvW76s5sZUY/xHnEDs29KeY7diHH9qVKFCpHhAG0c
        8YKnvUNoizIZSjO5YLRuWA4=
X-Google-Smtp-Source: AMsMyM74U+GHRlbS+IT1ksUQflSJtoFhADFBb2GzOHO8M2cLyNXJeFO72V3r7BEjfD3dqjhnYCt+CA==
X-Received: by 2002:a17:903:2305:b0:186:ed93:fc3f with SMTP id d5-20020a170903230500b00186ed93fc3fmr6506725plh.15.1666935693570;
        Thu, 27 Oct 2022 22:41:33 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902e48200b00177faf558b5sm2083579ple.250.2022.10.27.22.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 22:41:32 -0700 (PDT)
Date:   Fri, 28 Oct 2022 18:41:25 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH] [next] drm/radeon: Replace one-element array with
 flexible-array member
Message-ID: <Y1trhRE3nK5iAY6q@mail.google.com>
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
flexible-array member in struct _ATOM_FAKE_EDID_PATCH_RECORD and
refactor the rest of the code accordingly.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/239
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/gpu/drm/radeon/atombios.h        |  2 +-
 drivers/gpu/drm/radeon/radeon_atombios.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios.h b/drivers/gpu/drm/radeon/atombios.h
index da35a970fcc0..235e59b547a1 100644
--- a/drivers/gpu/drm/radeon/atombios.h
+++ b/drivers/gpu/drm/radeon/atombios.h
@@ -3615,7 +3615,7 @@ typedef struct _ATOM_FAKE_EDID_PATCH_RECORD
 {
   UCHAR ucRecordType;
   UCHAR ucFakeEDIDLength;
-  UCHAR ucFakeEDIDString[1];    // This actually has ucFakeEdidLength elements.
+  UCHAR ucFakeEDIDString[];    // This actually has ucFakeEdidLength elements.
 } ATOM_FAKE_EDID_PATCH_RECORD;
 
 typedef struct  _ATOM_PANEL_RESOLUTION_PATCH_RECORD
diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 204127bad89c..48de2521f253 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -1716,7 +1716,7 @@ struct radeon_encoder_atom_dig *radeon_atombios_get_lvds_info(struct
 							max((int)EDID_LENGTH, (int)fake_edid_record->ucFakeEDIDLength);
 						edid = kmalloc(edid_size, GFP_KERNEL);
 						if (edid) {
-							memcpy((u8 *)edid, (u8 *)&fake_edid_record->ucFakeEDIDString[0],
+							memcpy((u8 *)edid, (u8 *)fake_edid_record->ucFakeEDIDString,
 							       fake_edid_record->ucFakeEDIDLength);
 
 							if (drm_edid_is_valid(edid)) {
@@ -1725,10 +1725,14 @@ struct radeon_encoder_atom_dig *radeon_atombios_get_lvds_info(struct
 							} else
 								kfree(edid);
 						}
+
+						record += struct_size(fake_edid_record,
+								      ucFakeEDIDString,
+								      fake_edid_record->ucFakeEDIDLength);
+					} else {
+						/* empty fake edid record must be 3 bytes long */
+						record += sizeof(*fake_edid_record) + 1;
 					}
-					record += fake_edid_record->ucFakeEDIDLength ?
-						fake_edid_record->ucFakeEDIDLength + 2 :
-						sizeof(ATOM_FAKE_EDID_PATCH_RECORD);
 					break;
 				case LCD_PANEL_RESOLUTION_RECORD_TYPE:
 					panel_res_record = (ATOM_PANEL_RESOLUTION_PATCH_RECORD *)record;
-- 
2.37.3

