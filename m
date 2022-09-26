Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C555E9C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbiIZIyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiIZIxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:53:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CB83CBE6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:53:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c11so9043292wrp.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=LivMufJfxLpe4WS1qV8qZqQ4CFkVL3CKwRAqAJHi1Es=;
        b=PFSHfiu7M7KhHbwP0ceB/NA0fncscKquMUPY3R054Jv6/uQzPHkJ7Osjn+baRwnwWJ
         Gqlw0m0ygq/a2PTWJ1tqmXzNxB7ndwRgwvdfkmzq2KWiM73ISW1gcEaeMvB47nj0EczM
         fHzWswDfvAhidsBNM2cQdaEfzX2fk0Ay7ob7f50S6+HlqZ94CYK95F9x3CK7DxNrPCZ8
         Jj9hNcGYdfSMVBdeiZy2lkTxeboZFxxPa8ZtvXMr8wqzW2LpLmF77F3c8jVChFescLDV
         aRcKxvGmLryxssEwYm85E16VBEKTVb9sup4SxJ93FL7xDMDwe0hKw3fgsIbB1JxvH+0Y
         DnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=LivMufJfxLpe4WS1qV8qZqQ4CFkVL3CKwRAqAJHi1Es=;
        b=z6F/O3e5bgrpMKlub+Zo1S0XV+1dmiyzQHJL+tq7S6l+FREqAcYFI1qxukQsXf17Kv
         Sftxy/bx4RxUYt4OcEvVqd/jH3q7L8MP0rII3ZX8HxSyePbzr2qZm9Qxsdn1+/y+p6RY
         ff8Yu2ySGAt56lqyqQZjEApc2XGhQGJoRXw/xeCc5icxGLi1WrLvHG6cnsh8tQFVxUhG
         u59CjXZ9iyuYCyNI2IF0IZYoPocTRhMRZYsOe+JAIYpfW6f2lAXyPIEIZarMDgLGD9jW
         YGEaZaR7j6C46y6eBgEfQn4QmA2ilFB4pw9CDduwLYNfjHvjoApTTeuslhXL5ucfbPIP
         iM2w==
X-Gm-Message-State: ACrzQf3GpWVXtusEHKAMS3774a+M5m9lgoEGIfAnay75FnpQanuA/2UM
        Fi5uuiamjLQv8MT0L6pne5y9EQ==
X-Google-Smtp-Source: AMsMyM4DCMtMi/TGHpEULTmQPoY0SfiG4h2J3z/9LCH58zU8LGOX7pHu6gayEcBzM+3/Ib116p7mzQ==
X-Received: by 2002:adf:d1e1:0:b0:22a:cd3e:e98b with SMTP id g1-20020adfd1e1000000b0022acd3ee98bmr13124669wrd.510.1664182423996;
        Mon, 26 Sep 2022 01:53:43 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id q12-20020a7bce8c000000b003b5054c6cd2sm12142329wmj.36.2022.09.26.01.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:53:43 -0700 (PDT)
Message-ID: <f7fa76a5-a4c5-d254-bac1-c2933cb10044@linaro.org>
Date:   Mon, 26 Sep 2022 10:53:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] ARM: dts: qcom: pm8226: fix regulators node name
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
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20220925210229.128462-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
> Adjust the node name to match bindings and fix the validation warning.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>   arch/arm/boot/dts/qcom-pm8226.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
> index 9b7d9d04ded6..be8c8032a3b1 100644
> --- a/arch/arm/boot/dts/qcom-pm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
> @@ -98,7 +98,7 @@ pm8226_1: pm8226@1 {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
>   
> -		pm8226_spmi_regulators: pm8226-regulators {
> +		pm8226_spmi_regulators: regulators {
>   			compatible = "qcom,pm8226-regulators";
>   		};
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
