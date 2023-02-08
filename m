Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B4768E83C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBHGWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHGWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:22:54 -0500
Received: from mx.msync.work (mx.msync.work [185.250.0.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBC559E5;
        Tue,  7 Feb 2023 22:22:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC4EB51C43;
        Wed,  8 Feb 2023 06:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1675837369; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=Aa2PV27eIU54WaO8k3b46WwPSvf5JQjc0zNAr1utOQ8=;
        b=sI1Xkn0pAxy3Z6Io4b5Jo5vlgZLjmjdgAd4dceBJrf0zJ3kPscN+H1DscQ491SBb0pCNEq
        H5Vm1ijuwna1mwmTKhDJjCbeqFEOL23gDWsLntM93uLA/njTCni8rfgokU6zGmvL7l13wT
        Im+QAv0TZHb4MulpNzuaWLnoZkpS1q+N9y6gi/ZLo39OCwQszo2e/EJU83vj1hS0KVxSrI
        YfiogRii6P/E3KKlzLi7p3nnv7E0EAGHYy8e+EFDnSuafZxnDQAJdJPlqLjjkhm+QwuuPg
        91rcHK7gSA7+4wuCNGx+7pg4zDwfkyrgQj7Eo7w1ShcnDUF4n2wkDENSkjsYfg==
Message-ID: <430ee3ea-3a24-b3f2-e798-3bb5352b70cd@lexina.in>
Date:   Wed, 8 Feb 2023 09:22:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/8] arm64: dts: amlogic: meson-axg-jethome-jethub-j1xx:
 remove invalid #gpio-cells in onewire node
Content-Language: en-US, ru, ru-RU
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Yuntian Zhang <yt@radxa.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
 <20230207-b4-amlogic-bindings-fixups-v2-v1-3-93b7e50286e7@linaro.org>
From:   Vyacheslav <adeep@lexina.in>
In-Reply-To: <20230207-b4-amlogic-bindings-fixups-v2-v1-3-93b7e50286e7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

On 07/02/2023 18.07, Neil Armstrong wrote:
> Fixes the following bindings check errors:
>   - #gpio-cells: [[1]] is not of type 'object'
>   - 'gpio-controller' is a dependency of '#gpio-cells'
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
> index e1605a9b0a13..db605f3a22b4 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
> @@ -159,7 +159,6 @@ map1 {
>   	onewire {
>   		compatible = "w1-gpio";
>   		gpios = <&gpio GPIOA_14 GPIO_ACTIVE_HIGH>;
> -		#gpio-cells = <1>;
>   	};
>   };
>   
> 

Acked-by: Vyacheslav Bocharov <adeep@lexina.in>
