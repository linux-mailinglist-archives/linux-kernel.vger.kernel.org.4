Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6E962F42D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241432AbiKRMEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiKRMEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:04:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8C1264A5;
        Fri, 18 Nov 2022 04:04:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0705D624BA;
        Fri, 18 Nov 2022 12:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E643BC433C1;
        Fri, 18 Nov 2022 12:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668773050;
        bh=16/eZrNzuo6DfZkPEAFwMOchB87kodvzPf3XhDp0Vgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6ZAgd/uro5BfypVAdiqv7UtMzbw0VlsnIMF5F+91W+F+e75VGz/U/ORYFwuPBYRr
         OLWCQQwUW+9R4MgwH6B/WoE6qgRf9rbCZGAHWq15r9K+6FpbfSG6iSFhzbOXzTPani
         bXKoZHiA7cryOSx3dJlJlJRP0dY2ftGHwNP/Y9b7nR9yO5GjGxCu4O1ckeX9XjWQVc
         rBoamjnG5gkvNseRhmSm2Vjud4KL0f9MWtzIUvdgQojop/oh2lXXcHsDkYBH/h8AWt
         n/UXWgnoyLNUUma/2Nj8SZpyMtW1yP0MRWovLw5qV/pjHOR/y8grusi4JwORATYOLK
         KIcTPDPIAlf3Q==
Date:   Fri, 18 Nov 2022 12:04:04 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>, palmer@dabbelt.com
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] RISC-V: defconfig: Enable CONFIG_SERIAL_8250_DW
Message-ID: <Y3d0tL6UoAbdhHKE@spud>
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
 <20221118011714.70877-9-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118011714.70877-9-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Palmer,

Can you take this patch for v6.2 please, as it kinda just equalises
things for the existing jh7100 stuff? Everyone else can boot defconfig
other than the visionfive v1/beagle v.

Thanks,
Conor.

On Fri, Nov 18, 2022 at 09:17:14AM +0800, Hal Feng wrote:
> Add CONFIG_SERIAL_8250_DW=y, which is a necessary option for
> StarFive JH7110 and JH7100 SoCs to boot with serial ports.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 05fd5fcf24f9..a23d022974ad 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -122,6 +122,7 @@ CONFIG_MICROSEMI_PHY=y
>  CONFIG_INPUT_MOUSEDEV=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_DW=y
>  CONFIG_SERIAL_OF_PLATFORM=y
>  CONFIG_VIRTIO_CONSOLE=y
>  CONFIG_HW_RANDOM=y
> -- 
> 2.38.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
