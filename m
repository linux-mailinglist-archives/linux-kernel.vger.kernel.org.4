Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E392765756F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiL1Kq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiL1KqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:46:25 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15518DA3;
        Wed, 28 Dec 2022 02:46:23 -0800 (PST)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 256A0100008;
        Wed, 28 Dec 2022 10:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672224381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPhB9YD5mKOaUrJH3XDFS7rFqV5FxdGCchYtk5MvfdE=;
        b=gk9JkWgOOMenYieQG9suTpj/sWfHBXPuyGHmqeqY66hups8+Neu2LVN43A1VAhCQHUFofk
        uG9AqJCE4tB2g/X4CTP2BakPuvtGnG90jIICszUiepR1pcbSK2l582jTUYM61zasFqULXV
        zYOo9SX57Dc1RL5jh5uhU2CaimRU3J5nmXG0c14i58oQ3mNKoROPWc21ACoS/+Uz/0jbte
        xJUe/GIimcX6tRPn1V7yHIjb65w1zpMpOHfAjXVft0iQS17PaWZ2bfCbUUB7sGSGECoyG9
        ms+XQ4sf8ntTeSWqBkLByj+VMb31nU0U/CbaVhvrR6Mq5NHcKId4Vituw1OFeQ==
Date:   Wed, 28 Dec 2022 11:46:17 +0100
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v2 21/21] staging: media: tegra-video: add tegra20
 variant
Message-ID: <20221228114617.397cba35@booty>
In-Reply-To: <44d2d972-1cdf-fdb2-5dc0-cc493f79b3da@gmail.com>
References: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
        <20221128152336.133953-22-luca.ceresoli@bootlin.com>
        <44d2d972-1cdf-fdb2-5dc0-cc493f79b3da@gmail.com>
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

On Fri, 23 Dec 2022 15:35:58 +0300
Dmitry Osipenko <digetx@gmail.com> wrote:

> 28.11.2022 18:23, Luca Ceresoli =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

...

> > +static const struct tegra_vip_ops tegra20_vip_ops =3D {
> > +	.vip_start_streaming =3D tegra20_vip_start_streaming,
> > +};
> > +
> > +const struct tegra_vip_soc tegra20_vip_soc =3D {
> > +	.ops =3D &tegra20_vip_ops,
> > +}; =20
>=20
> Shouldn't this be placed in vip.c?

Indeed. Which means tegra210_csi_soc can be moved as well, so I'm adding
a small patch to the series to do that.

> Also looks like patch #20 won't link
> because tegra20_vip_soc is defined in patch #21.

You're right, we have a chicken-egg problem here. One solution would be
leaving tegra_vip_of_id_table empty in patch 20 and fill it only in
patch 21, but that would not be bisectable as patch 20 would introduce
code that nobody uses until patch 21. So I think it's better to squash
together patches 20+21.

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
