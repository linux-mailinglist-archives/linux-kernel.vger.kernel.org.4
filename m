Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66B4745EA3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjGCOjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGCOjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:39:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4755E73
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:39:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9922d6f003cso562666666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688395150; x=1690987150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ewfgpd/7GQjgbZQV9CDcnJPf5yWlKoXpABMnM/ALxVs=;
        b=t2LiKP9IdlpLX0G4leahldrhzy1nhIAc/pfiNb4QrN7xEz+oee+rIdBw/NxKLs3lwl
         bENBVPU5QnvNnyqRN5tcPj/6Zj+KKeWe8keo7z/S9nnJb604w6qEzN9IFAqnTxq0X9RT
         G2D/V2FB42/Eww+grdX6PjyudWUqFSbKUDVGwzpjLj4TrZ7Uxocz+NAkVSYQiZoth6AK
         1FPanXMhOF7icclzKNTb3LX3UHijwXvQ98rD4T0mK+to9WFqtVE+67jbxV6lSX0XdDKq
         G1UVLCkPUoA0W/Luf0yz6XSHYPkXhSW9gYNQjvu0Z/t+W0epJki9gI0+RjhqE99yKqSv
         Yhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688395150; x=1690987150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewfgpd/7GQjgbZQV9CDcnJPf5yWlKoXpABMnM/ALxVs=;
        b=FBxs+rCOb2pAHrzVpBEIZvjOHuEx8RdN8xH4dHj+Kp25bEgAKyVGq9sSY0JSFWOwx/
         eor8J/DFESeJLK28dQ2NeX46b/5AKUrKxo6ZtD3TM6ubQZ8pI6rq/JJOYaNBosgWn8Uy
         0ujwueCk8+6qoFaN99RZB5gcA/UDnWFPzrsVE8VUQ895E5oOI9bgg6yWf65HfTQOWJDc
         oxt9bsEPUwjiFmfzu+vEMtJ5HpALvQUv9rHYgX6Albni4w/ZZoLoFdCAg6wHeUZ79NX5
         U+DjHgfuAwCnJ/n9+QQTs2b7hZR668hrVa/2PI/dluGz2OGLQAAx8ckSXstUq+Mvw6fb
         umng==
X-Gm-Message-State: ABy/qLbkJC0XAUEoluP55/sb6OyDrrECtOyoXEh1r17FaE73/aDX6oOZ
        /UDhK9vcxRZ3sqqnukB/XP2ERw==
X-Google-Smtp-Source: ACHHUZ6OndtUxsKIxmSzOhgj+D7H/wO4w/Q0xlKcwOmnYyGvuvBhFFsJ8gkPcVl9r7fMzx7Fb3uZyQ==
X-Received: by 2002:a17:906:af15:b0:987:9823:b9f with SMTP id lx21-20020a170906af1500b0098798230b9fmr7964082ejb.28.1688395150275;
        Mon, 03 Jul 2023 07:39:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z9-20020a17090655c900b00992d0de8762sm5074198ejp.216.2023.07.03.07.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 07:39:09 -0700 (PDT)
Message-ID: <948211aa-2315-5ed6-4c04-f1a795045997@linaro.org>
Date:   Mon, 3 Jul 2023 16:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/3] dt-bindings: hwmon: add sht3x devicetree binding
Content-Language: en-US
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>, jdelvare@suse.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230703140818.427403-1-JuenKit_Yip@hotmail.com>
 <DB4PR10MB6261295D96DCE88F712910B99229A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DB4PR10MB6261295D96DCE88F712910B99229A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 16:08, JuenKit Yip wrote:
> add sht3x devicetree binding files
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
> ---
> v3:
>   - fix wildcards problem
>   - add vdd-supply property

No improvements in subject.
> 
>  .../bindings/hwmon/sensirion,sht3x.yaml       | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,sht3x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,sht3x.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,sht3x.yaml
> new file mode 100644
> index 000000000000..bef2eb492a47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/sensirion,sht3x.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/sensirion,sht3x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SHT3x-DIS humidity and temperature sensor
> +
> +maintainers:
> +  - JuenKit Yip <JuenKit_Yip@hotmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,sht30
> +      - sensirion,sht31
> +      - sensirion,sht35
> +      - sensirion,sts30
> +      - sensirion,sts31
> +      - sensirion,sts35

Your driver change suggests these are compatible, so make them such with
oneOf and a list.

> +
> +  reg:
> +    maxItems: 1
> +  
> +  vdd-supply:
> +    description: regulator that drives the VDD pin

Missing reset-gpios. It's the second ignored comment.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.


Best regards,
Krzysztof

