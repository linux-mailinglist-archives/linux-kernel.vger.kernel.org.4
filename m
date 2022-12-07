Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F5A645419
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiLGGjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLGGi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:38:59 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217C52B245;
        Tue,  6 Dec 2022 22:38:59 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2B76ckkG071199;
        Wed, 7 Dec 2022 00:38:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670395126;
        bh=/V+T88l8oC9cpiyVXjUF8saOMdaTLVrK6AsbdMLgbko=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=y74KxFnKI+/Z1gmb660fiMOYyZH3VqsnjPuvTTctyrdKVj3fafdMDFPraLe3NDRtC
         cEfjvYSzv0scEQ6MQCB47tR9dEWC9d1QppLJclWHXpCMdStLYW3UrKYu6bwzoh9+A5
         5gJLcHlXagZ9wUutqN8Q3DZYM3PXHGcNloYPI0IA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2B76ckZl009827
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Dec 2022 00:38:46 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 7
 Dec 2022 00:38:45 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 7 Dec 2022 00:38:45 -0600
Received: from [10.24.69.26] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2B76chuv115915;
        Wed, 7 Dec 2022 00:38:44 -0600
Message-ID: <4ed39c8f-3736-30d6-8d8c-92a4882b72e7@ti.com>
Date:   Wed, 7 Dec 2022 12:08:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] spi: spi-fsl-lpspi: support multiple cs for lpspi
Content-Language: en-US
To:     Han Xu <han.xu@nxp.com>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
References: <20221206225410.604482-1-han.xu@nxp.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20221206225410.604482-1-han.xu@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/12/22 04:24, Han Xu wrote:
> support to get chip select number from DT file.

In my humble opinion, a  more elaborate commit message would help.
You can add perhaps which DT node is to be set, like you might want
to say,

support to get chip select number by Setting the value of num-cs in DT

or something on those lines.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> ---
>   drivers/spi/spi-fsl-lpspi.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 6454b88c31fe..7f0562ed4d09 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -98,6 +98,7 @@ struct fsl_lpspi_data {
>   	struct clk *clk_ipg;
>   	struct clk *clk_per;
>   	bool is_slave;
> +	u32 num_cs;
>   	bool is_only_cs1;
>   	bool is_first_byte;
>   
> @@ -850,6 +851,9 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
>   	fsl_lpspi->is_slave = is_slave;
>   	fsl_lpspi->is_only_cs1 = of_property_read_bool((&pdev->dev)->of_node,
>   						"fsl,spi-only-use-cs1-sel");
> +	if (of_property_read_u32((&pdev->dev)->of_node, "num-cs",
Running a checkpatch on this patch gave me the following,

CHECK: Unnecessary parentheses around '&pdev->dev'
#36: FILE: drivers/spi/spi-fsl-lpspi.c:854:
+       if (of_property_read_u32((&pdev->dev)->of_node, "num-cs",
+                                &fsl_lpspi->num_cs))

You might want to just do &pdev->dev->of_node instead

> +				 &fsl_lpspi->num_cs))
> +		fsl_lpspi->num_cs = 1;
I am not sure I understand why you are setting this to 1 here?
I am assuming it is because you want num_cs to default to 1 if
it is not specified in DT.

Please can you also add a dev_err and be sure to warn about this?

Also adding a comment or even a message inside dev err that you are
setting this to 1 if it fails to get from DT would be helpful.

>   
>   	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
>   	controller->transfer_one = fsl_lpspi_transfer_one;
> @@ -859,6 +863,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
>   	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
>   	controller->dev.of_node = pdev->dev.of_node;
>   	controller->bus_num = pdev->id;
> +	controller->num_chipselect = fsl_lpspi->num_cs;
>   	controller->slave_abort = fsl_lpspi_slave_abort;
>   	if (!fsl_lpspi->is_slave)
>   		controller->use_gpio_descriptors = true;

-- 
Thanks and Regards,
Dhruva Gole
