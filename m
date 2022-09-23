Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0565E7E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiIWPPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiIWPOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:14:51 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F09B1E716;
        Fri, 23 Sep 2022 08:14:48 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C71D160007;
        Fri, 23 Sep 2022 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663946087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ob5PFOzdCFY5TAnwDP04gVYnRYdPCIJhW9s//Qw4b6k=;
        b=cYpi/4PiTwtuw/I797QTNFhQ51cU/29JchvcZFKbNsyiZJjXzEqAFmkUn9Ow6xYgDADFPH
        WsgPnhaCB67IWB1mQHJoPiUFd7HVJsx2shvDJ0MUAX5Ak6XWKkaPIvFa1UjTB2C/cVlDE2
        rHr8NblQwkUc26+d0gIZ8Nh7T25s0mdWnHMobHu6sq7d7hPoFjGNiwOXmb8AvVoI/tA/j4
        CfmIC6kQpNNVi//snzKyaFjejjdblF9MYyPA7jO5Nn5KvF1pYetmK7bV6sGqh+nxpVKCwh
        1frZmkuK5Rdm4ldlepQdc8iXm+B8AmWmETm5eZd75WFn2j7NLzDYK5llvtE09A==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marcin Wojtas <mw@semihalf.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] ARM: mvebu: Add audio support for Armada 38x
In-Reply-To: <20220920132648.2008-1-pali@kernel.org>
References: <20220920132648.2008-1-pali@kernel.org>
Date:   Fri, 23 Sep 2022 16:14:44 +0100
Message-ID: <87mtaqxguz.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> This patch series add audio support for Armada 38x. It contains commits
> from Marvell linux repository
>
> https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/a1d7044=
4cb0476a7524273274ca8e6d52ce6f1fe
> https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/f365c93=
237787c7a64f2617da9425eb01e09e71f
> https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/b645bfa=
9121214d6456de3df6b8e577f2c01c6b3
> https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/829c96c=
206f2930e5323064cef57158bd780730d
>
> first two squashed, rebased on top of the current linux master branch
> (at v6.0-rc6) with additional patches which adds S/PDIF support on
> Turris Omnia - A385 board.
>
> Marcin Wojtas (3):
>   ASoC: kirkwood: enable Kirkwood driver for Armada 38x platforms
>   ARM: mvebu: add audio I2S controller to Armada 38x Device Tree
>   ARM: mvebu: add audio support to Armada 385 DB
>
> Pali Roh=C3=A1r (2):
>   ARM: mvebu: Add spdif-pins mpp pins for Armada 38x
>   ARM: dts: turris-omnia: Define S/PDIF audio card
>

Patches 2 to 5 applied on mvebu/dt

The first one has to be applied in sound subsystem.

Thanks,

Gregory


>  .../devicetree/bindings/sound/mvebu-audio.txt |  14 +-
>  arch/arm/boot/dts/armada-385-turris-omnia.dts |  27 ++++
>  arch/arm/boot/dts/armada-388-db.dts           |  69 +++++++++
>  arch/arm/boot/dts/armada-38x.dtsi             |  24 ++++
>  sound/soc/kirkwood/kirkwood-i2s.c             | 136 +++++++++++++++++-
>  sound/soc/kirkwood/kirkwood.h                 |   2 +
>  6 files changed, 269 insertions(+), 3 deletions(-)
>
> --=20
> 2.20.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
