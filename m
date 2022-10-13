Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655575FD401
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 06:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJME4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 00:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJME4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 00:56:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A3B10CF85
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:56:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pq16so954299pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28zn6cgsHU6YtpOZu1YU2asuZjVGXsycTYTjxJ6pRUA=;
        b=O9XnoY1yPcJ8rbfuH000Q/NubRyjXPpGjHuUIzAcrc8zp4D2KRmC3Nu1hzSAtq3CeI
         ZyJ4LGZfAAVpvplG9HJ1twTStgWTomI7FGgrCkrPhjmcebLJST1t2hlaiHc/GWiEUkAw
         Ai+m5mIl0mWJ2EtkP3PRaUICKIAxUcpzfH6LGT+X0VIUocgbxq68qp3ykYt9NsnLB9x0
         56zVgFqh5p1hKK6CIaJJaatil2A3o2l6RIDcHrn2FQ+tk7LhUn4LRkwUqAN5dm39F4Wg
         F5Xi4+lVzqePnpDkvCuDTR8xNwymr93dXZtOfW4Q/YLKphDHtJSeDdWnecG6kqzXgdtY
         62ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28zn6cgsHU6YtpOZu1YU2asuZjVGXsycTYTjxJ6pRUA=;
        b=uImPvLM5P+5Hi9qkbik6GcEqxoTGo/+mR/zpNxbH7rQvf3huuWZAGqhjb2f5yF41Gc
         YUnK/Yw4b7awAG/GfDg1Z30YHtohriYLewoA4DLDfBzQzAa5Cdky6nxawLWG7AE18Spv
         mAWjtKArnLaQn85JES9Y+hrqdA+D2vlxR/smKM2X7l1CbgBR6CDv6OWFyM0Z0In8aYEs
         eq29r9yM9WlvWcKfFffF30s9DpQnUAcXc/akU82dwC3S2KK/sFlavYaipTYNTp+MydEk
         LzrBicB4QbWEDN13tLPTrhqk/utwgtd5aubJdAEFa7tPJE17ddvAF1sRPpzgTlLIk1u2
         1x+A==
X-Gm-Message-State: ACrzQf0r+/akZhyZpbuiFfET5lYEXPdv7fv402U0oQ6c/myXISSl7FIF
        67rLjplMJc2E1gO8lZ3cmUU7EA==
X-Google-Smtp-Source: AMsMyM4ugjiBwSXQxda1eNvwHmBz2fBmeCwoTH5OfbxNJoRGhqGRqBSY9uGTlgP9MR/U/J7DH821hA==
X-Received: by 2002:a17:90a:5ac2:b0:205:de77:72be with SMTP id n60-20020a17090a5ac200b00205de7772bemr9337413pji.24.1665636983966;
        Wed, 12 Oct 2022 21:56:23 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902d41100b0017bb38e4591sm11385104ple.41.2022.10.12.21.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 21:56:23 -0700 (PDT)
Subject: [PATCH 3/4] Documentation: RISC-V: Mention the UEFI Standards
Date:   Wed, 12 Oct 2022 21:56:18 -0700
Message-Id: <20221013045619.18906-4-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013045619.18906-1-palmer@rivosinc.com>
References: <20221013045619.18906-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, Atish Patra <atishp@rivosinc.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>, Atish Patra <atishp@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

The current patch acceptance policy requires that specifications are
approved by the RISC-V foundation, but we rely on external
specifications as well.  This explicitly calls out the UEFI
specifications that we're starting to depend on.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 Documentation/riscv/patch-acceptance.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/riscv/patch-acceptance.rst b/Documentation/riscv/patch-acceptance.rst
index 0a6199233ede..9fed6b318b49 100644
--- a/Documentation/riscv/patch-acceptance.rst
+++ b/Documentation/riscv/patch-acceptance.rst
@@ -20,9 +20,11 @@ Submit Checklist Addendum
 -------------------------
 We'll only accept patches for new modules or extensions if the
 specifications for those modules or extensions are listed as being
-"Frozen" or "Ratified" by the RISC-V Foundation.  (Developers may, of
-course, maintain their own Linux kernel trees that contain code for
-any draft extensions that they wish.)
+unlikely to be incompatibly changed in the future.  For
+specifications from the RISC-V foundation this means "Frozen" or
+"Ratified", for the UEFI forum specifications this means a published
+ECR.  (Developers may, of course, maintain their own Linux kernel trees
+that contain code for any draft extensions that they wish.)
 
 Additionally, the RISC-V specification allows implementors to create
 their own custom extensions.  These custom extensions aren't required
-- 
2.38.0

