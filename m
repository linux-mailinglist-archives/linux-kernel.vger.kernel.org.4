Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E8B674F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjATIIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjATIIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:08:37 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4343D0A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:08:36 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k16so3365000wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SoakVWr2ZpXn8C8zphXWAMGpcGPmjHlurBL8K29WTa4=;
        b=kZ4CjEly5q71Z7OT1xCMM7CXJM+0oCPaWZwNj0laoiWk5rkTBlxQC9VAyDYFmuewKW
         Ru6JgFaO0lcjAVNo41XRV+WjLO73wIY9cnumaiYh0JbZrVhPBCViXRbynk+PR1DbTckM
         lyFLWHtF3zj4cArdYrBzDv819FmV6CKKXN2jwAhClj5l/nnrCNiEWxu9UcQ09DYuY9EG
         EX8iz0WFgukU7RqLYxlR15RRElLRlkoI+cYogQi/ey4ldDuKHBsfRLZ2MxDOnpPd9q6E
         Bhc/2trz3/Yw3QRj3K7zUAdTDo/BzOjF9sOxGBbi9k6CeQbaqfHAVDBUk0ITclL3fTuB
         J82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SoakVWr2ZpXn8C8zphXWAMGpcGPmjHlurBL8K29WTa4=;
        b=BTZj8juQUzGBDPNIHUQIycc80F67A5N1X7qs333s1JOlcElpH5DCJj1j2OQ3rTamBZ
         ufEzZ6FZHKFFnh9PVL5bnEmyfxsVSQNmaId48fYuJZ3qgf1G0sshNA60bKeSZebteH2P
         VVROR+BUmnWooMmAEEubx8NA4mOA6nIVq6J+w9CGmkINK3VHs4r9BmVXks3PX0oxK2Yp
         ptAvUbVmMy4gU18xnOYMwCXA3poVtw1o5r0cAwnphl5w6N6My1e/gq1xAccShSVNaxN+
         OUG9dxrrWNTFAONM3MVwChOCA12FfwvqaXIcXfADkwoYwcWORl0JMy4PPQ5PJvxE9PgO
         Jmrw==
X-Gm-Message-State: AFqh2koKm2DX7C1GQPCs935x24EzSXqywHILH6CGi1TIldWQKw3au6kI
        jvx/yGL5Tj3RwRkeLWvUU5qi0w==
X-Google-Smtp-Source: AMrXdXsxranp5dMUg3iPRHSjijW/zcsfca/AAy7KUKgVp0zTYKX065EpPKjZGh4aP51/g0MyTlTP5w==
X-Received: by 2002:a05:600c:539b:b0:3d9:f836:3728 with SMTP id hg27-20020a05600c539b00b003d9f8363728mr13309040wmb.11.1674202115088;
        Fri, 20 Jan 2023 00:08:35 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b003da286f8332sm1522150wmo.18.2023.01.20.00.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 00:08:34 -0800 (PST)
Message-ID: <87469ff9-8fd6-7775-3d98-7d0b557d8ff9@linaro.org>
Date:   Fri, 20 Jan 2023 09:08:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v6 2/6] arm64: dts: Add i.MX8MM PCIe EP support on EVK
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
 <1674192352-4473-3-git-send-email-hongxing.zhu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1674192352-4473-3-git-send-email-hongxing.zhu@nxp.com>
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
> Add i.MX8MM PCIe EP support on EVK board.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index 0ce3005d578d..9d65b70939fa 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -371,6 +371,19 @@ &pcie0 {
>  	status = "okay";
>  };
>  
> +&pcie0_ep{
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie0>;
> +	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&pcie0_refclk>,
> +		 <&clk IMX8MM_CLK_PCIE1_AUX>;
> +	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
> +			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
> +	assigned-clock-rates = <10000000>, <250000000>;
> +	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
> +				 <&clk IMX8MM_SYS_PLL2_250M>;
> +	status = "disabled";

It's already disabled. What are you doing here? Having disabled node is
useless, so entire patch should be dropped.

Best regards,
Krzysztof

