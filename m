Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1F7734626
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 14:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjFRMl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 08:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFRMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 08:41:58 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B077B12B
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 05:41:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51a20c744ebso2924784a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 05:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687092115; x=1689684115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LcmCILrgJX1B1Vteq2MM9FqRXYqqpViPdWNgRXDlb3o=;
        b=dLxTN7sLvrQKZSpwIGW+AeLTtG/dhcI5bwtBx1FK7kHl1JuyqlMTryBFUs8YIupTvl
         AD22hN0u+IOPT2sf5wlG2QYlQc28vagkoCC14EBWQfH7ZHi/K44hgYjMzqu62nJAyhgE
         Pn9VWnGkzbcUIN8IHmLIr1XqQzjLjq2NlKFXRS1a3uDzUTkeBTqsNpVZXUmbP/t34P/X
         B9R3WMrkCL7TwAyQGxPbO9WojQmOfpmoAfcd/NRw6xSq4Y57xB32eZmfRZTXf0gcP3VD
         Xp7u80SadEF36cf9A/WOGsi7YIXtsOe3+AH1kf1V/oupO+SWozZywwYjlAaaECC2iejh
         Mwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687092115; x=1689684115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcmCILrgJX1B1Vteq2MM9FqRXYqqpViPdWNgRXDlb3o=;
        b=kCCYZR//7/JU6F2f5rWZfJv7AUH3YkjrRn11+GDV+U8CO9hdS+ahczFam41Y+JUDQJ
         uRIQf3QBWPq+FUThdXPyRCdnVqsb+Lz1m09YdvQbr3oPez3QDncwC58+06JGJHg8KLRR
         wg7A5vVRkC+DEPi2EekC6+iFtdeWugfJLVWJ5g43kSVnomqivS2t1yS+2DcA43k2vfeX
         IDPhbmIEnWgz9TMK2r+fEvVhzJWpv8HQC8k9u0mq/ZeRewyB2nRkw3hWUGkKMg56xVuw
         TNvXuhLsPE2lGEDcKiE1RRdRqcmJFe6oMKpK2APiskGVH2nnIzOczl9gi+pQ0OR4QEyD
         bX+w==
X-Gm-Message-State: AC+VfDyxPPNZKp+C05O5MktV0cOROmfbJhKJa43B0hAUtLDYTiZE3DvU
        6Rh7QJfYo90Pkh9DrfkyaHq9tQ==
X-Google-Smtp-Source: ACHHUZ50WlmlYxWLSbjtOGtaGPZ2SyiLg5sdXpLwhX0ienP7WjjARcHT61+XPqJAdqMSWmHIqxuyTA==
X-Received: by 2002:a05:6402:88e:b0:514:7f39:aa80 with SMTP id e14-20020a056402088e00b005147f39aa80mr4377322edy.18.1687092115222;
        Sun, 18 Jun 2023 05:41:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id t18-20020a05640203d200b0051a4fcf7187sm720934edw.62.2023.06.18.05.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 05:41:54 -0700 (PDT)
Message-ID: <7cbc6572-6772-64a6-6c91-567d58286426@linaro.org>
Date:   Sun, 18 Jun 2023 14:41:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] dt-bindings: leds: Add Kinetic KTD2026/2027 LED
To:     =?UTF-8?Q?Andr=c3=a9_Apitzsch?= <git@apitzsch.eu>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230618-ktd202x-v1-0-fc182fefadd7@apitzsch.eu>
 <20230618-ktd202x-v1-1-fc182fefadd7@apitzsch.eu>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230618-ktd202x-v1-1-fc182fefadd7@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2023 13:45, André Apitzsch wrote:
> Document Kinetic KTD2026/2027 LED driver devicetree bindings.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
>  .../devicetree/bindings/leds/leds-ktd202x.yaml     | 164 +++++++++++++++++++++
>  1 file changed, 164 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-ktd202x.yaml b/Documentation/devicetree/bindings/leds/leds-ktd202x.yaml
> new file mode 100644
> index 000000000000..9868d6f6f147
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-ktd202x.yaml

Filename matching compatible, so missing vendor prefix. Can be
kinetic,ktd202x.yaml

> @@ -0,0 +1,164 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-ktd202x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kinetic KTD2026/7 RGB/White LED Driver

Driver stands for Linux driver or for driving a LED? If the first, then
drop.


The rest looks good, so you just need to use proper filename.

Best regards,
Krzysztof

