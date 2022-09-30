Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8E65F0C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiI3Mv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiI3MvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:51:10 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0741296B0;
        Fri, 30 Sep 2022 05:51:07 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id c13-20020a4ac30d000000b0047663e3e16bso2151473ooq.6;
        Fri, 30 Sep 2022 05:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BKN6pqBF7loqZ839qOR8sDSeqrGBR2M9kkbIljc9QgQ=;
        b=q1+rm/AFwaboD5iJGKYd04dXFyQIe5vxxJFDVH6llfqGlxnEeQiA1XVtqXa7uRDQYq
         QxMKCZmwVjr/mVV+xDCQbjZPa7cE4+0NBDjpsyMBLnH2WKN+kb8Ikieni3NJ8ZWkkH96
         Req4Dp+YlxeNO63/Jbi5ZuIFp+1kxkn+EH7epAHqerQ9AmHVOpyq7fKIDPouQj5Q+OcD
         7BCBESbgTsVaVHwFRBlfAA/gfHmSpJ66FoE3rDd6EUKR7s32YcJLbvCDU1cwgf1L9ndE
         Fa3UQpg2v/kuizvuSHy4g69HrCzQylyue8Jqm/DR2DHtchATgxmkMDB9apdItQSZI7w0
         f1NQ==
X-Gm-Message-State: ACrzQf1xJpojHfzy2yZdOAR4fy/lNQZUR3REWljH2LLTHT+4eIYUNL3H
        sWQCF3Ivr8h/Hl99PrECIjJFUUEHgQ==
X-Google-Smtp-Source: AMsMyM72ktgqnPB0ybe/B6VZXT6Kl6bUWcvvBo5Ci6aR/i1omOc8r4PKjbOczRXFwoDN4TtO+evoZg==
X-Received: by 2002:a4a:434d:0:b0:441:9b4:ffad with SMTP id l13-20020a4a434d000000b0044109b4ffadmr3293506ooj.31.1664542266341;
        Fri, 30 Sep 2022 05:51:06 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b2-20020a9d7542000000b00637032a39a3sm560382otl.6.2022.09.30.05.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 05:51:05 -0700 (PDT)
Received: (nullmailer pid 95617 invoked by uid 1000);
        Fri, 30 Sep 2022 12:51:05 -0000
Date:   Fri, 30 Sep 2022 07:51:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@linux.starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 20/30] dt-bindings: clock: Add
 starfive,jh7110-clkgen-aon bindings
Message-ID: <20220930125105.GA93753-robh@kernel.org>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930055632.5136-1-hal.feng@linux.starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930055632.5136-1-hal.feng@linux.starfivetech.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 01:56:32PM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add bindings for the always-on clock generator on the JH7110
> RISC-V SoC by StarFive Technology Ltd.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> ---
>  .../clock/starfive,jh7110-clkgen-aon.yaml     | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-clkgen-aon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-clkgen-aon.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-clkgen-aon.yaml
> new file mode 100644
> index 000000000000..029ff57b9e3e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-clkgen-aon.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-clkgen-aon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 Always-On Clock Generator
> +
> +maintainers:
> +  - Emil Renner Berthing <kernel@esmil.dk>
> +  - Xingyu Wu <xingyu.wu@linux.starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-clkgen-aon
> +
> +  clocks:
> +    items:
> +      - description: Main Oscillator
> +      - description: RTC clock
> +      - description: RMII reference clock
> +      - description: RGMII RX clock
> +      - description: STG AXI/AHB clock
> +      - description: APB Bus clock
> +
> +  clock-names:
> +    items:
> +      - const: osc
> +      - const: clk_rtc
> +      - const: gmac0_rmii_refin
> +      - const: gmac0_rgmii_rxin
> +      - const: stg_axiahb
> +      - const: apb_bus_func
> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/starfive-jh7110-aon.h> for valid indices.

No 'reg'? How do you access this h/w then? If it is part of some block, 
we need to see the full picture.

Rob
