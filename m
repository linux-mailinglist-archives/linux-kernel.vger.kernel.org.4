Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81946E20B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjDNK00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjDNK0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:26:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962E54C22
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:26:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so11352079a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681467981; x=1684059981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8BUA25suHxulD4h8h8Ed5YSUpG0AWCiE6eu6o5CSqZQ=;
        b=r+9GrPNHUWonE+1iJu8Gj9vKbD8RASLQeG/VSb3udb6n//Vmg6VLrDb1neA11Pp+e+
         10pdWhXL/0O4OYnvs1fX041x+4LCIPgnF36cgKp5MChMJ65PXPeX38yaM7WANtztw2zO
         7WaQBf2q5KA0tZyGMqV8gc8gpZ6oCzo1WC9Sh2TyDyQjpOx3SXqVfueS9La3cvN2HEOA
         0JVFc9A+jd7QSILSvawjv7Zhx7i67a2574kW6xBywufRn4GjdNmBuzPH05ysnJ/OXkfr
         oxjjjqfz30OjQL/JyjIFucnDumiNuy1QBkXai19eiCfW63lH1lD/MClsHsISHCmsyeIr
         /9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681467981; x=1684059981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BUA25suHxulD4h8h8Ed5YSUpG0AWCiE6eu6o5CSqZQ=;
        b=f8k+Z1QOnb5ZvJ0uLtk2UpJcFH/UuGB9b52LsZFh3+vMPp4BY9mteAWQCgKmvpA2sf
         eLgB5Cwb3zBT5p+RWERsEwqagXyvMbr3BKQq3ysHiZKf5NZlQUYWWqIAU7VY3HyVCzJT
         l+gjQER5XtneUQA06QdMmJSMSF5JbG/jstD/bUPpspjOy2vxwbSVBfFgyVFG9Q29Yda4
         0XGIXoKpSrKw9tQesGjHA4Lp8pWK6562BE9ZU2fP1e1dE5Xig5Dj56ophbu4N+mCK1PK
         4z8OIvsiGdOzOLnObfrEw/HIWKEy3DEALUtm1Bfr1NzmraoOF6boWRVqpJ4sAmEouvne
         IHzA==
X-Gm-Message-State: AAQBX9d1T5qts544vKa64eVr1imv2y3Fv+bfXXFd+/MulBV1t/CQKjqr
        8cwNu8cu+57gFAKe86X4APkLIw==
X-Google-Smtp-Source: AKy350bmKBLAazy18u092/q4UOoH8FGLrv5xZiozb2JD87u6Jz8fplX4+HuDdSHDOgiARsXEVdaxvw==
X-Received: by 2002:a05:6402:42d6:b0:506:70a3:2aa0 with SMTP id i22-20020a05640242d600b0050670a32aa0mr5511669edc.3.1681467981125;
        Fri, 14 Apr 2023 03:26:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:40b9:8c57:b112:651d? ([2a02:810d:15c0:828:40b9:8c57:b112:651d])
        by smtp.gmail.com with ESMTPSA id l12-20020a056402344c00b00504803f4071sm1962444edc.44.2023.04.14.03.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 03:26:20 -0700 (PDT)
Message-ID: <fe746692-fed3-6635-8658-4e91d30f2aa8@linaro.org>
Date:   Fri, 14 Apr 2023 12:26:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Use generic name for es8316 on
 rk3588-rock-5b
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230414093411.113787-1-cristian.ciocaltea@collabora.com>
 <20230414093411.113787-3-cristian.ciocaltea@collabora.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414093411.113787-3-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 11:34, Cristian Ciocaltea wrote:
> Use generic 'audio-codec' name for es8316 node on Rock 5B board.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index 62750beb12aa..8cc97d146a73 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -72,7 +72,7 @@ hym8563: rtc@51 {
>  &i2c7 {
>  	status = "okay";
>  
> -	es8316: es8316@11 {
> +	es8316: audio-codec@11 {

This is a trivial change. Fix all instances in all subarch/platform DTS.
Not board-per-board.

Best regards,
Krzysztof

