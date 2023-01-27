Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32E867EAC9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjA0QX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjA0QXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:23:54 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A1080F8F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:23:53 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q8so3826943wmo.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=65MO12imV1nqCcpTeXSLh3c/aVlDLZs9NEXVWBJqWRk=;
        b=wVDHfwnW/Z2+BDsP/bNqlYsc+0Obb42FoQhtkUt3II9REyXmgmnN9Mnv9bbVeXBfRy
         +56GhmfJLXI/J64TBWemi9pxLT0PrwyXIgdO5HGtoOFKAUlfjcWkiaCTmtJThB8VmwUh
         LcByHD0PCiN3MabUOD0/xVnZiHPcYIezFr+QVPtC5yK2K18vrqjnmpOBWMgpMcyQMYnN
         fv58JdLgiEN/PI8SITq8NU06Rv+mq/02zbEac+Gnvo4i2izPeLKdKhjHe4+f7PLMZJBa
         rUuR1rMx2E1XsLDuYDlpA0w3wNC1urnmV/n1KPAqCwPrjuq2HpZIIYF+l8UTVUHBqByb
         sinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65MO12imV1nqCcpTeXSLh3c/aVlDLZs9NEXVWBJqWRk=;
        b=EsA7J0jVU9RgGxj+Yi/yUS8uhuvbQCikukE2uooREI4sA9YNlXBjLEjUoXQj1UdIOX
         4oPT4JgNRcNxBfTwQpJFZ5YOpgOKorbZa7lWllPQCMaff7a5sNDvVxHt/T/UMohDUKYj
         CZFBxEV2CJy5uZ3n9hHM129gDZwTEQICaOuVgqfbw6uq8CxQHmguJ26skX0sQTdvCNVq
         NCnFzk4cOVaQ9h8oofYrSUUcbjjsVnjblIP/iQCQnuF+ZNLjoHs4Ymb8FMA2LD17jaO8
         qDf0K4AzBxqhyZTFnvahgrS1jcBuZ6BhtwxMUJmDFqWKDF61HGYIFSJP2i+F1JpmXXGf
         Zwkg==
X-Gm-Message-State: AFqh2kq4qMqLG5fiBvkiDRQknXFwym9sgRHF3K2++J3e4pzICZi4I8iZ
        qCaft9n55l66yBZ76QgX949xtw==
X-Google-Smtp-Source: AMrXdXuidEmKRArhNg4hR1+6a9tqUH+Fvwc/xoaTWpcivHWXGGhJYiSN6tDkGVlXLzZqW9icUMm8dg==
X-Received: by 2002:a05:600c:1d22:b0:3d9:6bc3:b8b9 with SMTP id l34-20020a05600c1d2200b003d96bc3b8b9mr40855982wms.9.1674836631849;
        Fri, 27 Jan 2023 08:23:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:d4ec:15ea:873c:61e6? ([2a01:e0a:982:cbb0:d4ec:15ea:873c:61e6])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b003db09692364sm9191058wmn.11.2023.01.27.08.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 08:23:51 -0800 (PST)
Message-ID: <7e52a67a-ac64-2340-3b52-83e334440d7c@linaro.org>
Date:   Fri, 27 Jan 2023 17:23:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/5] arm64: dts: meson: bananapi-m5: remove redundant
 status from sound node
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230127142221.3718184-1-christianshewitt@gmail.com>
 <20230127142221.3718184-3-christianshewitt@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230127142221.3718184-3-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 15:22, Christian Hewitt wrote:
> The sound device is enabled by default so remove the redundant status.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> index 3c1267a7ffef..86f0afe6491e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> @@ -233,7 +233,6 @@ sound {
>   		assigned-clock-rates = <294912000>,
>   				       <270950400>,
>   				       <393216000>;
> -		status = "okay";
>   
>   		dai-link-0 {
>   			sound-dai = <&frddr_a>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
