Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CD36DD23A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjDKF4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjDKFzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:55:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA28170A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 22:55:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50489c6171dso1911968a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 22:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681192541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fIcu/5Vwec/5pmDwua6bnzxrZjxm6tYfo6xjgw1aQHk=;
        b=E5jbpYtMChv4wnKHQBV1sgtQMtfvAnAqYOFbf9v9NvIbVBCisFzEDLeNgxGzA8mzxG
         F4twwOCb2CowY08cCpc2qlbLWk5IKswvsGSNgpqIlLX4aigXpY/ts/WdeJMIWAvDGyF6
         NjXYCE0mxT7hYj/JxNOws/gVsFEIJbaBLSAHwT26Wh2kqDBZjQraT+yUbe1vEy8wL3mE
         QTxL962tJTvy7qb1N9rA1bcSIbHCj9QqxQM4PceCi5MnPoLvXV1laXnXCXCz236FG9ce
         cshMNCHLqsUuFgtID4orwDUdbec0V/DMvaHxZj1oZfA5UuBdaqzXcoL/BG2UumQ8s/8G
         5Jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681192541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fIcu/5Vwec/5pmDwua6bnzxrZjxm6tYfo6xjgw1aQHk=;
        b=5AhcOnM67ffZbGkSg3YuEgHqSkk8oe51paGmqNvS4GDsqTowGMDdLADlFE5i6P3fSg
         pGkisvCtSuXkMxHLg4w8Ng1vNwyjm2geEjEbuv7vFmkFCwLoiE2N2o/4hQUs+slpadbC
         P6Hcji8qa3z2XF9DlFcBaXElZf+7//WfuGCN5urEiqsEhB1ty43HRdU3Pp3/xHjE3ohQ
         0G21cIroXtGI8NxYMYiECLVe7hgo6ftMhdLuoRGoyn0681nowxZPhO+xVomjM3A4L3Gt
         dFIC2lamlY+ktC4dVMWh27G8DmAmaCTcTTlR9Nj4wzM+/5Qnr8xoPZd8b3iu/gePuMaV
         JtuQ==
X-Gm-Message-State: AAQBX9fJrinUr1k+CjM8dQKn6yqw0WPwZZzXfnLgJGqF/ZUVx1T9qxT9
        uFkq3/z4FY+93XQBJ0GXOhbBMg==
X-Google-Smtp-Source: AKy350bGvkN4SiYmY0SbOi6V11nu//NdPAdQmWpaiIwCulyUglnQHN+JIG8OT1crzFfyzP8mLu8xHA==
X-Received: by 2002:aa7:cd69:0:b0:504:a317:b9de with SMTP id ca9-20020aa7cd69000000b00504a317b9demr1369584edb.28.1681192540770;
        Mon, 10 Apr 2023 22:55:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:dad2:72b7:3626:af61? ([2a02:810d:15c0:828:dad2:72b7:3626:af61])
        by smtp.gmail.com with ESMTPSA id i13-20020a50c3cd000000b004fa012332ecsm4122296edf.1.2023.04.10.22.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 22:55:40 -0700 (PDT)
Message-ID: <f9552bb6-ea73-93b4-f15d-d5d7c326c708@linaro.org>
Date:   Tue, 11 Apr 2023 07:55:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/5] dt-bindings: input: touchscreen: add bindings for
 focaltech,fts5452
Content-Language: en-US
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230410160200.57261-1-joelselvaraj.oss@gmail.com>
 <20230410160200.57261-2-joelselvaraj.oss@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230410160200.57261-2-joelselvaraj.oss@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2023 18:01, Joel Selvaraj wrote:
> Add devicetree bindings for the Focaltech FTS touchscreen drivers.
> 

Subject: drop second/last, redundant "bindings for". The "dt-bindings"
prefix is already stating that these are bindings.

> Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  .../input/touchscreen/focaltech,fts5452.yaml  | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml b/Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml
> new file mode 100644
> index 000000000000..f42868293439
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/focaltech,fts5452.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Focaltech FTS I2C Touchscreen Controller
> +
> +maintainers:
> +  - Joel Selvaraj <joelselvaraj.oss@gmail.com>
> +  - Caleb Connolly <caleb@connolly.tech>
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - focaltech,fts5452
> +      - focaltech,fts8719
> +
> +  reg:
> +    const: 0x38
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description: regulator supplying analog power (2.6V to 3.3V).
> +
> +  vddio-supply:
> +    description: regulator supplying IO power (1.8V).
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - touchscreen-size-x
> +  - touchscreen-size-y

We always put required: before unevaluatedProperties. Base your schema
on example-schema.yaml.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

