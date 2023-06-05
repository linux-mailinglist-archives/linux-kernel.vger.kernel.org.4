Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AFC72276A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjFENaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjFENa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:30:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0208CD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:30:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977c72b116fso310412866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 06:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685971825; x=1688563825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9N5Xum37PH3vElfoq/xGvR9YZMDWuqhfk9rvQ3s9Xng=;
        b=WdhpqM0AVCM3qyL0GHgdrSJHtQhv1PYh0NuDYa4ZCEiDtaijwlFzvkEHWi/3VlhjdU
         btXvk1eLR5ACz3wBP6FtATWyGtH0hWrzBmTXNf1i/H+hjq54ZKVI40ZG4GKA+ylp1UU0
         5sBp1GISdALWrJCvvJC3ddKC28RmCFWfB+WSAhCYZbGX3zjZ2e4LOArzttsSQ4n7yev7
         u2U9PgOS/tVKnjsOqO+CEEvT/+npO5U6sxSJw5ghxcKJ93DbEFF7ESWzSp85O7oIma8s
         FED4y/yGiQrkzOcKtI4+b6H9LPIwhN0z9nf1HcZpZPCpG+fy7MWN01lcONr1qdyNLcrQ
         dLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685971825; x=1688563825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9N5Xum37PH3vElfoq/xGvR9YZMDWuqhfk9rvQ3s9Xng=;
        b=AYDn8iVinHqUsh7HlOW8jYtIIfAsWp9A8u4neoNQw/+n0R87obftXutsvg3MZtLPzs
         xB8Jp/L+urp7bxcEy3klc8jI8nyFY0s4nrAYe4PlWBtMgbIgDSv3fi4XwSoFf3EkNds5
         T0E3WM97jwZpfgIPGTFqm/XFaN4+zbtsWFcATwLZJJ7nbODk28/VJrkMmwG3wLvHMMx2
         6KV24Q2n4ViSBjLxy49g/ol7uOfm1WCHHtKZuTW4QN8s7io4AnfaIN0/3bnh60JIEcLW
         hzgg16DXXhK9S4+txrylisuDpm/4APcKcTXpU4MBU/i/6C2GU2NBbpYjqfy2z36l50Mc
         yflA==
X-Gm-Message-State: AC+VfDyWRtLtfn8cVNHcA/iocXjP+EEKMOP2eRt0dABOWgaFRaDU89aL
        6QiQ3s81p3HqrG1yGKVjgxrr/oMFcmj28MyNvns=
X-Google-Smtp-Source: ACHHUZ4Gpp6OQI4Q9MUi+CX2e4d01C6u1eJpgaFumPADq7T+YbaLI4ng+LDVm1/HcaHHXRQ8fKRuUQ==
X-Received: by 2002:a17:907:169f:b0:975:bbc:1e33 with SMTP id hc31-20020a170907169f00b009750bbc1e33mr5771040ejc.31.1685971825276;
        Mon, 05 Jun 2023 06:30:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i15-20020a170906a28f00b00968242f8c37sm4235348ejz.50.2023.06.05.06.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 06:30:24 -0700 (PDT)
Message-ID: <56137e35-3eac-41db-5f4f-b1a140df08f5@linaro.org>
Date:   Mon, 5 Jun 2023 15:30:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/2] dt-bindings:iio:adc: add max14001
To:     Kim Seer Paller <kimseer.paller@analog.com>, jic23@kernel.org,
        lars@metafoo.de
Cc:     broonie@kernel.org, lgirdwood@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230605130755.92642-1-kimseer.paller@analog.com>
 <20230605130755.92642-2-kimseer.paller@analog.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605130755.92642-2-kimseer.paller@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 15:07, Kim Seer Paller wrote:
> The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
> binary inputs.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested.
Please resend and include all necessary entries.

Subject - ignored comments.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> ---
>  .../bindings/iio/adc/adi,max14001.yaml        | 55 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> new file mode 100644
> index 000000000..1b17f5dc0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,max14001.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX14001 ADC
> +
> +maintainers:
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description: |
> +    Single channel 10 bit ADC with SPI interface. Datasheet
> +    can be found here:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/MAX14001-MAX14002.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max14001
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 5000000
> +
> +  vref-supply:
> +    description: Voltage reference to establish input scaling.
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#

Place it like other bindings, so after required or before properties.

Anyway, what happened with all the properties you had here and should be
switched to generic ones?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        status = "okay";

Really... You did not respond to my feedback, so sending uncorrected
version feels like being ignored. :(

Best regards,
Krzysztof

