Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB7168E615
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjBHCbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjBHCbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:31:49 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC9E27495;
        Tue,  7 Feb 2023 18:31:44 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id EEF6B24E20C;
        Wed,  8 Feb 2023 10:31:36 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Feb
 2023 10:31:37 +0800
Received: from [192.168.125.110] (183.27.96.33) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Feb
 2023 10:31:36 +0800
Message-ID: <87e31545-3107-1cc2-fc93-197f66712ccc@starfivetech.com>
Date:   Wed, 8 Feb 2023 10:31:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 0/4] Basic pinctrl support for StarFive JH7110 RISC-V
 SoC
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Andreas Schwab <schwab@suse.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
References: <20230203141801.59083-1-hal.feng@starfivetech.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20230203141801.59083-1-hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.96.33]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2023 22:17:57 +0800, Hal Feng wrote:
> This patch series adds basic pinctrl support for StarFive JH7110 SoC.
> 
> Changes since v3:
> - Rebased on Linus's "devel" branch of linux-pinctrl repo, which was based on
>   on tag v6.2-rc1.
> - Dropped patch 1.
> Patch 2 & 3:
> - Added a reference for '-pins$' patternProperties.
> - Put "additionalProperties: false" before properties section. (by Rob)
> - Improved the description.
> - Changed the node name in examples from "gpio" to "pinctrl".
> Patch 4:
> - Added some missing headers. (by Andreas)
> 
>   v3: https://lore.kernel.org/all/20221220005529.34744-1-hal.feng@starfivetech.com/

Hi, Linus,

I have resent the patches rebased on your "devel" branch. Rob has added
Reviewed-by tags for DT bindings, but the DT binding patches still need
to be modified a little bit. Could you apply this series if I modify the
DT bindings patches and resend as v5? Or it need another round of review?

Best regards,
Hal
