Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387CB6CED91
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjC2PxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjC2PxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:53:07 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074DE4C2C;
        Wed, 29 Mar 2023 08:52:57 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id bj20so11922317oib.3;
        Wed, 29 Mar 2023 08:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXYasbFGyOzjbVgkFYQhHdq2LiUoVceQJn8x4Q7U0Lg=;
        b=tOfFn1w7ThzOQxUnieExQknA1lBrLVzi91QhtMo0YvKpN/7nYfqKi4ZnVXXQPzM0b+
         BnIL64cH5VhOL+TfuQ4E6EmsR1N8eKxoDE+ghOqDhM8KXrCmfdJYyCT/sjoET4IdwoRx
         8g5vfNqiyZLy58P1iLHbDwa8op1RgXDhtpmN53berC9CyyX0RBfYhlH5kCJF47jXTQGK
         Bc+B9xYjPNT39n28wmY6LW75onKU5/HI6tZGNxkqGS/Gl/TiFoyTk7DsYcTwXLjK9aYI
         KBMTagKMkJkACMgSsfeLEKxRqvnCgdgQvMQY4LgYazkWgDdIpO9OBPPp8EfrGxzqX3FH
         zE1w==
X-Gm-Message-State: AO0yUKXwsjxFv+mqXCxhjsNE8LpftueRDwjwPJRTqmRnVk2xIaSIZhvc
        njJzoQZasC/IhS5QcXy93Q==
X-Google-Smtp-Source: AK7set9WFLmG+nDxrfFiYKr/Y1X4gukEgmYRhjOb4gvixi7TQjjzvpWDqSzTEx2qAniqrP2lpYSRIg==
X-Received: by 2002:aca:1316:0:b0:364:ebf2:735f with SMTP id e22-20020aca1316000000b00364ebf2735fmr8517999oii.24.1680105176210;
        Wed, 29 Mar 2023 08:52:56 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bx32-20020a0568081b2000b0038733b00a5fsm8526890oib.10.2023.03.29.08.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:52:55 -0700 (PDT)
Received: (nullmailer pid 3198093 invoked by uid 1000);
        Wed, 29 Mar 2023 15:52:45 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Mar 2023 10:52:13 -0500
Subject: [PATCH 16/19] cpuidle: Adjust includes to remove of_device.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-dt-cpu-header-cleanups-v1-16-581e2605fe47@kernel.org>
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

Now that of_cpu_device_node_get() is defined in of.h, of_device.h is just
implicitly including other includes, and is no longer needed. Adjust the
include files with what was implicitly included by of_device.h (cpu.h,
cpuhotplug.h, of.h, and of_platform.h) and drop including of_device.h.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take the series via the DT tree.
---
 drivers/cpuidle/cpuidle-psci.c      | 1 -
 drivers/cpuidle/cpuidle-qcom-spm.c  | 3 +--
 drivers/cpuidle/cpuidle-riscv-sbi.c | 2 +-
 drivers/cpuidle/dt_idle_states.c    | 1 -
 4 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 6de027f9f6f5..bf68920d038a 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -16,7 +16,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/psci.h>
 #include <linux/pm_domain.h>
diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index c6e2e91bb4c3..1fc9968eae19 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -11,8 +11,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/cpuidle.h>
diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index be383f4b6855..ae0b838a0634 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "cpuidle-riscv-sbi: " fmt
 
+#include <linux/cpuhotplug.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -15,7 +16,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index 02aa0b39af9d..12fec92a85fd 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -14,7 +14,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include "dt_idle_states.h"
 

-- 
2.39.2

