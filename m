Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6DA7060B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjEQHGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjEQHGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:06:04 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC2E213D
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:06:02 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5304913530fso352902a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684307161; x=1686899161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dja6n1QYOT0QdF33WA5S9z2IBWajgQssBMbcEbOlQ6k=;
        b=Meql198TIT6M6a364/S4hpN4M3p5SfgrUFM9xEa/Ljr9Wmjr2t4gk7BjQS8SHZfvSR
         0Is9qPTvvVWzbwweftOe9VkJCtwj5ucS9Q1d2zxZVQTSNwBIl5rLF6uuFZLaEkFAWxhY
         dtY+NjlIfWqbNzP95ivmyjVb7eqVUsnudnx0Umfpf0SPzj2nJB5Sf2ScYeK0SZ80lNRq
         IUialaYBiKBx9rs/UcVtiLdBcSuRDRW4HkawQnWdJuLg2HZazrbX4QbVqbAWOLPu+MLC
         lXZGcyRbG+i/v6cfpqmusR6SUa4wfsAnUGkQioiroefi2K/Kbv7lmJAEeFib8XdZ16e7
         dGvQ==
X-Gm-Message-State: AC+VfDxKxI/DDZOiwxpWB2xn+RLIFjLPoCgh1hLc2buAEa0I5u3Vl8sC
        NvRaFSKFy7qqCkIlG18xjlkLTtz7hls=
X-Google-Smtp-Source: ACHHUZ5QguHl2k+SFkc3S/ykgkKhUQZInn3xsKA7Z8lD67tG9dTHAaKcNdQVPoHEuwBLgl/bwFPzTA==
X-Received: by 2002:a05:6a20:12c2:b0:105:8173:93a0 with SMTP id v2-20020a056a2012c200b00105817393a0mr15244416pzg.5.1684307161118;
        Wed, 17 May 2023 00:06:01 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id t3-20020aa79383000000b0063f0ef3b421sm14825427pfe.14.2023.05.17.00.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 00:06:00 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     brauner@kernel.org
Cc:     anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bagasdotme@gmail.com,
        akpm@linux-foundation.org, Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH] ntfs: Add myself as a reviewer
Date:   Wed, 17 May 2023 16:04:23 +0900
Message-Id: <20230517070423.6379-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm volunteering to help review patches for current unmaintained
ntfs filesytem.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e2fd64c2ebdc..c2cecb2059d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14928,6 +14928,7 @@ F:	drivers/ntb/hw/intel/
 
 NTFS FILESYSTEM
 M:	Anton Altaparmakov <anton@tuxera.com>
+L:	Namjae Jeon <linkinjeon@kernel.org>
 L:	linux-ntfs-dev@lists.sourceforge.net
 S:	Supported
 W:	http://www.tuxera.com/
-- 
2.25.1

