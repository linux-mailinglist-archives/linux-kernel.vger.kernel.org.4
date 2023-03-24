Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7796C7BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjCXJle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjCXJkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:40:52 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68F228D02;
        Fri, 24 Mar 2023 02:40:29 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1A5F1240009;
        Fri, 24 Mar 2023 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679650826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tfAKNLINoAFCJxtObHpd6qzp3wuoC13J4SnQQo/qL/w=;
        b=mRY6y3KS98Yvv4kQKfT8tHIKiqhJBOAKKJqbtewDvDpralDha4cvXqaVlpj0Lz5amLtCkf
        WtPk2l4noyb4JXkAsUjWu9ETGqgbwpSpgtLnzbiqjuN9uGdPeVDbFIN6F0CanNxopllIay
        IKuxBm1V+mTTGPOhq26e53x3sTSUx4xDX4rG6HcmUifoatmHIf4dlQ56cq82ZytlMQKBXa
        HHBcoO+Mt7DuQWl3odKY/AyzzmMbIxTnWNovkJbg59cB/1k9MnJ4fL+bC418afObE0kz4u
        hsqKgeFLjY+2EB3JQB0PMUoODFJLl8dVbr00znSOG1R3y0+nq0t4JIgm9ZruMw==
Date:   Fri, 24 Mar 2023 10:40:20 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, masonccyang@mxic.com.tw,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mtd: nand: Macronix: document new
 binding
Message-ID: <20230324104020.54754079@xps-13>
In-Reply-To: <20230323124510.2484808-2-noltari@gmail.com>
References: <20230323124510.2484808-1-noltari@gmail.com>
        <20230323124510.2484808-2-noltari@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi =C3=81lvaro,

noltari@gmail.com wrote on Thu, 23 Mar 2023 13:45:09 +0100:

> Add new "mxic,disable-block-protection" binding documentation.
> This binding allows disabling block protection support for those devices =
not
> supporting it.
>=20
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> ---
>  Documentation/devicetree/bindings/mtd/nand-macronix.txt | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/nand-macronix.txt b/Do=
cumentation/devicetree/bindings/mtd/nand-macronix.txt
> index ffab28a2c4d1..03f65ca32cd3 100644
> --- a/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> +++ b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> @@ -16,6 +16,9 @@ in children nodes.
>  Required NAND chip properties in children mode:
>  - randomizer enable: should be "mxic,enable-randomizer-otp"
> =20
> +Optional NAND chip properties in children mode:
> +- block protection disable: should be "mxic,disable-block-protection"
> +

Besides the fact that nowadays we prefer to see binding conversions to
yaml before adding anything, I don't think this will fly.

I'm not sure exactly what "disable block protection" means, we
already have similar properties like "lock" and "secure-regions", not
sure they will fit but I think it's worth checking.

Otherwise, why would you disable the block protection? What does it
mean exactly? I'm not in favor of a Macronix-specific property here.

Thanks,
Miqu=C3=A8l
