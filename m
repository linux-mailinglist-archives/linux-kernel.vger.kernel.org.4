Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CF66CD67C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjC2JcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjC2JcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:32:05 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687113C1D;
        Wed, 29 Mar 2023 02:32:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg13-20020a05600c3c8d00b003ef90adc168so1385874wmb.5;
        Wed, 29 Mar 2023 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680082322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Avv23XPqNlpGIMWLh/TESJj7ffQ2JBTwAi7uETi93UA=;
        b=b1HJOuO8attyiOf5BQevzR0bmJsm+7CKgVef3qXZGZ/ArmmBEc3GVJf2Ss2omumB/v
         gQuTA4ENS43dDgbJV0HOt5koXrszzbN3+NBUVG/ZgAonsBu9T+6Lr7Fp1DJrICGEZyWP
         mP4BEeJVYLal3hRamKh+FWT8pe/wbqZEmnwAZIWkSp+/WlcywUaxyTPNcW8mA/q2dclF
         X648bwxJzocSPfELJl5sCdHzDgypdpZhx4N4XaN/ViR8yOxaT5JaHsv4fo8ODxSnRkMs
         nloq18rmePcgZ8y69J+QmNE+9n7XGEVH/ESNoBFFABIj+lvA9x4TrqqBHuRl614G4sYd
         ttBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680082322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Avv23XPqNlpGIMWLh/TESJj7ffQ2JBTwAi7uETi93UA=;
        b=FdzfYuP0MTwOzY1caQdHOLlR5dct80O9GM+Y+e/HFPIO2uXMYEjROBt7hN/IWEm2Hx
         WW6IZW3gcfyvYB97SoPqXOsTp7UhSj2hsb55DuKKvguPU3LrW0WlayIQmKuIk3NRn9iC
         5NcC0pfWyQhDX3Mg5Tdm3NF2b2tfqA3cLbD+3anuqlszTz2+pKfg7lBrZuyVx7+9Bt1k
         zLuHB9M2JZfmxBjJWwYsENayvLmx/8LOcnxOOj3X+mOfjgirXk0c/v3iE+KLrkyHZ3FU
         95znYKQU3S/WX8a5YzLogTn50HmmUlvDvpIAIDF4s0xIou/r49kFAQRWyqhp38BrGXxr
         Oo/Q==
X-Gm-Message-State: AAQBX9fpgt3cfN2sytGJfOR79S51j5/lHQF+x+nuQtiJl7Dh/HVXzU7A
        sKKcn/5XAcPBccehc7Snns0ig21j5ihSrw==
X-Google-Smtp-Source: AKy350Zbq4+5IwucGE4QGAx3Z7Mrlc4Lh9NFB1RPoIJf15U1sXMdvfG4MbAsKZVD0/ltvChJTNVmTg==
X-Received: by 2002:a1c:7714:0:b0:3ed:ea48:cd92 with SMTP id t20-20020a1c7714000000b003edea48cd92mr7646008wmi.15.1680082321759;
        Wed, 29 Mar 2023 02:32:01 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b003ef6708bc1esm1642557wmq.43.2023.03.29.02.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:32:01 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] optee: Fix spelling mistake "Unuspported" -> "Unsupported"
Date:   Wed, 29 Mar 2023 10:32:00 +0100
Message-Id: <20230329093200.419041-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a #error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/tee/optee/call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 290b1bb0e9cd..df5fb5410b72 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -488,7 +488,7 @@ static bool is_normal_memory(pgprot_t p)
 #elif defined(CONFIG_ARM64)
 	return (pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL);
 #else
-#error "Unuspported architecture"
+#error "Unsupported architecture"
 #endif
 }
 
-- 
2.30.2

