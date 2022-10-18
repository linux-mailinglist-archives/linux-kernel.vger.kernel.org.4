Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB88602694
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiJRIPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJRIPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:15:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9E2923ED;
        Tue, 18 Oct 2022 01:15:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 744F2614AF;
        Tue, 18 Oct 2022 08:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF48EC433D6;
        Tue, 18 Oct 2022 08:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666080939;
        bh=NiAv+zV+OhVw/SMNAL4VCwWVxv3D3VbyawFBS3TxEQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9ZW3YG6niqCp1gyNqn3NCMLDVI4wJaWqxfJ3sJnoDCzYaeXv8C/RTr/7xTbN2ma5
         Jcgmaes1h9cbLjBlx57/YNo8Z7I8qrYfggd0sWThLZOvxfNffo7bfY3QT0g9Dhdd6I
         MJr2HYjCnLEq7cXeaz8X0hhm5Z2DuM5OrrxAi15UUbYRazfOwEMqo/70tOXYlEZD/P
         CFSnqg4GfDghFJm4vJJwacOFS8oME8YDwJOhS5sbgBw7pagBQeaoLXpiCrtA4B+l5o
         1jdJ+kPP/VM0Q+fOgnIe/vE2iExBEGF0uAYl3BjFQkoXcR2BssjhLTOvYtQa8XK7Yu
         vY074BpKuMesQ==
Date:   Tue, 18 Oct 2022 10:15:33 +0200
From:   Matthias Brugger <matthias.bgg@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Drew Fustini <drew@beagleboard.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: riscv: starfive: Add StarFive
 VisionFive V1 board
Message-ID: <Y05gpRFo5DjWTM0o@ziggy.stardust>
References: <20221017210542.979051-1-cristian.ciocaltea@collabora.com>
 <20221017210542.979051-2-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221017210542.979051-2-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:05:40AM +0300, Cristian Ciocaltea wrote:
> Document the compatibles for StarFive VisionFive V1 SBC [1].
> The board is based on the StarFive JH7100 SoC.
> 
> [1] https://github.com/starfive-tech/VisionFive
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>  Documentation/devicetree/bindings/riscv/starfive.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
> index 5b36243fd674..5d3fcee52d59 100644
> --- a/Documentation/devicetree/bindings/riscv/starfive.yaml
> +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> @@ -19,7 +19,9 @@ properties:
>    compatible:
>      oneOf:
>        - items:
> -          - const: beagle,beaglev-starlight-jh7100-r0
> +          - enum:
> +              - beagle,beaglev-starlight-jh7100-r0
> +              - starfive,visionfive-v1
>            - const: starfive,jh7100
>  
>  additionalProperties: true
> -- 
> 2.38.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
