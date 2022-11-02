Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B50615DB4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiKBIct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKBIcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:32:46 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933C9240AF;
        Wed,  2 Nov 2022 01:32:45 -0700 (PDT)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 58A321C0013;
        Wed,  2 Nov 2022 08:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667377964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3dtpyVTwPgQUnhehX8zqlud+7lGgjvApwXe9PW42hFE=;
        b=MseqCRQ+bWc0HZ2fTFw7uqZi3ih9tn/l7q3Mg6It2MnCcR3n7g6VDbOImxgZAXIQmJ3/1m
        oDLwTxDt9DdN9HgWXJ/hgQ/WK1LmpsuqhLTKhztUENfsJPq5UEMPCD2pBMLkpzStwbiGbB
        YsB4L1Jd1Z3MLEmh3DVFBand9uWvNVqK9q9JIcUrBM2bBzPaMcZyrNd7QCa8asyaGoWEYe
        9waTZwbpKvk0sqaqBkX5E4ACek/7nEQG0d06fwBUw8sM6Wpo82K8ihUO0uaZ3WOaHQCFIS
        UCkv9nlCvLDjcdFSU4wZ852YyRBeTsp9EsRQvee/EfTKafgYaKTURsjD5N8dCg==
Date:   Wed, 2 Nov 2022 09:32:40 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 6/6] clk: spear: Fix SSP clock definition on SPEAr600
Message-ID: <20221102093240.62225991@kmaincent-XPS-13-7390>
In-Reply-To: <20221028002219.6AEEEC43470@smtp.kernel.org>
References: <20221019133208.319626-1-kory.maincent@bootlin.com>
        <20221019133208.319626-7-kory.maincent@bootlin.com>
        <20221028002219.6AEEEC43470@smtp.kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
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

Hello Stephen,

On Thu, 27 Oct 2022 17:22:17 -0700
Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting K=C3=B6ry Maincent (2022-10-19 06:32:08)
> > From: Kory Maincent <kory.maincent@bootlin.com>
> >=20
> > There is no SPEAr600 device named "ssp-pl022.x". Instead, the descripti=
on
> > of the SSP (Synchronous Serial Port) was recently added to the Device T=
ree,
> > and the device name is "xxx.spi", so we should associate the SSP gateab=
le
> > clock to these device names.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> Does this need a Fixes tag?

The old commits on SEAr6xx clock names definition update did not have it,
therefore I don't think so.

Regards,
