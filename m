Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC313668FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbjAMH70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239812AbjAMH7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:59:13 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B9D5373F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:59:07 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z5so19207366wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S/oMLkBOnD290qbrE6pzN9G/Hhm9cWR2pFL/k2bFlN8=;
        b=LiMtBVTrWqQDdf0LWuh6CnvRnV5rbASBr8yl4nNUo+2ISVCCUlH0jrgK5H529f5een
         HD7wulyHV/lKpHzXxx7elFDvSW5910gaRwIJs/dIvcGZ5cEVpS83fa2Q9xRp2MVuJFpM
         209RqqAdVpX5RPgCdR59hnPyAMo9f1g4uIoz2Uqv9HmBAWCo/i79agsi5LDEMEHPK+td
         Ii5X9eufXMZs+R4g3Y4SVoxMsAIDHa1dKvnRV3lNlCneS/HsZXRz3zq4ImXH7vTtz5qw
         vl9H9Msuxp3Z9E13DuPn0TqJIsT1iJBmuFHghGkczznAjbRAulNqzvlZW8CXXLWgdOck
         La4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/oMLkBOnD290qbrE6pzN9G/Hhm9cWR2pFL/k2bFlN8=;
        b=BeLC2UMUOaDwi+LwIKAMlcL+rDwH8cAQH8UE2omhKNAlf4Bs5kONYSzX1HmT6MQ2g6
         gaFtdnLw6MpxSwBnB2UjxP6S0TshhjOhvnBR/QVa6W5ISJdvL3A3vZBhwnELIUA2sCxF
         oq5zLyE7qFQw7lpKV2EyiWpjfTb8z7xuotHmvH6mXxfE94DvC5r4AgCPoWxJhltfJGOF
         lcu7yKva9pqPDVa6Kg2nFJcShRnL2PfLpgeaTxIoLPpbun+tRHkRwBQPlAmkJ9I6OBqu
         LUlZWSQDocIPNFr72gYG7bYo4+FuTp1mQEj5hxszJj0rjt/4C7phS8JD9U3MeM+Kh98i
         IOsg==
X-Gm-Message-State: AFqh2kqjtQifC0/iq4qH9F9B/9EZaHHKR7rqWWI0czLLS6szgJ9cQT//
        ZwvX+sGJ2L/jQ589pJ6E6/DpgA==
X-Google-Smtp-Source: AMrXdXvycYOuWc5AoUDUUKwrnceG8E6IB6hct+3EmAZQNyya2ff4ZzsmK045sFSZtKoRMFiFxs9M9g==
X-Received: by 2002:adf:eb4f:0:b0:242:659c:dc7 with SMTP id u15-20020adfeb4f000000b00242659c0dc7mr48215131wrn.61.1673596746159;
        Thu, 12 Jan 2023 23:59:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8660:aed9:5ce2:6bbb? ([2a01:e0a:982:cbb0:8660:aed9:5ce2:6bbb])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d678b000000b0029e1aa67fd2sm465978wru.115.2023.01.12.23.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 23:59:05 -0800 (PST)
Message-ID: <039f5898-03b6-84a4-28d7-b8434ad85a42@linaro.org>
Date:   Fri, 13 Jan 2023 08:59:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/6] arm64: dts: meson-axg: jethub-j1xx: Fix MAC
 address node names
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
References: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
 <20230111211350.1461860-4-martin.blumenstingl@googlemail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230111211350.1461860-4-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 22:13, Martin Blumenstingl wrote:
> Node names should use hyphens instead of underscores to not cause
> warnings.
> 
> Fixes: 59ec069d5055 ("arm64: dts: meson-axg: add support for JetHub D1p (j110)")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> changes from v1 -> v2:
> - new patch
> 
>   .../boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi     | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
> index 5836b0030931..22fd43b5fd73 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
> @@ -168,15 +168,15 @@ sn: sn@32 {
>   		reg = <0x32 0x20>;
>   	};
>   
> -	eth_mac: eth_mac@0 {
> +	eth_mac: eth-mac@0 {
>   		reg = <0x0 0x6>;
>   	};
>   
> -	bt_mac: bt_mac@6 {
> +	bt_mac: bt-mac@6 {
>   		reg = <0x6 0x6>;
>   	};
>   
> -	wifi_mac: wifi_mac@c {
> +	wifi_mac: wifi-mac@c {
>   		reg = <0xc 0x6>;
>   	};
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
