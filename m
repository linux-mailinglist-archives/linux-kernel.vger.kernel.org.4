Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35376418C4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiLCUXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiLCUX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:27 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B951B9E8;
        Sat,  3 Dec 2022 12:23:25 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n9-20020a05600c3b8900b003d0944dba41so2317689wms.4;
        Sat, 03 Dec 2022 12:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOPpk3F63YJM7B8vtZeeoYKXEwkghnICZM7JjkrRZ3U=;
        b=R0j6F0ZJ4tm/K/ZCm/5xEaeLBuZoZXfC2gcIRfB4LwefS5RWu77QcbsYzn50+M5qIs
         e6KiewpbemadN3V2sqsZ9rGtLR73U2K/PCIzSFOcat9N7W2DOGVMW7LcWitgbp8a+VtH
         JWTPjMMwqreohWbUh2nPPc1A7PUiMTwxoy5hlykpgePASmb9JBUrzoI71LZbh6w1n+0M
         4JgULEJ3HSWL00oPKJ/6bbUi2KlI+fDCN77VmMGRxj1XidJ/plbMrhUYXUQmY8W1+ZOS
         M5xnT5kCUAA5zRMekbnYHH0n0/SCzijusIzkPbSL0rodyAnvqHLXiK6d3stC+gOQ19by
         HF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOPpk3F63YJM7B8vtZeeoYKXEwkghnICZM7JjkrRZ3U=;
        b=2qjnm7j4K9N0fb74QXtO0Wu518HUiaXSoqoJDQDJQUlPQRRo6qNLLEu/lrVjNtoowm
         UcvHieBrwVs1aarVDGFsxrvhC1sb5XUzij/W754lcZ37z4/LZQuw01DVYE7tbjZkx560
         OS8Ngc6hd8qgSc8NKXL+EsVgrL7b/ncRjEIoKsoZrkjrt4tfVSxxhrWs2Q86PLuBjaAh
         jcGbkOR3YKqow9ULhL8jxY/htkXd1FNvry22bc/lSw0CgGfJidFKUMizldaEq0f2U3Hs
         9MzYEuY4hVNyX7PEosnlOuto3Sr+ci/mFCQBt6TUA2iDJRQ9unvm3xiVHKVAtuvsf2kq
         8rFA==
X-Gm-Message-State: ANoB5pnPhuGoH8NBdpz/u+BzK0b2Goa+V6cG1lwVWQb5JTHJnw+DXSyk
        W9X/nienwkL0ZHNQ7CDn8bOM2HwVhAA=
X-Google-Smtp-Source: AA0mqf79maKanJMnDJx8giBtF5XWz7YkG07Y3VMwgO33dZtBWEgy9lv3TaXs/R4mABb6S0lgzDCNQg==
X-Received: by 2002:a05:600c:3d16:b0:3c6:de4a:d768 with SMTP id bh22-20020a05600c3d1600b003c6de4ad768mr42017335wmb.61.1670099004416;
        Sat, 03 Dec 2022 12:23:24 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:24 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/41] copy_file_range.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:42 +0100
Message-Id: <20221203202317.252789-7-alx@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221203202317.252789-1-alx@kernel.org>
References: <20221203202317.252789-1-alx@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 man2/copy_file_range.2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
index 3cb15e930..1360338d9 100644
--- a/man2/copy_file_range.2
+++ b/man2/copy_file_range.2
@@ -13,8 +13,8 @@ .SH SYNOPSIS
 .B #define _GNU_SOURCE
 .B #include <unistd.h>
 .PP
-.BI "ssize_t copy_file_range(int " fd_in ", off64_t *" off_in ,
-.BI "                        int " fd_out ", off64_t *" off_out ,
+.BI "ssize_t copy_file_range(int " fd_in ", off64_t *_Nullable " off_in ,
+.BI "                        int " fd_out ", off64_t *_Nullable " off_out ,
 .BI "                        size_t " len ", unsigned int " flags );
 .fi
 .SH DESCRIPTION
-- 
2.38.1

