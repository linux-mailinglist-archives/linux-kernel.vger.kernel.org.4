Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768376E699C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjDRQd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjDRQdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:33:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04929AF1E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:33:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id xi5so74733952ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681835632; x=1684427632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3svsIMn6NH5JCDnnmVh5j6tmp5Rqo651qJv21VxnbUk=;
        b=WntZgeh7bu5HerTd9byX4AYleKBGwtBjVc30YksLoyXyGpK8fJhu3mzQrS7STCN0Be
         ajy2L8JKCxRhMp3ddCMAGmch8XjmJs+uaawiP04onIeCNuBzL95C8WDM6+SU0IHDQSiG
         QubuWhqYm29NX/Mr5VPr+UYtHz2kJ2b06EkCXLa7YK+Hw5PTjXaCOlZn58K1LEnAyMbj
         +S8TerKUQDWOLXk4dW/gxw50pjW2aE0J3ry7UyfozeDPW0pDEDA6SVDvozwQ5z4+cHtS
         +rFW0I5u3Y4aah1ot2T0Yggrj7KUlLP9uCVtX3QIkoDTUV/n5N/addjwwF4xbkvqapTb
         nVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835632; x=1684427632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3svsIMn6NH5JCDnnmVh5j6tmp5Rqo651qJv21VxnbUk=;
        b=bBu7HjnELM76Ze2K1MZrLa+GQ2IZISLf6lIkHTx63aen6e2k4jsZjdbOy+pIzdSHOb
         nD9kW2NZa17JH2va4rLB1HEJ7rCcIaQZSfB5dWkPqzEwLnGU5oAOq8JuUWPOC99+yVoV
         6zpzG1mOMG4ze9wmODR1gOOqI95R0rNlwOM7ADKvOlOpNc+7EgDaYDK3tyCMiMFGgEZG
         00vc1MbV/eMqUdHR0hRNh3Qbv7LDfjesx4lguG6PaOTI26cHSPPfVtOWeaNJ1Lxkn3J8
         2J9pTlqmVr0kUHycp5NHsJeMGdw0Cb1vmBIqw83xS0EpCdjGDYOyWuyxduW9qlUYZal5
         Nxuw==
X-Gm-Message-State: AAQBX9dhAn4QQXHJwnmNSXUNZN3BS5xHzY75Bsksuh4t7Tk6v3c1pSYb
        BuKvH1w0Wg6bXuF/RFxOIeHN8A==
X-Google-Smtp-Source: AKy350YtYb/o/2iyCoIf0t1KEQpHNJriAL+kgd/CuaRAMIxDIfL6vkbP5yzQCD+Z/16jZrR+IIPkZw==
X-Received: by 2002:a17:906:845:b0:94a:5d8e:ddb0 with SMTP id f5-20020a170906084500b0094a5d8eddb0mr10519617ejd.62.1681835632490;
        Tue, 18 Apr 2023 09:33:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id p25-20020a17090635d900b0094e75d3ba1bsm8259026ejb.131.2023.04.18.09.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:33:52 -0700 (PDT)
Message-ID: <99eeac8e-1811-0d9b-9d19-875c339b5fbc@linaro.org>
Date:   Tue, 18 Apr 2023 18:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] dt-bindings: Document TI OPT4001 light sensor
 bindings
Content-Language: en-US
To:     Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
References: <20230323-add-opt4001-driver-v2-0-0bae0398669d@axis.com>
 <20230323-add-opt4001-driver-v2-1-0bae0398669d@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323-add-opt4001-driver-v2-1-0bae0398669d@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 12:36, Stefan Windfeldt-Prytz wrote:
> Add devicetree bindings for opt4001 ambient light sensor.


Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> Signed-off-by: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
> ---
>  .../devicetree/bindings/iio/light/ti,opt4001.yaml  | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
> new file mode 100644
> index 000000000000..43fd1a992aea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/ti,opt4001.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments OPT4001 Ambient Light Sensor
> +
> +maintainers:
> +  - Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Ambient light sensor with an i2c interface.
> +  Last part of compatible is for the packaging used.
> +  Picostar is a 4 pinned SMT and sot-5x3 is a 8 pinned SOT.
> +  Only sot-5x3 has an interrupt pin.

Drop this sentence. It obvious from the schema.

> +  https://www.ti.com/lit/gpn/opt4001
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,opt4001-picostar
> +      - ti,opt4001-sot-5x3


Best regards,
Krzysztof

