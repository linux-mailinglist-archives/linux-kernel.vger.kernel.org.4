Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727B76D1CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjCaJp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjCaJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:45:24 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38FE1EFE7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:45:00 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q16so28109884lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680255898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7J3SpzN/MQEAAcFx2JUXnlqdObi7qFjYYyIS8qQbak=;
        b=R9miRmCTRELVUJ07u3L7Ss4UPhjVEfY7zWJGUsyzAM7ilpTZP6hegnJPir7qb0KIWD
         nhlNsbBaeyouRkQ/l3KvPvFPkEv0yDWTZ+zSST1Dx/Y8H90Pg7Ituz32yz1GNILjGVQw
         NhnbFQf//QjAP2r66ORmL7l7LtkEHx1Wutn1+42UNwUazNvP7exGSjU+nFiH/J4RDuk+
         RnNDNNJoxO7ufndlirLzxPATaXaSLaf9XNcQoSutVv9hO0unlWtxysEyxc+9OP/w2qk3
         3CDVOY00/Y5GoytlOTggwOAIwbHDacwxwUqLS6cpYXzDw/E9zKrShzAz7RnIHg/r08Gl
         uaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680255898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7J3SpzN/MQEAAcFx2JUXnlqdObi7qFjYYyIS8qQbak=;
        b=T85TOi+NqoArT1ZNfQzis8gqRIZ5NpWptb/r5oBgNNb1iIkKNHeDlM4M2UuRleFbuD
         xACrI1wjEKuqZ/9FCP3w1mJosdFbkXXa2no+7LNi708Rx54jm+yvR9d3naqmQq4eEiNd
         D0HvuUb7pueheKmyQMxKqk2BpHUcPwfrha0Tc6gbKWC6f1D40oaey7a9J9NId29udYbE
         AQzPEw5+Hw2cOIaddAVQoipLbWb08nwtRFK8IxVuE5SHlSW3hQgbRKJ1HPVdOt7r+Tn8
         HEPJDU8EWVOwI5xaoobK0OtWqUkJjhSCXtqbsIvUjOBV+uAfSV+nWjH+w6/jr8l6st9C
         es2g==
X-Gm-Message-State: AAQBX9f5vQIB2QoR+sAmjRl+JpIhDF104/0UPLaAD6rFoo+cyoGZoq1Y
        rsGqB/6oNiozawGICm2hiiIhdg==
X-Google-Smtp-Source: AKy350ZtYm1U31pvzT1yDnz262K83bU8KgyY1ClWvAm3fGsf1tZXMgIkNsOt4V97cqaQxb//TZ1RAg==
X-Received: by 2002:ac2:4859:0:b0:4e8:487a:7c34 with SMTP id 25-20020ac24859000000b004e8487a7c34mr7984826lfy.12.1680255897838;
        Fri, 31 Mar 2023 02:44:57 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m30-20020a056512015e00b004d023090504sm313085lfo.84.2023.03.31.02.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 02:44:57 -0700 (PDT)
Message-ID: <7d9e1d19-10e0-a627-bf1f-a42e7d936dcf@linaro.org>
Date:   Fri, 31 Mar 2023 11:44:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 1/2] dt-bindings: spi: add loongson spi
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230331032909.7720-1-zhuyinbo@loongson.cn>
 <20230331032909.7720-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230331032909.7720-2-zhuyinbo@loongson.cn>
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

On 31/03/2023 05:29, Yinbo Zhu wrote:
> Add the Loongson platform spi binding with DT schema format using
> json-schema.


> +properties:
> +  compatible:
> +    enum:
> +      - loongson,ls2k-spi
> +      - loongson,ls7a-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/loongson,ls2k-clk.h>

Why do you need the header? Wasn't the entire point to remove it?

> +    spi0: spi@1fff0220{
> +        compatible = "loongson,ls2k-spi";
> +        reg = <0x1fff0220 0x10>;
> +        clocks = <&clk 17>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +    };


Best regards,
Krzysztof

