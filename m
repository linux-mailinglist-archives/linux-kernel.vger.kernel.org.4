Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3ABD6E8277
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjDSUS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjDSUSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:18:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9325587
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:18:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dx24so1213729ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681935502; x=1684527502;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6pbzo4OluoRMXV+MR3P7u+CXjqXd/it4CqxiYCU0P9A=;
        b=btV0gK2VFbXrK3woTgBAayGrxear9h3tidO6nMICtFU+IhyWrj/M/Jh7hjisWBc1Zx
         XKY66a2n6iL+1jau2DCE8eAZrBI239NA+MIQyKnF5cgpnHfIXJeXiDSw4Al9tbxJUmtj
         mzWnMSQawuJ368G4GLTCYa2HLPWrmBSeLdIf6T+0OWLmKgOz9gU10KXgC/3kGal6DDHG
         WNCCA9EOovlQDyu2ALQe1gFLx56qgtAWAl1Dm0E3Iy9YKxj8n2pox7xJ3igCpK5qVf2E
         xUJFLdKuUkHOpIuPZDo5a//c7BTTtV1ZS098nYzt262A6vjsL3lOaGKKliz/aKNRVukd
         D8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681935502; x=1684527502;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pbzo4OluoRMXV+MR3P7u+CXjqXd/it4CqxiYCU0P9A=;
        b=ZjXJeO1BlbAtvpzcAQBApgBKr4w8J5xTbgcQS5kFU6e9NAam280ox/Vc6y1GiSGAIE
         x7o+Tw5ggTTmWyWtv0DG2V4sc381mvFEpaBolee/K9dQHiA6TRskvXZG8NkkSEMVuSht
         C3SNq6LVj/HsMUFXc/gOnAKRoBcYJH+okxIHhPjCEvKuQxosY7o3d+NRS/ncke14+pOF
         xZYrht8kmbIyA2MJytTgxC0RoffUQEVdjo6HjWIbmxRahuZ2bntmLTXbIH9SmllUe0gC
         D1Psrgq5cptrC8dFv8q2ipz/fvkj+YGIGLhXifGSrjTG6BZHz82b0KxlX+GE/BSUs0P3
         pO8Q==
X-Gm-Message-State: AAQBX9eizJry+OTq/1Mtvl5yE3k1luyisehFpiTfAN5qCCKWP7/y1qw/
        lI0QhdedRZ4Yz2H5qjMMs2TWUw==
X-Google-Smtp-Source: AKy350aPYDtN4ck6FY3wvdtXBvqts4HMhVtEKMJkuZRG6iceMxMu0/SFu7q2kDFyXRuOy1kw1nJLJg==
X-Received: by 2002:a17:906:3790:b0:94a:845c:3529 with SMTP id n16-20020a170906379000b0094a845c3529mr14378455ejc.9.1681935501841;
        Wed, 19 Apr 2023 13:18:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:976c:1d6c:6ed0:8935? ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id fl3-20020a1709072a8300b0094f396c7a7asm6052425ejc.214.2023.04.19.13.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 13:18:21 -0700 (PDT)
Message-ID: <6c4dadfb-b92f-3e95-1d56-de033d560eba@linaro.org>
Date:   Wed, 19 Apr 2023 22:18:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2 v2] dt-bindings: watchdog: marvell octeonTX2 GTI
 system watchdog driver
Content-Language: en-US
To:     Bharat Bhushan <bbhushan2@marvell.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com
References: <20230419120635.3736-1-bbhushan2@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419120635.3736-1-bbhushan2@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 14:06, Bharat Bhushan wrote:
> Add binding documentation for the Marvell octeonTX2
> GTI system watchdog driver.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v2:
>  - compatible changed from marvell-octeontx2-wdt to marvell,octeontx2-wdt
>  - corrected type atchdog to watchdog 
>  - Replaced hardcoding to use IRQ_TYPE_EDGE_RISING flag
> 
>  .../watchdog/marvell,octeontx2-wdt.yaml       | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml b/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml
> new file mode 100644
> index 000000000000..96a979c4082d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/marvell,octeontx2-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell OcteonTX2 GTI system watchdog
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +maintainers:
> +  - Bharat Bhushan <bbhushan2@marvell.com>
> +
> +properties:
> +  compatible:
> +    const: marvell,octeontx2-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        watchdog@802000040000 {
> +          compatible = "marvell,octeontx2-wdt";

Mixed indentation. Use 4 spaces for entire DTS example (or 2 spaces, but
4 is preferred).

Best regards,
Krzysztof

