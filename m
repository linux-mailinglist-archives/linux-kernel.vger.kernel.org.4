Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A470072503E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbjFFWwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbjFFWwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:52:44 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91F31725
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:52:41 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b1ac373c9eso64390511fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 15:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686091960; x=1688683960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odYCRHRQ0gkwKhK+y2SacO/W7W8SAPtOlMi46abCh4k=;
        b=K9ZToqVtYGeJMr3uPq06q4SXo0Xq4+O+99N/PMJ9Ke4Ms2BdMzE0YmefueHuQ7M0OZ
         J2xV9v7QD+F5H48AMROR6Y1F7cSRGWtDmRnC5h3JFdcB73y0kP0fKUjLUKOTgzDLVQbF
         L58m+FCmvnEK+hWzax1fO7D5NxwCmV0FggQuCxZNzgefDhHfDDixiSeQ0mHY3+ltWchw
         A36nq4b4dKE0wV+J/TJbdftu4xTPA+1hSjw4U0V1QjS/UcDVffs14Pu5DqFD4V9/cYYl
         h39pJrDIfFbwsNSEzh511kg+bWQoW6WwFA6FQwnuCkGMhvb5H/cI+xUxiGzC3vOmvziO
         hJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686091960; x=1688683960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odYCRHRQ0gkwKhK+y2SacO/W7W8SAPtOlMi46abCh4k=;
        b=kqZkes0vSX/CABB2uda0pkR2oRemYBwDX08Kww8l30MA+VriDydK/fOhOVTSRdMVwV
         QQ7y9Sxz0f7HvLauJUG5xNcKB+Al6mqwa+n78tFrLebp9Vcyefch9qkiw/M/WQoV/AqF
         R7u4JSxrlzMS/k7zmo4yN6W71NFi/CAt/QlupL722gT4x1CXGlY2uPU0T4NRRnPZLYd5
         lQ9iXlw/0C8td/a4JQfYeqY1EK+eaz9N6oXjOf+1IJwcETRn1JZ8ZXEHeZ1KXCM+MV07
         XoU/0+oKc3LsPqU361Szjen++Ayu3z/gnL2qFlTWbHqldkBHwlUiucNVwpDMAyZs763h
         5MlQ==
X-Gm-Message-State: AC+VfDzGeK+cTvbfb8/9s018xCt2vfc5mPshN9zBbzlPx8ujGNRSmxk8
        4USUlDdgMBdzSbAhjm8hiBKGEw==
X-Google-Smtp-Source: ACHHUZ4KZwQFOH7rrX32p1/vKfvhKjWp355/Mrl2AujBs9Yoiklg4fAZ5RK401e3IXIMMlADj4lGhA==
X-Received: by 2002:a2e:9096:0:b0:2af:3141:a52b with SMTP id l22-20020a2e9096000000b002af3141a52bmr2047883ljg.22.1686091959916;
        Tue, 06 Jun 2023 15:52:39 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id v5-20020a2e87c5000000b002ad9a1bfa8esm2033169ljj.1.2023.06.06.15.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 15:52:39 -0700 (PDT)
Message-ID: <974f68dc-b667-c9a7-94c4-1023ef271fab@linaro.org>
Date:   Wed, 7 Jun 2023 00:52:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8250-edo: Panel framebuffer is
 2.5k instead of 4k
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230606211418.587676-1-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230606211418.587676-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.06.2023 23:14, Marijn Suijten wrote:
> The framebuffer configuration for edo pdx203, written in edo dtsi (which
> is overwritten in pdx206 dts for its smaller panel) has to use a
> 1096x2560 configuration as this is what the panel (and framebuffer area)
> has been initialized to.  Downstream userspace also has access to (and
> uses) this 2.5k mode by default, and only switches the panel to 4k when
> requested.
> 
> This is similar to commit be8de06dc397 ("arm64: dts: qcom:
> sm8150-kumano: Panel framebuffer is 2.5k instead of 4k") which fixed the
> same for the previous generation Sony platform.
> 
> Fixes: 69cdb97ef652 ("arm64: dts: qcom: sm8250: Add support for SONY Xperia 1 II / 5 II (Edo platform)")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
And so I derped again.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v2:
> - Rename griffin (copy-paste from related patch) to pdx203 in comment.
> 
>  arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> index 3d22be747f042..8f867f841cb83 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> @@ -54,9 +54,10 @@ chosen {
>  		framebuffer: framebuffer@9c000000 {
>  			compatible = "simple-framebuffer";
>  			reg = <0 0x9c000000 0 0x2300000>;
> -			width = <1644>;
> -			height = <3840>;
> -			stride = <(1644 * 4)>;
> +			/* pdx203 BL initializes in 2.5k mode, not 4k */
> +			width = <1096>;
> +			height = <2560>;
> +			stride = <(1096 * 4)>;
>  			format = "a8r8g8b8";
>  		};
>  	};
