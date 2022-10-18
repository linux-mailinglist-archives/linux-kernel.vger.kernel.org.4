Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495E46035FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJRWgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJRWgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:36:07 -0400
Received: from smtpcmd0986.aruba.it (smtpcmd0986.aruba.it [62.149.156.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2893BCC810
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:36:02 -0700 (PDT)
Received: from [192.168.50.220] ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id kvBoovvaFaWj1kvBooEOsQ; Wed, 19 Oct 2022 00:36:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666132561; bh=luzvlvgLF0QVUwO0gT+OoCdQWZnYIwCJYht0pOjIZ3U=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=dSUdRnUFi0Crty2pYHbqT/DSo4YUVoudW7NGYNWRPptQ30prDF4Ez61lAul/r/fkJ
         GC5EJhNKQwRMchylAa0XX2Bq63Jhyj1n3uI2H1wj/2HcCflMHet7N0hIzC8sLh5K1a
         +QixalwmxG2+EwDw6OFGoXStRtXobeohoJeyFsV49caURRoJemHUn9+XhgZ69sF+fC
         FMqzn2cRohNqN8MIwbEuq/v+nxRRrBgRrOlnmM5YirOTF3IFSoXBSQ/fLiMyFpZddq
         3eu7pAHjGK+kTcuDn5vuTFPOUD40hIMPbbYKDMzzFfZLjj19PIIc5gbCbBBtRoolyV
         2NaThyRjN/a1g==
Message-ID: <ac5c75e0-2921-84ef-90c3-93e526358d7c@benettiengineering.com>
Date:   Wed, 19 Oct 2022 00:36:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/5] clk: imx: imxrt1050: fix IMXRT1050_CLK_LCDIF_APB
 offsets
Content-Language: en-US
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jesse T <mr.bossman075@gmail.com>
References: <20221017235602.86250-1-giulio.benetti@benettiengineering.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <20221017235602.86250-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOrIqwcb7/+eOP2FY7EKspVzfwUbtM756/UiDbnbjXc52sKwXx1avxmGQAPGFy7tsJypcnBnEyow6xb7ccR38m69Kt67ZKk+OE1RyIbFR8IELk59oCPu
 s51DqBg+n0VRDLG0SeI+/qmyT60QBmYWgkvxza+soxLIsEc0BMqM+QE1LmajxHiDbhpvwDaQUnWUO8DuM6dDvz8E5NHpcva0fvnDrp52WhykFnQBsQgsYhhR
 cNeYfrFdxRiSO7uk+d6zTYq0Yhzp8OS7n9wgVPheVzPX65nvtqcuNWcbcZBSkAsBzaz1aBwCrL719VglAJLsDKsEoOQBM/4go3sT64ssMKvybYcetGrp2VDV
 biQy0DpKM16tWe00D6WOkYyQpJFV3U3vkmgA2f0j9wpB1HNPd1n1faONXfz+spZ4i4t0gAPqi/tHOHb4Keb2MGwIxg5GNGFZ+M1gUE533fpNJ8gHP14TSY+k
 jJSOfMbm8nOc4GCyTK8I5vIcZjYt+VsiLm41Sn5mPvMIkkKfUrvFeBKZHtRLezAJglFDTKxQazOF3Q4h2fbwrCKYlAWqs0WLWdmZLQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

On 18/10/22 01:55, Giulio Benetti wrote:
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>   drivers/clk/imx/clk-imxrt1050.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
> index 9539d35588ee..26108e9f7e67 100644
> --- a/drivers/clk/imx/clk-imxrt1050.c
> +++ b/drivers/clk/imx/clk-imxrt1050.c
> @@ -140,7 +140,7 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
>   	hws[IMXRT1050_CLK_USDHC1] = imx_clk_hw_gate2("usdhc1", "usdhc1_podf", ccm_base + 0x80, 2);
>   	hws[IMXRT1050_CLK_USDHC2] = imx_clk_hw_gate2("usdhc2", "usdhc2_podf", ccm_base + 0x80, 4);
>   	hws[IMXRT1050_CLK_LPUART1] = imx_clk_hw_gate2("lpuart1", "lpuart_podf", ccm_base + 0x7c, 24);
> -	hws[IMXRT1050_CLK_LCDIF_APB] = imx_clk_hw_gate2("lcdif", "lcdif_podf", ccm_base + 0x74, 10);
> +	hws[IMXRT1050_CLK_LCDIF_APB] = imx_clk_hw_gate2("lcdif", "lcdif_podf", ccm_base + 0x70, 28);
>   	hws[IMXRT1050_CLK_DMA] = imx_clk_hw_gate("dma", "ipg", ccm_base + 0x7C, 6);
>   	hws[IMXRT1050_CLK_DMA_MUX] = imx_clk_hw_gate("dmamux0", "ipg", ccm_base + 0x7C, 7);
>   	imx_check_clk_hws(hws, IMXRT1050_CLK_END);

I've forgotten to add you in Cc, can you please take a look at it?
You've written the driver so you maybe can give me a feedback.
Same for patch 2/5

Thank you very much!

Best regards
-- 
Giulio Benetti
CEO/CTO@Benetti Engineering sas
