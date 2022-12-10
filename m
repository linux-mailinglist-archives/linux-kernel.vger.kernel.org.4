Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D93648DFA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 10:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiLJJcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 04:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLJJb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 04:31:58 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E241D31E
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 01:31:56 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id c1so10712685lfi.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 01:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q22psyh7vIuSTAyo+VTH/u5gOPrXWBAWUyVY5G37HJ4=;
        b=IByPJGZusV+y4+L58Wx24wQ3AxHtMKJGLEt8/IYcCkAStjCFT2UQsZ/IBbAoPwXDz/
         YE3QOgtZUdY0Z77kEU1tScwbAZc5IAe4yKUUTNFCzR8UB2zl2DZTLLkAb8ic77L1yu9Z
         AX18YA0dmOSTttrhVpJeMCD2k0j0bnSwMXTOrKhO3U0AgoZtKgYjOARQGKh7QnHYeWVr
         ZJZwSpUvkAxqRtSN0chdrhGnb9TGBB0hiAEDSexgh5eNXFLPToJFAg12yEijpl3FLC0t
         Doj3kk8OkPOz4CcKUvh73ie/mOGGQRipm4fVmRx9P/knHu915x3OeiyuJEqNy7nv4tKn
         s9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q22psyh7vIuSTAyo+VTH/u5gOPrXWBAWUyVY5G37HJ4=;
        b=L4uY4UNe3V1NA1qE9cDPzfcIQ7MCx+Kcvpb8DUhV5pS5YVAPOTKMhIp7GRBvm7yVg7
         buf/QxSUNX/VlY18sufH7qV49aZ9FoNFWVNjSfSn//vk7R02fHTRux+FeC1qEpWHF59i
         rX0hLBJZpEm7eH2XsPYOXvu89yK9OUJznFKyAJJfNeDWT1jn5VZsLZZYERck4lU0WvCi
         IGYJv5zUxymojvmpC2+HiFibD+E9gbvGXGDAm2BygRVdpl70hinl2e/MdX5+VCwgY3iO
         lVYtsFv5Yob+IzcsgJanHVCnRjV6oB51nzX5J3x4Pz14Pb0j56VaYFxSZjIAcMpXlvT0
         OdCA==
X-Gm-Message-State: ANoB5pnUPaKuGR9Wi5k9qZI9fKzd79jXWv7tjkrzYXebYPWekcE/AmMV
        oEMzz1NusX8QcxGXmkF2HqUXpA==
X-Google-Smtp-Source: AA0mqf5cBUGRW0tkcAXfALEyDIFlijX6tAjRld5gC/6BIXWWq9sBRCjqmUtNdkImfcWqMp4Il3O6Fg==
X-Received: by 2002:ac2:47f8:0:b0:4b5:5da1:4bcb with SMTP id b24-20020ac247f8000000b004b55da14bcbmr3601239lfp.13.1670664715064;
        Sat, 10 Dec 2022 01:31:55 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id w20-20020a05651234d400b004949a8df775sm652098lfr.33.2022.12.10.01.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 01:31:54 -0800 (PST)
Message-ID: <5013a8f8-2c2c-f298-b397-8dc6b1944b31@linaro.org>
Date:   Sat, 10 Dec 2022 10:31:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] arm64: dts: qcom: sm8150-kumano: Panel framebuffer is
 2.5k instead of 4k
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209191733.1458031-1-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221209191733.1458031-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.12.2022 20:17, Marijn Suijten wrote:
> The framebuffer configuration for kumano griffin, written in kumano dtsi
> (which is overwritten in bahamut dts for its smaller panel) has to use a
> 1096x2560 configuration as this is what the panel (and framebuffer area)
> has been initialized to.  Downstream userspace also has access to (and
> uses) this 2.5k mode by default, and only switches the panel to 4k when
> requested.
> 
> Fixes: d0a6ce59ea4e ("arm64: dts: qcom: sm8150: Add support for SONY Xperia 1 / 5 (Kumano platform)")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
> index 8f1ddc969406..9f48a097927e 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
> @@ -35,9 +35,10 @@ chosen {
>  		framebuffer: framebuffer@9c000000 {
>  			compatible = "simple-framebuffer";
>  			reg = <0 0x9c000000 0 0x2300000>;
> -			width = <1644>;
> -			height = <3840>;
> -			stride = <(1644 * 4)>;
> +			/* Griffin BL initializes in 2.5k mode, not 4k */
> +			width = <1096>;
> +			height = <2560>;
> +			stride = <(1096 * 4)>;
>  			format = "a8r8g8b8";
>  			/*
>  			 * That's (going to be) a lot of clocks, but it's necessary due
