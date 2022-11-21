Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E419E631BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKUItN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiKUItJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:49:09 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5087EBDB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:49:07 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id r8so3125819ljn.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fVT43T/dHnFe2fySXLzb5zjQ/wmCHIUhX9kGLd6O8bg=;
        b=m7YEpSdoPncIay7CK55dZamOK33iC41fbxI561jsG8EtQOA/NW2Vp+Ys1Qt0NFmitZ
         TXx8mFQhSTfbpEJ2aDLtvWWLUdpGTb2ktCgqBKMi9d5IchW6xLsTaQavafYkRx4sb135
         BoQyKgxloiHckVgNKcB4BHrc/bfpPo4GBQL11STHd+81mYBQWskdvXXsAxW68mC4RNCW
         tpP4QdID8cFLxNEdUUXaOHTS5u8oHNpr+Xg64BVPBShhUPi/ZWAnS2YxaTTa0CdeIZlW
         5YsXs+vXT8OrojWiDUG4qp0kJ8y+ukUk0ePHkPQvNsmf1rz6icdokA3IUkoFvZo8xXq5
         9JFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVT43T/dHnFe2fySXLzb5zjQ/wmCHIUhX9kGLd6O8bg=;
        b=bA2yPYRkGZsU0k+JCFcrmjADh2mrUnkz6mpTblgiqrZ+co1gcTn5B2N/C9PQIK3PWM
         6c/4EDUoN+LRHY/499Ir88fn0Evp2tuZgnxJYDGl9i+apCdEHJDRalqstL89muvqg4vt
         K95L09iwBbd6AYYSVmbljFEHT5bH3Y7Nb7xvis82V1djHpPmw3uFem2X8L0ZSGKVFf2w
         X41ty5USeTqbpYg8b699YVsKwAYfnznTfD1gHx/NG+d8zi+M8ti9Ut42H5vHhwr+Dc9g
         WOxHdJJY5ed53Uf43wFhbJQ22JeuwixCaWhNLBG38FqdAxQri1Ul+MEGKmPdFS5ekKI7
         toqw==
X-Gm-Message-State: ANoB5pm4k5E+EdD9tEqkcWCpiVSaVIbTh0xmY6RcsfExECN+OJMGsD0f
        RsJya/jmTNZ2SrBYtUvNuZvh8A==
X-Google-Smtp-Source: AA0mqf5kutEIoaxtevDmPqDbnLgxJ+m8XshHejRbM21MKTWUvRWlYZn6/xrxrWSEwZDb/uwiQFbWjw==
X-Received: by 2002:a05:651c:32b:b0:277:8d3:4298 with SMTP id b11-20020a05651c032b00b0027708d34298mr4891897ljp.302.1669020546204;
        Mon, 21 Nov 2022 00:49:06 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m22-20020a0565120a9600b004a608ec6d8csm1938901lfu.27.2022.11.21.00.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:49:05 -0800 (PST)
Message-ID: <8153973d-e8ad-e47a-3808-bbcdbfd169a5@linaro.org>
Date:   Mon, 21 Nov 2022 09:49:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 10/14] dt-bindings: clock: Add StarFive JH7110
 always-on clock and reset generator
Content-Language: en-US
To:     Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
 <20221118010627.70576-11-hal.feng@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118010627.70576-11-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 02:06, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add bindings for the always-on clock and reset generator (AONCRG) on the
> JH7110 RISC-V SoC by StarFive Ltd.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../clock/starfive,jh7110-aoncrg.yaml         | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
> new file mode 100644
> index 000000000000..afbb205e294f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-aoncrg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 Always-On Clock and Reset Generator
> +
> +maintainers:
> +  - Emil Renner Berthing <kernel@esmil.dk>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-aoncrg
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Main Oscillator
> +      - description: RTC clock

Real Time Clock clock? :) I don't think the input to clock controller is
the output of RTC...

Best regards,
Krzysztof

