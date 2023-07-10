Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2558174D250
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjGJJws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjGJJvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:51:51 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E35710CB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:49:08 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 13A261C0009;
        Mon, 10 Jul 2023 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688982546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=esbaZstYUmTKpbeA0NmlrMUg8K32jAHi3MEtkOjE08c=;
        b=cvB0hda8puFMHWP2kwb9SNZVdlQIEm//XyiVMeeLZBykMpC2VM7jc6hClcq5b7W+I1vQDC
        I3TK32b2z6wDYGDujfyEHYf31uCA89mATLeUo7lwLt56AKJ6Xhy8TpAaCOk0wY90dWscWv
        gy+sWs/SKhPYtgP4kVIyLz1/1OIh2ywGgzmWTwUXQU4NW/kIq8Hy6A+PfJLMErT7C7hX/F
        P/RbrXIWz06mid+SHtQdCcPoRuylKyVM85rqZ4ZXFwQLVyJ1zVAiHUKMurxR/Wg7Uz/s4+
        GcjFABZuJLwzBLNlZLoYlZ7Or0mhSymTZbmLn/Lj1JsVr8QeXb/eOVLKuThVcw==
Date:   Mon, 10 Jul 2023 11:49:03 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     vigneshr@ti.com, richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as reviewer for HYPERBUS
Message-ID: <20230710114903.352bc12d@xps-13>
In-Reply-To: <20230622102836.2be2ab1b@xps-13>
References: <20230620025359.33839-1-tudor.ambarus@linaro.org>
        <20230622102836.2be2ab1b@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


miquel.raynal@bootlin.com wrote on Thu, 22 Jun 2023 10:28:57 +0200:

> Hi Vignesh,
>=20
> tudor.ambarus@linaro.org wrote on Tue, 20 Jun 2023 05:53:59 +0300:
>=20
> > Add myself as Designated Reviewer for Hyperbus support.
> > I'm assessing the framework and I'd like to get involved
> > in reviewing further patches. =20
>=20
> Vignesh, any chance you could give feedback on this patch quickly? I'd
> like to take it for the next PR if you agree.

I'm surprised there is still no feedback after 3 weeks, I haven't heard
from him at all since a while.

Vignesh, are you still around?

Thanks,
Miqu=C3=A8l

> > Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6992b7cc7095..df5c039fc577 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9623,6 +9623,7 @@ F:	tools/hv/
> > =20
> >  HYPERBUS SUPPORT
> >  M:	Vignesh Raghavendra <vigneshr@ti.com>
> > +R:	Tudor Ambarus <tudor.ambarus@linaro.org>
> >  L:	linux-mtd@lists.infradead.org
> >  S:	Supported
> >  Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/ =20
>=20
>=20
> Thanks,
> Miqu=C3=A8l

