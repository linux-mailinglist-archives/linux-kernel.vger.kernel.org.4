Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1739735145
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjFSJ7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjFSJ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:58:39 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22B826BD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:57:47 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b474dac685so14989741fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687168659; x=1689760659;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iOef33aX9SqXLeZ6q1z0RA2Y2ZXLvzhAWSbAHkB3gyI=;
        b=JoPmFBgSdhOddKGu9esD8ZJut/ty52ZYbQkZAlUPuv8Xd5N5SPKt2g9IACUsFNO7Sy
         N5PXDBLvpRsmJTNfAOc8hqtySYGJK+hj57t8nND9o3I8zLYNu58qQFnOem3C07i2rOOD
         cVoJNzSxiTlxIL4f28chtCKrkvtF3wzSx4BymQtKdBZrMU4cma/nOSe7Dxl9UHS7Cyes
         pfAwaOjUu1hAeHozqU7sc9aYI7VF0N157443qOPI0EcwmujsemoieZWumfiT88V9tcFU
         H7bm5AhR7rWQHCqLOE+HwLQdsUgHj9Fj3+TvSZr8IG1g0FqdVmHQUjkfMSWLMIDm+Ho3
         tEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687168659; x=1689760659;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOef33aX9SqXLeZ6q1z0RA2Y2ZXLvzhAWSbAHkB3gyI=;
        b=DtA7tOIt/pJL1QMzArocccX7gFDNp85lBWGaUzPOQZ0elymTLKWpZN2CQGmtTtUi5z
         AfIDLpLtoSm/x0yhsRQArl9XVgxCso3Uh+Qr29W54RIYWfffkCclF6bf9zbF/A0QAEPy
         WVFUtERR+E9yGIvwR8eQ3Mgm3AmquETvIb0NFvTWnORQAtx3MCkPY6I5yxo4aafg07Ip
         0C+youc4mPgL5zloed1cfri6GlBYxDY0MvkeNu1mjPLuWTP+cy8EjIUBXizPNA8rRXxv
         TWohayXCMRRxUVvOegdLuaE+1g0l1HwBo01MTbndNznXBDrvT8NOBkFqPQ0UIPnZMVp3
         wn1g==
X-Gm-Message-State: AC+VfDwjTElKA+Knj1jt8djQadbPiqdZ/R0hNL1qPDR0r0ZmPREU/Fih
        8id7gHGmIJ4Wtj/w5cDcmorQ2g==
X-Google-Smtp-Source: ACHHUZ6jsvCNOIFPHYJ9QvPRqQzGliyLw0+8SuawY7NpXu4/dacDLz5JMbsAdwMSh1cF9wdf/AOZlw==
X-Received: by 2002:a2e:95c2:0:b0:2ae:db65:2d01 with SMTP id y2-20020a2e95c2000000b002aedb652d01mr5622600ljh.23.1687168659695;
        Mon, 19 Jun 2023 02:57:39 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id s20-20020a2e2c14000000b002b1a8b926f3sm5116309ljs.3.2023.06.19.02.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 02:57:39 -0700 (PDT)
Message-ID: <1da5b11f-0154-0fb1-0489-c617c44c6459@linaro.org>
Date:   Mon, 19 Jun 2023 11:57:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sm8150-kumano: correct ramoops
 pmsg-size
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
 <20230618114442.140185-6-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230618114442.140185-6-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.06.2023 13:44, Krzysztof Kozlowski wrote:
> There is no 'msg-size' property in ramoops, so assume intention was for
> 'pmsg-size':
> 
>   sm8150-sony-xperia-kumano-griffin.dtb: ramoops@ffc00000: Unevaluated properties are not allowed ('msg-size' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
> index baafea53770b..ae0ca48b89a5 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
> @@ -222,7 +222,7 @@ ramoops@ffc00000 {
>  			reg = <0x0 0xffc00000 0x0 0x100000>;
>  			record-size = <0x1000>;
>  			console-size = <0x40000>;
> -			msg-size = <0x20000 0x20000>;
> +			pmsg-size = <0x20000>;
>  			ecc-size = <16>;
>  			no-map;
>  		};
