Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33183636B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbiKWUtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbiKWUtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:49:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467D26C72C;
        Wed, 23 Nov 2022 12:49:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC0EA61F0F;
        Wed, 23 Nov 2022 20:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE71C433C1;
        Wed, 23 Nov 2022 20:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669236555;
        bh=zhAO3YZEgtsjDcAYaBQkQ0qOKaBzRKJDU31uqjYHdfg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VTt8eJ9W5dgiW9v1VRM9XlXRxoPrs3ngI9nfJi5+STVAhATYsaoyO+DSK0fST7AvZ
         m+45pjUZgI7ezOvJjuKahoJmSF7rjhix4UHXQMIhgE8pDcel1ddsInpeBb4nlgZa8A
         NzOnsQ8+0BEOMzwKk4/K3X6V0blkR3+4grUnBXp2nFppHVxjE2U75Tp38bPF2DDrL6
         wdfuv0wZEYiXklzcjUFpJefhy/cS80zTggApHtkI+PVSRQph+ZO12+Lc5seJ8juou3
         LtPkKYnLh3wwVvgdwNZS1xvDLF6FrGuEuGqFTZ/Fez5Y4xpsawMyjjuF3qwN66g65Z
         ohqndyx/2v+gg==
Date:   Wed, 23 Nov 2022 21:01:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: renesas,rzg2l-adc: Document
 RZ/Five SoC
Message-ID: <20221123210147.0bf34345@jic23-huawei>
In-Reply-To: <166863468321.1016692.3662033617872440170.robh@kernel.org>
References: <20221115124128.1183144-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
        <166863468321.1016692.3662033617872440170.robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 15:38:03 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, 15 Nov 2022 12:41:28 +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > 
> > The ADC block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> > SoC. "renesas,r9a07g043-adc" compatible string will be used on the RZ/Five
> > SoC so to make this clear, update the comment to include RZ/Five SoC.
> > 
> > No driver changes are required as generic compatible string
> > "renesas,rzg2l-adc" will be used as a fallback on RZ/Five SoC.
> > 
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml          | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >   
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied. Thanks,
