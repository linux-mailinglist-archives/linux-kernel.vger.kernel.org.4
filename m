Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C56B660F68
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjAGORg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjAGORe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:17:34 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E7B4D483;
        Sat,  7 Jan 2023 06:17:32 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C534E1C0003;
        Sat,  7 Jan 2023 14:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673101050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3vSlD9vjCmzG/8rJElMrfdFbS1XrvDaONmQUsaXCWKY=;
        b=Kf2+8JwqCfDZofc4LQX/Nss0zvoyIjOfD4HtDOPTgIkrMThTREIpUk7EN8Xp1JApjr7Gf6
        yg30je3wDF8CzQkbv0xu3KTrN7GMvtgt3LZKzLCEW/QbJvq/BJ5ZD+y8fF1PiVsNWczFgv
        XWNKbjySPTftTVh/fs9k/h1HYKZbMSR9o39T5dbgky4rw2Zg1Trkhu7RkTfhmQ6x8zvYmG
        Rcpx9Mo0F1gTrFO3CKN1JoKocyu/bzOR25dAwj55Wv/SSP5YbmBmAJIgP5NtzyieHR7ool
        r/CgQLx3iyNPAP1+fH2m9+VxzXaJnzXo7+7BEvS4nrrZj+/RQmW2YWqYoJ+y8w==
Date:   Sat, 7 Jan 2023 15:17:22 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>, <arnd@arndb.de>,
        <richard@nod.at>, <krzysztof.kozlowski+dt@linaro.org>,
        <herbert@gondor.apana.org.au>, <robh+dt@kernel.org>,
        <claudiu.beznea@microchip.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <pratyush@kernel.org>, <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] MAINTAINERS: Update email of Tudor Ambarus
Message-ID: <20230107151722.743401bf@xps-13>
In-Reply-To: <20230106164751.7ddaf5c54e0a764344806848@linux-foundation.org>
References: <20221226144043.367706-1-tudor.ambarus@linaro.org>
        <feb09bac-0ea4-9154-362b-6d81cba352a8@linaro.org>
        <678ad800-7a3b-e2bf-6428-f06d696d8edb@linaro.org>
        <20230106165506.0a34fa78@xps-13>
        <f653b23f-cf25-61ec-60d4-91dd7823edd2@microchip.com>
        <20230106164751.7ddaf5c54e0a764344806848@linux-foundation.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas & Andrew,

akpm@linux-foundation.org wrote on Fri, 6 Jan 2023 16:47:51 -0800:

> On Fri, 6 Jan 2023 16:59:52 +0100 Nicolas Ferre <nicolas.ferre@microchip.=
com> wrote:
>=20
> > > Are MAINTAINERS changes accepted through fixes PR? I see a number of
> > > experienced people in Cc:, I would like to hear from you folks, becau=
se
> > > I never had to do that before. If yes, then I'll do it right away,
> > > otherwise I'll apply to mtd/next. I'm all ears :) =20
> >=20
> > I remember a conversation that stated that MAINTAINERS changes must lan=
d=20
> > in Linus' tree the quickest, because it'll just avoid confusion and=20
> > bouncing emails. =20
>=20
> Yes, I always merge MAINTAINERS fixes asap.
>=20
> Probably these fixes should be backported into -stable kernels also -
> we don't want incorrect email addresses in *any* kernel.  But I don't
> do that.

Thanks a lot for your feedback, I'll take care of it.

Cheers,
Miqu=C3=A8l
