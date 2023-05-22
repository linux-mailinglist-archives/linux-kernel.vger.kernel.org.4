Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D8B70C168
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjEVOqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjEVOqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:46:06 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADA7C1;
        Mon, 22 May 2023 07:46:02 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 20DC740005;
        Mon, 22 May 2023 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684766761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z97QcL8z6xmYm5A3uwe7N+++cwdw3dgMa47oOZgJgFY=;
        b=JSYBgD0ta/vb/ROv8mvsU1g5Q8TvFe+e6a8P1dtEiUimRU8tQah0BBCMqwBfyBEC1jJCgD
        oHXyqQapKb6113Rj4Of9hjzDBFcSeSJMz7Ykq7Jfhz4ZoVr5y6wZ7FYrQJNKlQzvseGJue
        AJzyJ2OMmpnBICe74whOC0BVHTRJWvyUOUKM3xI/TVt4+53kotxasumgwnVOcgHKpmDjwT
        osWIQG5m7JYj7hpSF53+bPqcHwIQj7doy/U+hGhzPc1Zbco1Lf1nemCrfc41l4ptlXB7o8
        WO+5HZPwKGUH7j9UkJKX2HVOAulsXzMGdQhRpR5DQE+h55bDrT2hDm4FpfJ/sw==
Date:   Mon, 22 May 2023 16:45:59 +0200
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
Message-ID: <20230522164559.6c599c61@xps-13>
In-Reply-To: <CACRpkdYLZ36Ad5y7qLUTFix6yx=jBQ=ZvxaB9U-fhqQ_fvvXCQ@mail.gmail.com>
References: <20230506-seama-partitions-v1-0-5806af1e4ac7@linaro.org>
        <20230509093129.40b30c7a@xps-13>
        <CACRpkdYLZ36Ad5y7qLUTFix6yx=jBQ=ZvxaB9U-fhqQ_fvvXCQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

linus.walleij@linaro.org wrote on Tue, 9 May 2023 20:30:33 +0200:

> On Tue, May 9, 2023 at 9:31=E2=80=AFAM Miquel Raynal <miquel.raynal@bootl=
in.com> wrote:
> > linus.walleij@linaro.org wrote on Sat, 06 May 2023 17:29:43 +0200:
> > =20
> > > This type of firmware partition appear in some devices in
> > > NAND flash, so we need to be able to tag the partitions
> > > with the appropriate type.
> > >
> > > The origin of the "SEAttle iMAge" is unknown. =20
> >
> > I don't see any kernel changes, why do we need an additional binding? =
=20
>=20
> The bindings are not strictly bound to Linux, it's more like all OS:es
> uses the Linux DT binding repo because it is the biggest project.

Yes, that's why I wanted more context :-)

> Also we actually merge a bunch of bindings just to describe hardware
> (or things like partitions), in the hope of making use of them in the
> long run.

It's always problematic to do it this way because no user =3D=3D no precise
requirement. As binding are supposed to remain stable, and because we,
human are far from perfect when it comes to read the future, I of
course prefer when there is an implementation that uses the new binding
so we can more easily spot the issues.

> Anyways, for the record, the full story:
>=20
> Currently this binding is used in out-of-tree OpenWrt code, where it
> is used as magic for splitting partitions with mtdsplit.
>=20
> I guess you might be familiar with mtdsplit. It is a software partition
> splitter that makes it possible to split a big partition into smaller
> partitions dynamically, using magic block identifiers.
>=20
> The typical usecase is to put the kernel in the first flash blocks,
> then pad up to the nearest even erase block, and then add a
> JFFS2 or UBI filesystem immediately there.
>=20
> This way it avoids using static partitioning, the tools rebuilding the
> firmware can dynamically split off more flash as the kernel image
> grows.
>=20
> The mtdsplit code uses different magic numbers to identify where
> the different partitions start.

Is mtdsplit acting on a device or on a partition? Right now you define
a partition to be compatible with seama, I would have imagined the
partitions container should be compatible with seama instead of
fixed-partitions, but I haven't looked at the whole implementation, so
maybe my comment is just wrong.

> One such type of partition is seama, so the code needs to know
> that it should look for seama magic to determine the size and
> split this partition in a kernel and rootfs part. This is the code:
> https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dtree;f=3Dtarget/linu=
x/generic/files/drivers/mtd/mtdsplit;h=3D3e0df856713a84b1decf17190f171cb10c=
e7a757;hb=3DHEAD

That's very informative, thanks for all the context. I believe this
could actually be part of the binding description (not the "this is an
openWRT stuff", of course).

> It is a bit sad that no-one has the energy to propose mtdsplit
> upstream, I think it is quite generic and generally useful. I started
> to make an upstream patch but got exhausted with the task.

:-)

Thanks,
Miqu=C3=A8l
