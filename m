Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0745274E9C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjGKJDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjGKJDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:03:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE4110C3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:03:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e4c868ee4so3961241a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689066222; x=1691658222;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Lw6Fio6MM8aQyHHH2Gtx5wACdysDo6ZPeKbdUxENhw=;
        b=msiU/+xMcahUqIkdiyY5SaV0lh5WjlO2rQuLmPZ0badsW7i6rQ5pmTNlIcSdSDBaRG
         hIugN9XVpR7Rr4jpls+Zi/5PkCozRv2TdIgnr1TEYWsYwPPxWdd5dzV1XhALVT/B7Q0B
         OJNolJmF2/wfYbO0JDkyGwYOdP2RfQXyM7zbfDyNQsoObj4DT3jTXHsGRGZyquwnTFZl
         TzWz5LFI6AFePlNH5xSuYsqZfHNtRJvJ2xqdDG3lhEe3mf3qBn9+PYWvrfKxSStXM43Z
         eOA7Km+2/cV4INV3wzQPEMEUlwPOxw2AKAQR4LFh/nZF/51cI52tDXM5Zd3udfgw9/oF
         v3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066222; x=1691658222;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Lw6Fio6MM8aQyHHH2Gtx5wACdysDo6ZPeKbdUxENhw=;
        b=YNATsRUFEiNFBwRe4jSGW2Q/MmXYDnqYfs7FWgm0hH+OrG5aJ7X/c8kGo3Ts6zrHZo
         qCgnEoiWj+Gms5H8z1LZRGz0aM8H/7MxBV1nKNhmPoTbPqxqBhYRgP+5beWQfeeOiX+b
         dY8spEg2rl+kRrGTgExaFlzdU93s8ibCc0oIHAou4+/rz4K/evUUbappd2v+aD5IkXAw
         eVc1VIcpoFSnGfyey26JTIe3lOlg3phBvlGhY5f2GLdXuM/jJ8YTfjXu6KfFMDyxFbIn
         J3M1CGhIBZxVE652ZNhpAXl4+vRY++5xLu9nBdpyQKnj30SKEOeMynavog256zSbB1/h
         NVcg==
X-Gm-Message-State: ABy/qLZnwXZTwCLwYM3kaeYmSk3p6IroJsVk1spzaoziiaYG9Atfxn/f
        4wSFWAN7U5f5EfTM48FuNntODw==
X-Google-Smtp-Source: APBJJlGQrnIKzKa1cvH6yRytquR4/mHpXJkdOXwxN9nXW/rPbh62x2Xb+7Gbq7H7q618igwYKqIGew==
X-Received: by 2002:aa7:ccd1:0:b0:51e:12b:b989 with SMTP id y17-20020aa7ccd1000000b0051e012bb989mr13728889edt.20.1689066221712;
        Tue, 11 Jul 2023 02:03:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id y19-20020aa7ccd3000000b0051dd4daf13fsm946680edt.30.2023.07.11.02.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 02:03:41 -0700 (PDT)
Message-ID: <8e5a51cb-c726-1027-1f4c-7870b10bc706@linaro.org>
Date:   Tue, 11 Jul 2023 11:03:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/6] dt-bindings: phy: qcom,m31: Document qcom,m31 USB
 phy
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_varada@quicinc.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1689065318.git.quic_varada@quicinc.com>
 <77fe66271044a18871e1dfb80bbb481617197d18.1689065318.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <77fe66271044a18871e1dfb80bbb481617197d18.1689065318.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 10:51, Varadarajan Narayanan wrote:
> Document the M31 USB2 phy present in IPQ5332.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v3:
> 	Incorporate review comments. Will bring in ipq5018 compatible
> 	string while posting ipq5018 usb patchset.
> 
> v1:
> 	Rename qcom,m31.yaml -> qcom,ipq5332-usb-hsphy.yaml
> 	Drop default binding "m31,usb-hsphy"
> 	Add clock
> 	Remove 'oneOf' from compatible
> 	Remove 'qscratch' region from register space as it is not needed
> 	Remove reset-names
> 	Fix the example definition
> ---
>  .../bindings/phy/qcom,ipq5332-usb-hsphy.yaml       | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
> new file mode 100644
> index 0000000..2cfdd73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/qcom,ipq5332-usb-hsphy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: M31 (https://www.m31tech.com) USB PHY

The URL should rather go to description, not the title. Title is like
document title.

> +
> +maintainers:
> +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
> +  - Varadarajan Narayanan <quic_varada@quicinc.org>
> +
> +description:
> +  USB M31 PHY found in Qualcomm IPQ5018, IPQ5332 SoCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq5332-usb-hsphy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    maxItems: 1

Drop

> +    contains:

Drop

> +      items:
> +        - const: cfg_ahb
> +
> +  resets:
> +    maxItems: 1
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> +    usbphy0: ipq5332-hsphy@7b000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Best regards,
Krzysztof

