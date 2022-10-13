Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914475FD402
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 06:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJME4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 00:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJME40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 00:56:26 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4670110B30
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:56:25 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r18so611908pgr.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBUW8W9IHpm/LsPPxDUBqPLclXqN19ToVh29BLs8YZk=;
        b=OB11k6EzJwNvSCmIlAfMmIOJpHbpIOqkQWvUJ4Jvl8mr2f/Os4CyZ0nNb8BzO3KPNt
         jHdnvy5LRvpx69LLOlPGddElGnjkCzNsuXHlPtwh4t88JPdjUBbTOFEv6b0hyRkb7lwU
         2AsmsmLHTeeIxJqBIdODZ9zySeQOnkn7G8fqCaHVwL74dqt3YUWilHrxY38llh45qxUH
         e0xvAPfRMUpu/iuyKnVludvj16BPlPkL7qq0oCRyNEhlUphB3aDDWrIro4FD+4rSCPUi
         ZE6hOnFFlz1crUS3eng/zwaq8NOi+MdF+PcXGsbpDed6tJBy+UU12buSuRD3580JrY2S
         Dpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBUW8W9IHpm/LsPPxDUBqPLclXqN19ToVh29BLs8YZk=;
        b=WQaW4bC6eO7whFGhww67v3nSqqzBausPXXHSUWRz0PW7i7Cximb8FE8Nczpfc9Wbwo
         7vYxyPBTjMShv16l30G/GMy0O17202AyD9/kiVv4o3xX1Rcyxdvsu5l/CHaOJkaJ2Y+9
         ZreCFIS5A5/gcEwUKrw+J8kFVp/evwSjou30VMGj7Ywagy85Ezdf3VipdjVtJwTE/HOM
         yXK6Lzi9Vt9vfm7lwLNyl6JTdJkOFT3VK6iSGmxPFO6GKqJNHA5N24sowkmwp/t7RHyg
         V4yuCDNwmMbi8K3/zDKi/uS/716dE8gWtrpDnuNBN4sKlHXDqXEVbt9tpuvQqg9LGKpD
         xdVQ==
X-Gm-Message-State: ACrzQf3ogvYY2Mqb0X1H/8T/UFMXvLX+/GJb4W7dDjvjAncl2YqxynSN
        k89gVNBwRvdh+dHFNZ+hJZsfDQ==
X-Google-Smtp-Source: AMsMyM5HNnFq81l4RdSLltMaolIOGtBC4m30BJwmTpaAXLcTYknK/lnO0ieb/Avzudz+YE3F/RUOag==
X-Received: by 2002:a05:6a00:2495:b0:562:c459:e327 with SMTP id c21-20020a056a00249500b00562c459e327mr30684563pfv.47.1665636985213;
        Wed, 12 Oct 2022 21:56:25 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902cf1100b00177f25f8ab3sm11484255plg.89.2022.10.12.21.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 21:56:24 -0700 (PDT)
Subject: [PATCH 4/4] Documentation: RISC-V: patch-acceptance: s/implementor/implementer
Date:   Wed, 12 Oct 2022 21:56:19 -0700
Message-Id: <20221013045619.18906-5-palmer@rivosinc.com>
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
        Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor@kernel.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>, Atish Patra <atishp@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Implementor does appear to be a word, but it's not very common.

Suggested-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 Documentation/riscv/patch-acceptance.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/riscv/patch-acceptance.rst b/Documentation/riscv/patch-acceptance.rst
index 9fed6b318b49..89c7d8abd4bb 100644
--- a/Documentation/riscv/patch-acceptance.rst
+++ b/Documentation/riscv/patch-acceptance.rst
@@ -26,7 +26,7 @@ specifications from the RISC-V foundation this means "Frozen" or
 ECR.  (Developers may, of course, maintain their own Linux kernel trees
 that contain code for any draft extensions that they wish.)
 
-Additionally, the RISC-V specification allows implementors to create
+Additionally, the RISC-V specification allows implementers to create
 their own custom extensions.  These custom extensions aren't required
 to go through any review or ratification process by the RISC-V
 Foundation.  To avoid the maintenance complexity and potential
@@ -38,5 +38,5 @@ RISC-V extensions, we'll only accept patches for extensions that either:
   for which a timeline for availability has been made public.
 
 Hardware that does not meet its published timelines may have support
-removed.  (Implementors, may, of course, maintain their own Linux kernel
+removed.  (Implementers, may, of course, maintain their own Linux kernel
 trees containing code for any custom extensions that they wish.)
-- 
2.38.0

