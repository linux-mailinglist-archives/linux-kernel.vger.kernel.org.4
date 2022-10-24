Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A547060B3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiJXRVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiJXRUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:20:51 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8679F9867;
        Mon, 24 Oct 2022 08:55:47 -0700 (PDT)
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id C9041CA977;
        Mon, 24 Oct 2022 15:45:19 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3D64A2000C;
        Mon, 24 Oct 2022 15:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666626232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uBuQRJf5o8jnwEhp0sljdhub5NXushkq7FT9EjADBvU=;
        b=aVntb3TlCW6S4JwPnqJRR7r3sIB4XX/ka0RnW9LdenHniwPyzKjD5jjvD66L057kvFlBSq
        tlscpxmwH3B14MUT0b7GVz+fb2yRpqQzALBM/O7W8Bo82Wy46yiOz0oWDF8lC3crBNqY2b
        dFp/cDudIDZkXYCtxK9KJajIBNcc2xjrP99GFs3jbFz5s5w7Ap2NxYwNUqCv8BzazhC5Qj
        V+4/yuROUE7mU8AsflDr+WdqQaTpKL+kwYimIl4yyw44Nn15S7cUFYCR9xEQTGjI6A153r
        txlxz5/ry1TC1ef4GLQ12hnSVZmCZHd2B+oZWu+aSuezJbyyvuKq9KYHLfKVNw==
Date:   Mon, 24 Oct 2022 17:43:49 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Message-ID: <20221024174349.756ed154@xps-13>
In-Reply-To: <VI1P190MB03171976C0A5F4BEA804FD87952E9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
References: <20221022082628.23876-1-vadym.kochan@plvision.eu>
        <20221022082628.23876-2-vadym.kochan@plvision.eu>
        <5ef70149-5079-173f-ab6a-a9f0cc01f281@linaro.org>
        <VI1P190MB03171976C0A5F4BEA804FD87952E9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
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

vadym.kochan@plvision.eu wrote on Mon, 24 Oct 2022 17:08:14 +0300:

> Hi Krzysztof,
>=20
> On Sat, 22 Oct 2022 12:21:07 -0400, Krzysztof Kozlowski <krzysztof.kozlow=
ski@linaro.org> wrote:
> > On 22/10/2022 04:26, Vadym Kochan wrote: =20
> > > Switch the DT binding to a YAML schema to enable the DT validation.
> > >=20
> > > Dropped deprecated compatibles and properties described in txt file.
> > >=20
> > > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > > ---
> > > v2:
> > >   1) Fixed warning by yamllint with incorrect indentation for compati=
ble list =20
> >=20
> > I guess all my comments from v1 apply.
> >=20
> > Did you test the bindings? =20
>=20
> Sure, I tested it for arm and arm64, thanks for the comments
> I will fix them.

I believe Krzysztof meant with `make dt_binding_check`, and I guess he
detected errors when doing so on his side.

Thanks,
Miqu=C3=A8l
