Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D44E698ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjBPIhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBPIhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:37:02 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF373403E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:37:01 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a3so3391746ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4KBTMU8jBmlXCRW1BaMb/5ofBQCyWlJecu0txQ7QDQ=;
        b=sX6bc4X1bXcDji0c9x8LU9221lS5GZNrB0hpiW83JiXZB8E7BbjFgomSAkDec2QDRP
         xMMyabXWimG5hrxVlKDQsh8/ig2WIJix2+a7B/zbbhwrNrK7YYYB+HL8T9THmhJRnB9X
         rZMI5uVRsL06y+UQxD8HugesN7xlwDsPgoOctNF2yN2ZOo4u+N2zez2OTxFRbKKiRa7V
         BIhTV0uc2PPHOg2VKcWBPujv07qjX21mpJr7rGUih6wbn+8yIi7TRyKHqeDdT1mo4BLE
         xNNAl39lS836wPU/L7VrIhemaC5i4wjQwCzd6zMBCiq1+0SnaoaOTTUMrdHqEcvWH9jT
         8Jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4KBTMU8jBmlXCRW1BaMb/5ofBQCyWlJecu0txQ7QDQ=;
        b=L0oHvuBBnobNQeSIzh5kwmuz/b6DqA2vupHrpAKKUH+55enkO71EMMyzJEh8KMTu7z
         GTGOT9csyGN8IY8yHoiZw+iMokSidwr5xpOp5srRTuCXhe88uaGPm8MjShbFMRE8RtYK
         m3U1M1MG3/LXm/vigBwlgco8ryJTG73Xw3e0j90yPwkmRq1CvuVpcGW84b/wl5n1yb4l
         pjb2iyIY1kRqIiWPB53Iy/XxA4RJ/fD61Inw+XfDXc8xWqhZQVTJaS++8YAG03M5qshU
         rUqt8qoxFlsIydB7ky4/O/zoqlbwmh8TlIuL83z1itD2c8RyHGghxRt8mpran6e4go/K
         BDfA==
X-Gm-Message-State: AO0yUKUpjw9+2fQr/a6PKY57ipxuopZurO5zGygka6C46jRaMq4KftHo
        kCSmvr0hoc3TdSuQn9PuaUmmXYSl8sKeiTbD
X-Google-Smtp-Source: AK7set/DjcOeEnTTPlpWqyb5qlVnKQSuJzZgIydVcNrWDHVrvPif6RZ/z5BOKu/cP6sB+osLLeO7hw==
X-Received: by 2002:a17:907:9868:b0:887:5f45:d688 with SMTP id ko8-20020a170907986800b008875f45d688mr6646754ejc.41.1676536620210;
        Thu, 16 Feb 2023 00:37:00 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k20-20020a170906a39400b008b14c5a82e7sm497276ejz.127.2023.02.16.00.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 00:36:59 -0800 (PST)
Message-ID: <f720eaf9-01d0-0e57-f6bf-9aade00aafb8@linaro.org>
Date:   Thu, 16 Feb 2023 09:36:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/5] arm64: dts: allwinner: a64: Add hwspinlock node
Content-Language: en-US
To:     Bastian Germann <bage@debian.org>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20230215203711.6293-1-bage@debian.org>
 <20230215203711.6293-6-bage@debian.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230215203711.6293-6-bage@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2023 21:37, Bastian Germann wrote:
> Add the hwspinlock to A64 which is already implemented for A31.
> 
> Signed-off-by: Bastian Germann <bage@debian.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 77b5349f6087..f2ecc21f06ed 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -851,6 +851,17 @@ wdt0: watchdog@1c20ca0 {
>  			clocks = <&osc24M>;
>  		};
>  
> +		hwspinlock: hwlock@1c18000 {
> +			compatible = "allwinner,sun50i-a64-hwspinlock",
> +				     "allwinner,sun6i-a31-hwspinlock";
> +			reg = <0x01c18000 0x1000>;
> +			clocks = <&ccu CLK_BUS_SPINLOCK>;
> +			clock-names = "ahb";

Please drop.

> +			resets = <&ccu RST_BUS_SPINLOCK>;
> +			reset-names = "ahb";

Please drop.

Fix the driver instead.

Best regards,
Krzysztof

