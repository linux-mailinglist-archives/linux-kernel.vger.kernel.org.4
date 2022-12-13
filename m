Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF564B624
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiLMN1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbiLMN1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:27:24 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C374F19C2C;
        Tue, 13 Dec 2022 05:27:21 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7F00EC000A;
        Tue, 13 Dec 2022 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670938040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BqsUopVXi25NAnceaPj1LcaqQQP8ClUAqCeu3+4ddCA=;
        b=VWHRcYwzPT0AsE2x/qWC4meiq8PCvs4HS2kzTINM0xgQkmFbcK+l1XpJXagzntK4c58muK
        PJcC4xrgPlMgqcodhzeIWSvB1SDHo3mD2PbqEiHUjnmvlAkp7Q3uAfL9cqJcoQEhgnWpjd
        LbV1CTtwXAr/0Lq3hI3ahnNkM1RVwqAJWalx9dnhE7KRm6PCyRg6k8aPQMdqD+Oz6cSDip
        JOfhUItF0fjg2gMRqsHfsGMIHjezx7gaWiBCUIFPd2umQiqBnKq9ynJdJSm9NJVwzRlKqC
        CZYgjtwcSJNuDtSf7Gj2cte2+2xxrtLzisTB30ea/APnOwsbEr61xJd8lc8RGg==
Date:   Tue, 13 Dec 2022 14:27:15 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 8/9] ARM: dts: r9a06g032: Add the USBF controller
 node
Message-ID: <20221213142715.012bdf2d@bootlin.com>
In-Reply-To: <CAMuHMdWHVStUFx61oKWh=YiJ9wfXZaeWEnt2CSRgn3HQe3pQ6w@mail.gmail.com>
References: <20221207162435.1001782-1-herve.codina@bootlin.com>
        <20221207162435.1001782-9-herve.codina@bootlin.com>
        <CAMuHMdWHVStUFx61oKWh=YiJ9wfXZaeWEnt2CSRgn3HQe3pQ6w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-redhat-linux-gnu)
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

Hi Geert,

On Thu, 8 Dec 2022 10:09:01 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Wed, Dec 7, 2022 at 5:25 PM Herve Codina <herve.codina@bootlin.com> wr=
ote:
> > Add the USBF controller available in the r9a06g032 SoC.
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
>=20
> My
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> on v2 is still valid.
>=20

Will be added in v4.

Thanks for the review,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
