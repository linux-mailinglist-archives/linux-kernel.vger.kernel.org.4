Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8616960D4D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiJYTkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJYTk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:40:29 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702A35AC5A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:40:28 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id w10so3244174qvr.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PuJ4rqhBVW/pzXuCIr6qAp0C/9agM39YZk4Tyezi0lg=;
        b=L2kqjdxA4/IcBXtCiww7ZIrzUkvLV+QQMxEBKsv9hiUWXaMwc/uzi0z+O/cOcRG7JV
         /J1c8ZyXAM9gvNhXIYl7273XQr93hmQedx+ZlTHuC1B/oDk0jk4gHMrfs1OIWoZgr5Zp
         qSyueabix5LDL24xa9eZdzp0Ojzj0lJt52J6DQ6PJuLScOOUbDKNzJ1pBeXOJQeLmYU8
         6nF+RcwAUmuHQJ1po29cdqUOmaUBN1Jcnv5rSBY2Wabdac1z5bB4zugv2mNo94obfeAU
         23sIqtykWF1b9ubLcGKJJwi2lMcrN/6AsruNeE2IUUdTRVoVieFZ7ZMKMJT59eqcC0Df
         1lnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PuJ4rqhBVW/pzXuCIr6qAp0C/9agM39YZk4Tyezi0lg=;
        b=c1rHueqedrlKND5fozylv+o3jNSXZkDwZGhIbu8nD6uRx32YFmIy5U0mg1sf8+gKa3
         bhMo1Du8thOwI04wpvNP8DuOV4tpQmoM4oXjRkJpkQ+A66ZM5EJNIC/zkuEFRpqaSrzc
         +TO2zu0HrXkQuAz52beTOk4OLZZ17RjcMvNKWrrKgNSs23w6RPzV5FU3I41eMHrlwuMQ
         4E6FrxQ2GMukTxLGoVp+eRFGW/alMlxbuknFnU+hw3/mwySEwzumXA7aNG+gQxKmLSpT
         ba0ZvVB2qa3hCkF/1TsLnHrhpPSyOg+Npn7a2V0sUL+RS+TOOYbjFrV+I8qFnFC058Db
         wajQ==
X-Gm-Message-State: ACrzQf29XIg2T6TbjL29i/hLN866sRQVHmK1yd+QqCREYltiLzqrarF3
        ETTb72Z7CzsvW5V+7UNa4DBjIQ==
X-Google-Smtp-Source: AMsMyM7+P6vDmIeHHpQ1nGvGx/DyvpypIrLH2RG7R10wpTZc9qLl/phhWX5f1YYNDk+MUG5rmd8g4g==
X-Received: by 2002:ad4:5eca:0:b0:4ba:535a:6d45 with SMTP id jm10-20020ad45eca000000b004ba535a6d45mr21478617qvb.56.1666726827588;
        Tue, 25 Oct 2022 12:40:27 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id l2-20020a05620a28c200b006e8f8ca8287sm2653378qkp.120.2022.10.25.12.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 12:40:26 -0700 (PDT)
Message-ID: <7c67c721-685a-fa0e-ab4b-41b7de3ea0a0@linaro.org>
Date:   Tue, 25 Oct 2022 15:40:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/2] dt-bindings: soc: add loongson2 guts
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hector Martin <marcan@marcan.st>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Sven Peter <sven@svenpeter.dev>, loongarch@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221025035128.21068-1-zhuyinbo@loongson.cn>
 <20221025035128.21068-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221025035128.21068-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 23:51, Yinbo Zhu wrote:
> Add the loongson2 soc guts driver binding with DT schema format
> using json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../soc/loongson/loongson,ls2k-guts.yaml      | 37 +++++++++++++++++++

Looks like wrong location, although difficult to judge because you did
not describe the hardware at all. If this is chipinfo-like device, then
Documentation/devicetree/bindings/hwinfo/.


>  MAINTAINERS                                   |  1 +
>  2 files changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml
> new file mode 100644
> index 000000000000..2502f8aeb74d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-guts.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/loongson/loongson,ls2k-guts.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson2 GUTS driver.

Drop "driver." unless you refer to some hardware (like motor driver?).

> +
> +maintainers:
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +description: |
> +  GUTS driver was to manage and access global utilities block. Initially

Drop "driver" and describe instead what is GUTS, including its acronym,

> +  only reading SVR and registering soc device are supported.

Entire sentence describe Linux driver - drop it. Instead describe the
device, the hardware.

> +
> +properties:
> +  compatible:
> +    const: loongson,ls2k-guts
> +
> +  reg:
> +    maxItems: 1
> +
> +  little-endian: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    guts: guts@1fe00000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


Best regards,
Krzysztof

