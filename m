Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37D25ECF64
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiI0VjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI0VjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:39:22 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277DB107DC2;
        Tue, 27 Sep 2022 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=DPYju4UlrsNG5SoXMWeppqqTGHjGy6TmKutDfna9o1U=; b=CNJUM2005XPaqlP9SugZU2blwO
        NZi2KpZqaG8DT8fSrD20aOas6nr2FdSN3QpeRZzI9rEOwtDRoTru7EoERB4Z2R5mQXhrAf4AyPZOD
        LRofPE50ju7Dj6kV7a51ijmnOeSclMi1cD/DK6bgQIcFSGEmWwRzYb14DMCTfyxUxD3PSxVrWmmVt
        RCCWAXxO9kVhswg7xu8iZtoOSqVqk3fMrt0uK1E36CIxp9QNNtQwYaRdTp5QC1VFH1NA1N8zzAg6H
        dpUQm7OPhuv6jHzSaI0QeRs3zh+ft2K2kBjsIX+3RdqxxSWrCQlEaYGMXiQZ6or1/ioX6mtULcAOl
        ySBNfN/Q==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1odIIP-00C1hU-ME; Tue, 27 Sep 2022 23:39:17 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1odIIP-000VSG-0F;
        Tue, 27 Sep 2022 23:39:17 +0200
Date:   Tue, 27 Sep 2022 23:39:17 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Lin Jinhan <troy.lin@rock-chips.com>, wevsty <ty@wevs.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lin Huang <hl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] hw_random: rockchip: import driver from vendor tree
Message-ID: <YzNthZ0MtfwjIqdH@aurel32.net>
Mail-Followup-To: LABBE Corentin <clabbe@baylibre.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Lin Jinhan <troy.lin@rock-chips.com>, wevsty <ty@wevs.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, Lin Huang <hl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org
References: <20220919210025.2376254-1-Jason@zx2c4.com>
 <32f8797a-4b65-69df-ee8e-7891a6b4f1af@arm.com>
 <YzMm4d3sZBHpitm9@aurel32.net>
 <YzNTB+RQK6yITi7/@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YzNTB+RQK6yITi7/@Red>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-27 21:46, LABBE Corentin wrote:
> Le Tue, Sep 27, 2022 at 06:37:53PM +0200, Aurelien Jarno a =C3=A9crit :
> > On 2022-09-20 10:35, Robin Murphy wrote:
> > > On 2022-09-19 22:00, Jason A. Donenfeld wrote:
> > > > The Rockchip driver has long existed out of tree, but not upstream.
> > > > There is support for it upstream in u-boot, but not in Linux proper.
> > > > This commit imports the GPLv2 driver written by Lin Jinhan, together
> > > > with the DTS and config blobs from Wevsty.
> > >=20
> > > Note that Corentin has a series enabling the full crypto driver for=
=20
> > > RK3328 and RK3399[1], so it would seem more sensible to add TRNG supp=
ort=20
> > > to that. Having confliciting compatibles for the same hardware that=
=20
> > > force the user to change their DT to choose one functionality or the=
=20
> > > other isn't good (plus there's also no binding for this one).
> >=20
> > It might make sense for the cryptov1-rng driver (I haven't checked). For
> > the cryptov2-rng driver, I looked at the RK3568 TRM (I can't find the
> > RK3588 one), and from what I understand crypto and TRNG are two
> > different devices, using different address spaces, clock, reset and
> > interrupts. The vendor kernel uses two different drivers.
> >=20
>=20
> I confirm that TRNG is not on the same IP on rk3568, something I didnt re=
mark when doing my V2 driver. (I need to remove rng clock from rk3568 dt).
> But the rk3588 crypto IP and the TRNG are in the same device.

Ok, thanks for confirming about the rk3568. It seems the only one in the
family with separate devices for TRNG and crypto. Does it means we need
a separate TRNG driver only for it? Or could we handle it the same way
than for instance rk3588 anyway?

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
