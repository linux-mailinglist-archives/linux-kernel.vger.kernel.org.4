Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2AB633C21
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiKVMJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbiKVMJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:09:35 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201A24732C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:09:34 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id d20so17660125ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ZD3VVVFh1AU2zjGJYTB+TJZq374XTiT14bnR+oy1JI=;
        b=BkDpER8hmrv73TFgPEFSoFkepvVOtf2iT3bLQkDy6otKfLhdsFd2n1gpNV0dh0WMrs
         9HeG/GMquZSssZ8nVoehhaGt3nU9Et1p0SOzg8PSP7Uy2peKg4WkKSTDFTrhkGO9E7BY
         JssNK3ZDRtAOGl3FWPodSzHywXOhGXiHhGF3LzhaJgcI5P/VsEHnIN5kgZhBY7Y0fUxy
         KcsrtZWxe+hJkNKTdMtAtqMiBQCkIp10dx0nQ2mxtokZgPI78VwU0rSRT5ai990NO4dm
         ruDtEQFTGeEBCHhcMhSuY+K98J8W1i8laytUo7liglT+uB+jd3X4AH5otfbgC8R1b3lZ
         wUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZD3VVVFh1AU2zjGJYTB+TJZq374XTiT14bnR+oy1JI=;
        b=5PTODm/T83nOPin30+h7rFqNuhi9Dg2BzA1SL9+5XSQoZ10WwCOd2RWAYDDRbdQxPN
         0JAp2UzUgHZxKMD24PSbqlBm2qknt43ZLNChzUuJch+Pc5kBGgZIqyVZaco2ScGfjG2m
         cinfK4mC45aOY0mvX61qOFrIZrA73+cOOXj0/QPdv3piFFc2jvnhdECu5JT+/j2Df1F8
         MPci9X9a4qJ7ucQK1CfibgOgZmgoYBZYhiGJG4CfHplGQZ925jkih0/G99eq73oOPlZr
         2pxz/YzmJEzgfQvM+dysvCkF9DAK2G2GZi1FzM+7OxdQPcIS8HE1vLa/CzZZqLfYa66h
         bg9g==
X-Gm-Message-State: ANoB5pla9ZvMfoDzlxuphSS9wxSABFkpNfC3IHmLyCQgSoUb8j8zCkJ6
        Gm0Jd8Xh83GIVCQjkP7nDC2xCg==
X-Google-Smtp-Source: AA0mqf59Pdk52BV2iOIAuYFJocChXfShRihfZCTI4sAzzMyEyuHu7qXMgqPLoXtliUHsiZH6Um8/Kg==
X-Received: by 2002:a2e:3a1a:0:b0:278:f073:d3c0 with SMTP id h26-20020a2e3a1a000000b00278f073d3c0mr7940111lja.357.1669118972347;
        Tue, 22 Nov 2022 04:09:32 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id y25-20020a2e7d19000000b0026dd4be2290sm1836111ljc.90.2022.11.22.04.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 04:09:31 -0800 (PST)
Message-ID: <d8094c01-38d7-d758-16e0-13939af422c6@linaro.org>
Date:   Tue, 22 Nov 2022 13:09:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] ARM: dts: qcom: msm8974-castor: Enable charging over
 USB
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Julian Weigt <juw@posteo.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221121213019.324558-1-luca@z3ntu.xyz>
 <20221121213019.324558-2-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221121213019.324558-2-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.11.2022 22:30, Luca Weiss wrote:
> From: Julian Weigt <juw@posteo.de>
> 
> Set usb-charge-current-limit to higher value so that the device can be
> charged over USB.
> 
> Signed-off-by: Julian Weigt <juw@posteo.de>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> index 2725bd343f3a..0f2154a57a59 100644
> --- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> @@ -575,6 +575,7 @@ &smbb {
>  	qcom,fast-charge-safe-current = <1500000>;
>  	qcom,fast-charge-current-limit = <1500000>;
>  	qcom,dc-current-limit = <1800000>;
> +	usb-charge-current-limit = <1800000>;
>  	qcom,fast-charge-safe-voltage = <4400000>;
>  	qcom,fast-charge-high-threshold-voltage = <4350000>;
>  	qcom,fast-charge-low-threshold-voltage = <3400000>;
