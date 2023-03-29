Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93026CEE18
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjC2PyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjC2PxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:53:14 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9E91FD3;
        Wed, 29 Mar 2023 08:53:06 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id bj20so11922666oib.3;
        Wed, 29 Mar 2023 08:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4/7KPsNb+9xFZnBvWPuvHxFUZ+0wY+oqrqhzOTeb8U=;
        b=fu+XBy6INa2LX4BHAD5kKrqHmwqTZoY026sz8jV7qNxcBhluiv5nTJEZ5kj90AUopf
         Zxlo3ZDsmzP9apqcSw4XiziN3mtsFibAyzI5kov2b2+Wd8pV0F+fZ0QBFjPbnXMn1eQI
         I5Wo4zLN2ZGoa19/FSRX3NrTaL+fQEncmhtarvuEFfeINDSMzBl3T7TlQuGhKPZTNFW+
         U3smpKxkMTVkDCnO1y7TLbeTYsjcUhRPTMqYsz4fASD0gMsUJ74m9mfKYsOA0TEq29hk
         hgVx0/10VKQ2RGfPlhpCS/eweShU4NxmEb1YlKdAKcfoy3vwh+ltD8UT8m4U0EbK1ANU
         9PIA==
X-Gm-Message-State: AO0yUKUI2GgtvSAGfX2zmv16mlSOJDl4Gu/XP9pqBww/ONcr3+AX71lh
        Hr21V2xbJlZFZ3Er93DVMybs4Y1AZA==
X-Google-Smtp-Source: AK7set+4b8TVt2XSxmpWLVvJqTy6ovjjoLfneQ9RKzw6pkGeQwoKn8nerPqu8oZLFPwkmZXWaUmfeA==
X-Received: by 2002:a05:6808:2995:b0:37f:7770:4c01 with SMTP id ex21-20020a056808299500b0037f77704c01mr7467612oib.28.1680105185402;
        Wed, 29 Mar 2023 08:53:05 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y184-20020aca32c1000000b0037841fb9a65sm13730637oiy.5.2023.03.29.08.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:53:04 -0700 (PDT)
Received: (nullmailer pid 3198077 invoked by uid 1000);
        Wed, 29 Mar 2023 15:52:45 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Mar 2023 10:52:05 -0500
Subject: [PATCH 08/19] riscv: Add explicit include for cpu.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-dt-cpu-header-cleanups-v1-8-581e2605fe47@kernel.org>
References: <20230329-dt-cpu-header-cleanups-v1-0-581e2605fe47@kernel.org>
In-Reply-To: <20230329-dt-cpu-header-cleanups-v1-0-581e2605fe47@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing the include of cpu.h from of_device.h (included by
of_platform.h) causes an error in setup.c:

arch/riscv/kernel/setup.c:313:22: error: arithmetic on a pointer to an incomplete type 'typeof(struct cpu)' (aka 'struct cpu')

The of_platform.h header is not necessary either, so it can be dropped.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take the series via the DT tree.
---
 arch/riscv/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 376d2827e736..dcfa4b6fa4b1 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -8,6 +8,7 @@
  *  Nick Kossifidis <mick@ics.forth.gr>
  */
 
+#include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/memblock.h>
@@ -15,7 +16,6 @@
 #include <linux/console.h>
 #include <linux/screen_info.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 #include <linux/sched/task.h>
 #include <linux/smp.h>
 #include <linux/efi.h>

-- 
2.39.2

