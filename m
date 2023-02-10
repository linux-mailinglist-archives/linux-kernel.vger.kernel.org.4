Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F577691E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjBJLSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjBJLSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:18:15 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97AF39294
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:17:49 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r2so4717936wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LluXRHw1q9uiEZifFjzk0gopSuMiP0vZV1o52cFhagI=;
        b=gUBktHxMRHYp0QENlk0xiZa5eocX7nVaQMH12EOKTVCyWsf13RixwQJWuUd7koRHSb
         DBsBC8b8Vl9+OxaBnPV4uOtwzdkZWt/hMA9ay9ZysrKAt5I7C9vMBjUqCt8l49PjduwT
         /F07Bf3/3dbOKa4F09CbhKYYtC0bT5MV+w7yOKUvDUEZotTg5+BcAe0qXWYnhXU7KI+N
         AyfgccM5a/xjwz218+8bzDS6TGtAun40MoHbYRPi0aLCsRHcVRZvO8wH9gVv28ODQ7BK
         OUAClZ5U7FWDoHTza7afvbryozYTcwyQ+zxQSNTLY3F4p8Jh7dDOPlhUj1ka6kQ4X9Wq
         LN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LluXRHw1q9uiEZifFjzk0gopSuMiP0vZV1o52cFhagI=;
        b=l2xme22pdf+jfeSpKj9nr6YB/0Yib9ggkIistO1hxlHPU7Ltpj9afcpzCVx1uRMhzz
         UIvm1QC+bWHtj/kk91mqjBqT8P+PRJczFn9Mbfrwedx3Cc4grIqp2rSNnyBp9X9Oy2fO
         nsapSRG+A9XjiU/tJNKIJLzrEkKVxKSBvI66XZYqJ35H6bf/bI8/Jp/JvAjfzwuIFKOh
         dayQeoJGOIpne1z6E+0aaHrac0tc2OaVrioe9ughnucMvf8YSESulHL2Jjx0NGmV4eYR
         RBg0kHCWRlN1KB8+l4LgezUpFgJCiBN/Jvuuo6X1NSdf9OS3jeZ1Tgj1/5/PDQpgeIdi
         t+iw==
X-Gm-Message-State: AO0yUKWOCzgBulg2XplkcmD5S7PzvdkRfxlS1Do+9ptIQAjHD6H/5i+T
        pr1ffnIuTJBddfscchOixUcQkQ==
X-Google-Smtp-Source: AK7set/+DurBtwXRzd5cecBlX95GqusHF4ZlYLj5keSuUNnQy45nTWUYYDKS/lOS0llUQGjuZM2uEQ==
X-Received: by 2002:a05:6000:181:b0:2c5:4b3a:dc20 with SMTP id p1-20020a056000018100b002c54b3adc20mr941562wrx.5.1676027868288;
        Fri, 10 Feb 2023 03:17:48 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d568d000000b002bfb8f829eesm3310604wrv.71.2023.02.10.03.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 03:17:47 -0800 (PST)
Message-ID: <b5bc6bef-1304-79b1-39e3-61c65ef98cf5@linaro.org>
Date:   Fri, 10 Feb 2023 12:17:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 5/8] arm64: dts: qcom: sc7280: Update lpass_tlmm node
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org,
        quic_mohs@quicinc.com
References: <1675700201-12890-1-git-send-email-quic_srivasam@quicinc.com>
 <1675700201-12890-6-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1675700201-12890-6-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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

On 06/02/2023 17:16, Srinivasa Rao Mandadapu wrote:
> Update lpass_tlmm clock properties, as different clock sources

All your subjects are vague. Everything is "update". That's not
acceptable subject.

> are required in ADSP enabled platforms.
> Also update LPASS_MCC register region. This is required to avoid
> memory region conflicts due to overlapping lpass_efuse Q6 regmap
> region used in LPASS PIL node.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  .../arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> index 9b04491..86ba4a5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> @@ -121,6 +121,15 @@
>  	status = "okay";
>  };
>  
> +&lpass_tlmm {
> +	clocks = <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +		 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +
> +	clock-names = "core", "audio";
> +	reg = <0 0x033c0000 0x0 0x20000>,
> +	      <0 0x03550000 0x0 0xa100>;

Are you sure your patchset is bisectable? The conflict is already there
- via patch #3 - isn't it?

> +};
> +
>  &lpass_tx_macro {
>  	/delete-property/ power-domains;
>  	/delete-property/ power-domain-names;

Best regards,
Krzysztof

