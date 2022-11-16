Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBA162C6D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbiKPRuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiKPRux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:50:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2937E5E9DF;
        Wed, 16 Nov 2022 09:50:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDC7361EE5;
        Wed, 16 Nov 2022 17:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0DEC433C1;
        Wed, 16 Nov 2022 17:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668621052;
        bh=sYfpAzVzPlK94TgXFu2w+4Eiy5UZCKxlvYioVQA7W0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+3Lf+uCHADtE0GCia3d2ky8ujiTrrIkuWOscMc1Cx8X0BK1qmCSc1aV7TqKmEOCN
         AMmYUBsKkYe9F9DxfJGNnCXIe3WsLjwmtXiYB90z5c2X84kn4J4ojXQPjU97SNi70l
         o8RtNTw/E28f7NQvVTLAufSyE9kBlDvvsmkFj71UPdg6Pg3Sw8mk7tYHdDrVQPe9gx
         5v66uBM0i9fUkn81nwfz2KSfeGtkkOdJ7fwv2piNLIqusmdUAZqshABU5ppTHexBjn
         PXO9AvKapEFQtHfzfB8R4TswHruXb66mGk9qwHGzAiLC13RFTJZBPlYJKlX/l9WcrV
         m5do2id/2zeYg==
Date:   Wed, 16 Nov 2022 17:50:46 +0000
From:   Conor Dooley <conor@kernel.org>
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
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v4 0/3] Enable initial support for StarFive VisionFive V1
 SBC
Message-ID: <Y3Ui9mmcvuWMw2AL@spud>
References: <20221017210542.979051-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017210542.979051-1-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:05:39AM +0300, Cristian Ciocaltea wrote:
> The StarFive VisionFive V1 SBC [1] is similar with the already supported
> BeagleV Starlight Beta board, both being based on the StarFive JH7100 SoC.
> 
> In addition to documenting the necessary compatibles, this patch series 
> moves most of the content from jh7100-beaglev-starlight.dts to a new file
> jh7100-common.dtsi, to be shared between the two boards.
> 
> No other changes are required in order to successfully boot the board.
> 
> [1] https://github.com/starfive-tech/VisionFive

Hey Cristian,

Apologies for the delay here, we've been sorting out re-routing RISC-V
DT stuff via the SoC tree. That should be sorted now, so I have picked
the series up. Should be at:
https://git.kernel.org/conor/c/a3fe69160c7328a284ebc711ccb689f3beec42dc

Thanks,
Conor.

> 
> Changes in v4:
>  - Rebased onto v6.1.0-rc1
>  - Fixed a conflict in patch 2/3 as pinctrl-starfive.h has been renamed
>    to pinctrl-starfive-jh7100.h
> 
> Changes in v3:
>  - Added Reviewed-by tag from Krzysztof in patch 1/3
>  - Optimized patch 2/3 by enabling copy detection on "git format-patch",
>    as indicated by Krzysztof
> 
> Changes in v2:
>  - Simplified documentation by using 'enum' instead of 'const' in 
>    patch 1/3, according to Conor's review
>  - Added Reviewed-by tags from Conor
> 
> Cristian Ciocaltea (3):
>   dt-bindings: riscv: starfive: Add StarFive VisionFive V1 board
>   riscv: dts: starfive: Add common DT for JH7100 based boards
>   riscv: dts: starfive: Add StarFive VisionFive V1 device tree
> 
>  .../devicetree/bindings/riscv/starfive.yaml   |   4 +-
>  arch/riscv/boot/dts/starfive/Makefile         |   2 +-
>  .../dts/starfive/jh7100-beaglev-starlight.dts | 153 +-----------------
>  ...aglev-starlight.dts => jh7100-common.dtsi} |   3 -
>  .../jh7100-starfive-visionfive-v1.dts         |  20 +++
>  5 files changed, 25 insertions(+), 157 deletions(-)
>  copy arch/riscv/boot/dts/starfive/{jh7100-beaglev-starlight.dts => jh7100-common.dtsi} (96%)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
> 
> 
> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
> -- 
> 2.38.0
> 
