Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7E6695C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjBNINl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjBNINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:13:23 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B92B5596
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:13:21 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id he5so2565654wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHpaQq9B2wrn+Cjlf3NtLyf+7OFHfhWv9uGGdSiv/7c=;
        b=Ty3UtCwZvrw+i2dvA18WAg2j/gojaLzg1DAUNLAgK1b3m5/HA+i0+r7RyXX1q6TPMk
         KPnCB9L50sPdSVazWqwlB1b9BU71SYbvGP3pG1S2LWHlT3kuIzGiAZ8TM76cFw/ZheMz
         5AE26YLz7KKAjC+9VJPXB8IGP8evxc3a7WLhOhvDre7KkCQFA4dnJSwpYoS3Ga9shiJE
         lIvUEKwiDAnFHDv8zBbEnMVwddJlGMY2v8GKgxlwv98XNKt7ngUg+LM3PskKa+h32mlj
         daH7dRSy2pnYBjG0cNONlJFe/Ot4mjZ8FDGANYis5rWrsZiv16DuL+bljKj39H1cwBbH
         swJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHpaQq9B2wrn+Cjlf3NtLyf+7OFHfhWv9uGGdSiv/7c=;
        b=xthZ9dQHknTmym9XSAPoZfU33GSekBlPPidbb0NE9e/FBY5AKaLwjtoEGs8eeSj8ri
         aG0NIrTfekJrOrOieO6SnbDGyJ644XXXzOioOWwO1Zxb6V696snS9Gfrg6BPp/gu34Ac
         LQ3nViAxhGdVloGsRqdZ8yBuGxIUwU8aYpL0ahhEuZjZUjkqL1R35YSLcOg+RB5Tudrv
         hhHb10xPbmWGzR+9cZlWgV4apt0hDdVQvUGsZC+J9/OLhmcGWQLkfEHO2aljoZ+r/K5h
         dzJ+oEzkckErj2BVa/JVJmWkY8hxw0zcCvPYSdJOP5/x3BBvG8UnsXR48cc6eKn/3J86
         DlLw==
X-Gm-Message-State: AO0yUKWuZ/DuBppe9mM/c6i52fgEezIdWL2cWeS1Gs+0oaXGKOPhmiwM
        DyTxhlgpOtYWF0YuTBJRZ0BetQ==
X-Google-Smtp-Source: AK7set+OX2Ib6PWH7M5HgBNK8worIzRCtIeKsrwFzxHqQ1CJRDA1mavA/qMeJPg7uy7j6yp0wBnMgg==
X-Received: by 2002:a05:600c:4a90:b0:3dc:46f6:e607 with SMTP id b16-20020a05600c4a9000b003dc46f6e607mr1250694wmp.3.1676362400677;
        Tue, 14 Feb 2023 00:13:20 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c42c600b003df245cd853sm15360946wme.44.2023.02.14.00.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:13:20 -0800 (PST)
Message-ID: <4d68ace9-d9ab-647a-9cd0-33f5cc450e58@linaro.org>
Date:   Tue, 14 Feb 2023 09:13:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] dt-bindings: mailbox: sti-mailbox: convert to DT
 schema
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230213212751.18789-1-avolmat@me.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213212751.18789-1-avolmat@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 22:27, Alain Volmat wrote:
> Convert the sti-mailbox.txt file into st,sti-mailbox.yaml
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> v2: update commit log
>     remove quotes around urls
>     add mbox-name $ref
>     remove mbox-name from required properties since not mandatory in the driver
>     fix IRQ type in example
> 
>  .../bindings/mailbox/st,sti-mailbox.yaml      | 53 +++++++++++++++++++
>  .../bindings/mailbox/sti-mailbox.txt          | 51 ------------------
>  2 files changed, 53 insertions(+), 51 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml
> new file mode 100644
> index 000000000000..e91ca86284eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/st,sti-mailbox.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/st,sti-mailbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics Mailbox Driver for STi platform
> +
> +description:
> +  Each ST Mailbox IP currently consists of 4 instances of 32 channels.
> +  Messages are passed between Application and Remote processors using
> +  shared memory.
> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@foss.st.com>
> +
> +properties:
> +  compatible:
> +    const: st,stih407-mailbox
> +
> +  reg:
> +    maxItems: 1
> +
> +  mbox-name:
> +    $ref: '/schemas/types.yaml#/definitions/string'

Still quotes to remove.



Best regards,
Krzysztof

