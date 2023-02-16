Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409A9699211
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBPKqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBPKqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:46:13 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA292D6A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:45:50 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id k24so1484376ljn.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+tEM7ELPzWqQR39OWNvLKsRiqKGZ0XHVkzhGqQzL5A=;
        b=tMDIOPqrV1cihBfOtKYdrin2dN/STDL8GJgt0/X7r+iAEezn22nj1ALz3qLninITwo
         VqQkjhE1ib57xd7df8rhIA0lIK9sbAFGGeBqLZYNRG4TNUhdKFDu/x5UghrnctL45ahb
         gLpqicbL2IB41gqZIB5mxp0XrcjBde3MpRhHWKJ3DFHT0tdD8mI3FoJUt4BXF/ICPnOB
         jDQvlqqFk1lRd9vF8sn5S3WDIM/w33vTRrxl9jtX/14wxQpJXymL7TXWAQYHs0Ee6zs4
         VUGRrvtTTqjwaOpVXE+0jQLRdLG9TzmfYVwbo7b/a+AYWxp6JvkBD/dzEyXcusS2tLPU
         dbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+tEM7ELPzWqQR39OWNvLKsRiqKGZ0XHVkzhGqQzL5A=;
        b=kncfd39Zo92Frl3SuMs6eiYT4X1sHw5HC7KmUBBMzL2nFH+K5NOh6f9d9MrEZ9E9/S
         2tIxcoq8jL1kyp6Zv6tP5Nklc5zBcflZjdan5jUVpNvSoSz+hw6EQxa9HK7D40ZPJgvN
         39ovY44TJneWs19Zjx9l+OOTO5BkmwLXkV+K9lChdnKnZYoCgmqXRnUWeNEwMT9tLPEU
         85uh9ZIRvtee27usYrO7x3ymWd05vjRZ+L7qGfBxO8vyX/kc8nuNMqm6pLgstzC7rlQO
         r2HWsOtMjtxEPzroACO3ETfXxgN9aK2WjC1saVqfcRvjIDKEh1h1dfRP7BddCjTURlPn
         Ifbw==
X-Gm-Message-State: AO0yUKWIa1QLeLJmn4pPqafF5+csq/JTcEm7RKaOyYK4gKgNCsQ/4nZD
        u1Rm9aOy0DHwyeO8dTwKodaI7w==
X-Google-Smtp-Source: AK7set+CXwukOmdllAARvYAOe0F8ZQOQ8gO+m4oU6JCDs+DivY338SNguO78KAxpky2MfX5SA616Fg==
X-Received: by 2002:a2e:a58e:0:b0:294:6b9a:6e91 with SMTP id m14-20020a2ea58e000000b002946b9a6e91mr132856ljp.17.1676544344786;
        Thu, 16 Feb 2023 02:45:44 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id t16-20020ac25490000000b004d5786b7299sm250603lfk.5.2023.02.16.02.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:45:44 -0800 (PST)
Message-ID: <7a411fab-b0b9-e61b-5a4b-dc4da1758c00@linaro.org>
Date:   Thu, 16 Feb 2023 11:45:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 1/4] ARM: dts: qcom: ipq4018-ap120c-ac: setup serial
 console
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr
References: <20230214161211.306462-1-robert.marko@sartura.hr>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230214161211.306462-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.02.2023 17:12, Robert Marko wrote:
> Add the required alias and stdout property so that kernel can setup
> the console based off DTS and not have to set it in the cmdline.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
> index a5a6f3ebb2749..38efd45433da5 100644
> --- a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
> @@ -8,6 +8,14 @@ / {
>  	model = "ALFA Network AP120C-AC";
>  	compatible = "alfa-network,ap120c-ac", "qcom,ipq4018";
>  
> +	aliases {
> +		serial0 = &blsp1_uart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>  	keys {
>  		compatible = "gpio-keys";
>  
