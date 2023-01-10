Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C9A663CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbjAJJd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbjAJJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:33:25 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F038AF9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:33:23 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso11300937wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jfj9Vw3D8ZX4MdEbwgBQxtSlmIa3nYu0UGzCjpPfxE=;
        b=oYX4A1yjy32A+H/doqG67qiVsZlLEdPONvs+SBSRCVWx5cSUjtFK/8rgmiuyjae6sk
         nJuhXagDzHtelrZ9iB3JBVg6iTD0m+9b+ll+jCBacuXBr/BBmXGUshCa0kagL6bmpGbF
         /vIWgucZBBok+dDcQNcb7acBY7S85Lp9BTgocflK/vSYRP/BT2iPqwHQiRYj6ozE41f3
         99sOlBngfXghj9WfccyNzOl10FqhQbDYTDpxeCXIEWFL6yAdlQx2xUK+QfHzz+kGwi45
         0ty3TCrXAToPvkEz7V+dOdDROJ0luLB8HFwP6Ob81Mvz3ePR63nCaYlIwdc2bwhFDh0G
         2Wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jfj9Vw3D8ZX4MdEbwgBQxtSlmIa3nYu0UGzCjpPfxE=;
        b=EZJgjO6m68yWOvN2fN12V+ovye0KhDzIeI+EA0CF12VmDAIPKvaJ3btCjFGeFk5n3V
         TleYAz4XcTh91DrvlLg7pye2i0VtuQOyAe3gie8oYqzEJe4yvaJRowq1s7v0JFhsn9mn
         KPQHw9q2/sBHTTG8qm29sOQ6vsHVyGe0Bk3Omo4EPHJiaQY9SYn5PVAiMmMqFQtnhwhc
         viU333GsOzOOzqyTZKu5uyNjAhMZ5SaPxvDGnUjpvNEcD77l6D6yKZkMwoNLI6tbdPFv
         MPpbvHunbLEl/QevmL+E31UTz7xjQ8VkLBCe+3TsgmCUh9FZU0OunxCcEybtKrQHBXZF
         Nxuw==
X-Gm-Message-State: AFqh2kpyPFVtDwlzKe+7BabhhkUACi+2Py/jlWpQWJr3wLuu78YZLSGX
        t8o7/f0NxwQBWDSriA2DDMxoaA==
X-Google-Smtp-Source: AMrXdXsrih7nnKIOBXnnr50hxUBa1SIexlUteXct6oa/s4ma2nSLWJeKhPczJLVjIZL0WjLZRjh+yw==
X-Received: by 2002:a05:600c:3b1c:b0:3d9:f0da:542c with SMTP id m28-20020a05600c3b1c00b003d9f0da542cmr4660166wms.28.1673343201715;
        Tue, 10 Jan 2023 01:33:21 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j30-20020a05600c1c1e00b003cfa80443a0sm16052527wms.35.2023.01.10.01.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 01:33:21 -0800 (PST)
Message-ID: <a6dc4cd9-7008-7de3-f27d-7b82e5f51fbb@linaro.org>
Date:   Tue, 10 Jan 2023 10:33:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2 01/11] dt-bindings: remoteproc: qcom,q6v5: Move MSM8996
 to schema
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org, robin.murphy@arm.com
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, amit.pundir@linaro.org,
        regressions@leemhuis.info, sumit.semwal@linaro.org,
        will@kernel.org, catalin.marinas@arm.com
References: <20230109034843.23759-1-quic_sibis@quicinc.com>
 <20230109034843.23759-2-quic_sibis@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230109034843.23759-2-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 04:48, Sibi Sankar wrote:
> Convert MSM8996 and similar (MSM8998/SDM845) MSS PIL bindings to schema.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  .../remoteproc/qcom,msm8996-mss-pil.yaml      | 370 ++++++++++++++++++
>  .../bindings/remoteproc/qcom,q6v5.txt         | 137 +------
>  2 files changed, 375 insertions(+), 132 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
> new file mode 100644
> index 000000000000..d3d3fb2fe91d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
> @@ -0,0 +1,370 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,msm8996-mss-pil.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm MSM8996 MSS Peripheral Image Loader (and similar)
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Sibi Sankar <quic_sibis@quicinc.com>
> +
> +description:
> +  This document describes the hardware for a component that loads and boots firmware
> +  on the Qualcomm Technology Inc. MSM8996 Modem Hexagon Core (and similar).

MSS Peripheral Image Loader loads and boots firmware
on the Qualcomm Technology Inc. MSM8996 Modem Hexagon Core (and similar).

> +
> +properties:
> +  compatible:
> +    oneOf:

It's not oneOf. Just enum.


> +      - enum:
> +          - qcom,msm8996-mss-pil
> +          - qcom,msm8998-mss-pil
> +          - qcom,sdm845-mss-pil
> +

With both above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

