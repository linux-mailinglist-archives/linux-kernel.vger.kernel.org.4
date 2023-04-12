Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE60C6DEC4F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDLHOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLHOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:14:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD20F1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:13:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f26so20248390ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681283638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSb8+3GCZjbScMcwhrVNFlcYVQrPjCh+ouHXg2g6vWE=;
        b=t8Xz7E9XCnpbOXwsyz8O03mqMBfcFwjo2T++uD1k1tMQBk9dKFNXnMGnukEG9HYhF/
         1qi9GWSfbcc+9hH4qhyLqkp8FQ0JXB0np7ELNbdnONnU6t84N6OW0Gv3FOQgcq602yCL
         WAJWZEg6Oq4JFPsDHPGu3hy2XteM3p8fIza8T7ZId+gvpejruoMew5pw3CHfNtehRLin
         Gh6MWQfuTqJtRpVqa+6QfJHqjfA/8SomnkmlcjgDC8xR1jmC8NRn0BqRi95L+hyA0R5U
         t86TwDKpHzTYRR0EWV8LREIdklHIKBiLRVQJDYJ13lyFY7Ot66wfsBB/rDiWnohhGbQO
         jBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681283638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSb8+3GCZjbScMcwhrVNFlcYVQrPjCh+ouHXg2g6vWE=;
        b=hkqi+TIJdaU3f+c8RDWVdJcohVtmJNwbLRJcbGIoY/lHL08urXHf+CU0HXW50x2pdg
         lN/w4RbTd70mU8wkccXJV31R6rPPlR4eTyRW6NaGSTtdCG9Tp7uU/A0giSBboyXZkPOS
         aPOMH3vePCkNDgSPrL0jsu9q+ZRfghdz79uH+W1cWZ8TDp7RUQce8Is/NyGF6M52wywX
         4sb51GAzLEfGq2DXMBU1Cc/dtoky0/bkSnnAI/2VOFXoYqEwXDQblw2NLPR2+m+IioK/
         feLyFc1jma9pUcCrG35y7fEpw/AW7ihiKyUXoaTBT9Wg2EgsietQFgBM4XSMtBB8BtZs
         lGaQ==
X-Gm-Message-State: AAQBX9e2tov7W0hafR71tmqscP7BrZH5w9TBl3GpgLfy/Gle4nerfBXu
        R8ioCAkV4JcyCohXLd+QIgVOh5veMG4Ng1J4Eqg=
X-Google-Smtp-Source: AKy350YvNxNAcnAmDGZ1SZtTtgBgAJyImltMTkW5Dfa1JOksPBss0D9cjHcRM6QSzXZzwziyoC5owg==
X-Received: by 2002:a17:907:1686:b0:930:f953:962c with SMTP id hc6-20020a170907168600b00930f953962cmr16169593ejc.1.1681283637718;
        Wed, 12 Apr 2023 00:13:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8fa0:9989:3f72:b14f? ([2a02:810d:15c0:828:8fa0:9989:3f72:b14f])
        by smtp.gmail.com with ESMTPSA id n14-20020a1709065dae00b009334219656dsm6900701ejv.56.2023.04.12.00.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 00:13:57 -0700 (PDT)
Message-ID: <77cadd45-0b15-af1a-9eab-ebe0b3241473@linaro.org>
Date:   Wed, 12 Apr 2023 09:13:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] ARM: dts: mvebu: Add device tree binding for
 Marvell Armada 38x
Content-Language: en-US
To:     Tony Dinh <mibodhi@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230412025737.20280-1-mibodhi@gmail.com>
 <20230412025737.20280-2-mibodhi@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412025737.20280-2-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 04:57, Tony Dinh wrote:
> Add device tree binding for Marvell Armada 38x.
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

This is not DTS. These are bindings.

> ---
> 
> Changes in v2:
> - Add marvell,38x.yaml. For now, add this binding to the Marvell
> directory to keep it consistent with other Marvell yaml files.
> At a later date and a separate patch, consolidate the Marvell
> yaml files into  marvell.yaml.
> 
>  .../bindings/arm/marvell/armada-38x.yaml      | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml

marvell,armada-38x.yaml

Or just squash it with existing armada bindings... Keeping one binding
per one SoC group is a bit a lot.

> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
> new file mode 100644
> index 000000000000..096bd46d932a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/marvell/marvell,38x.yaml#

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).


Best regards,
Krzysztof

