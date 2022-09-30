Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21495F1426
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiI3Uto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiI3UtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:49:09 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1313063FDA;
        Fri, 30 Sep 2022 13:49:09 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-13207a86076so2536875fac.3;
        Fri, 30 Sep 2022 13:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YN8qEL8DJBJUXwLGIJhhXCICK2Erz7u2/C6FcnHwxvw=;
        b=LLG1civW5Bz3dtCZAQ1pYC9yqFnPjnDVjDU0EniOcBWi/GVdN//JE+ISzvor587YTt
         7q/D2ToiNp3jPOxPwzbk4r5eD108F0FFl3I4sfztr+lJcOcga9JAYs9k6OOMxw6D7/GH
         jnMUB/Avxxfv8eBUUu3N5j/4VQ651AZT+VgAxmd1A8ffxTUPMZ1C5OCo2KQk1aSrBm39
         bC8FiL06wq6zLywVRu3nEJIyUqV1VQR6rE3XvfasIF8O8QUrKT32uFT0pFuktygRybEd
         YUy6Y78/smbRNYcEkUI957xMClMgBeNx8k4sZiqOBZ8z11B4N3WNh91PVRhx4/b/ltYT
         uAXQ==
X-Gm-Message-State: ACrzQf0uW6qRd6zXC/fPtDhFm5Ae+C+l4YttudduaCKlifFargpCo1b8
        ygh9dfBByIuP2/R52Wca6Q==
X-Google-Smtp-Source: AMsMyM7cQo+Xdc1zu4Ia/015WNtr0fkOMyA0Z7nPSaR5qXioETaX7bCFr8c6/ztbX7UjQ65MKT544Q==
X-Received: by 2002:a05:6870:3451:b0:131:82bb:22e3 with SMTP id i17-20020a056870345100b0013182bb22e3mr28626oah.233.1664570948264;
        Fri, 30 Sep 2022 13:49:08 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b42-20020a056870392a00b0013187edfde2sm971842oap.12.2022.09.30.13.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:49:06 -0700 (PDT)
Received: (nullmailer pid 908078 invoked by uid 1000);
        Fri, 30 Sep 2022 20:49:05 -0000
Date:   Fri, 30 Sep 2022 15:49:05 -0500
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
Subject: Re: [PATCH v1 09/30] reset: starfive: jh7100: Move necessary
 properties to device tree
Message-ID: <20220930204905.GA903203-robh@kernel.org>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929143225.17907-10-hal.feng@linux.starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929143225.17907-10-hal.feng@linux.starfivetech.com>
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

On Thu, Sep 29, 2022 at 10:32:04PM +0800, Hal Feng wrote:
> Store the necessary properties in device tree instead of .c file,
> in order to apply this reset driver to other StarFive SoCs.
> 
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> ---
>  .../bindings/reset/starfive,jh7100-reset.yaml | 20 ++++++++
>  arch/riscv/boot/dts/starfive/jh7100.dtsi      |  3 ++
>  drivers/reset/reset-starfive-jh7100.c         | 50 +++++++++++++------
>  3 files changed, 57 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml b/Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
> index 300359a5e14b..3eff3f72a1ed 100644
> --- a/Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
> @@ -20,19 +20,39 @@ properties:
>    "#reset-cells":
>      const: 1
>  
> +  starfive,assert-offset:
> +    description: Offset of the first ASSERT register
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  starfive,status-offset:
> +    description: Offset of the first STATUS register
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  starfive,nr-resets:
> +    description: Number of reset signals
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
>  required:
>    - compatible
>    - reg
>    - "#reset-cells"
> +  - starfive,assert-offset
> +  - starfive,status-offset
> +  - starfive,nr-resets

Adding required properties is a red flag. You can't add required 
properties to an existing binding. That breaks the ABI unless the OS 
deals with the properties being absent. If the OS has to do that, then 
why add them in the first place? All this should be implied by the 
compatible string.

Rob
