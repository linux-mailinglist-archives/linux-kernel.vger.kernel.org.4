Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD6E5F7EEE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJGUgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiJGUgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:36:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF8D60F8;
        Fri,  7 Oct 2022 13:36:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h189-20020a1c21c6000000b003bd44dc526fso1564634wmh.3;
        Fri, 07 Oct 2022 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pOHfZ3Sx31FxA0S0BeP6EcfNHiCjgn3I1JbBdumkwP4=;
        b=RuacaJVJBA6iLTKO4EegSYRFbd4mg7MgtQNn8vnZ+GlKc85ZnypRZ59NKL7Bhmr7fN
         N+w2HSiSgeHXRv3XOvkBQMT+6QnXGpV/uCqjZkPwk9kyk7bPTvOJcP9FZIAoJWtXQs9j
         NUWcOrv6bF6fe63Mk92vd27EXrX0L5Osop1tAKpB3qww4NAKIOA6gqztP3UAbBSphrKW
         AfvhyPqMrGX5BM3OeQnxXoCYw29f3rEml/SYmcm9QW6kYmeMhvDn1pfosNKQCgR5PHjS
         50YTzUmS0AovUdM9DkcxkHBry62WiJDTn/fQVMrvjZlNujvx5daX0zBtgCNn+8InAsCU
         doRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOHfZ3Sx31FxA0S0BeP6EcfNHiCjgn3I1JbBdumkwP4=;
        b=Of63PUCz0rDtLhRqDx8apv5p9clw0Jtj/ordV9RVCJXRtA7wLPSkAErEAkt8Y32zQF
         bNDUEJ4BGcHoaSrb4UCm3LjDrk5qHudQ+vhwuj2Dml1riMRWz2y3jD5Bs+/C/TmZBe60
         zezieE61JtPD111ZHQs1pmm7aOY26GT0/9bEGzcxV7Mddtaz9Kr0rURzTfMg/V/JFu+M
         inPDSj2s2H/GXAiAh0498g0IINFUxInwO8OHVkKrwb9AFv20E70BDcWaxOdx3tikewvL
         dSy4sbH35pExcZG0YxKFqbOD7ePnnNPSG9S8KjFxtqocUfKeydLHUsHRt1CtME4/1f2J
         L8gg==
X-Gm-Message-State: ACrzQf2uBUoHWScorQ+MB+ZZEKp2WIT+i03e7wsgccyHElSQYKYVRI4O
        Oj2n847tQvxe2V54KrzAF+SKnR2UiYm6KdZc
X-Google-Smtp-Source: AMsMyM7JCpo9Fml6evtYnchhoBY6DO5X2EA77jsz/2kxEPQwY3XaCso+afLoMuQLikAp56JH42RIrg==
X-Received: by 2002:a1c:a3c6:0:b0:3bd:1b3:d334 with SMTP id m189-20020a1ca3c6000000b003bd01b3d334mr4605114wme.90.1665175005780;
        Fri, 07 Oct 2022 13:36:45 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v22-20020a05600c12d600b003b3401f1e24sm3010600wmd.28.2022.10.07.13.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 13:36:45 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cramfs: Kconfig: Fix spelling mistake "adressed" -> "addressed"
Date:   Fri,  7 Oct 2022 21:36:44 +0100
Message-Id: <20221007203644.2756986-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a Kconfig description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/cramfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cramfs/Kconfig b/fs/cramfs/Kconfig
index d98cef0dbb6b..a8af8c6ac15d 100644
--- a/fs/cramfs/Kconfig
+++ b/fs/cramfs/Kconfig
@@ -38,7 +38,7 @@ config CRAMFS_MTD
 	default y if !CRAMFS_BLOCKDEV
 	help
 	  This option allows the CramFs driver to load data directly from
-	  a linear adressed memory range (usually non volatile memory
+	  a linear addressed memory range (usually non volatile memory
 	  like flash) instead of going through the block device layer.
 	  This saves some memory since no intermediate buffering is
 	  necessary.
-- 
2.37.3

