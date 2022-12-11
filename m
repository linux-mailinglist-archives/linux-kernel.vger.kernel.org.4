Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600126492F7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 07:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiLKGzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 01:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLKGzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 01:55:00 -0500
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ACC9585
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:54:58 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 4GEbp4I6yvgTT4GEbpFfpL; Sun, 11 Dec 2022 07:54:53 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Dec 2022 07:54:53 +0100
X-ME-IP: 86.243.100.34
Message-ID: <361c0911-7133-4d28-436e-1dfab2b807a8@wanadoo.fr>
Date:   Sun, 11 Dec 2022 07:54:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 3/3] regulator: axp20x: Add support for AXP1530 variant
Content-Language: fr
To:     martin.botka@somainline.org
Cc:     angelogioacchino.delregno@somainline.org, broonie@kernel.org,
        devicetree@vger.kernel.org, jamipkettunen@somainline.org,
        jtrmal@gmail.com, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        marijn.suijten@somainline.org, martin.botka1@gmail.com,
        paul.bouchara@somainline.org, robh+dt@kernel.org,
        takuya@takuya.tech, wens@csie.org
References: <20221209234654.1082522-1-martin.botka@somainline.org>
 <20221209234654.1082522-4-martin.botka@somainline.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221209234654.1082522-4-martin.botka@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/12/2022 à 00:46, Martin Botka a écrit :
> AXP1530 has a few regulators that are controlled via I2C Bus.
> 
> Add support for them.
> 
> Signed-off-by: Martin Botka <martin.botka-KtrmGDJU8+nZ+VzJOa5vwg@public.gmane.org>
> ---
>   drivers/regulator/axp20x-regulator.c | 44 ++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index d260c442b788..ca422311a996 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c

[...]

> @@ -1252,6 +1292,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
>   		drivevbus = of_property_read_bool(pdev->dev.parent->of_node,
>   						  "x-powers,drive-vbus-en");
>   		break;
> +		case AXP1530_ID:

Nit: indentation.

> +		regulators = axp1530_regulators;
> +		nregulators = AXP1530_REG_ID_MAX;
> +		break;
>   	default:
>   		dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
>   			axp20x->variant);

