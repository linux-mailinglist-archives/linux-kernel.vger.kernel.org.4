Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3341B6C5944
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCVWHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCVWH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:07:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00381A640
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 15:07:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ek18so78944112edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seecs.edu.pk; s=google; t=1679522843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVG2u0PxjcHnMZyDP5cFJRBQ+0w73Zdls1zxTkcKhxE=;
        b=4BllPFkRTczeJDJcUxBJ4nsD6E4yo6yZMqI5ufh32vPtKvfVCk57nb7nG3lnCd7pLg
         IZf1khqXXszZgb3ZKun7cZ0SEvW0V1Km+MTlbTlLMA+9NCZLXTAy42vqSW3yCafM5wrB
         rTfpNxBxJLw2I1H/aKLoXRpLnMGIpUpdCB4yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679522843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVG2u0PxjcHnMZyDP5cFJRBQ+0w73Zdls1zxTkcKhxE=;
        b=enqKcIRy1ZLYbAIy03N1msGB9V+wbXPeRUbsSlTbHF8/CkLZCyC4P9hE2+26Mm1fHV
         S9uCHSEC2b4GXtY9UrJYQwpRlbUVuFmOa450fmhy7oDSBooWVk/J8aBmgmC9AfI5ou1v
         JsvuUH1wTl/Xz/lAuAmvWK8meTyOTw8XxanqZ+CSXd9kgqPP7VHSpEtF0tWUjQ33GfWe
         E2Kwk9KOGLH89udJOVcygDD9HJvaqxIuNCXsXU8tOPkKT78So52rEnn8JSq/tBiYO1bE
         49fzHy/neLd2//7l8cbrQfCvFkaCWKaOAA9gKpEUl8nTGBHcbYCNc8cXe1y1e9mvaY19
         miTw==
X-Gm-Message-State: AO0yUKW26BqERawKkyvAJPlQxW+cSyemM7GTbE+dOKMff7QFLkjc/JE7
        j00nMPOHgLJLnAK4RTwyJnIKAw==
X-Google-Smtp-Source: AK7set+SkK/C2Wqx91jsFrtmCMtKRHhrbDLMipKVjE/mmH6XsanIVqmWwvsaMF1HoLCV4+Nj+3O/5w==
X-Received: by 2002:a17:906:4f8f:b0:925:5705:b5b8 with SMTP id o15-20020a1709064f8f00b009255705b5b8mr8138114eju.58.1679522843190;
        Wed, 22 Mar 2023 15:07:23 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm7787935ejk.114.2023.03.22.15.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 15:07:22 -0700 (PDT)
From:   Khadija Kamran <kkamran.bese16seecs@seecs.edu.pk>
X-Google-Original-From: Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Khadija Kamran <kamrankhadijadj@gmail.com>
Subject: [PATCH 0/4] staging: rtl8192e: code cleanup patches
Date:   Thu, 23 Mar 2023 03:07:00 +0500
Message-Id: <cover.1679521517.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix several cleanup issues reported by checkpatch.pl in module
staging/rtl8192e in file rtllib_rx.c

Khadija Kamran (4):
  staging: rtl8192e: remove extra blank lines
  staging: rtl8192e: add blank lines after declarations
  staging: rtl8192e: add spaces around binary operators
  staging: rtl8192e: remove blank lines after '{'

 drivers/staging/rtl8192e/rtllib_rx.c | 73 +++++++++++-----------------
 1 file changed, 29 insertions(+), 44 deletions(-)

-- 
2.34.1

