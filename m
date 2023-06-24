Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC5573C703
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjFXGD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFXGDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:03:25 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083A126B3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:03:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b7e66ff65fso142795ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687586604; x=1690178604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hBPPH4/uw0ABWvVPTs2OWTzo1oNRx61u6JuJ/5dY43c=;
        b=I0vRFb+kCb71Z0VAHVn+jYVYu4Xd2HLgqO4gYa8zyJmzJVQgFpUYnMQ8H5ZenOEacF
         HHFZ5+OP/TQq06FRNQrPH4QN66dq4PM3XLOc517r3+6xj9Q+CIEShSzFXBt34sbmoTpI
         MdfWZGmHEWVKJ3v7yuyrwzoxNEBDFmvzXg5+gtXoIDBIp85spmcNBjUjJTg5PQ249ev4
         fPju/XdxvcA4LErbMgJtyQF9Vg11QPcTEKZHHhK0s+Xq0PbfDshFFA4+yTOH9ChWv1hk
         DHY+KCUEAUxXLle4/wJQXvrtVJGN+iRNpyOhd5N8PdrPtBF+8SnHy0HZfmT64kURnZTL
         9CzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687586604; x=1690178604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBPPH4/uw0ABWvVPTs2OWTzo1oNRx61u6JuJ/5dY43c=;
        b=AQt9tCEdbaCW1i4D2b2d3qam8aLapoTxb198DATamjnqa875vfaviS9qPW4kJeEtK7
         oFb31Oqua3TkEnMvfy2JI9MM5TBfH5zF2YLvQu3jNBpFIUPAhhtep5cqjM1WZMCkXhkJ
         jZbv2mr8b/FBEIItDuceKBtpRITj3pMKiqB30TfdWQTGXtsZ+SKeW8Dzt1eKQjYOAYm6
         fO9HYHpFQ2106sCLkrvqqJvQvAP5zXNHFDvRngO7pIbReIox6KWTC5bZXZxMAF/6DWFq
         QzmvoLJyZv648+k30TWQfLsrQfZ3pdMhe0KGa7R3/8fioR7dYSkFvh2bjnGOqC++dYqh
         3QXA==
X-Gm-Message-State: AC+VfDxgrYHZRQSldOyGKuXzIeYX6jaTZZtB+WJY3qWRwsENwZrkpAgK
        QiL6c1sUMWhId/0FxlmXQ/6SiQ==
X-Google-Smtp-Source: ACHHUZ4V9zO6Xv3qreahhHVgK9sxCO7H5Govxp5RPtg6T+PU20Khx2zOATbEIt9AW0daKtDaQEHVWQ==
X-Received: by 2002:a17:903:41c7:b0:1b5:5ad6:ce9d with SMTP id u7-20020a17090341c700b001b55ad6ce9dmr1527206ple.50.1687586604471;
        Fri, 23 Jun 2023 23:03:24 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090341cf00b001b539640aa3sm465802ple.283.2023.06.23.23.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 23:03:24 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: Select HAVE_ARCH_USERFAULTFD_MINOR
Date:   Fri, 23 Jun 2023 23:03:20 -0700
Message-Id: <20230624060321.3401504-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allocates the VM flag needed to support the userfaultfd minor fault
functionality. Because the flag bit is >= bit 32, it can only be enabled
for 64-bit kernels. See commit 7677f7fd8be7 ("userfaultfd: add minor
fault registration mode") for more information.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5966ad97c30c..21e864fa93db 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -97,6 +97,7 @@ config RISCV
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
+	select HAVE_ARCH_USERFAULTFD_MINOR if 64BIT && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
-- 
2.40.1

