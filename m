Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6356782DC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjAWRTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjAWRSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:18:52 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E4C9EE5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:18:26 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so9121213wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dm4tVx7Ktm1TROcUxQcJbyZ0GFOr9/zY4sDt0r6QtHM=;
        b=WsNpkk8cs9nNO1TSpU3nzblsbtRV9K0XkCHEnsMmIB4HJuRntlr2p2yh/LZFm/RLpI
         CsXg/DPYPtCPzQNVWVtcZ8tSgz9qETplZ2gH8GgWwISYuJsM3RVAqcqTfq5s+y7EXZbx
         hHOLmss/kA7NMzstBitC+8/H795q8u2rQXK9CHEQlDd2x6RZePt583/PEsR1lbAK3MLo
         jQn3b6AqN5VI7HzhITBZZlxdWPSn1xAgDyddb8+2QY0Xzr21iksAhUeNlk/0LerSUyMm
         xK4ytVWiPT4Kx0PIy/1PU7wy+3IarrWYPuxWL1+LPckRHRe7hVF/HrxeFeYFN14SRo/x
         rjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dm4tVx7Ktm1TROcUxQcJbyZ0GFOr9/zY4sDt0r6QtHM=;
        b=uCmRaI89DOV4/qNW/hAEQ/OrS3q+N1EA2poyogDfGJtqd0H9D4DxnxZpjEOog94x8s
         EvRgBZrDhKd5CR4Rc3Iiei/iBoAEIGcsqLUl11aWLRzVIFeG4pP3h92cXKBWGWAVxwNM
         1Pvuvqv4Vy0xYvONFozgoGUmYEvTloCCjekL8hT4zpRjtr0BVTRmU/+nWnOl4z1zsl7t
         GLHVkomloa+qMdDL5IFcz0L3ZEhP3LLfKy1aJsATfRNiqyrugxsLFke5bh39FtghK/m/
         swQuByZ0hZARtBuiNK/9ILVVLtkSwG7dX3olQK+kqGhV/k8trwMhfbptS/P3uSbwUsLF
         cBgA==
X-Gm-Message-State: AFqh2kp7p1+7u01AU5+k2N8KF2sLgg+y5CIfBcYuM/FuUeMVs9nV2kP+
        xsTS4leIbsLB2XNTO+d0o8MtAw==
X-Google-Smtp-Source: AMrXdXtnErYrv8lVfvrt00x7Dk7jqp7bU4diG4fsuDxceJzOyCSq3biItIT/dbPu7Kfhe/+Edv6bQg==
X-Received: by 2002:a05:600c:2056:b0:3db:ce8:6662 with SMTP id p22-20020a05600c205600b003db0ce86662mr22663193wmg.31.1674494298647;
        Mon, 23 Jan 2023 09:18:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r11-20020a5d694b000000b002bb28209744sm4332992wrw.31.2023.01.23.09.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 09:18:17 -0800 (PST)
Message-ID: <02e5bf79-3e2d-02c8-67e7-61bbff32ba29@linaro.org>
Date:   Mon, 23 Jan 2023 18:18:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 5/5] ARM: dts: qcom: msm8974-oneplus-bacon: Add
 notification LED
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230122-msm8974-bacon-features-v1-0-4049f565c24c@z3ntu.xyz>
 <20230122-msm8974-bacon-features-v1-5-4049f565c24c@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230122-msm8974-bacon-features-v1-5-4049f565c24c@z3ntu.xyz>
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

On 22/01/2023 17:48, Luca Weiss wrote:
> Add the node describing the sn3193 that's used to provide notification
> LED.
> 
> Unfortunately the driver currently supports neither multicolor API nor
> using the properties function & color, so we use label instead.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
> index ffb486ceb6a6..a672c45d7070 100644
> --- a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
> @@ -114,6 +114,34 @@ led@0 {
>  			default-brightness = <80>;
>  		};
>  	};
> +
> +	led-controller@68 {
> +		compatible = "si-en,sn3193";
> +		reg = <0x68>;
> +
> +		shutdown-gpios = <&tlmm 45 GPIO_ACTIVE_HIGH>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@1 {
> +			reg = <1>;
> +			label = "red:status";

These should be colors and functions.


Best regards,
Krzysztof

