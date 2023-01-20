Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D9E674F22
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjATIJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjATIJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:09:18 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470058766B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:09:13 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e3so4074224wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jEZtg+5jqkpg3P/5H5Ehq0RGRwwcKGDTqGTwglnFBd4=;
        b=Sv6rd9DP92yI3Vlov+pggH2YbdMKcyrV6H3M7s2kfeYAdWRIAWM+akdhSkO93jojuk
         d/dJzetUSmUm1pK/pmVmDu+D7lKJR6awdUWBs3fucZW1WAOFGPqGkjotIY+msVY+7wMC
         3D60dbpmc9TyqlLqYh9FbtBLD1F5J+GHIQADXDdsRQ+8bFZLDEy8SBn5PyEF/InKjt56
         ORkXszC18x6mRkuwDFaA1+EGD5mNHh1OMr5NK4nMA0QObnJwyc/63pgzGW+t6EpIEdLD
         DiGYVuvTj92sjRuXCZ7dHUiOkUKbd6IoIuQx9x7Gl11VuOP/NbvfIkCAcjAwbngKzasP
         hZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jEZtg+5jqkpg3P/5H5Ehq0RGRwwcKGDTqGTwglnFBd4=;
        b=XWxRbHIsgkijWtnlTGPqk1lsF1sZxlOQAlmMet7yko/tHaR83JpJ8ClSjv/nmFaMX1
         Lw5KatY3iukmYT5gJROn9vyDKiV1loeodJ6KEefjOvN4go2r4GRwo9xPU9ZBXIB53RG1
         pEqXxxvCjv7UDpP+/oIDbucH63XTLe1QkjdYGeWYVrrPZ1+xNFGf8cwykeKeZgLGKtuC
         nkr0PZET/Zrk3sfZj4TX8RQNpyCt6LwRfO/5mRHQ2rfkwK9+UeNCduaPKxOIkfUHI4Oh
         DnqGHZ+jCBS66qZLm5sF4vWjyDm3b5fjlC9PX+p/io5D048Z3HzICglV5E6tCbZlqQoP
         lvHQ==
X-Gm-Message-State: AFqh2kq2Fs5y8AEx+eY7tGeNfsJk2Y4nU3gygTZfrai0Oux1q2E9skPt
        4fRAzCG3Q76W+vUywIt5GCl2lw==
X-Google-Smtp-Source: AMrXdXvKPQNavE0ZwRV4Z2rgT10cfoWdIMMymKvDjEgUTNHNzJwt/J6CZtgUIjo+VjdQwELkEwwvDw==
X-Received: by 2002:adf:c645:0:b0:2bf:81e9:cdc5 with SMTP id u5-20020adfc645000000b002bf81e9cdc5mr291892wrg.42.1674202151341;
        Fri, 20 Jan 2023 00:09:11 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ba29-20020a0560001c1d00b002b065272da2sm14597291wrb.13.2023.01.20.00.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 00:09:10 -0800 (PST)
Message-ID: <b4375605-c322-4dfc-e3ec-1e38aa45774a@linaro.org>
Date:   Fri, 20 Jan 2023 09:09:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v6 6/6] arm64: dts: Add i.MX8MP PCIe EP support on EVK
 board
Content-Language: en-US
To:     Richard Zhu <hongxing.zhu@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        peng.fan@nxp.com, marex@denx.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, frank.li@nxp.com
Cc:     lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
References: <1674192352-4473-1-git-send-email-hongxing.zhu@nxp.com>
 <1674192352-4473-7-git-send-email-hongxing.zhu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1674192352-4473-7-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 06:25, Richard Zhu wrote:
> Add i.MX8MP PCIe EP support on EVK board.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index 7816853162b3..6c94d57912b4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -404,6 +404,12 @@ &pcie {
>  	status = "okay";
>  };
>  
> +&pcie_ep{
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie0>;
> +	status = "disabled";

Ditto (drop patch)

Best regards,
Krzysztof

