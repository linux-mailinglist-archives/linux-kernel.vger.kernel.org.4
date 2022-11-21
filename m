Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43913632FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiKUWVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiKUWUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:20:55 -0500
Received: from smtpdh18-2.aruba.it (smtpdh18-2.aruba.it [62.149.155.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B33726AF7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 14:20:53 -0800 (PST)
Received: from [192.168.50.220] ([146.241.87.80])
        by Aruba Outgoing Smtp  with ESMTPSA
        id xF9mot2TY4DZxxF9noR1bw; Mon, 21 Nov 2022 23:20:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1669069252; bh=V23/NqyNya/rR8Jiz8DD3xEX/c5+XAWgZRu5zQgQ8o4=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=AVULT+Lht/g8gyaQGVH7wpjha6z+pckPpHXkSXBLy1anPbKIp5VWoCNzEH2kn2WpZ
         sQO4r/yGCsw1wWISrhlYj5glr4jVZRcQDECflt5kdF0LAYG2ZGHZiYjMeyNbDfZ2GY
         Kkj0vXUVYIjD5YcdAexjzZcpNsaer63umEG0XyI+TbcT0nemm3AGgLoCAOd5uQ6qkV
         YLEVK61MTLQ0ehr3THaWBRM6SZKO2yQQ9Bgnklysye9WkuOPDXjoT6htZtenilOeFw
         BKk/9HvVtx4wIf+Z4nYCjefLtBM8+SgRFTkErZJtJGOTf9iAUO9f7ej+Jouj7JgIOQ
         PwqMnmGfNz6hA==
Message-ID: <759187e4-9948-a676-a7cc-3bc32fc8fe0b@benettiengineering.com>
Date:   Mon, 21 Nov 2022 23:20:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/4] clk: imx: imxrt1050: fix IMXRT1050_CLK_LCDIF_APB
 offsets
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bough Chen <haibo.chen@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jesse Taube <mr.bossman075@gmail.com>
References: <20221117181014.851505-1-giulio.benetti@benettiengineering.com>
 <Y3v3R94KF8/ygnkT@linaro.org>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <Y3v3R94KF8/ygnkT@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPdYJJkvdSITZGVVUI8hvcMyv9M6rK0T7EQeXc1b/Dzm7NHEmgxbVT4nsLCTRK+TEPJU85jUo/LH4TzAgC8RLL2QIZpkAHygUipWFoxnFG0lFncZ1lb6
 EYTIf8tdBWghnNTdrKekjWGNECYrjZvQS6PWBO/9DOhov/eUDyHC45u4dLOzrpDWB+8Nc9B5r9TuYzAhPpYEeYAAT6LuwHZEJCjZjm9B2qaUcD2LpuIAYr3g
 0+/4ZTBcW3z3yZ+4N+hktPyzdevefO9qrwPDxZ61CgtZSgMZrsIFpOd/wLMYypBUpG4NzC0aNLPNXxwAuur1QTheqOndQ6pq9MKiZHWtdWbdZp2FjYfEmlR/
 cT2jAFaNE8XU45CFndqQkCIOJEjNRWb9m/uUIWgYM4dodvnQ/ezYV1Ep02Cs7HhVSTzLOsoSoUMmTyfizqsRga8IE8L7jB/DERa/Y+hW3aKkzGkua6pX1agk
 YSy1FpOHDo/PLJ2wIZNPW2BkJLWh37sP44lwixUwFEquCrGWvCsv19bPxQCy+wFdCDmAHqetW08cXG1y9kzE+hzywBroGxE8cZTiRfZLtWugSQBS+3+vf2d+
 VdeG8UVtOXKLzp5tQJrhYiMxYPFTRXIx1eAK7V/ELDi03J+dTieYOlyrIqJwVZ5oAbNS3qzSKBG4k98KNg3wujjp7O683l3R9XtTqL1Pwcezf8KolIgZjS6Y
 J/fyuJ2+vPmhICDLuCeDA0pJZKpp2Iqj3GbVn/kYdXOBwOpzOn6CHIEcexPiqDeYwqg3k+8KjwE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/22 23:10, Abel Vesa wrote:
> On 22-11-17 19:10:11, Giulio Benetti wrote:
>> Fix IMXRT1050_CLK_LCDIF_APB offsets.
>>
>> Fixes: 7154b046d8f3 ("clk: imx: Add initial support for i.MXRT1050 clock driver")
>> Cc: Jesse Taube <mr.bossman075@gmail.com>
>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> 
> Applied patches #1 and #2. Thanks.
> 
> As a suggestion, next time, please send two separate patchsets,
> since there are two different subsystems involved (and the patches #3
> and #4 are not related to #1 and #2).

Ok, thank you for pointing. Next time I will do like that.

-- 
Giulio Benetti
CEO/CTO@Benetti Engineering sas

>> ---
>> V1->V2:
>> * nothing done
>> V2->V3:
>> * added commit log and not only subject as suggested by Jesse Taube
>> V3->V4:
>> * added Fixes: as suggested by Fabio Estevam
>> ---
>>   drivers/clk/imx/clk-imxrt1050.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
>> index 9539d35588ee..26108e9f7e67 100644
>> --- a/drivers/clk/imx/clk-imxrt1050.c
>> +++ b/drivers/clk/imx/clk-imxrt1050.c
>> @@ -140,7 +140,7 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
>>   	hws[IMXRT1050_CLK_USDHC1] = imx_clk_hw_gate2("usdhc1", "usdhc1_podf", ccm_base + 0x80, 2);
>>   	hws[IMXRT1050_CLK_USDHC2] = imx_clk_hw_gate2("usdhc2", "usdhc2_podf", ccm_base + 0x80, 4);
>>   	hws[IMXRT1050_CLK_LPUART1] = imx_clk_hw_gate2("lpuart1", "lpuart_podf", ccm_base + 0x7c, 24);
>> -	hws[IMXRT1050_CLK_LCDIF_APB] = imx_clk_hw_gate2("lcdif", "lcdif_podf", ccm_base + 0x74, 10);
>> +	hws[IMXRT1050_CLK_LCDIF_APB] = imx_clk_hw_gate2("lcdif", "lcdif_podf", ccm_base + 0x70, 28);
>>   	hws[IMXRT1050_CLK_DMA] = imx_clk_hw_gate("dma", "ipg", ccm_base + 0x7C, 6);
>>   	hws[IMXRT1050_CLK_DMA_MUX] = imx_clk_hw_gate("dmamux0", "ipg", ccm_base + 0x7C, 7);
>>   	imx_check_clk_hws(hws, IMXRT1050_CLK_END);
>> -- 
>> 2.34.1
>>

