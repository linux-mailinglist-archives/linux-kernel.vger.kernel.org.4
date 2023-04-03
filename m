Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAD36D40A0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjDCJbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjDCJba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:31:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3153530F0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:31:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w9so114689412edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680514287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NPh+EMUaLdi2l+M+ekkhJU7AhmrhVeIn6TgP3iXWonE=;
        b=DFmUo+L+r1nbQLbhsZ74wuyxun8LuYXe6M1hSwvmx7Ez7wmO/cK1hWOXGEoPMiRYMx
         iQ+fTKC1i7LTsWzkT7Q2EGmLT1k+LPZ7z1hxsDA9/ROAWZhkdWzU8pDjLQLfDHMcHtw1
         MKGUq+v5v1q5C7iHkHudPEzf4wNVCQvGA3iytlwW4pm/BZKQlw32HDfgFnNvG5ef5HDt
         qTUDR07pWufV7uD3j0lqvIZDQPIaar9GATF/0QCWkV74x6WC/dz5zaqM+dh76HpgUbDI
         DE9l6DsEv8Jcp8/yrnOtQPJgeDpDl84bUMuzVGZNkuTlDPQuR4w9zgmzkKeQB5wyv5SW
         /D6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680514287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPh+EMUaLdi2l+M+ekkhJU7AhmrhVeIn6TgP3iXWonE=;
        b=Glxlgwzx0e0sn+dcSl4kWuwXJt8qN12ov/QJMlVRdLmUpEVIP4zdFIsnfMYsBk6E1p
         YwtuAtF739ziPgv1g4DRig2C4NGV1bfKAtT8ATcb5Ge+61RREwdeBGI92nZy7GEt/Oiq
         2o7jrFkWXZ5r8Yg+Omn+RVwCDEeUaRezGGAZeYqeM1NvCd4f/RW1m2nUsW5QiUarc0DO
         opRZw0laMGH4ooHaRQpdF64G/SXDb9HZvw8PZlNk59EWEtfgenPpWo9YFPBGC+/G1lKc
         Mqx0afejo08MjQ1StAzUXHdJa6fLWl3I0gfMTxtVk1hiHe2WXJr+IIS3HQ5wEED7jIGg
         Ia3Q==
X-Gm-Message-State: AAQBX9dA8SSuLrg1ckfu4sYdm5smo4vVp0/yxn2/gBhhY5Atby6UAcBt
        ihQtFSZ0YPi8eRaIu12gMCTrgA==
X-Google-Smtp-Source: AKy350ZZKIe0XlZ5unRDt/7zn2r/gepDCwan5IHWh/Z2tdxfGiKQQF3K6cy7KtDVd2EBLddBhONZVg==
X-Received: by 2002:a17:906:d8a9:b0:925:5705:b5b8 with SMTP id qc9-20020a170906d8a900b009255705b5b8mr35741794ejb.58.1680514287645;
        Mon, 03 Apr 2023 02:31:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906c00700b0093f83562f09sm4284868ejz.87.2023.04.03.02.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:31:27 -0700 (PDT)
Message-ID: <5e487bc2-0a5a-4fa1-bc02-2647fa3a887a@linaro.org>
Date:   Mon, 3 Apr 2023 11:31:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: watchdog: alphascale-asm9260: convert to DT
 schema
Content-Language: en-US
To:     Om Parikh <hack3r-0m@proton.me>, daniel.baluta@nxp.com
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Olof Johansson <olof@lixom.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230403004138.326482-1-hack3r-0m@proton.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403004138.326482-1-hack3r-0m@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 02:42, Om Parikh wrote:
> this patch replaces the txt file and adds YAML bindings file

Do not use "This commit/patch", but imperative mood. See:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

Use full sentences, so start with capital letter.

> adhering to the json-schema for alphascale-asm9260. It is a
> demo patch for potential further contributions to the GSOC
> project.

Drop unrelated messages.

> 
> (see: https://wiki.linuxfoundation.org/gsoc/2023-gsoc-device-tree-bindings)

Drop, not related to Linux kernel.

Anyway, send your patches first through you mentor, so we won't have to
comment on trivial things.


Daniel,
Are you doing a review of your mentees?

> 
> Signed-off-by: Om Parikh <hack3r-0m@proton.me>
> ---
>  .../watchdog/alphascale,asm9260-wdt.yaml      | 76 +++++++++++++++++++
>  .../bindings/watchdog/alphascale-asm9260.txt  | 35 ---------
>  2 files changed, 76 insertions(+), 35 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yaml b/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yaml
> new file mode 100644
> index 000000000000..1f7baaf6b0f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/alphascale,asm9260-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Alphascale asm9260 Watchdog timer
> +
> +allOf:
> +  - $ref: "watchdog.yaml#"

Drop quotes.

> +
> +maintainers:
> +  - Oleksij Rempel <linux@rempel-privat.de>
> +  - Olof Johansson <olof@lixom.net>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - alphascale,asm9260
> +      - alphascale,asm9260devkit

NAK, this does not make any sense. I don't understand what do you want
to document here. These are boards.


Best regards,
Krzysztof

