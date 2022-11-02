Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D28B615DC6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiKBIdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKBIdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:33:42 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B722224BF9;
        Wed,  2 Nov 2022 01:33:39 -0700 (PDT)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A89D2240009;
        Wed,  2 Nov 2022 08:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667378018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVX8Jh3XQV0EV4EibL1W+dUpdgCRz4sy7pqO+LZhTAM=;
        b=b1y8FFI571ADTewH42OQryEGH1bX/FhLnWaVylK/pt0hFRMqIbTsoalk9RoIl+b6CDy95e
        nmstYW4FIZUp6UlwECxO30AMgDo/DIphksyrswr70I5La6V57hqf9YSKjsTFh6CKHXj5lD
        Wk/tt4kiU+RzOLgCi7mXOM6w4cQMky7SFExAJk/jWnHQwJCHa59s+f3v6EcM/V/1IJenYB
        ITk8DD+id4TK8P0siKIuiaql6O6IaU25Q3DHBNFyqQGxP5u7MiLtktPeVRA8jrck+jVyil
        heZ3IC9eNBNXikVK/ZFMkzygj206if4IuUCJVYBqf9Zbw6PNZQjVS7o7ph3dRw==
Date:   Wed, 2 Nov 2022 09:33:35 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 4/6] clk: spear: Fix CLCD clock definition on SPEAr600
Message-ID: <20221102093335.3a48b426@kmaincent-XPS-13-7390>
In-Reply-To: <20221028002149.A6573C433D6@smtp.kernel.org>
References: <20221019133208.319626-1-kory.maincent@bootlin.com>
        <20221019133208.319626-5-kory.maincent@bootlin.com>
        <20221028002149.A6573C433D6@smtp.kernel.org>
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

Hello Stephan,

On Thu, 27 Oct 2022 17:21:47 -0700
Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting K=C3=B6ry Maincent (2022-10-19 06:32:06)
> > From: Kory Maincent <kory.maincent@bootlin.com>
> >=20
> > There is no SPEAr600 device named "clcd". Instead, the description of t=
he
> > CLCD (color liquid crystal display controller) name is "fc200000.clcd",=
 so
> > we should associate the CLCD gateable clock to this device name.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> Does this need a Fixes tag?

The old commits on SEAr6xx clock names definition update did not have it,
therefore I don't think so.

Regards,
