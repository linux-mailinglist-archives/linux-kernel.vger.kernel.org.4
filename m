Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7275B4519
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 10:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIJIDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 04:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIJIDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 04:03:19 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F2676453
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 01:03:18 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bn9so4627068ljb.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 01:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LsbyJCRQGv8ADJ14m4fwuin9ksJE732HC/gnyZPsMxY=;
        b=n/EewGvvQIuAe2DE83YPWVE6cnz9tF9z0jkslzZzCTr9s5K5c0quxSyDp9Lv59Hx8a
         QF1wUSxtKxcqESO1QMRcs6G3FSdYbT0+NrRZSsS+kaWDwcknV3yyt1PazGtXJ88GJwRn
         Nr7pQ8Aw/8UqevlyfjtpMc+QeUSuz5Qe9o/zqiLE9PLsG6gTkxhYhPJzqpidLjnVEwxP
         JYnKdPeOT2xwimdEcifyV3p7HS6o3BZpZMBeYrkMUYqPH2zUsvS90YYJAEWqaw0JDs+2
         w479rjYLxDFbHKQLP8rnlrVPmfAGcCDPEJ3fEtq90sJ93+ODDw3Ri8WTBrgGoQriMKgv
         uKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LsbyJCRQGv8ADJ14m4fwuin9ksJE732HC/gnyZPsMxY=;
        b=PcTaNOmH7FPKNJ70NpGSGjWl/9LeUI0gJP3ulYWB+sgMTaCbNkmycjxzYI8jnKdoWH
         Qa9bmWlHYwGvjplfqSPWdf+shKN8/mitEvskmzx7Ac84fDyEmu5gKquYVw8fsrI/HqQ6
         /5NLsj2bYGdP39pgx2rHuOn0szTJkE/nDwFQew+etqZsAsXLRNokhz2X5a3hT0lMylLb
         3/KuPMtGbQyDc1q9Wy7oAgR+JvOXd6WTI+7KFj8QKYfQGYOeMgGH6QvbPX784fbwcASK
         4Zd3UkgSgCJ4zYNr0uM2paBMIFh2i9xe1oRcGdV8ZfKHlDEQP9QTa32ZWJ6jbgp9oMB9
         z71g==
X-Gm-Message-State: ACgBeo3mCvlNxoALs1ME6Jwy95dB0V5vFDp3NBS/JR6kfjRhwfV42qoz
        yiHNmZOBWCo6MpnWEDtSW9hJPQ==
X-Google-Smtp-Source: AA6agR43KgEW7WNcuh0EnpRKVUpHw2VVjmlXH9U0fJ2jA8k6r0BNZrXvGoENxRr1SsNi6QdqK8wuXA==
X-Received: by 2002:a2e:2244:0:b0:26b:e1c0:8ae8 with SMTP id i65-20020a2e2244000000b0026be1c08ae8mr2192100lji.146.1662796996708;
        Sat, 10 Sep 2022 01:03:16 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v19-20020ac258f3000000b0049462af8614sm179262lfo.145.2022.09.10.01.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 01:03:16 -0700 (PDT)
Message-ID: <ee4cdfb1-8edd-a0de-5068-85de88e16c3d@linaro.org>
Date:   Sat, 10 Sep 2022 10:03:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCHv3 08/14] dt-bindings: mfd: add rk806 binding
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220909175522.179175-1-sebastian.reichel@collabora.com>
 <20220909175522.179175-9-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909175522.179175-9-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 19:55, Sebastian Reichel wrote:
> Add DT binding document for Rockchip's RK806 PMIC.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Thank you for your patch. There is something to discuss/improve.


> +  vcc11-supply:
> +    description:
> +      The input supply for pldo-reg1, pldo-reg2 and pldo-reg3.
> +
> +  vcc12-supply:
> +    description:
> +      The input supply for pldo-reg4 and pldo-reg5.
> +
> +  vcc13-supply:
> +    description:
> +      The input supply for nldo-reg1, nldo-reg2 and nldo-reg3.
> +
> +  vcc14-supply:
> +    description:
> +      The input supply for nldo-reg4 and nldo-reg5.
> +
> +  vcca-supply:
> +    description:
> +      The input supply for pldo-reg6.
> +
> +  regulators:
> +    type: object
> +    patternProperties:
> +      "^(dcdc-reg([1-9]|10)|pldo-reg[1-6]|nldo-reg[1-5])$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +    unevaluatedProperties: false

Sorry, for not spotting it earlier but the indentation here looks wrong.
On "patternProperties" indentation you need additionalProperties: false,
because only the patterns are allowed.

On "$ref: ....." level of indentation, you need unevaluatedProperties:
false, because you allow only properties previously evaluated (evaluated
by regulator.yaml).

Best regards,
Krzysztof
