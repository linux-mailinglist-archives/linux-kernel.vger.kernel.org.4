Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1920674F09
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjATIIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjATIIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:08:04 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C643C2B1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:08:02 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id n7so4098392wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=STHLwGZXZMHCtu+L3MSZ6vVWJEcyID79HXvNnoIUF8E=;
        b=JPJjsGVG7xNvKBsgABMXeoPgwfN/c/K03F9YjVry0PmgQ9C73vhxrwhwHGKUHB7Fqx
         LPTDXgtoUuhRwMiD0T4F4YLSlUOLoh2Ey+blMA1JXXZKX8V821CPAK7HgYWBb/VdI87W
         R1JkUsxatRn5huEOf1n8Gm4QR1F33ztX1g6kLqDt+tug1/KkuC4S+//uOx2zG/OUGChn
         ju0J+26kZ/Sj4dlnealw77Xok3ZEyQLCH10Gz7DSbS+phSh7QHQSkrrV7IJt5SO1CR2Z
         n00PTKUhFwingUNnC/WRBABuuqfBYkxhiQBI/K7sFRFXay/eo9KylQfwzoN4g7ZiNsH7
         jzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STHLwGZXZMHCtu+L3MSZ6vVWJEcyID79HXvNnoIUF8E=;
        b=Cw09cBN0BAbzQP21Y1qwuzVAP7nP9NCoOe7XoJ6aOARJb8flxVY0+td4M/UCakVtPM
         QZu9KXfUWy6gneBMDIUd5FOMyee+wExzZWcwt8v7FiWzd3Wjbfxh2b8/M/fJXWG0SaGH
         4Fbx73O6F9F76Rkws9tXL+t8gfAxfEj9g6fbIZVDJa1hcWrUtk8o/V5hfd039v8rBhj1
         FR8r6626waiIp3a/ZwbavHgQhGc2NuB5soZ346XLNfh42hNj3pZiwIE/GaCE6J7/QSjc
         yWBI5sEUlBrREUyznUw+rtXuzJ8+BOYiqrjYU0wc0543f6YYP6h1WlBHyd3rYnuihwj8
         Jasw==
X-Gm-Message-State: AFqh2ko7kNRSVYzBimQ9W4qlJmOahfGj2v5d6iBaGL1GxxeqqyCk6105
        zvYhr/7Pv9SZG3xvRACJIlwEFQ==
X-Google-Smtp-Source: AMrXdXt0yUFX/LrRmQp9TEzvtBMaEkuE1Mg+XzU/8ouTVQmDD2RVmuD0+miuMHOVLGlLXZWyRMKpKQ==
X-Received: by 2002:a5d:58e8:0:b0:2be:b07:d411 with SMTP id f8-20020a5d58e8000000b002be0b07d411mr11501323wrd.3.1674202081452;
        Fri, 20 Jan 2023 00:08:01 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f16-20020a5d50d0000000b002755e301eeasm17571099wrt.100.2023.01.20.00.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 00:08:01 -0800 (PST)
Message-ID: <c4733adc-4f2f-f4ff-5517-b4d2bc003ac8@linaro.org>
Date:   Fri, 20 Jan 2023 09:07:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v6 1/6] arm64: dts: Add i.MX8MM PCIe EP support
Content-Language: en-US
To:     Richard Zhu <hongxing.zhu@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        peng.fan@nxp.com, marex@denx.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, frank.li@nxp.com
Cc:     lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
References: <1674192352-4473-1-git-send-email-hongxing.zhu@nxp.com>
 <1674192352-4473-2-git-send-email-hongxing.zhu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1674192352-4473-2-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 06:25, Richard Zhu wrote:
> Add i.MX8MM PCIe EP support.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 24 +++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 31f4548f85cf..9662aeccdb3b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -1315,6 +1315,30 @@ pcie0: pcie@33800000 {
>  			status = "disabled";
>  		};
>  
> +		pcie0_ep: pcie_ep@33800000 {

No underscores in node names.

> +			compatible = "fsl,imx8mm-pcie-ep";

Did you test it with bindings? Does it pass without warnings?


Best regards,
Krzysztof

