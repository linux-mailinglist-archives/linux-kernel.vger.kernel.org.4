Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACFB6A7C88
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCBI0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCBI0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:26:14 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4939538E83
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 00:26:13 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id d30so64409364eda.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 00:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677745572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qF8dljky4ONoFIZIMt0AmOCbbWROQiuEBW80nDTpnbc=;
        b=JND/hOZrRZB2DYjUvPTbFXmjVmjFuWlRHyvseoPlgtNxsYgJ4mmX+0iO45+7aICQ6k
         wryisL9XAtARegCrPikiRm2gSiOA3OXUkEmqRrqn9CTPNjIjzDsZZK1VGMDcKGtq+olA
         sF55nWLSfPNSHLCfNJKrN1CIYWbn5UU70uuA7USQHH9L+MkjhoV+nuUdJD8ycn7o47xe
         Pp7dea/0vRNHDlOVEBgVQuWznjkyKNAwgW80essaXbNzt8zRILWHx+NwzfOXzOuvP//F
         0j3umPIKOqGDOAb9npSD8AUVQnV0l8KxtK/YK3wQBI9o0bPCYC0tW4VyoDzn1H8zOUAA
         S9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677745572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qF8dljky4ONoFIZIMt0AmOCbbWROQiuEBW80nDTpnbc=;
        b=Q3eZhnuYgKB0SJbIy29hZedWA1UdMWsSw4sFZMS7I/UZPXJ3Mz5iA0piZaiDCMKEOO
         xMjwongRsQ6PiIJ2+QvbKwKeWQ+PvPwanylcW8qCpr9Wqn5Ng3Twx/c2HWZQk1G92s0X
         1/+LWk59Y7X9Qz1F9WheuOQa5IoozKh0oV/vLFglt2IXp2QkY9PEdYwcm2KXI/IJwJQy
         DMBX24VnZfKBjN2J5b8UZCrZwlPJ6pzx0n23RvFY8o9uLHb3ZMkOjv+lwcneou5iXgeC
         UCeEA8fNqxZXEjxkIpdgnKwUr1TYDuoQFHOnLfM8LeEBPCoW4950x+BgK2KwIw649UQy
         nmfw==
X-Gm-Message-State: AO0yUKWa291Rwr92g3f84m75PnZoLmzBaMbOKYN+oYwIU1nz4DR0dYuT
        qenDuBXb//2IbjR7J5uVxRX8Vw==
X-Google-Smtp-Source: AK7set8yhCkIAjMSqdf425HNhmIcVIL5UZnj7FbIiO+n95PoVmjF1Yx/1oFoTv65o+yYJ9f8SwKWBg==
X-Received: by 2002:aa7:d456:0:b0:4ac:bd84:43d9 with SMTP id q22-20020aa7d456000000b004acbd8443d9mr9961151edr.2.1677745571741;
        Thu, 02 Mar 2023 00:26:11 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q8-20020a50aa88000000b004bc422b58a2sm1684180edc.88.2023.03.02.00.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 00:26:11 -0800 (PST)
Message-ID: <dcace8f8-8591-40df-895b-155f0604665d@linaro.org>
Date:   Thu, 2 Mar 2023 09:26:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add MAX5970 and MAX5978
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230301091234.3159953-1-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230301091234.3159953-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2023 10:12, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> The MAX597x is a hot swap controller with configurable fault protection.
> It also has 10bit ADC for current & voltage measurements.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Co-developed-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

It's v12 or what? Where are previous tags? Or you ignored entire review
and sent something new?

You already got the comments about it, so basically you ignore it second
time...

Where is the changelog?

> ---
>  .../bindings/mfd/maxim,max5970.yaml           | 151 ++++++++++++++++++
>  1 file changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> new file mode 100644
> index 000000000000..6ee269afdab2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> @@ -0,0 +1,151 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Regulator for MAX5970 smart switch from Maxim Integrated.

Drop the full stop. It's title, so follows the title grammar rules (you
could also capitalize it but it's matter of style
https://www.grammarly.com/blog/capitalization-in-the-titles/).

I don't know whether I should review rest or not... just in case I don't
want to waste my time, so I'll skip it.


Best regards,
Krzysztof

