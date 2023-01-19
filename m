Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1955067312B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjASF1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjASF0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:26:47 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C020CE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:26:46 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id g9so818100qtu.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC4jG2P7TxWk2xJp/iiDtds8NtE5bfDPvvXdGd6AAck=;
        b=NAGaDdwxyXQU9vq7ltkCPRl1iGhpgYu/A2RgiYg6jwn1rEsUpWIb+1C7cEqotNB2dH
         3kC8jzOXysoav7zP3YE+69BlP0NgLv69Ow30Q+l7FRS9H0JFopH80KG7yEsMmkLITON7
         Y+av8jnv+G3M/d4rtXltAvKRf3LFLxiuTupvkvziaZOtddRCie0OdfyAdB0NEVdqNvkc
         B4svO4SegF0tP6xvxalxDC36jb8wGnEZMWfdoh7p1vGi0Fz5ArhGhu3OlkMBx3DfVbPA
         SxClmoaOnUNIkPS225ElDLrxWGLxfvvO89R39rK3hUtMTLno7NgOTRuAK5UH726aT6zv
         R6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tC4jG2P7TxWk2xJp/iiDtds8NtE5bfDPvvXdGd6AAck=;
        b=jk1xOs/vbf1u6u0n6qT4zTm3CTAl2z+cbO/QsId/j2Ml4P+i+y4r6JonXVQlimPKBy
         nH16VXSyQN0SPrMMQtfW4o0cFhIN58359u187OdSCJ2qLs2beAkRb/9ziqzAgBTdAmYF
         3KJjOzXSsIu2AWeilYbGPwN5qD9sdgYcjSRoh9iUG7meAlajaW4kNIMK7Y4X6rwQBTQu
         eaGAc5y/hrkDzJfFvMDOu02N5sUN3jECNHu9eeg6UCvDIYMNp/MMmUvCFYbpgN4pTpAy
         CdTo9hUVBWUQabhmvwnA/mzlR6ERIoGZTwAAM18TRLBZm7Hu0zjSk/aCNBGjvlu7LCoZ
         9CHw==
X-Gm-Message-State: AFqh2kreSJRMJ+HKpmWAuOVDa1ouuCapO2ekfuA9tF8mYmpZQggPMEvi
        49m8T8kWFnHprIZQWghAIfo=
X-Google-Smtp-Source: AMrXdXtbA85An2UlTdL2XzbhfLYOvcD87z0EDVwbQ4RYCtnVmmT6y5CqsNyrZiS3va0/p+EQApDNig==
X-Received: by 2002:ac8:5ed2:0:b0:3b6:313a:f461 with SMTP id s18-20020ac85ed2000000b003b6313af461mr12124149qtx.65.1674106005334;
        Wed, 18 Jan 2023 21:26:45 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id v21-20020ac87295000000b003a5430ee366sm507330qto.60.2023.01.18.21.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 21:26:45 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Yimin Gu <ustcymgu@gmail.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v1 1/2] riscv: Kconfig: Allow RV32 to build with no MMU
Date:   Thu, 19 Jan 2023 00:26:41 -0500
Message-Id: <20230119052642.1112171-2-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119052642.1112171-1-Mr.Bossman075@gmail.com>
References: <20230119052642.1112171-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yimin Gu <ustcymgu@gmail.com>

Some RISC-V 32bit ores do not have an MMU, and the kernel should be
able to build for them. This patch enables the RV32 to be built with
no MMU support.

Signed-off-by: Yimin Gu <ustcymgu@gmail.com>
CC: Jesse Taube <Mr.Bossman075@gmail.com>
Tested-By: Waldemar Brodkorb <wbx@openadk.org>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 arch/riscv/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 59d18881f35b..49759dbe6a8f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -163,8 +163,8 @@ config MMU
 
 config PAGE_OFFSET
 	hex
-	default 0xC0000000 if 32BIT
-	default 0x80000000 if 64BIT && !MMU
+	default 0xC0000000 if 32BIT && MMU
+	default 0x80000000 if !MMU
 	default 0xff60000000000000 if 64BIT
 
 config KASAN_SHADOW_OFFSET
@@ -262,7 +262,6 @@ config ARCH_RV32I
 	select GENERIC_LIB_ASHRDI3
 	select GENERIC_LIB_LSHRDI3
 	select GENERIC_LIB_UCMPDI2
-	select MMU
 
 config ARCH_RV64I
 	bool "RV64I"
-- 
2.39.0

