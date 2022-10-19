Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CFD604088
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiJSKD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiJSKDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:03:12 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400EDF4186;
        Wed, 19 Oct 2022 02:41:20 -0700 (PDT)
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 51A7BC899A;
        Wed, 19 Oct 2022 08:47:41 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7920E240004;
        Wed, 19 Oct 2022 08:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666169221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yHd14eyO9S7G2ilSa3qdTym8TxwadiwTy0QqUCJBV/I=;
        b=DTgQRNrnscX6K3pU2U5UQQzepwSB916+cYk3PtilU6VMpEE3pZ0B9eVhvmHeQinntXOKSE
        yVW58xUkYAHyUHea6rKKHI+iRdwGi1+kJzouUe8phKkR23STURgE0GsRziRvYGbSMy7lY7
        KFWDRQoXXt64KLOqfxsPZWqzFlZ0S+eN3q+gDKoNZsTJAuhi55boZ8v5m58+WdyKt2ukWr
        kU7+l4SuGRTMFo0qYn26X+ep6n42n/iILUA6LA/Zk4fYwOw3NOgU6TlUWT4IsV375TcWSe
        o9Oi8K2l+j1keCquOfaE+seab3m99G1zX4fxMPxQ50UupULqm2b6+TkdlMC1zQ==
Date:   Wed, 19 Oct 2022 10:46:54 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Aviram Dali <aviramd@marvell.com>
Subject: Re: [PATCH 2/3] dt-bindings: mtd: Add AC5 specific binding
Message-ID: <20221019104654.7ee35744@xps-13>
In-Reply-To: <20221019082046.30160-3-vadym.kochan@plvision.eu>
References: <20221019082046.30160-1-vadym.kochan@plvision.eu>
        <20221019082046.30160-3-vadym.kochan@plvision.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vadym,

vadym.kochan@plvision.eu wrote on Wed, 19 Oct 2022 11:20:39 +0300:

> From: Aviram Dali <aviramd@marvell.com>
>=20
> Add binding for AC5 SoC which have its special way of handing
> NAND layout.
>=20
> Signed-off-by: Aviram Dali <aviramd@marvell.com>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>  Documentation/devicetree/bindings/mtd/marvell-nand.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/marvell-nand.txt b/Doc=
umentation/devicetree/bindings/mtd/marvell-nand.txt
> index a2d9a0f2b683..293551ec7350 100644
> --- a/Documentation/devicetree/bindings/mtd/marvell-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/marvell-nand.txt
> @@ -2,6 +2,7 @@ Marvell NAND Flash Controller (NFC)
> =20
>  Required properties:
>  - compatible: can be one of the following:
> +    * "marvell,ac5-nand-controller"
>      * "marvell,armada-8k-nand-controller"
>      * "marvell,armada370-nand-controller"
>      * "marvell,pxa3xx-nand-controller"

Could you please do the yaml conversion first?

Thanks,
Miqu=C3=A8l
