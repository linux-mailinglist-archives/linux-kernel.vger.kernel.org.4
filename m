Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97046D36CA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDBJ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjDBJ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:58:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CEC5B84
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 02:58:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id er13so65346423edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 02:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680429517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkmwX+s78lg6bo26NOgVKCiXJuV292J/9j0MsWg/NjI=;
        b=Xq7VeP7EawkPfRn13Vu4OKwYHMMpPlC32bXNrfjrPFzriBbLHTE7CDSSKVIwcP6Amp
         H/DeMJn4HvSksP6CZPLahNmPhkiKP46XCBROcPk/LnIfjNCvDaH6n6V93AkiteV/gQes
         ObdaKAVSj9A+ciq0b5C6N0/sA2b1myIAPaAwE6dSC3eON3mGK9suERhCZRHdNyUlGc0p
         IzJPmqiAfLQYMDY6cOxC4gnsJVrYk4255Z020cyDTK//Jn9MGvn8Z+zFBdeSmi9kG/6r
         l2ul0y3lj99QyFd2wXfUWhfhYNVSzG1GqLZd4bXoGgSG8cAB9gS5WI+PTnRXecmhNQjM
         fFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680429517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkmwX+s78lg6bo26NOgVKCiXJuV292J/9j0MsWg/NjI=;
        b=Tyoi3Fv7jSJndKSIIpqCvKkIz/8ewqENIuSyg4qhiXvpTl5ETTdnDqcmxkW42Whw2L
         e8hAk6In1a3/ILQtKrjJehUgQTvAcEh7xurNgloUklofo7FfQFDFXGOlIb2AQa8UmPzT
         mtd3K1Am+QHGHjl/EBiBW0EmYcwCKWkISCqkhnbIAbplo+dX8z4CuVH4rzKgpVTHv4Bv
         kyd8uJv/gRlq9S9UEdJ6cL0wxOhHSJElC9FXH+0zwJa+27sXdaHd7qDX8sTOvjJViQL/
         RtxO6U4ucIC+0ywti1wCBoYIEEga/4vBdBDGS74nhq+AoyQ0ZBtXuf+/B724s2HCoA7v
         hyWw==
X-Gm-Message-State: AAQBX9dgM1m96dOQ3vgpq33as3opOYOe7qyiTgRAbTe4LGR600DJBKMY
        gxolW+B+0/mTAAwi9wzO7DfCrudwAFdoouLrgJc=
X-Google-Smtp-Source: AKy350aF4niBs3Rwa4U5LDWCVMrb5c3v0bW6W6qU1x6Oic5ekNrAlkVcWuWnypJaWrIOuFZ2PQWuPw==
X-Received: by 2002:a17:907:8c83:b0:8b1:7ae9:647 with SMTP id td3-20020a1709078c8300b008b17ae90647mr33178204ejc.76.1680429516842;
        Sun, 02 Apr 2023 02:58:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7f7f:6a30:7a20:94d5? ([2a02:810d:15c0:828:7f7f:6a30:7a20:94d5])
        by smtp.gmail.com with ESMTPSA id kt5-20020a170906aac500b0093a768b3dddsm3050356ejb.216.2023.04.02.02.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 02:58:36 -0700 (PDT)
Message-ID: <c0199067-4dab-651b-bf88-8cc5c035f79e@linaro.org>
Date:   Sun, 2 Apr 2023 11:58:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 1/2] dt-bindings: spi: add loongson spi
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230401095652.17364-1-zhuyinbo@loongson.cn>
 <20230401095652.17364-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230401095652.17364-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2023 11:56, Yinbo Zhu wrote:
> Add the Loongson platform spi binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../bindings/spi/loongson,ls-spi.yaml         | 42 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml b/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
> new file mode 100644
> index 000000000000..ef113296529b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/loongson,ls-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson SPI controller
> +
> +maintainers:
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - loongson,ls2k-spi
> +      - loongson,ls7a-spi

You don't use this compatible?


Best regards,
Krzysztof

