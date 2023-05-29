Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C539A714F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjE2SJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjE2SJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:09:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4176BB0;
        Mon, 29 May 2023 11:09:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA8406164F;
        Mon, 29 May 2023 18:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528D4C433D2;
        Mon, 29 May 2023 18:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685383785;
        bh=DZwkSxqH5CA99S8iqAdJKK2KtULg6w6mwM5CbYx50+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wypd7QbAHP5aWGDsT0+pYJw4ca0lkr/ETXW+8/dL2nscR6Leu55fFFXNzYU0GBdgL
         OBbRjwoHvXx5iXZ5g1eodZ3vrdFRQHWugbH6J6MxzJnBuVzAElZEOsEYFReYDI1HHC
         Yvf1jtsnUJRcjWTYSPoK124f4SavfHfaxvz9PxF7Qd7x3hweTCJ/ZvOn5a4vlyxLzL
         PhHpkv3XWBW5TjA8WItzhgKmprONIuwPIMDo4I4iWAuUYQpvExrKgouw1ECe7IVD+h
         L00TXI877V4oxxzrP9kMFplj9bv+UikV9DRkriE8ubEM51hdD3en4F/l28mavBWTGp
         gQCkAIhfCUBkQ==
Date:   Mon, 29 May 2023 19:09:39 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v4 6/9] dt-bindings: sc16is7xx: Add property to change
 GPIO function
Message-ID: <20230529-florist-hardiness-be5de59e660c@spud>
References: <20230529140711.896830-1-hugo@hugovil.com>
 <20230529140711.896830-7-hugo@hugovil.com>
 <20230529-seventy-stash-0446d9ae02e8@wendy>
 <20230529102601.144e17eccefaedc891e76f3a@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3m/oGbX7oIKrh9f/"
Content-Disposition: inline
In-Reply-To: <20230529102601.144e17eccefaedc891e76f3a@hugovil.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3m/oGbX7oIKrh9f/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 10:26:01AM -0400, Hugo Villeneuve wrote:
> On Mon, 29 May 2023 15:16:47 +0100
> Conor Dooley <conor.dooley@microchip.com> wrote:
>=20
> > Hey Hugo,
> >=20
> > On Mon, May 29, 2023 at 10:07:08AM -0400, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > >=20
> > > Some variants in this series of UART controllers have GPIO pins that
> > > are shared between GPIO and modem control lines.
> > >=20
> > > The pin mux mode (GPIO or modem control lines) can be set for each
> > > ports (channels) supported by the variant.
> > >=20
> > > This adds a property to the device tree to set the GPIO pin mux to
> > > modem control lines on selected ports if needed.
> > >=20
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >=20
> > Did I not ack this in v2? I didn't notice a reason for dropping it
> > in the cover etc. Was it intentionally dropped, or missed?

> In v3, I slighly modified the example, and that is why I didn't copy your=
 ack.

Ah, I would say that for "slight modifications" when you have an ack,
you could keep it - but everyone is different and dropping tags is
likely to piss people off less than keeping them, so I understand
sticking on the safe side.


--3m/oGbX7oIKrh9f/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHTqYwAKCRB4tDGHoIJi
0iT6AP9Q185i0OxcOD7GLWmxswpaTvHOufcQOLOWg93VAMiGFAEAuhzLQA7nbEQ5
Qy+7aOMjI25GLgVmTTGqeAXe2EtCGwM=
=7KVg
-----END PGP SIGNATURE-----

--3m/oGbX7oIKrh9f/--
