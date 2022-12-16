Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF2E64EC02
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiLPNTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLPNTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:19:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEFB2637;
        Fri, 16 Dec 2022 05:19:32 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bx10so2529440wrb.0;
        Fri, 16 Dec 2022 05:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=od90tXEQYsjLrQqPYAWlVmlPm4cbiuRT6WyvN1iDenk=;
        b=AmhgfXlT7Zr6IxKscdrarNyqKPDbNmj2k9dpNeesPsji5wD+Db0h3vPAztXh9wFVer
         Tod6TKuBut7PCtzq1GKMYRFU+aHKZoNxEgsg621Ad2qwPF20sn3kVCtvM+rgt0E+DsdW
         mtuTx4/b36nfmKXVMFPkkSVe25uoesKImVf6UKKhAAOMqteor1jZdYyQcUK3eHYjwq4j
         sEvdrcjed3J4KtM+EUtiU++VdZgMngClY5kyW5w2aCVTeQMkiC2sPjjx5H9NaFgvXj3G
         AF6FnxDZE5IrYMb0oVkpjOGuTc4/TnlglNgsmWFxsQlCb9amLtpkJ2kAkf+cTIyUFB/F
         qOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=od90tXEQYsjLrQqPYAWlVmlPm4cbiuRT6WyvN1iDenk=;
        b=m7RKE5iI9BnBGGlg0uA0V1MicC4b//2GtJdLmHqnGz2W8RtjohlA73SCD5+qy/sJX1
         nJbEntoqkwA0mp4SoRXl6oR/W4mKHOgzwFFauxIP8YTq+3FRAUuymbyNyO3+innq4im0
         Vn9egvm2T5anzQTHH41HZd7FvroB/N1WAF03QZYSlvnGtrLcV4+O/HlWMgGRFfzW9nH3
         IofEgghZ/gZ9L0mq0NLxzHOnwZqZK4o2ZVRvQGPThVOL8eaB+/Y7UV6fxB0pkdRuouE2
         bfvMiKgixvao+7fDEi6gml9svgCqGiETevKV+YB4x/9AMSoPxoxi99mo6d+vOgq1zYd2
         VCvQ==
X-Gm-Message-State: ANoB5pkGbmOuy3SNNSxMbhH5CL4/7N+8kot6hI+1sAMIII/zNL2j1SOT
        imhF/t2HBZNn+Hjqu9krjRY7uFtfDuQ86g==
X-Google-Smtp-Source: AA0mqf4ydAM5HaZnbwmxIzH1A8yNfHgcWat0P0NjHYg57pGecMzD5e4Ju3k/zehUXw+pUJCL5UM2Xw==
X-Received: by 2002:adf:e44a:0:b0:242:763:34a5 with SMTP id t10-20020adfe44a000000b00242076334a5mr20371199wrm.2.1671196771125;
        Fri, 16 Dec 2022 05:19:31 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id x18-20020adfec12000000b00236488f62d6sm2250832wrn.79.2022.12.16.05.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 05:19:30 -0800 (PST)
Message-ID: <f1e85a62-0f48-c4d8-f674-9a51b348e615@gmail.com>
Date:   Fri, 16 Dec 2022 14:19:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] arm64: dts: mediatek: align LED node names with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221125144138.477198-1-krzysztof.kozlowski@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221125144138.477198-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/11/2022 15:41, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern:
> 
>    mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dtb: pwmleds: 'keyboard-backlight' does not match any of the regexes: '^led(-[0-9a-f]+)?$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!

> ---
>   .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts      | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
> index dec11a4eb59e..77b96ddf648e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
> @@ -13,7 +13,7 @@ / {
>   
>   	pwmleds {
>   		compatible = "pwm-leds";
> -		keyboard_backlight: keyboard-backlight {
> +		keyboard_backlight: led-0 {
>   			label = "cros_ec::kbd_backlight";
>   			pwms = <&cros_ec_pwm 0>;
>   			max-brightness = <1023>;
