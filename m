Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D336A67E17E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjA0KWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjA0KWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:22:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC8D46AF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:22:05 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso255276wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sBBZE6fsZhsI0wcUQwggfPGavBu00/fVBlJ5MgC/dQk=;
        b=tFIXfRa5b53+eFriCRzBeWfVB9BHcFBu7jTzd2EONUyeLwXhnHuBDDhWkF8I5rmAI1
         aa/rUfa5Zd+qOKNrb77ggyhKzNskVhGvqfq8iU1CWV0mo4m5DFhBMOZuAfnl0a2JwT8d
         7GwZZCtwJaW5SAjzXxsFHMvbg1goTCZMov0TsJO+Cfbe7EKorI99DN3b93Ufe6T+P3YS
         gUMCrbz2NpqtXmAsSK1Zxks3NF1KxiZiU5THm/EPRrX1yQSxxIKQyAZdAYSYOqkb0z7W
         SqLPdRu8knLlX/hchXiyAjv+D+dKrFF4UBMdA6OdhJWqC1aRaJJlp1Qb7qF1kmZmCevh
         80Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBBZE6fsZhsI0wcUQwggfPGavBu00/fVBlJ5MgC/dQk=;
        b=seNwRquXS6G4ltL48wHLeGHZUgxxA7hVEaPUjaQ8urbDeAyI15rnlN76Ar1tTQbqoX
         PIJfWbJ9IrJeJMYOxRTkxGRJMa6qiy2ehj2+P6HSFyHaRLwI6Yu7zOEZT16GdEBwwRZK
         bmR9/Zp+hAIdAdnG5+kJtR2ws+efiJXwYd4c766i04wZld2OzBC4VMAXNbuagGybX+CR
         OMA33r0xQHukoh5AYCTKdMeFkGbzjTKoOHK3hefNf17mAPnM5GqZphsDv+i8KuhJcd7v
         H2Qi3jZRc3tEgyxBK3BUvx+jJbLptLAVEYL7y6Y5EaWP4bAdnLpEuGFlL4gNZFe6aubJ
         I6Iw==
X-Gm-Message-State: AFqh2kqgB7ELyPGadgSu8mHLP+XOdmKAxzNAoAu9KFHmVchJIRil8PaG
        LoaefE6reFwKsrQGt5eS305ahw==
X-Google-Smtp-Source: AMrXdXvlCtdKUrzEnKQayhEFNIdQjKPSOmDLYO1GL+EqJanXTFsG+fSLTOYkwwvPaOsg/jftSj4TKA==
X-Received: by 2002:a7b:cd11:0:b0:3d9:6c7d:c9ee with SMTP id f17-20020a7bcd11000000b003d96c7dc9eemr46774652wmj.25.1674814924298;
        Fri, 27 Jan 2023 02:22:04 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bh6-20020a05600c3d0600b003daffc2ecdesm7245750wmb.13.2023.01.27.02.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 02:22:03 -0800 (PST)
Message-ID: <bce2138e-7323-a85a-9f84-5af697926013@linaro.org>
Date:   Fri, 27 Jan 2023 11:22:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/6] dt-bindings: clock: Add Qcom SM6375 GPUCC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230126181335.12970-1-konrad.dybcio@linaro.org>
 <20230126181335.12970-4-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126181335.12970-4-konrad.dybcio@linaro.org>
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

On 26/01/2023 19:13, Konrad Dybcio wrote:
> Add device tree bindings for graphics clock controller for Qualcomm
> Technology Inc's SM6375 SoCs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 -> v2:
> 
> No changes
> 
>  .../bindings/clock/qcom,sm6375-gpucc.yaml     | 60 +++++++++++++++++++
>  include/dt-bindings/clock/qcom,sm6375-gpucc.h | 36 +++++++++++
>  2 files changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm6375-gpucc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml
> new file mode 100644
> index 000000000000..b480ead5bd69
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm6375-gpucc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

