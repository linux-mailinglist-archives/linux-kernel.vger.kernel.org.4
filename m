Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E19A70013F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbjELHS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbjELHR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:17:58 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2961100FA;
        Fri, 12 May 2023 00:17:33 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id B68FD24E287;
        Fri, 12 May 2023 15:17:26 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 12 May
 2023 15:17:26 +0800
Received: from [192.168.125.131] (113.72.146.187) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 12 May
 2023 15:17:25 +0800
Message-ID: <0463378b-60d8-ee05-2a2e-1e709b882bae@starfivetech.com>
Date:   Fri, 12 May 2023 15:15:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 7/7] riscv: dts: starfive: jh7110: Add PLL clock node
 and modify syscrg node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "Rob Herring" <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Hal Feng" <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-8-xingyu.wu@starfivetech.com>
 <c432c26b-27d3-80dc-fe6b-457996234871@linaro.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <c432c26b-27d3-80dc-fe6b-457996234871@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.187]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/12 14:37, Krzysztof Kozlowski wrote:
> On 12/05/2023 04:20, Xingyu Wu wrote:
>> Add the PLL clock node for the Starfive JH7110 SoC and
>> modify the SYSCRG node to add PLL clocks input.
> 
> 
>> @@ -465,6 +469,12 @@ syscrg: clock-controller@13020000 {
>>  		sys_syscon: syscon@13030000 {
>>  			compatible = "starfive,jh7110-sys-syscon", "syscon", "simple-mfd";
>>  			reg = <0x0 0x13030000 0x0 0x1000>;
>> +
>> +			pllclk: clock-controller {
>> +				compatible = "starfive,jh7110-pll";
>> +				clocks = <&osc>;
>> +				#clock-cells = <1>;
> 
> This should be part of previous patch. You just added that node. Don't
> add half of devices but entire device.
> 

So do I merge the patch 6 and patch 7 into one patch and add syscon and
clock-controller together?

Best regards,
Xingyu Wu
