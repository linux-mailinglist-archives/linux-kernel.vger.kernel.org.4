Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1009D6396F1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 16:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKZPya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 10:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 10:54:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1141C5;
        Sat, 26 Nov 2022 07:54:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA2A760B87;
        Sat, 26 Nov 2022 15:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788A3C433D6;
        Sat, 26 Nov 2022 15:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669478067;
        bh=C1r5GHLV5/tMA5KWxFKhaWvykn3QHCxI+yprvdC29B8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VViYIVmGrgXDKYSKgkGlPzEPxgRGcNB60aDCZewHPRSt8al1S9rYz39S/VPC4jHIR
         pgfJqzerAsjiawOEJbI/4lyCgU3mnii8Z+ULRFx0NPf2i4T90L5eJcJoqojRRygEZ6
         W11BstYyboUZJa1TciP0w1PigzA5EYXAvUIKnEZqeQnxGTgMsn3I8x4cxWrCAetB8f
         Pe3VYg74xt6pKrGj9wdRBJFmhGJqqRQGY6N0tYQf2/cmg8OH4OsjJRbsBJBjAzpBfH
         zSFTw+IjHkhC/h7gOTfXCeilv4myzhZaGHgTKNPkxL+klzh/DqAWEe6L4b5GU5LE9V
         HrfRHK1KHHTtg==
Date:   Sat, 26 Nov 2022 15:54:19 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 03/12] dt-bindings: riscv: Add Allwinner D1/D1s board
 compatibles
Message-ID: <Y4I2qxTCr7GvkuVz@spud>
References: <20221125234656.47306-1-samuel@sholland.org>
 <20221125234656.47306-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125234656.47306-4-samuel@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 05:46:47PM -0600, Samuel Holland wrote:
> Several SoMs and boards are available that feature the Allwinner D1 or
> D1s SoC. Document their compatible strings.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v2:
>  - Add MangoPi MQ (non-Pro) board
> 
>  .../devicetree/bindings/riscv/sunxi.yaml      | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sunxi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/riscv/sunxi.yaml b/Documentation/devicetree/bindings/riscv/sunxi.yaml
> new file mode 100644
> index 000000000000..9edb5e5992b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/sunxi.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/sunxi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner RISC-V SoC-based boards
> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +  - Jernej Skrabec <jernej.skrabec@gmail.com>
> +  - Samuel Holland <samuel@sholland.org>
> +
> +description:
> +  Allwinner RISC-V SoC-based boards
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: Dongshan Nezha STU SoM
> +        items:
> +          - const: 100ask,dongshan-nezha-stu

I googled the 100ask crowd & see yet another d1 based board:
https://www.cnx-software.com/2022/11/02/dongshanpi-d1s-allwinner-d1s-risc-v-development-board-teach-programming/
It's cool to see the variety :)
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> +          - const: allwinner,sun20i-d1
> +
> +      - description: D1 Nezha board
> +        items:
> +          - const: allwinner,d1-nezha
> +          - const: allwinner,sun20i-d1
> +
> +      - description: ClockworkPi R-01 SoM and v3.14 board
> +        items:
> +          - const: clockwork,r-01-clockworkpi-v3.14
> +          - const: allwinner,sun20i-d1
> +
> +      - description: ClockworkPi R-01 SoM, v3.14 board, and DevTerm expansion
> +        items:
> +          - const: clockwork,r-01-devterm-v3.14
> +          - const: clockwork,r-01-clockworkpi-v3.14
> +          - const: allwinner,sun20i-d1
> +
> +      - description: Lichee RV SoM
> +        items:
> +          - const: sipeed,lichee-rv
> +          - const: allwinner,sun20i-d1
> +
> +      - description: Carrier boards for the Lichee RV SoM
> +        items:
> +          - enum:
> +              - sipeed,lichee-rv-86-panel-480p
> +              - sipeed,lichee-rv-86-panel-720p
> +              - sipeed,lichee-rv-dock
> +          - const: sipeed,lichee-rv
> +          - const: allwinner,sun20i-d1
> +
> +      - description: MangoPi MQ board
> +        items:
> +          - const: widora,mangopi-mq
> +          - const: allwinner,sun20i-d1s
> +
> +      - description: MangoPi MQ Pro board
> +        items:
> +          - const: widora,mangopi-mq-pro
> +          - const: allwinner,sun20i-d1
> +
> +additionalProperties: true
> +
> +...
> -- 
> 2.37.4
> 
