Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9483B61F70E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiKGPDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiKGPCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:02:31 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D736BF6B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:02:29 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z24so16690517ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 07:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fODzgR6f5QIFQoQpSBqUjOLDxlY3mnOv7TGRHuzFTmQ=;
        b=Sa3GlGhKz9uFh2xqVF8cJoU3Rjyu+lW99l4UTK5vaJQyJGY6nBEgvS0sw04i2CTloO
         bsEm3VpZONpb7/0esp7CVMuVMI0WhPcfnK4wfKSJBdQZWTliIllDagRJbTVMLjWVfMB/
         y7nOTLmb+q8rBgXSIyLUO8Dy8CFYQ9ra93pHcCjU3iJFxmCcidG9C7lwTRq5WNBrT5zy
         2BI50NMYSP2Jlv+QCsIIVgCnREo91KPRqexIfjimqLibHRiZ8yv3+lw6O6DeppQkqrzx
         j5Jcqd+rbgT+8Izh6bAq+KIbx/7p7XBzgWKhQy8DCK64B7Hr5oesOQiXBYHUndvSskGE
         fBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fODzgR6f5QIFQoQpSBqUjOLDxlY3mnOv7TGRHuzFTmQ=;
        b=f6fdZGPNH/TkeI9BClpMQk0jIh1J/qufbPNtBCscKIVus+QhWGT4CqG3OGbIHbexmI
         znaDGgEMYUVNjrTV1rYK9yy88AkIhyRtGVDCpKAxCOpLREys2P3mo6ri+RI/cxUFW/mX
         rzgoltvKJpVVsqvOw4B2pwVVa5RuqcWzm51J/2hjLy1ia2cdocOLRKzqXcqSw44P/Gae
         QhyHNtOHiOEs6YSHGJNaP70L2TuRiJB0efRPeA3fQelrlHKNYd+Tnhmv17+LhR6R/2Ji
         vKPsMug9AAbrt7bWfPU+Cao8h0+HaK7HtcybixUTCgLdPAttFXB0GTV3nuhJ6c3MiHtw
         JH6A==
X-Gm-Message-State: ACrzQf06D63t0BfwSn2M59sQEkwPunf7kTm9KV5R/lqexpUCBaVjvkTQ
        q7/v4/70mhFagXskcZ93IX3CIg==
X-Google-Smtp-Source: AMsMyM6B0W0l3KqZ9xRH+gtlHucDMeOI7PEKTYEscM5ZWSFSyC5tIOLxpnuRvNgZsHoxQ2HzMi+yNQ==
X-Received: by 2002:a2e:bc11:0:b0:277:6018:6f07 with SMTP id b17-20020a2ebc11000000b0027760186f07mr12809516ljf.16.1667833347512;
        Mon, 07 Nov 2022 07:02:27 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id x23-20020ac24897000000b0048aee825e2esm1272499lfc.282.2022.11.07.07.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 07:02:26 -0800 (PST)
Message-ID: <88c55827-067c-e6b1-a841-be70c05b7fc4@linaro.org>
Date:   Mon, 7 Nov 2022 16:02:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/3] arm64: dts: qcom: Update soundwire slave node
 names
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        vkoul@kernel.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org
Cc:     Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
References: <1667830844-31566-1-git-send-email-quic_srivasam@quicinc.com>
 <1667830844-31566-2-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1667830844-31566-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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

On 07/11/2022 15:20, Srinivasa Rao Mandadapu wrote:
> Update soundwire slave nodes of WSA speaker to match with
> dt-bindings pattern properties regular expression.
> 
> This modifiction is required to avoid dtbs-check errors
> occurred with qcom,soundwire.yaml.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts             | 4 ++--
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts           | 4 ++--
>  arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 4 ++--
>  arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts     | 4 ++--
>  arch/arm64/boot/dts/qcom/sm8250-mtp.dts              | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index 2c08500..983e8a9 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -1007,7 +1007,7 @@
>  };
>  
>  &swr0 {
> -	left_spkr: wsa8810-left {
> +	left_spkr: wsa8810@0,3 {

While changing it, make the node names generic, so:

speaker@0,3

https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

>  		compatible = "sdw10217211000";
>  		reg = <0 3>;
>  		powerdown-gpios = <&tlmm 130 GPIO_ACTIVE_HIGH>;
> @@ -1016,7 +1016,7 @@
>  		#sound-dai-cells = <0>;
>  	};
>  
> -	right_spkr: wsa8810-right {
> +	right_spkr: wsa8810@0,4 {

speaker@0,4

and so on...

Best regards,
Krzysztof

