Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98933724012
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbjFFKtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbjFFKrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:47:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263691706
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:46:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-970056276acso880423466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 03:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686048392; x=1688640392;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IwF81Uszex7htTNK3p1MH/L9IV1Rte84JPTknI851dg=;
        b=THdgqVu+vY8gBqOdTZMw0AmNc6mFnvwxj9ZJ7FmSN3G8T0riJ390M9/uFura4aNH6r
         ZLdDgY76ymTqBJSDQFGo3xI4kNU/Ow0jv5KJSZPb6p3pbJcMWfjIQDTPet+3z9z3jEKY
         /nPhNWfU8nZFTaDSzh/eBFw7QvBR1462yhwe+elTPkM6gImFCYhUaL4HD+/14Rb07pdk
         PzCnmoBLhaOdP4IyBH7fPzF50Lg2ZKEWf64s0a0aauQ3QHX0rBwmMA82MnVGl4zIetUA
         FIdayuGRLfrxEBBcEHyZGfUuOsrQsSKIj3/53Yp+sfYyRXXDpW6uoOeN/GkqJ9a90RAm
         ukVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686048392; x=1688640392;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwF81Uszex7htTNK3p1MH/L9IV1Rte84JPTknI851dg=;
        b=YzabsolMXMcJ7nuWVcuJZKzGbjT0ridowMnQYd7lBpVWbt45zrp+Fy3934Zra/6Jx0
         i22OjhP/KyhzT8jnbqoTfAWr7MTSk5XbyMqsezzmBSdZG0/xb8c2w858rwfx74G2R4nv
         PYSoft7+Yu+nC/ydHOFBFqLHijOd4vIy8sVQJZWyXF1K+aWBjZPyyH3fgem8YRopYnFs
         ajZz1WcvWxwKfYrd1AjVrhOxIjd342UlUjQ40TEMm0VzMF6Zb1GzwFfMDQVaQCe0Ka6J
         arsIGBvmPMr1jsiNExhv8C9g47/iSXKZnpqw3XKXvVCuLZzY1yNZ+OPB8nEn6q8wdelD
         nLNA==
X-Gm-Message-State: AC+VfDyyUNep+yq+zje/qzIppySxYLD6G2MKteykExBLqc/jukqkcoAI
        C6AEL3sfbImaO4US73y4PH+2NA==
X-Google-Smtp-Source: ACHHUZ4qdGWPGdQz77Iote61dJgae30lb2JlzA6V3oh4lZI/epujOFp9DJLcmngZs+OFwjsSZyiqMw==
X-Received: by 2002:a17:906:730c:b0:94f:956:b3f7 with SMTP id di12-20020a170906730c00b0094f0956b3f7mr1903651ejc.2.1686048392634;
        Tue, 06 Jun 2023 03:46:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id o9-20020a1709064f8900b0094e6a9c1d24sm5599121eju.12.2023.06.06.03.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 03:46:32 -0700 (PDT)
Message-ID: <d7d0d46f-853d-ca78-9e6c-8b05011f2f69@linaro.org>
Date:   Tue, 6 Jun 2023 12:46:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v5 2/5] dt-bindings: hwmon: Add bindings for aspeed tach
 controller
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        lee@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, corbet@lwn.net,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        patrick@stwcx.xyz
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-3-billy_tsai@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606094535.5388-3-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2023 11:45, Billy Tsai wrote:
> Add the aspeed tach device which should be the child-node of pwm-tach mfd.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> ---
>  .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> new file mode 100644
> index 000000000000..50b3d8c98d55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Ast2600 Tach controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The Aspeed Tach controller can support upto 16 fan input.
> +  This module is part of the ast2600-pwm-tach multi-function device. For more
> +  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-tach
> +
> +patternProperties:
> +  "^fan@[a-z0-9]+$":
> +    type: object

additionalProperties: false


> +    description:
> +      Child nodes used to enable the tach channel.

Anyway you did not respond to our concerns. Why do you need it at the
first place?

I clearly asked:
But more important - why do you have such child
nodes? Your example does not have them. What's the point? Do you expect
different number of fans per one device (one compatible)?

Where is the answer to these?

Sorry, but ignoring the feedback and resending same stuff will bring you
nowhere. Several comments in the patchset were ignored.


Best regards,
Krzysztof

