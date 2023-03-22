Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175666C5917
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCVVyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjCVVx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:53:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5E234325
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:53:54 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y4so78881406edo.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679522032;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xehrL2dgpZYyP/0AM2a+lXnXwn5PW3e0iW5W0VmPTqg=;
        b=KI4TzoNHQxflEoUcBryC3LXEvMO9lxh2bsIloTZApwsunrsKsg/6DG3LYjPR5oFezI
         5d8J3vnMlni6v+vzv9ACcW66GzUBcBw/K8sL01C5mAu3Sl/R6PDlECvjEAcR6l0oG9iI
         3TAXYG4RGicppbFPS+KwYwga/aDWrOF6JisGaWjN6DkxOPEEmb2096NhC7ZlQdeu+XwH
         6GILqbGa4V8HaiubNnE+t5cWZAP5TQQmCIdNdah2XT1/mPkplH0H6XKVLHOZGz+PbalS
         SsQ02tae7TxAYj7DnzjObjMbDHUrMrzXtAmVblIqV5PpLUD86/Lz0S1/Oh+XmlAy3xkS
         1j1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679522032;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xehrL2dgpZYyP/0AM2a+lXnXwn5PW3e0iW5W0VmPTqg=;
        b=LZEEWM1xtZh1q0ImOReU//NOL3/tUgP25rzERNONN1LOrN4dpncGO9v1Q8XMllDuPW
         GZ0fMY5DJT7Qby9gT5sSzLQsTgr2B4spRmvvm2Dmn6uncEk1JgQOVjhj72piVv6QMX5T
         OTZRwtu43Gn1hYuaL/J1Xr4yYhPYKoh8hDTtJzM7D1oUVyzgyla/7WLvKfM433+vG0Bk
         aOEDrcU3WfP+NDQGvTnNx+4PPqTxBnuqLcoW20wU9OrC3UWd2qGdt4u2xX+nZgxFbeoQ
         jzksnhVEQj45jFHOTkwbENCRU1Z/+0v/ZF1/5H3rXTTB7uV95mqIqWMA++3SomuO9iVH
         LtAw==
X-Gm-Message-State: AO0yUKUS+cVNNHYlEqFIs0vrlJWNCH/s7cL+Vv1d2VDlbuBxsOJJFqwZ
        vldPCDzx77XV6DPNtbl5gZjxmQ==
X-Google-Smtp-Source: AK7set+sdpyhZHcj4stGuQd5RDDcBiVcAch7q43+icvAAhA35KsTbJdpiWJDVoDcAHwDrvEpoPevgA==
X-Received: by 2002:a17:906:46d7:b0:930:7164:e8e5 with SMTP id k23-20020a17090646d700b009307164e8e5mr7122905ejs.38.1679522032625;
        Wed, 22 Mar 2023 14:53:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:626d:5729:6e71:4c22? ([2a02:810d:15c0:828:626d:5729:6e71:4c22])
        by smtp.gmail.com with ESMTPSA id lk8-20020a170906cb0800b009311c9d33d7sm7656336ejb.184.2023.03.22.14.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 14:53:52 -0700 (PDT)
Message-ID: <4e1cc130-8bfb-96d1-1f93-f1389544b8e3@linaro.org>
Date:   Wed, 22 Mar 2023 22:53:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 3/8] dt-bindings: usb: dwc3: Add IPQ9574 compatible
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1679479634.git.quic_varada@quicinc.com>
 <2ef0959be2aba24b3e3017cd09af7cc63aea74ba.1679479634.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2ef0959be2aba24b3e3017cd09af7cc63aea74ba.1679479634.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 11:44, Varadarajan Narayanan wrote:
> Document the IPQ9574 dwc3 compatible.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index a2aabda..3ae56d3 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -17,6 +17,7 @@ properties:
>            - qcom,ipq6018-dwc3
>            - qcom,ipq8064-dwc3
>            - qcom,ipq8074-dwc3
> +          - qcom,ipq9574-dwc3
>            - qcom,msm8953-dwc3
>            - qcom,msm8994-dwc3

No updates for clocks? Then disallow them for your variant.

Best regards,
Krzysztof

