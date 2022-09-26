Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E9A5E9C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiIZI4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbiIZI41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:56:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E2B3DBD6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:56:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l8so3995929wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=LivMufJfxLpe4WS1qV8qZqQ4CFkVL3CKwRAqAJHi1Es=;
        b=MRgp3u3JMORAFJM1sdZCZ+fpbuvN/7UVQgKaoUDWgnopUmx0KzboYH4qBgaa586Mde
         xjhaIqpQuYs6QeA3esTVl9PVqvdZ5WWnp8gzolizgYe/R3mJfJYbDVEzq/HN5SIGHWqs
         ZWrlxyCysl9mkx+q0cGFTdlKtPWJE7gXl4F/u/rVlQ5MSmjOpkRdxoMG6UfV7cUXScjJ
         /RpTRHqNag6vzFDFWtUM/WPB6ahMzKhSB9FOD52qmzoHJY74vIWpvcExI3Xn9t+YH4t5
         61KB3VEE0zuIzig4eUNlE1jHmWXdiVHefncrl5Qm9cTQ/jUJbWpkEbgbVXKJ7a3afli9
         lPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=LivMufJfxLpe4WS1qV8qZqQ4CFkVL3CKwRAqAJHi1Es=;
        b=DToaGOgvUVwPWcb5lkJEwnGeVBJzA7qDNQxsZw10f7zjitVX7mQ99pWaShPyjZFP4S
         z7SVxEYNq/4s2V5yNgygWJJnNaXGtfz/t1AheRiz8orklpBZVzjWOkUq3vdFshmZnLoq
         tQMRuVDg0F56FQJ5cwDsaqzvZvYyU0jHD9oiha0Z2ZdX96jXG80KaWlZ9G3drFXzbbOo
         B1BBDYhOSa6i7opvswcgGtGBgNBBiJjTP9ByuLf6GGCq1EiX+hPV9mJCjMKJXiJivLcA
         oBj5GE2wWmIoUOcfP4ACHsUcu8EhOb6iSXt+e1oQ0K5tr7r4C7lbh/jot9Il+5zt+Jt6
         DnQQ==
X-Gm-Message-State: ACrzQf26aFsTRE0BdLmrKJLCYdFBpiVISQtpjGgOOZG7lSVxDur9NZQq
        hNpBUou9Djrmw0eSoIbO5Zum9w==
X-Google-Smtp-Source: AMsMyM4Y59b0CEMYEx8UROytR1dUIY3XCcqskebtJQmrX/B7U6CuFkbooGLEL9GFVFs90Z58A0aXLQ==
X-Received: by 2002:a05:600c:310b:b0:3b4:c709:4322 with SMTP id g11-20020a05600c310b00b003b4c7094322mr20567216wmo.141.1664182584628;
        Mon, 26 Sep 2022 01:56:24 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id r14-20020a0560001b8e00b0022afcc11f65sm13731379wru.47.2022.09.26.01.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:56:24 -0700 (PDT)
Message-ID: <199190a8-611a-7940-0109-a5a509b3dc87@linaro.org>
Date:   Mon, 26 Sep 2022 10:56:19 +0200
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
