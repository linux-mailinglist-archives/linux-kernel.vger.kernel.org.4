Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A768B74DECE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjGJUHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjGJUHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:07:49 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC5719C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:07:44 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so76247591fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689019662; x=1691611662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Gmkr0ZsV7o9lbnt39Mt5hBjVzHXUL3TRnDJ+Lhjk48=;
        b=UUNRxaaJeK6MBUR6FGYs6kSlVtSWACYECM2MlILdlrf7J4Y6FzZG1b8TjdLhH4Nmlz
         3vDRW8A9t3NGVNfzFpErchAVANUjkSA7KU9e4zZMG62N9goUQbZKBlLiZVjgG8eCUZEd
         2ai7tjadJgN62/n+MzfbGMD8r+9h571gi3KiVA+ouQSReLHogLgPViESJ4JwwK3wmS4d
         sv9z2xfEbtfKUpBQVi0p3vXZaeH9hrkdpUUXv4r4yFziCk04ziKieLeVgsURjnd+jwcJ
         sd02Il9bqZ7oSJf5/OmZm2U5dEg2U5VzoRocX/02a1A2beAJhYyX9Sd6JQBrcYWEBJR2
         zzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689019662; x=1691611662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Gmkr0ZsV7o9lbnt39Mt5hBjVzHXUL3TRnDJ+Lhjk48=;
        b=cVBtH+Tg41By+hRazgSo4zV8fdoDUb8mWskoHbbR0C589aI2+nPokGrBB8054x7DUG
         BJfJga78IsXXZGSTxScZ8Cc9G8QMFl1ZBK4zfDVLzEAlf0Be+ANCl5IO02Vjd1KZlpJM
         qIl4FijiAOixosu8BXnF/4v3YcQFiB7YGPHd0SPfIg/442aqCO7h79FF+rQpYjUlsgTr
         I4HtoGKG/vn/erKHx/LUtQsyUc2ODgWsvE43zMgy0kGINJLfKu//FHCW0v5McY0PQ6oG
         AodSrLjHsC8I9UG1Q4z6cRAL94GPBZK0sNViD4hulDocwKB4tkeG0kJ0CdyJi4N0+I0s
         Akgg==
X-Gm-Message-State: ABy/qLaj+nKn9kYcEXjjs20D5cYm1uRVf4TjT79lKBX8AOsKMbk/X+FQ
        OsAUDyvIjXEOpPqLXU0s59qijg==
X-Google-Smtp-Source: APBJJlHQNf+KH5erXwYyHE8pLluEhzLlSnS1QXI/mllF/cXrYYtjdPxl8Ruwbp9e5HUitkEm8V28Aw==
X-Received: by 2002:a2e:3c0e:0:b0:2b4:7f2e:a433 with SMTP id j14-20020a2e3c0e000000b002b47f2ea433mr11330207lja.36.1689019661849;
        Mon, 10 Jul 2023 13:07:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l24-20020a1709065a9800b00991bba473e1sm175723ejq.3.2023.07.10.13.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 13:07:41 -0700 (PDT)
Message-ID: <ee0db4bc-ec28-513a-bd39-b526a6ee805c@linaro.org>
Date:   Mon, 10 Jul 2023 22:07:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] arm64: dts: qcom: ipq5332: Add tsens node
Content-Language: en-US
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-5-quic_ipkumar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230710103735.1375847-5-quic_ipkumar@quicinc.com>
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

On 10/07/2023 12:37, Praveenkumar I wrote:
> IPQ5332 has tsens v2.3.3 peripheral. This patch adds the tsense
> node with nvmem cells for calibration data.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 113 ++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 8bfc2db44624..a1e3527178c0 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -150,6 +150,91 @@ qfprom: efuse@a4000 {
>  			reg = <0x000a4000 0x721>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> +
> +			tsens_mode: mode@3e1 {
> +				reg = <0x3e1 0x1>;
> +				bits = <0 3>;
> +			};
> +
> +			tsens_base0: base0@3e1 {
> +				reg = <0x3e1 0x2>;
> +				bits = <3 10>;
> +			};
> +
> +			tsens_base1: base1@3e2 {
> +				reg = <0x3e2 0x2>;
> +				bits = <5 10>;
> +			};
> +
> +			s0_offset: s0_offset@3e4 {

Underscores are not allowed in node names.

Best regards,
Krzysztof

