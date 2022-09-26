Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4805E9D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbiIZJYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiIZJXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:23:45 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D091165BB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:22:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k10so9857106lfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5Pax1quc7TkVCsZ5g50ISsP4krlqOVio/qYdLgmPV2A=;
        b=ZlAjxTIbF9jWZb40Cys1vsy5WSEW4ArucWQMek5niQFZonsCRJ495ZTx8dCaaGV6O3
         QjDkdeCwRoPFQ2/sLqHc8BjPLXuYz38QlBiomM/KXS5gzH17NZmEiYTbLVyiQAxEZpfP
         vICWmo3ldGWvgvr17wg8mtjFib3PabC93VVNpDdjfhLOqgWOS2eufT3zUZdS9rcwvVPN
         bKExKv+6ZGRzxpHWbPAjkJfa4yci81w118nwXzsJ9VacewuRI9zsnLkEgL7ecj0v5aEH
         nKlek2qEkl17CRkUlwTDEsehzQkBmJ1VXviR39NZ7Qjt5GvMfCOuE+Zp7SJQj+FWx0ZP
         ssyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5Pax1quc7TkVCsZ5g50ISsP4krlqOVio/qYdLgmPV2A=;
        b=dzdiHD39Y2A38tfQzWAHGO4XGh2WZp1GEyN5TB4lTtU9wNxjqJp5R+qRgFGLxVgZLf
         Fkq+XJ2dvAK3TCvZcLtcKCnIstQwLLsePqh05kOAqSPQmbNhRJ1LZKxTZ7gp/qyMMjRJ
         KtBTP1zgfzQMVX1cpG6Kd5tPONvaVSQpCVT6cMJiZWrhTVnxAsU9YgA+Q+sbV4/hvAnf
         5Bpbp3W7SWkA2SNRKYNY+JA+jGkdO9sW7K0l4fYPqaUhVYXa8F8lmeDfHSDzZuT/KRrh
         VLvma3/mA4f2PyfTSdcFkb12DSy/gC2mWhx6JyROQ3psKJtv2B7F9fQ23b1X+ysqkhPz
         mktA==
X-Gm-Message-State: ACrzQf3TMoaBa2lOnUUYzD4kW6ewTwolWOQ7YuibUivcFuYrA8dH4Gcb
        sR2tuO4Ue3dsAoZ57+7nnKOaQg==
X-Google-Smtp-Source: AMsMyM6Zb7SV+m0UEnPdXALbNrT0oxJ3wNweY1r7T3uKJxbT2ckDhfEi4NsqJhhhUcLcF7aPMaF/Dw==
X-Received: by 2002:a05:6512:3055:b0:498:f7f5:53a3 with SMTP id b21-20020a056512305500b00498f7f553a3mr8185314lfb.367.1664184134878;
        Mon, 26 Sep 2022 02:22:14 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q6-20020ac246e6000000b0048a757d1303sm2471959lfo.217.2022.09.26.02.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 02:22:14 -0700 (PDT)
Message-ID: <ec8cc121-9814-cd52-fb49-c33ab1376f89@linaro.org>
Date:   Mon, 26 Sep 2022 11:22:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/3] ARM: dts: qcom: pm8941: adjust node names to bindings
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925210229.128462-1-luca@z3ntu.xyz>
 <20220925210229.128462-2-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220925210229.128462-2-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2022 23:02, Luca Weiss wrote:
> pm8941-misc should be called 'extcon' and pm8941-coincell 'charger'.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm/boot/dts/qcom-pm8941.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
> index 33517cccee01..01f14d5f314d 100644
> --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> @@ -27,7 +27,7 @@ pwrkey@800 {
>  			bias-pull-up;
>  		};
>  
> -		usb_id: misc@900 {
> +		usb_id: extcon@900 {

Why? extcon is Linux specific name and should not be added to DTS.
Anything requires it?


Best regards,
Krzysztof

