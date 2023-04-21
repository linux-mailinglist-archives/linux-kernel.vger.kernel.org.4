Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD68D6EA491
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjDUHVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDUHVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:21:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82681BC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:21:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94f1a6e66c9so207608766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682061675; x=1684653675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5ELr7NOuHUY/ynanedA15kMHwV6wcIikVe8Is7rmn8=;
        b=AB8EOG1t+oft4jpC+v/284cWoHBR7USjcmk9UtO85zzyaEOBbNrioJUG8JViuQku84
         /R9r3edytZo9ffXSblpIbqyGKrklK5QTzDVK3DQm606Dq8Kb2dXo5O27v4aHH1V0TK3b
         Yi3l2hZeCZrwUd5PgpnoJylM8yL0MdJQPCI9LSSpdEdhtEno161qJUMcW9iCogSK/3tY
         ORAZUWBAmpy+gzJ0PhvYmTEEbIpJz/QmJfXAEXzFZoTuBpaR5c3G57TgcUn+iCI+/Eb6
         AIv7I8eRxU4MQF0DoRrOL94n2WebXBb+uJw2c1HeEVpe6ZUaGrrgWU6QZw0g3+pdheUe
         e4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682061675; x=1684653675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5ELr7NOuHUY/ynanedA15kMHwV6wcIikVe8Is7rmn8=;
        b=CgmHyaeqnc4xRWjG/c1lNA7WpnAnTJLgQjxfbGKme9AqFVib3FEfeZ0n+GH+3de6wg
         w/M7uF6UzD0LGzokawfW6/6RQ8hUOx46alzzQz4pR+o5WeqrXSz8yjFW9PL2LVus96P+
         IpNV0Qwzwv9pFPsNXqZ3j1JkHaOEOj/HgLYfOFKK8iCdeeRe4jcLUx15kZfJ+q4vrsX8
         /tAoinuIwy8KHYQC9fIPeryTUTYaRgw/EgevhxGmidZGYcNPA0ppZOrTaUOb96XyDCuz
         byOymH19nxm7M39AZa3tlk9PJihTaqhPieDZQ1o2jQB1VcNfgmDkXwBu1ROFKDbF7YgK
         kcng==
X-Gm-Message-State: AAQBX9crAvgR/xxWt16573xFuMuAYk4HM6Kq6lk9AXpuNj0Rs2uFZQRa
        mr5YCrqBqvmp6nsTxoUDZUq4kg==
X-Google-Smtp-Source: AKy350ZtOgORWSLsYISUnf4T9Rq2uCegqzIrNTgDf8dhtZSHGzR4IQvPxzVa1AlErkNKm+X32sL/ew==
X-Received: by 2002:a17:906:c08c:b0:952:b51d:5086 with SMTP id f12-20020a170906c08c00b00952b51d5086mr1393877ejz.57.1682061675614;
        Fri, 21 Apr 2023 00:21:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:668b:1e57:3caa:4d06? ([2a02:810d:15c0:828:668b:1e57:3caa:4d06])
        by smtp.gmail.com with ESMTPSA id my34-20020a1709065a6200b0094f6f45b2c1sm1694801ejc.156.2023.04.21.00.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 00:21:15 -0700 (PDT)
Message-ID: <9664d548-f25f-a585-d655-8eb2e403fae4@linaro.org>
Date:   Fri, 21 Apr 2023 09:21:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: pressure: Support Honeywell
 mprls0025pa sensor
Content-Language: en-US
To:     Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
References: <ZEGZ0Us/I40jLuB8@arbad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZEGZ0Us/I40jLuB8@arbad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 22:00, Andreas Klinger wrote:
> Honeywell mpr is a pressure sensor series. There are many different models
> with different pressure ranges, units and transfer functions.
> 
> The range and transfer function need to be set up in the dt. Therefore new
> properties honeywell,pmin-pascal, honeywell,pmax-pascal,
> honeywell,transfer-function are introduced.
> 
> Add dt-bindings.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../iio/pressure/honeywell,mprls0025pa.yaml   | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> new file mode 100644
> index 000000000000..80ab1beac7f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/honeywell,mprls0025pa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Honeywell mpr series pressure sensor
> +
> +maintainers:
> +  - Andreas Klinger <ak@it-klinger.de>
> +
> +description: |
> +  Honeywell pressure sensor of model mprls0025pa.
> +
> +  This sensor has an I2C and SPI interface. Only the I2C interface is implemented.
> +
> +  There are many models with different pressure ranges available. The vendor calls them "mpr
> +  series". All of them have the identical programming model and differ in the pressure range, unit

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.


Best regards,
Krzysztof

