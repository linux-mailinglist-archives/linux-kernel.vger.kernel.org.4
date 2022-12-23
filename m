Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65111654E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbiLWJQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiLWJQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:16:46 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6422826ABB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:16:45 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id s10so4424165ljg.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KXbHYBuDIV5lUJXXUP4LnYOsl7UwVCFUCALdZR+OXAQ=;
        b=H3sQ+jHe5Z3JtG1119HvnXeyk4Uw8Lsg3yjKTnebZyKM07wWg615yTsYGsoDHvt/hS
         q+BOq/kz9Or1/12S54jhHQep6IWHXUv2p9fNSkXIAZkXAPpZu9TjrfkbKXVVWACDaoeS
         +gpv7EgNF4e6n62wBvkO1K8HWtRoyAJANObhEfq3ac9Bq59rJMlDADrKgyoth7MenPFS
         5XJOqgmQ4yzmVJJo+E5h118PT9bxtVSSUyjJn8q8YY29nRli/QBnZ3IlE6bk5VFH34fk
         Fk2sFanEBI5IdpMn8og1EV72kqIWs/UQOPaO/FMxwN+zcEh/g7L65KUTTAo8bECil4/K
         cMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXbHYBuDIV5lUJXXUP4LnYOsl7UwVCFUCALdZR+OXAQ=;
        b=MbvluSWNE6sjRyYC5i1D8SS9FpfRgLX+GVa9kQ6HDwAr6efMV7cRv6PlAdhCSX081D
         71D2vGCTCddluo8/OpXpbWScxF32+/R2L9MTjFCLE+ogMD66kZDH+mu+RrA7qMzoa3P3
         1DrrG8RsIlfV1N4n8p4Od6BMlM3qlVYevJt3E0nt1NNYLxvJPG5Q5GsQ1QdCPOz49GPI
         lM7ll+Lw3OH3Z7nWMTrS9/Dx+r6ltjHrClMG3HYbUypiQkxFgFS/ZKUUmGXcCXGDGUcI
         19ojyZkG1KRjBgBXsduhdW2mEvP/Xjw86pLiJmx/8hCmcGYKoAKD04RoCPiBagn3aR2D
         CYXw==
X-Gm-Message-State: AFqh2kohEionNP2GcU6WCtP7XX7SsLIuLJ55ddcsBzttkbrMuCss2GXt
        RREmro8wMSmWFQY16QcsOpxT4Q==
X-Google-Smtp-Source: AMrXdXtez93izZq8YZ+fN8elJ6VvJ8bOrAVeqQGSPUhyuGBteGzly12p5jek1guTd9KaU+PX5xivVw==
X-Received: by 2002:a2e:2286:0:b0:27f:836a:229f with SMTP id i128-20020a2e2286000000b0027f836a229fmr2313634lji.41.1671787003659;
        Fri, 23 Dec 2022 01:16:43 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y8-20020a05651c106800b002790e941539sm327679ljm.119.2022.12.23.01.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 01:16:43 -0800 (PST)
Message-ID: <4ea89880-d876-4ad8-e2c7-55a985acb53e@linaro.org>
Date:   Fri, 23 Dec 2022 10:16:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sc7280: audioreach: Disable legacy
 path clock nodes
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        konrad.dybcio@linaro.org
References: <1671702170-24781-1-git-send-email-quic_srivasam@quicinc.com>
 <1671702170-24781-8-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1671702170-24781-8-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 10:42, Srinivasa Rao Mandadapu wrote:
> Disable legacy path clock nodes to avoid conflicts with audioreach
> clock node.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  .../boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi   | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> index a0061ef..dce0114 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> @@ -162,6 +162,18 @@
>  	status = "okay";
>  };
>  
> +&lpass_core {
> +	status = "disabled";
> +};
> +
> +&lpass_aon {
> +	status = "disabled";
> +};
> +
> +&lpass_audiocc {
> +	status = "disabled";
> +};

Keep nodes sorted.


Best regards,
Krzysztof

