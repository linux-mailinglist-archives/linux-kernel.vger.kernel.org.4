Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3011619DD7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiKDQxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiKDQwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:52:37 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A243E092;
        Fri,  4 Nov 2022 09:51:46 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2389EE0006;
        Fri,  4 Nov 2022 16:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667580705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2TpV1GkI8zGQR6JKfyw/HdeFrbBiylvnAQB2Uw3mqNs=;
        b=WMLsC7SmXuJmoX0RIhZMa9MCjLX40bblUGF4D7yA8RKM5cAoPU9S7JuH8Ell4gOlE+BIOC
        POakrWGAPj5Jz5EW77NkUuBT8fVp8CWifEqC5ye9D69d4BD22xvUx4dSM9p+2FIMu18VJY
        749sh98b0COmXUKQQ79jZ30UhX6lbui4nWkglF+VdSw9gro8qygHy1ldlJfANPgsfe2V6p
        vFL+GMadFXsFB08z1OpXFyyWnj5VVUvFav8jz+cn3CX86ae+NihEQOzo5kjSUlNeARW+J1
        LW021OsOeZWQxZipUUCtsMWGaQ1GvmOkd2Nz8bK9vOLTKHfwwUDztmPyxK+yiQ==
Date:   Fri, 4 Nov 2022 17:51:42 +0100
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
        Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v5 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Message-ID: <20221104175142.5ca2f132@xps-13>
In-Reply-To: <VI1P190MB0317E5C8AD323A8D1A4B5D8195379@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
References: <20221026134545.7146-1-vadym.kochan@plvision.eu>
        <20221026134545.7146-2-vadym.kochan@plvision.eu>
        <33f04b06-dc00-b7ce-6a24-2282608b40dc@linaro.org>
        <VI1P190MB0317C739E2D39427CD2A771D95309@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <10581088-e4ff-76db-3c9b-42a7a9c118ee@linaro.org>
        <20221027151825.166a9255@xps-13>
        <e937b059-4168-3bd4-b294-cbfff0519d1f@linaro.org>
        <20221027155025.7c04774a@xps-13>
        <683dffbc-744f-80cd-2262-b6deb4200ccc@linaro.org>
        <20221028094740.3c11f52b@xps-13>
        <a98f00bd-013a-a1ce-0054-bbceeaefcefa@linaro.org>
        <20221028145049.76db792f@xps-13>
        <VI1P190MB0317E5C8AD323A8D1A4B5D8195379@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
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

Hi Vadym,

vadym.kochan@plvision.eu wrote on Mon, 31 Oct 2022 14:29:22 +0200:

> Hi Krzysztof, Miquel,
>=20
> On Fri, 28 Oct 2022 14:50:49 +0200, Miquel Raynal <miquel.raynal@bootlin.=
com> wrote:
> > Hi Krzysztof,
> >  =20
>=20
> [snip]
>=20
> For me it looks like the "label" and "partitions" can be dropped from thi=
s series,
> so in the future they can be handled by the common mtd-related yaml ?

I am currently working on this, see below. This series has not yet been
accepted but I believe you can rebase your work on top of it. Please be
sure your reference the right yaml files and do not redefine generic
properties (from mtd.yaml, nand-controller.yaml or nand-chip.yaml).

Link: https://lore.kernel.org/linux-mtd/20221104164718.1290859-1-miquel.ray=
nal@bootlin.com/T/#mf2a94fa36b4760b29269c5b94a7dfcb533c8cafe

Thanks,
Miqu=C3=A8l
