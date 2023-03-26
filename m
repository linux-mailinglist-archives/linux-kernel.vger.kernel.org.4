Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3FD6C933B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 10:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjCZI4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 04:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjCZI4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 04:56:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DC159FA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:56:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w9so24221264edc.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679820993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSRJuPJNbdoJyj84IHhrxYPlKl+uIt4tNBO6X3LD2DI=;
        b=xQ6x8t6UN0lTvfBbnStPW15+jZwIKm8rVcOWs7jvMIE9A94J3+n70etIA0cgKZDJTy
         dT1Ea2HkG7tw3zLbLDdyAHSY+qvYwzNRMPy2qUQqjlNuWfcGjsZ2t1fpdtQt+aJZqTAx
         P7pbSWZ8Izg3D8O2IC5P6gqrbOO8m4I30QeQg1J8q6J8bPWZ69NQZff/Q6gwzRsoNfMa
         kyiWBlEnfwvJladFS8YRLUDfu97ld2NdWzNTN2nUoZ/RJQUfv8slvpq1dKlBGkcmMpcQ
         PyeGe53k7MJXRGEc+gidiPkYbhsZ2tK9MpUsmh73ET7BVV6rh/qhEELnqNKQxJBPr4CQ
         0Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679820993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSRJuPJNbdoJyj84IHhrxYPlKl+uIt4tNBO6X3LD2DI=;
        b=bMdCV3xC3xD+WhDs4O2MOwO7m6ulg4kbhzqdq0o1YcUcP41/pKDh9Ws9wRFLgf2a8j
         OU11GFypfP9Fry2WEHxSuVhIZDAh9v1orPABkGZBOvJ78W0LyGZ7JT6l+e60pLduWyg4
         ObDBNO4tRgqt/u6OTDd57rNbOgrex37/TYXnvDPz2r+xbOk2jH/zwmZ8O1O1BIkXBYPk
         x3G6iUL6z8Rkq7b2McFEp23YpswzmwHbA3LSdBX2cjPvB31S170XwMTwqQz/GjNydJN2
         bEKAjL+bnyWEuUYg8uVChpiRgt/27ZRbvWsff+iMUAkbogV19eQkD6ut7/wxkwzF5G5m
         4M/A==
X-Gm-Message-State: AAQBX9djwxmrLqf7EUN3BTdlFOxakjs79hxyKmGL3xKyp+b8DgJgqJsU
        ZoQm0zGb00VI1R6yRx7KgT+xFw==
X-Google-Smtp-Source: AKy350bInaaXgnMIes/Y4RoXKc3ohgRSh/e0IdcU2rk18ZRcrLYvSKRpTJJBOuQQN4EdoOhGrSDZkQ==
X-Received: by 2002:aa7:c50b:0:b0:4fd:29e4:ccfe with SMTP id o11-20020aa7c50b000000b004fd29e4ccfemr7941750edq.18.1679820992803;
        Sun, 26 Mar 2023 01:56:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6cac:926d:a4f2:aa09? ([2a02:810d:15c0:828:6cac:926d:a4f2:aa09])
        by smtp.gmail.com with ESMTPSA id q27-20020a50aa9b000000b004af73333d6esm13160375edc.53.2023.03.26.01.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 01:56:32 -0700 (PDT)
Message-ID: <61881229-cd91-cfb3-be2b-51d516f8473c@linaro.org>
Date:   Sun, 26 Mar 2023 10:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/4] dts: arm64: qcom: sdm845: add SLPI FastRPC support
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230325135114.21688-1-me@dylanvanassche.be>
 <20230325135114.21688-3-me@dylanvanassche.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230325135114.21688-3-me@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 14:51, Dylan Van Assche wrote:
> Qualcomm SDM845 SoC features a SLPI DSP which uses FastRPC through
> an allocated memory region to load files from the host filesystem
> such as sensor configuration files.
> 
> Add a FastRPC node at /dev/fastrpc-sdsp and a DMA region, similar to
> downstream, to allow userspace to communicate with the SLPI via the
> FastRPC interface for initializing the sensors on the SLPI.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 8dcfe6293762..5a6c7d00719b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -878,6 +878,14 @@ mdata_mem: mpss-metadata {
>  			size = <0 0x4000>;
>  			no-map;
>  		};
> +
> +		fastrpc_mem: fastrpc {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			alloc-ranges = <0 0x00000000 0 0xffffffff>;
> +			alignment = <0 0x400000>;
> +			size = <0 0x1000000>;
> +		};
>  	};
>  
>  	adsp_pas: remoteproc-adsp {
> @@ -3344,6 +3352,22 @@ glink-edge {
>  				label = "dsps";
>  				qcom,remote-pid = <3>;
>  				mboxes = <&apss_shared 24>;
> +
> +				fastrpc {
> +					compatible = "qcom,fastrpc";
> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
> +					label = "sdsp";
> +					qcom,non-secure-domain;
> +					qcom,vmids = <0x3 0xF 0x5 0x6>;
> +					memory-region = <&fastrpc_mem>;
> +					qcom,assign-all-mem;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					compute-cb {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

Best regards,
Krzysztof

