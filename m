Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169BF6663F6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbjAKTrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjAKTqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:46:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38CCD2F2;
        Wed, 11 Jan 2023 11:45:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DDAA61E06;
        Wed, 11 Jan 2023 19:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BF2C433D2;
        Wed, 11 Jan 2023 19:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673466301;
        bh=xRr7us8zBW0sk990QLjOp0ucsfIPeo81l4T24fBaPC4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sKny68A3/QnJwl4Wk9++6MFNKMrAlPUELmesjETKeCB20k/As5eX4jlVVJy9UB+JG
         vkfnftDpWJ/G1xD56x9raf2Q0G/oFMdFJJtZfFUeYq9aTVHl6TkR2MB9tY4vDy+yQV
         S7tslv0IMokoh95dI43PC8ppZEl/h2WQGiilovuORceThkx1RWjp9dZNcK5tW5sf4B
         CL1lOZBwxuQEahlWvhuGS4jJn8LYOz2K38AZgV2bN6OJ+U94P5Ow+40NCdtH/oH7Mi
         ZWLOPjgTU92ubxpASPdAYCtAvPY3BjNnTddzXlxecSx3DWTj+7GcfCCicC5TmVvwrx
         gyEoZ//R/BlBw==
Message-ID: <8980856c1138571976f00413b94cfeb8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221226095745.19757-2-a-bhatia1@ti.com>
References: <20221226095745.19757-1-a-bhatia1@ti.com> <20221226095745.19757-2-a-bhatia1@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: fixed-factor: Add TI AM62 SoC OLDI clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Tomi Valkeinen <tomba@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Linux Clock List <linux-clk@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 11 Jan 2023 11:44:59 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aradhya Bhatia (2022-12-26 01:57:44)
> Add "ti,k3-am62-oldi-clk-div" to the fixed factor clock compatible enum
> list.
>=20
> "ti,k3-am62-oldi-clk-div" is a fixed-factor clock that helps the TI
> display subsystem request a pixel clock for itself and a corresponding
> serial clock for its OLDI Transmitters. The serial clock is 7 times the
> pixel clock. This clock needs the clock set rate request to be
> propagated to the parent clock provider.
>=20
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/fixed-factor-clock.y=
aml b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
> index 8f71ab300470..0696237530f7 100644
> --- a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
> @@ -14,6 +14,7 @@ properties:
>    compatible:
>      enum:
>        - fixed-factor-clock
> +      - ti,k3-am62-oldi-clk-div

I don't see this compatible anywhere in the kernel tree. Is there a
patch that adds a node using this? I wonder why the display subsystem
can't add this fixed factor clk directly in the driver. Does the OLDI
Transmitter send a clk to the display subsystem?

I'm asking all these questions because we got rid of vendor compatibles
here in hopes of simplifying the logic. Maybe the problem can be
approached differently, but I don't know all the details.
