Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8094467CA75
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbjAZMEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbjAZMED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:04:03 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B1AF9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:04:01 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so3128686wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVvADtVeyYptFWF0MydblAJtxtKctGx6MpVLSGR2LlE=;
        b=L84Uy1hwTkVHRhQ3dVQI6CQdYNLEwmKIHOfwhOdxyvMcy4OUH4bylSASxR/tqpX8p5
         NLXY5VCrscWlUqc1bLDhnR/DbAFgomJ3iU+D9Kcwtr4UZLZve+oAzu8OFTcU66e31+hL
         fATs8XFrDz5IRN/5eL6slYS4c7Iehsnko3Kz6f7w71LzCtrtJfKf8DTk/Xc/5Y7FuK/F
         CmMxZ/cddW8JIVKNfk3da+Yzo29zfJvoT0qNZqLRxDCMxEK0i7EBXbkirjP+n8OnKdcI
         PH/6dQOIT53Kr0zJKrRl/RwhZxLkAinC3dOqOwqBqZXiD+FOiVGMtL+y6kR3yUNKjBdn
         a5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVvADtVeyYptFWF0MydblAJtxtKctGx6MpVLSGR2LlE=;
        b=CGDgfBgpaekbfA0+EKsovZzhpinNgv/8S5W5T82gM1vbqpNqjHXsttZoxjdHLHKIM5
         PlA7LMi/Rc7fPq4ltHqkAyp5QSY8WrSftDqhlXEQCmjHu/l25FAxLWOrqZnc6Ax4u1UR
         4eClTDLgr2Ga88UNmQJVnVpqzdqB1Cd85jCBc7uk7k5XSPK0gAX5mFhs/pB+mhJtUU//
         CdYrUn9cYW/SImZ2t4VOAME2N9aAgfj15F2DRmg0VJsso3GNn1lh5RcYg4OlDN287xnI
         FY4MyVg6dEiXJ9pkv5mk1b00LJbEqAARnhYm3G32yoQ4pND7Ap87SFUwb7tjDBgaMg+D
         4rwA==
X-Gm-Message-State: AFqh2kpyEGjBuwvn2mi/TLpuPzOllwZv699FlZMreUFDxATHjItZLqaA
        AtBCqLrvTn25tUJnCcuX/VPGAw==
X-Google-Smtp-Source: AMrXdXvswf6o+FLrL8oSK0T/z89VYOCOqxTXsD7xa1Luv/CMKcJo5ayhihdj+Fv0ZyQgV3x979I4ww==
X-Received: by 2002:a05:600c:214f:b0:3cf:7197:e67c with SMTP id v15-20020a05600c214f00b003cf7197e67cmr35714366wml.25.1674734640378;
        Thu, 26 Jan 2023 04:04:00 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l38-20020a05600c08a600b003d358beab9dsm1200363wmp.47.2023.01.26.04.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 04:03:59 -0800 (PST)
Message-ID: <3d076b05-6953-abe4-44de-3badacd55887@linaro.org>
Date:   Thu, 26 Jan 2023 13:03:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFC PATCH v2 21/22] ASoC: dt-bindings: Add Q6USB backend
 bindings
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126031424.14582-22-quic_wcheng@quicinc.com>
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

On 26/01/2023 04:14, Wesley Cheng wrote:
> Add a dt-binding to describe the definition of enabling the Q6 USB backend
> device for audio offloading.  The node carries information, which is passed
> along to the QC USB SND class driver counterpart.  These parameters will be
> utilized during QMI stream enable requests.

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  .../bindings/sound/qcom,q6usb-dais.yaml       | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml
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
> +
> +  qcom,usb-audio-intr-num:
> +    description:
> +      Desired XHCI interrupter number to use.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - '#sound-dai-cells'

Use consistent quotes - either " or '

> +  - qcom,usb-audio-intr-num
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usbdai: usbd {

Generic node name, so: dais

Drop also label, not needed/used in example.

> +      compatible = "qcom,q6usb-dais";
> +      #sound-dai-cells = <1>;
> +      iommus = <&apps_smmu 0x180f 0x0>;
> +      qcom,usb-audio-stream-id = <0xf>;
> +      qcom,usb-audio-intr-num = <2>;
> +    };

Best regards,
Krzysztof

