Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C58762A339
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiKOUn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKOUnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:43:47 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008A963A9;
        Tue, 15 Nov 2022 12:43:45 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id c8so10548831qvn.10;
        Tue, 15 Nov 2022 12:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q87uCsHCBTu9Z0/6CF1vDWYXnEVvrdO31JXyGw3q8M0=;
        b=jF5I4hmhDrYs3/Fpf2k+KouEY8u8ERsCeluyxLdxtS1coXenuTmlq/1+Z4PIk07Mr2
         ZExdYGAI2/BdEq4l0SRT1WYAlL2LhFTf1XumBObTWmsPwhgiPY2PdJHK0ySiLQumIMDw
         3ARiz8zQ1068vyxH/QgCInKC8OR1u5sUq876ZVstkamFfZ0jxAcmiDhy0Bg0IL2w48NY
         uDIdGAnM92bSxFPVFZOlWblAn9RVwPy8NyOJ9mvZiWng2ekUXnSnO/3X6Tk+K1FBBADs
         Zq2cOEJLuiBIFUVHagL2qXxQHTEZgpCWO4npvW7dddA7iJ7YwzBfQuPXMM/ENfiL/SUo
         abWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q87uCsHCBTu9Z0/6CF1vDWYXnEVvrdO31JXyGw3q8M0=;
        b=1EHrhIMrMASq+5kolbGtSIuCjA9sv55ZivnNtyqwLC4yhuBoXjOnxW6NEeBzuk3Ngb
         Eaj3tyaH/xJnba2Hy5fopwq1Z0hX79/Z/v9oC/TnN1RcaR9WR+2OBiXcxRByZWzsq/E+
         NRG7Yoy/sJdult4qiqQvpBW+ElrOLdRKczDzbDzI4CAvOT7PX5Nq8sh7VD7fZ7tKXKJn
         sSjRjWMGtcgF9N16Xupy9B/97RhmmjLBRznhzsNlLkVaiBvtJwSo0gY4GwHbN44KeBOy
         GMDArqQUhF44DYnnuUAmzZpKi44E6t3IooMAGLsgHkxucPIe/jkyy6+kfRgPvajBZpCC
         PeJQ==
X-Gm-Message-State: ANoB5pk7olHGV67iE/iS5thKK4wjLh5Nlh7cdolDaukwgd5b7iZ/L2xH
        o/zRbtGDTDbjUnLXbtouEyk=
X-Google-Smtp-Source: AA0mqf543qnsocNHrWBmFuloL+X64vLd7zWgx3ulcBS+q0kbikND+rN79Jq9tAIIo3idUYG2pdDLaA==
X-Received: by 2002:a05:6214:5a81:b0:4bb:64ec:c465 with SMTP id ln1-20020a0562145a8100b004bb64ecc465mr18546030qvb.24.1668545025030;
        Tue, 15 Nov 2022 12:43:45 -0800 (PST)
Received: from [10.4.10.38] ([96.237.180.62])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a240700b006fba44843a5sm1000557qkn.52.2022.11.15.12.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 12:43:44 -0800 (PST)
Message-ID: <b09ead30-3fc6-f00b-e157-8c753358d5d4@gmail.com>
Date:   Tue, 15 Nov 2022 15:43:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 2/4] clk: imx: imxrt1050: add IMXRT1050_CLK_LCDIF_PIX
 clock gate
Content-Language: en-US
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
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
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <20221115193244.10484-2-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/22 14:32, Giulio Benetti wrote:
> Cc: Jesse Taube <mr.bossman075@gmail.com>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
> V1->V2:
> * nothing done
> ---
>   drivers/clk/imx/clk-imxrt1050.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
> index 26108e9f7e67..39f77c03b892 100644
> --- a/drivers/clk/imx/clk-imxrt1050.c
> +++ b/drivers/clk/imx/clk-imxrt1050.c
> @@ -141,6 +141,7 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
>   	hws[IMXRT1050_CLK_USDHC2] = imx_clk_hw_gate2("usdhc2", "usdhc2_podf", ccm_base + 0x80, 4);
>   	hws[IMXRT1050_CLK_LPUART1] = imx_clk_hw_gate2("lpuart1", "lpuart_podf", ccm_base + 0x7c, 24);
>   	hws[IMXRT1050_CLK_LCDIF_APB] = imx_clk_hw_gate2("lcdif", "lcdif_podf", ccm_base + 0x70, 28);
> +	hws[IMXRT1050_CLK_LCDIF_PIX] = imx_clk_hw_gate2("lcdif_pix", "lcdif", ccm_base + 0x74, 10);
I think it makes sense to squash this with PATCH1 because it changes the 
same file. It also will make the change more understandable as I swapped 
the offsets for PIX clock and APB clock accidentally. I'm not sure if 
this is necessary but I think there should be a commit description. 
Otherwise
Acked-by: Jesse Taube <mr.bossman075@gmail.com>

Thanks,
Jesse Taube
>   	hws[IMXRT1050_CLK_DMA] = imx_clk_hw_gate("dma", "ipg", ccm_base + 0x7C, 6);
>   	hws[IMXRT1050_CLK_DMA_MUX] = imx_clk_hw_gate("dmamux0", "ipg", ccm_base + 0x7C, 7);
>   	imx_check_clk_hws(hws, IMXRT1050_CLK_END);
