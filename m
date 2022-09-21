Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448955BFA55
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiIUJMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiIUJMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:12:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4E97754D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:12:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id f20so7661563edf.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date;
        bh=EUT7U16Zxb0ZExEemxBABTNFCTWV0UDUspkxIn18yIE=;
        b=RmyMZIVdigRGiSJK9ug4SPUwCvbOYt5uXxjoVzDCxmoVfr3AnDCuT4xq6iCx3t397D
         CBWlp932QgpzumiSJ90dCDEUB5+SCtxJCmeUbC2XssRvj8hG2BwllAANU+bSARgUIRjt
         b4pwla+S4WmrrsF2Kk4W851z3czNTNz6MJhgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=EUT7U16Zxb0ZExEemxBABTNFCTWV0UDUspkxIn18yIE=;
        b=qBVdPwPBuBFg4DAGgZb4iiWJsACqH7tyl9AHPsHpVrcLwSJzafhrq5uELo8qEkZNdM
         uTH2kFKiWfbe5lbRQAN0Ay6FGGQ9iSMtUR9kXxRnzoMLKfsW5ZIqqp4dN1v9lgOJYhOP
         JCzVecB9SFcqPhpY5KfqIdtaZ6KgN9sVRKZ5APlRLIAems9I0X4JNuH2c7vLK1iGu23y
         Qwjo3eg0DLRYC4/hu3UpW3b2tmPHyWGnkCa0EZbua8TNNqbEmgoKfmvcNIONHfBLrMDC
         HQAQ+hS9vbwiAwg7Smb1IDRtK6sh/5ErpmIvSj0OeXcASSoko8UVGqRHKPDg8ImoysrS
         2uPA==
X-Gm-Message-State: ACrzQf0f8Dul9Jj3ECryuf3UhgkpDZB510kSanVEAVkV2UUIqh0V0Y3E
        jzeLNyvREpXuduQT/vGsUYb7MA==
X-Google-Smtp-Source: AMsMyM7DJ5F/JsPnlz8SNEaLEwm7FyfXZsg07sqfKLlxCDefE7CrVQakliNWhQ2I4mQsX2GoZ4Cr1g==
X-Received: by 2002:a05:6402:14cb:b0:452:f1b4:7e52 with SMTP id f11-20020a05640214cb00b00452f1b47e52mr23506137edx.177.1663751552599;
        Wed, 21 Sep 2022 02:12:32 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:160b:cee7:2e8b:f72c])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090690c400b00771cb506149sm1031913ejw.59.2022.09.21.02.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:12:32 -0700 (PDT)
Subject: [PATCH v2 0/7] [RESEND] Follow-up patches for uvc v4l2-compliance
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAGnVKmMC/4WNQQ7CIBREr9Kw9hv4UrWuvIdxUeC3kFAwH0timt5d4gVcTd5MZmYThThQEbduE0
 w1lJBTAzx0wvoxzQTBNRYoEeWAEpgKJQdVRwSbl1cMY7IEenKG9GTcxfSilc1YCAy3zLd6WmNspg/l
 nfnzO6uqyePvblUg4apOZ21VjziYu/Wcl7Aux8yzeO77/gVbO3FwxAAAAA==
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Sep 2022 11:12:09 +0200
Message-Id: <20220920-resend-v4l2-compliance-v2-0-7c0942040004@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=MMjSLZT6eS0B8Bc0AeIXpf2+IIYhod4p4XLb8hr5I+8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKtVst+MgB8+USDe0HYhBUikfa4zIgh+mP/aMVo6M
 e0C725GJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYyrVbAAKCRDRN9E+zzrEiPS5D/
 9Ss2Rr6+kQ/6HAwhbL5r03vDQ+EIu68x/tVlMYGtkRbfBNbYOknBvqfvNGGsVF4f1aXCrDjGSnVI5+
 qvauh/Pz4r6Q3o9awAjIeucFTvU1WeD6fTi2+kGutHV1oCNMCeDLePAunKnLs0a3BnDXaz7Uzsl9Uk
 IThunq1X9DNQX7qbFIV9BPuZFGKzZrnU5lkDvZY8cBwd5DC9Jz9v9fj6c0eQ4ks5sSbsRFMPdLR5YB
 1suQ+Q9rtMVcFsDuXBAmx66n+/rWvmCZjjiaPmG639McfdrkHmsFsOX+y5FbNkhmeQaxjBjswcP5wC
 9WrrqoS0p91HCw2+f/f4Kh1A0d11ar0MCkcN5oe6SehzD1Wd0Zy6BpOmOvryAy/GOFaOUJnpqZb3fv
 80QZUfB77dysDLBFqWkRhou+i74sxvjy7P6ee5q27j675FIUkc0HQ49ayT/wmsZa3FQpHtCGgRV+3I
 ZD+Pu8Iz1bxLR5UFyQUHvR7P88Mig8jEGCHUDJWxzZrSnmJmgJnF+gMdaMi6fRsYrkNmx+QbsWeGS2
 UgO6d6koxoSx1iDJJM57hJBswVc+JVCGuqSeX9JBTQPUKu8OuQDTJRn+RPaRKCEfoFtMB8mNmw0rSo
 2txEpe5FGzS9Vz412t+HOxpGbk+6eA6ES1jJlW3XwzsVWqXX+mhVPSKCebBw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains the fixes for the comments on "v10 of Fix
v4l2-compliance errors series". In particular to the patches

-uvcvideo: uvc_ctrl_is_accessible: check for INACTIVE
-uvcvideo: improve error handling in uvc_query_ctrl()

And the patch:
-uvcvideo: Fix handling on Bitmask controls

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v2:
- Include "Get menu names from framework series"
  https://lore.kernel.org/r/20220920-standard-menues-v2-0-a35af3243c2f@chromium.org
- Link to v1: https://lore.kernel.org/r/20220920-resend-v4l2-compliance-v1-0-81364c15229b@chromium.org

---
Hans Verkuil (2):
      media: uvcvideo: uvc_ctrl_is_accessible: check for INACTIVE
      media: uvcvideo: improve error logging in uvc_query_ctrl()

Ricardo Ribalda (5):
      media: uvcvideo: Return -EACCES for Wrong state error
      media: uvcvideo: Do not return positive errors in uvc_query_ctrl()
      media: uvcvideo: Fix handling on Bitmask controls
      media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
      media: uvcvideo: Use standard names for menus

 drivers/media/usb/uvc/uvc_ctrl.c   | 230 ++++++++++++++++++++++++++++---------
 drivers/media/usb/uvc/uvc_driver.c |   9 +-
 drivers/media/usb/uvc/uvc_v4l2.c   |  85 ++++++++++----
 drivers/media/usb/uvc/uvc_video.c  |  15 +--
 drivers/media/usb/uvc/uvcvideo.h   |   8 +-
 include/uapi/linux/uvcvideo.h      |   3 +-
 6 files changed, 258 insertions(+), 92 deletions(-)
---
base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
change-id: 20220920-resend-v4l2-compliance-4fdbe4fbd7b5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
