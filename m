Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46F16FC07B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjEIHbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjEIHbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:31:38 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FE4210D;
        Tue,  9 May 2023 00:31:35 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BA47D20003;
        Tue,  9 May 2023 07:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683617494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=thBpxMdTvuKvVReNZXCUnuLFIZgJ3012Hq4MQ7xruTE=;
        b=jnrKyy4p05PGCckAgNbRnBNkw0Vhzx7U5n6NKTWD1CHpwFh96TVqS5zeSI56jqu/jOLsKM
        YSHaT5zzQMfuJWUJ27+DS1Q05Qc0W4epsxY4g9goiSTJyY4A+i/PZAKnEDOv1Yu6dvalsQ
        KGTzAfQZGyW0Tv1TmCw0SAF3mafX5ralBv7hlYtLovCdcZDYF2ULz1SJuRihe9ex/DOhe0
        BcU4cEA6oyambZ1C9x1t+OAcgl8Lcc1eVA3oqGsLFxlgI5UG2jPXu4Cy0EQxWKqXhOWr89
        3RIYcFYDNpFXJMCJw43QW44yQK+WSRjvIQDXERbH7DT7bFQpoTQa1T5sN45Lfg==
Date:   Tue, 9 May 2023 09:31:29 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFm?= =?UTF-8?B?YcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] Add SEAMA partition types
Message-ID: <20230509093129.40b30c7a@xps-13>
In-Reply-To: <20230506-seama-partitions-v1-0-5806af1e4ac7@linaro.org>
References: <20230506-seama-partitions-v1-0-5806af1e4ac7@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

linus.walleij@linaro.org wrote on Sat, 06 May 2023 17:29:43 +0200:

> This type of firmware partition appear in some devices in
> NAND flash, so we need to be able to tag the partitions
> with the appropriate type.
>=20
> The origin of the "SEAttle iMAge" is unknown.

I don't see any kernel changes, why do we need an additional binding?

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Linus Walleij (2):
>       dt-bindings: mtd: Add SEAMA partition bindings
>       ARM: dts: bcm5301x: Add SEAMA compatibles
>=20
>  .../devicetree/bindings/mtd/partitions/seama.yaml  | 50 ++++++++++++++++=
++++++
>  arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |  1 +
>  arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts      |  1 +
>  3 files changed, 52 insertions(+)
> ---
> base-commit: caad71e7d226920623d78be2e6283516decdc502
> change-id: 20230506-seama-partitions-b620117b9985
>=20
> Best regards,


Thanks,
Miqu=C3=A8l
