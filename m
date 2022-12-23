Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9FE654E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbiLWJN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiLWJN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:13:26 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5263720378
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:13:25 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f34so6329874lfv.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nHN7DDcS7nZ1cFrOceolRofMEbbkNs2dqEr6ujP/YdU=;
        b=W07pqGy4CreoMdurzJl/VbTvWUqiTZS2TL+sok2QHSpiFjHvR8DeY9PZSjirwrvOqi
         4lsBU7tfqjuGwviFbN7C7vTjJ5BNt5I1ILluyS83w0Ju+xp6wLEWuAm12JPXhdX184f/
         NibP0BYQsGfefLFkT05ZwXzPNd8BlADCsR56u4l2ADfwENOk+z0F5izlf9r+yW37N243
         23WVSOKUCw6WY2+fDHt1fJfwlSOrxHee+f0v/cZAS7nNOA3viGZWu6RBdYnSwn2RwyNj
         PsduTzTx8ol+rlEHVHR9QBjmgP3DxshH9n5Szm8k8xvOfp77FuSlLaBZrPUxfRlUNYMg
         xogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHN7DDcS7nZ1cFrOceolRofMEbbkNs2dqEr6ujP/YdU=;
        b=mXBEAEi4l0QbML9GntFEuV3nTrLTsRcW3pYP6Fx22EARI+TKn1koPMj9Col7HSg36g
         ldAC3R13sJiEkR9nkdUGzgwmrFAvcdlcmBof12DMZxJ5tqDOEJ14xsZHMudnuJr+GtjF
         mNZa0559Xq2DgDPkuDREJs9YNBDdVNicWiD6LDlWHUopF64A/Tg2m8Z5n8NC4TB+OUCx
         +WyCkFpQhLpli5gkhEJ5+n41t3YfHbENC+yY2mMn1hQmymxL6wTaqepRBJR7LNOceOLl
         LX0zTkzGDC6xGPvdZ9TbMpbl5fdQvOPKupZ7k6rjiUFLtHUK/K+qcHCcwRUX0mvi1txV
         p5DQ==
X-Gm-Message-State: AFqh2kro+C8TN1ZhN1yh4/IWQ1lV7h6UOXRhnYesQH8nVUTUv38F6DjW
        RYEzIWu56R8novpMHtcTdTsafQ==
X-Google-Smtp-Source: AMrXdXt569rGwmxRny6+JZiocZXjZ2lfSlwIU6OXtuVNu8eReVWLbk2yZ7BUQx1eK7OgLjH4QcOsww==
X-Received: by 2002:a05:6512:1111:b0:4b5:43ef:a552 with SMTP id l17-20020a056512111100b004b543efa552mr2723310lfg.16.1671786803264;
        Fri, 23 Dec 2022 01:13:23 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bq27-20020a056512151b00b004b591c33b99sm449075lfb.13.2022.12.23.01.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 01:13:22 -0800 (PST)
Message-ID: <09fd48bd-7f92-b0e0-cb2a-ab2fb6ece868@linaro.org>
Date:   Fri, 23 Dec 2022 10:13:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/7] arm64: dts: qcom: sc7280: audioreach: Update lpasscc
 reg property
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        konrad.dybcio@linaro.org
References: <1671702170-24781-1-git-send-email-quic_srivasam@quicinc.com>
 <1671702170-24781-5-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1671702170-24781-5-git-send-email-quic_srivasam@quicinc.com>
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

On 22/12/2022 10:42, Srinivasa Rao Mandadapu wrote:
> Update lpasscc register mapping for avoiding memory regions conflict with
> ADSP pil node.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> index 0ce8755..a750f05 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> @@ -111,6 +111,14 @@
>  	};
>  };
>  
> +&lpasscc {
> +	reg = <0 0x03c04000 0 0x4>,
> +		<0 0x032a9000 0 0x1000>;

Misaligned.

> +	reg-names = "top_cc", "reset-cgcr";

I have doubts this was tested... git grep shows 0 answers.

> +	#reset-cells = <1>;

Why all these are not part of SoC DTSI?

> +	status = "okay";

Why?

> +};
> +
>  &soc {
>  	qcom,lpass@3000000 {
>  		compatible = "qcom,sc7280-adsp-pil";

Best regards,
Krzysztof

