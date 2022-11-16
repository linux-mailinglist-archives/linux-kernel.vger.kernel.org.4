Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E262CACA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiKPU1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiKPU1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:27:34 -0500
Received: from smtpcmd0642.aruba.it (smtpcmd0642.aruba.it [62.149.156.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C97654C27C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:27:31 -0800 (PST)
Received: from [192.168.50.220] ([146.241.88.137])
        by Aruba Outgoing Smtp  with ESMTPSA
        id vP0KouklmEclovP0LoJbVb; Wed, 16 Nov 2022 21:27:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1668630449; bh=+JRtOayWKQNzm8a7ydAMoZlnFkRlaIc41mGw4qjaIcg=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=Jc967SzOu/+JXcL+rDLtzghtLQemHymhCNUkM1LC8qNXTXAOLw+WwT7B2WhYy9JpH
         K/xpY/hUPBie2CO+4m0KLzjj27C2rHILmX0nnp7xT7OVABjsyJaJ3ZArmlZEV7ehcy
         n597koKqMI853DvvvcZSYBmgK+eHqr8XJm0v3PW6jQRCWozoW0eqDiYYV3oD4BJ775
         udUcnRS1+bubwimb4iDg5bK4dq/UOrq9XqCvbYOZ+wLiPAiLAP6J2ngz5GiFLyoNy3
         qxYYtUJP7rOqFEZB00sa9DFmmABSeT3Zo+9W5yTB6Ud5Nw8WkNTgcfqOZrunHqF/IQ
         q3vIZwkI/6SLQ==
Message-ID: <4a31d860-0bd0-e1df-2b0a-93cad42d59f4@benettiengineering.com>
Date:   Wed, 16 Nov 2022 21:27:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/4] clk: imx: imxrt1050: add IMXRT1050_CLK_LCDIF_PIX
 clock gate
To:     Jesse Taube <mr.bossman075@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bough Chen <haibo.chen@nxp.com>
References: <20221115193244.10484-1-giulio.benetti@benettiengineering.com>
 <20221115193244.10484-2-giulio.benetti@benettiengineering.com>
 <b09ead30-3fc6-f00b-e157-8c753358d5d4@gmail.com>
Content-Language: en-US
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <b09ead30-3fc6-f00b-e157-8c753358d5d4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfE99GrT/syc0EXpp6Wjlrx6BMuFyfuaOS/bjNjHK2raoUdS/3sfzW0/J/EkBR0XtCEM2VcEo4VaU2QJ98dMxOVID3SgfylaBkF5nXwb1gK5MzQ0mGo8q
 pxhJmztbWZerTvlqYeNa3jwkbB4Nk50OvnFoThxFAqVfGlO3b4XOdtdUsI2bCYtOtVLPdJJxOoVR/3m3X7jqbUh4Sshp2ZeRj3u2FGlGophPVWMS1lm4a6BK
 O/Iz6qZ+ulYBBcqXjP1XvdQjCppiBz7lVYooXf6lj1vd71kD8iNSbIFmMg4mbwrhJok7feU9cqZtv4Ze8ieN8fqtsVguugVU5Mef29qZO/iXNe0CdD8Ujrjg
 vOKcv2G10ebQ+0RRX7bRdq/MW9AEJ5b/O/l2DaFOCXPTsvZixCZBOfpf0ygJqZUgH3nAoOCBZXQdjJZBPFrvSsToQ7mw/m2hgjG/8dlsNRO9lYsyNqn7A+fZ
 AybtBfZXdRUSgJwiRzDcGOG/khrWpmfwTHn60Gi5NhrgS/IWpAURqgiolAQfPmvH0PmCwsZLU0dksq9RzKAkbbH07nlHVeDzVQvbWE7ntBLNyjCaC/lk7vXQ
 CgP5YThxSSXYvbI6m8iWE+DCW5mpCjM1yHp5nQ8hmHzqeuV58MvCWGNFk8l4ikr9jB6r7bwk47FPLTYZN755zVuT9SOfiHGx3qUlAUPsmE/tCqpP6oVBnr0F
 Dr1c60IkoMYYJkNGJjnIDLIcWKgEYg3fnyToksthLkORIk1+DEL9cg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

On 15/11/22 21:43, Jesse Taube wrote:
> 
> 
> On 11/15/22 14:32, Giulio Benetti wrote:
>> Cc: Jesse Taube <mr.bossman075@gmail.com>
>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>> ---
>> V1->V2:
>> * nothing done
>> ---
>>   drivers/clk/imx/clk-imxrt1050.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/imx/clk-imxrt1050.c 
>> b/drivers/clk/imx/clk-imxrt1050.c
>> index 26108e9f7e67..39f77c03b892 100644
>> --- a/drivers/clk/imx/clk-imxrt1050.c
>> +++ b/drivers/clk/imx/clk-imxrt1050.c
>> @@ -141,6 +141,7 @@ static int imxrt1050_clocks_probe(struct 
>> platform_device *pdev)
>>       hws[IMXRT1050_CLK_USDHC2] = imx_clk_hw_gate2("usdhc2", 
>> "usdhc2_podf", ccm_base + 0x80, 4);
>>       hws[IMXRT1050_CLK_LPUART1] = imx_clk_hw_gate2("lpuart1", 
>> "lpuart_podf", ccm_base + 0x7c, 24);
>>       hws[IMXRT1050_CLK_LCDIF_APB] = imx_clk_hw_gate2("lcdif", 
>> "lcdif_podf", ccm_base + 0x70, 28);
>> +    hws[IMXRT1050_CLK_LCDIF_PIX] = imx_clk_hw_gate2("lcdif_pix", 
>> "lcdif", ccm_base + 0x74, 10);
> I think it makes sense to squash this with PATCH1 because it changes the 
> same file. It also will make the change more understandable as I swapped 
> the offsets for PIX clock and APB clock accidentally. 

I would not squash them since on "Patch 1/4" fixes something, while
"Patch 2/4" adds something.

> I'm not sure if 
> this is necessary but I think there should be a commit description. 

You're right and same goes for all patches, I keep forgetting.

Sorry for the noise.

Thank you
Best regards
-- 
Giulio Benetti
CEO/CTO@Benetti Engineering sas

> Otherwise
> Acked-by: Jesse Taube <mr.bossman075@gmail.com>
> 
> Thanks,
> Jesse Taube
>>       hws[IMXRT1050_CLK_DMA] = imx_clk_hw_gate("dma", "ipg", ccm_base 
>> + 0x7C, 6);
>>       hws[IMXRT1050_CLK_DMA_MUX] = imx_clk_hw_gate("dmamux0", "ipg", 
>> ccm_base + 0x7C, 7);
>>       imx_check_clk_hws(hws, IMXRT1050_CLK_END);

