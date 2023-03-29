Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E376CEDE9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjC2Pxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjC2PxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:53:19 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB83114;
        Wed, 29 Mar 2023 08:53:19 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id l39-20020a9d1b2a000000b006a121324abdso6856136otl.7;
        Wed, 29 Mar 2023 08:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avhGoClAu60FK+4OH3axA1tPVPlExeBA2pd36OTtZtE=;
        b=4hmXUkZK1Jo0vkxbQBklysI/LPTAzAR1f9B0fsSTs0g2bQZxaYBRzNA0L5TeEKOuGk
         tbDegycH8Gc8qcmC7/RmHUxXuWOKlJOJk8VYV/mW0uEqocVoOPm1xS1Pxz+uU+xmsPuC
         lgz97t+ydmVhxI5SbAqrBylcu/hfzkX/kb3urG+/ixbG5qa8+ad+VEZ9BFI8aldcwwiZ
         DQ3clKfDXru2LymxqiC8zO+zQbQT4HSB8yiRtnH1R5GRyysb6KJ3k8U+C+igEEX+JyhL
         ePrLqehyUvCkutqZS0rW4WIjN/xERpD1YZDlq9KVzFO/VHYKR6X+ODu/OA3zOf/inYET
         33/A==
X-Gm-Message-State: AO0yUKWv8J8kCVln1j+fiYxMckcjr+1yTde2eB+xSeyDrbRDcwJgmfEh
        SdzuU+yxG9dfJbzsk82Jpg==
X-Google-Smtp-Source: AK7set+ZOHjqyI4LzxgjdsE15Cx5pZk+wokjAG0VqGy5aA+Dncm2MiNsSACjR/bJ9bGa9YBaDIKZXg==
X-Received: by 2002:a9d:67c6:0:b0:697:ef66:e7f4 with SMTP id c6-20020a9d67c6000000b00697ef66e7f4mr9233955otn.24.1680105198532;
        Wed, 29 Mar 2023 08:53:18 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s14-20020a9d758e000000b006a154373578sm2278866otk.39.2023.03.29.08.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:53:18 -0700 (PDT)
Received: (nullmailer pid 3198079 invoked by uid 1000);
        Wed, 29 Mar 2023 15:52:45 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Mar 2023 10:52:06 -0500
Subject: [PATCH 09/19] riscv: cacheinfo: Adjust includes to remove
 of_device.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-dt-cpu-header-cleanups-v1-9-581e2605fe47@kernel.org>
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
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that of_cpu_device_node_get() is defined in of.h, of_device.h is just
implicitly including other includes, and is no longer needed. Adjust the
include files with what was implicitly included by of_device.h (cpu.h and
of.h) and drop including of_device.h.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take the series via the DT tree.
---
 arch/riscv/kernel/cacheinfo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 3a13113f1b29..e3829d2de5d9 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -5,7 +5,6 @@
 
 #include <linux/cpu.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <asm/cacheinfo.h>
 
 static struct riscv_cacheinfo_ops *rv_cache_ops;

-- 
2.39.2

