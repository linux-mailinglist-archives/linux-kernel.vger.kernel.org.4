Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94D267D0CF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjAZQBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjAZQBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:01:52 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7765D12D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:01:51 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id x40so3651155lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5Ms9/N7/h+Q3K/7Kcf2QDN/nKdDnsv1ksmJeqEJ4s8=;
        b=BUsa7nCQKL2wwrfAC+d6ATNxemzFJRPIToCfIKKNH3Aybg3LBuGXZcTveogBaeJwfZ
         v9BWLB1Gc3ulWTpl/CbcHBpBShbk/dBoswFnuh8nWEM861BYi/muql6nwbqp3NUU9BnM
         m99w7WloEb405olLaX4bQVlGkhyU5b62ZBA4LMtHawwWICGnzl2zXA1f21EhYjpYhAr8
         UW29g5fMyhmHY76FpEcUWelG+/f8A7mTPhs7soOwgUJNx2z18wDHGBf7F1vschF6VFnY
         OKITevXq83JgiEseptkms9J23mFehGp9VKNu3GiSeVlzWwWHN6b0jHiYNCqo7IGcCv2N
         s38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5Ms9/N7/h+Q3K/7Kcf2QDN/nKdDnsv1ksmJeqEJ4s8=;
        b=vTq+oZyVFbbdrvhQq7pCnpoo8VCZDm7NTkU1GMfBkpGn43Crxu6FDvr9lmONgClM1E
         GQ5ZuAFrexwVee4UUTutPvblsVNqH38ludJRwvUvBPUs7KJ0zIHXYQsBXLJOF5MNKIWg
         0fo7siSs3apFGgoMm8vedMr2PeqoiI9Lz/6KLsaHATYYadLMFaC9kpdYf7MXG7cy5wue
         tmnki9L3Q85fFn/sMyN27vbHVMdWWZCqalg5VtfkW47rRG3xOa8Rjx+d0auAoP8VbdYI
         BC0NH5DKlC76EX6fjEJhKzeBqnwC/BRrbRhksTH8/9MCES7xjLRyjcLFnTXsUUYDot2Y
         sIrw==
X-Gm-Message-State: AFqh2kpemmnJXN4lVJhKsOnMeySLaFy5+jEizlMT4YLo3nMsaPBQNSxL
        QQVKXeCF1AK4KK6RaTlwiGta0Q==
X-Google-Smtp-Source: AMrXdXvkVKfZdcsjY2sUxC828zVsk7+QQCWicTlakTGR1QBfrqe0HQ31k4Fm+iuXbse2OEbGopoRVA==
X-Received: by 2002:ac2:4f0c:0:b0:4cc:6ffd:9fe6 with SMTP id k12-20020ac24f0c000000b004cc6ffd9fe6mr9574037lfr.50.1674748909319;
        Thu, 26 Jan 2023 08:01:49 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id y8-20020adfdf08000000b002bfb31bda06sm1700126wrl.76.2023.01.26.08.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 08:01:48 -0800 (PST)
Message-ID: <d6af0436-6c73-8fe0-0627-af18120adca8@linaro.org>
Date:   Thu, 26 Jan 2023 16:01:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v2 21/22] ASoC: dt-bindings: Add Q6USB backend
 bindings
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, broonie@kernel.org,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-22-quic_wcheng@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230126031424.14582-22-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 26/01/2023 03:14, Wesley Cheng wrote:
> Add a dt-binding to describe the definition of enabling the Q6 USB backend
> device for audio offloading.  The node carries information, which is passed
> along to the QC USB SND class driver counterpart.  These parameters will be
> utilized during QMI stream enable requests.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>   .../bindings/sound/qcom,q6usb-dais.yaml       | 55 +++++++++++++++++++
>   1 file changed, 55 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml b/Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml
> new file mode 100644
> index 000000000000..e24b4d52fa7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/qcom,q6usb-dais.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm ASoC USB backend DAI
> +
> +maintainers:
> +  - Wesley Cheng <quic_wcheng@quicinc.com>
> +
> +description:
> +  The Q6USB backend is a supported AFE port on the Q6DSP. This backend
> +  driver will communicate the required settings to the QC USB SND class
> +  driver for properly enabling the audio stream.  Parameters defined
> +  under this node will carry settings, which will be passed along during
> +  the QMI stream enable request.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,q6usb-dais
> +
> +  iommus:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 1
> +
> +  qcom,usb-audio-stream-id:
> +    description:
> +      SID for the Q6DSP processor for IOMMU mapping.
> +    $ref: /schemas/types.yaml#/definitions/uint32

We could derive this directly from iommus property as we do it like 
q6asm-dai.c


--srini
> +
> +  qcom,usb-audio-intr-num:
> +    description:
> +      Desired XHCI interrupter number to use.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - '#sound-dai-cells'
> +  - qcom,usb-audio-intr-num
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usbdai: usbd {
> +      compatible = "qcom,q6usb-dais";
> +      #sound-dai-cells = <1>;
> +      iommus = <&apps_smmu 0x180f 0x0>;
> +      qcom,usb-audio-stream-id = <0xf>;
> +      qcom,usb-audio-intr-num = <2>;
> +    };
