Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEB472404F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbjFFK6M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Jun 2023 06:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbjFFK5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:57:16 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611C3170B;
        Tue,  6 Jun 2023 03:57:01 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 77B8C24E28F;
        Tue,  6 Jun 2023 18:56:59 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 6 Jun
 2023 18:56:59 +0800
Received: from localhost.localdomain (183.27.98.75) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 6 Jun
 2023 18:56:58 +0800
From:   Mason Huo <mason.huo@starfivetech.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Shengyu Qu <wiagn233@outlook.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: [PATCH v4 2/3] cpufreq: dt-platdev: Add JH7110 SOC to the allowlist
Date:   Tue, 6 Jun 2023 18:56:55 +0800
Message-ID: <20230606105656.124355-3-mason.huo@starfivetech.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606105656.124355-1-mason.huo@starfivetech.com>
References: <20230606105656.124355-1-mason.huo@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.75]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX067.cuchost.com
 (172.16.6.67)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible strings for supporting the generic
cpufreq driver on the StarFive JH7110 SoC.

Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 338cf6cc6596..14aa8281c7f4 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -85,6 +85,8 @@ static const struct of_device_id allowlist[] __initconst = {
 	{ .compatible = "st-ericsson,u9500", },
 	{ .compatible = "st-ericsson,u9540", },
 
+	{ .compatible = "starfive,jh7110", },
+
 	{ .compatible = "ti,omap2", },
 	{ .compatible = "ti,omap4", },
 	{ .compatible = "ti,omap5", },
-- 
2.39.2

