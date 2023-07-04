Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5F7747898
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 21:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjGDTOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 15:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjGDTOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 15:14:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42E610D5;
        Tue,  4 Jul 2023 12:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28D3661348;
        Tue,  4 Jul 2023 19:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEA2C433C8;
        Tue,  4 Jul 2023 19:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688498057;
        bh=774aSqho5oCbt5eD+KXB3aukhvZSsdRso4l6bcpL69k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcoONUGGc2ahSTNq9xiKhhd8ppl7hhbCGCWSPF8Z8G2rZY/zePt28kCq42/Jonmto
         qdigjrE3jEVWuHtHZ84YUpVx/tDbRSvseCVFe1MSBfHXRKe5B/d8OXLx+9Z4emvbYa
         srhWBskW4AlkHH7hXb7qz02gHISop8/bZOrq+T6BXYApZkJmvUiakSRnctjPMiqXKo
         PwkOXDorzAISgnf0C06+utAnzQeqIMXt7fjlDowk5+lKl5RskGdr++J3KLXtVftqgF
         Wf4np0rT2pT+H13phzgUK4ByKb4WZhse8qT3uUI1kCFKvxjqKcPl7/YyUNdYH2CwD0
         OnV4/Mg/qIkZQ==
Date:   Tue, 4 Jul 2023 20:14:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, jbrunet@baylibre.com,
        jirislaby@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, kelvin.zhang@amlogic.com,
        xianwei.zhao@amlogic.com, kernel@sberdevices.ru,
        rockosov@gmail.com, linux-amlogic@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 3/5] tty: serial: meson: apply ttyS devname instead of
 ttyAML for new SoCs
Message-ID: <20230704-goofiness-maximum-a964d2fd0dcd@spud>
References: <20230704135936.14697-1-ddrokosov@sberdevices.ru>
 <20230704135936.14697-4-ddrokosov@sberdevices.ru>
 <20230704-pogo-zeppelin-5fa281f5c9e6@spud>
 <20230704171326.tyforkt7z23zmgqa@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Tecr9VZAi6Q825ui"
Content-Disposition: inline
In-Reply-To: <20230704171326.tyforkt7z23zmgqa@CAB-WSD-L081021>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Tecr9VZAi6Q825ui
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 08:13:26PM +0300, Dmitry Rokosov wrote:
> On Tue, Jul 04, 2023 at 05:57:15PM +0100, Conor Dooley wrote:
> > On Tue, Jul 04, 2023 at 04:59:34PM +0300, Dmitry Rokosov wrote:
> > > It is worth noting that the devname ttyS is a widely recognized tty n=
ame
> > > and is commonly used by many uart device drivers. Given the establish=
ed
> > > usage and compatibility concerns, it may not be feasible to change the
> > > devname for older SoCs. However, for new definitions, it is acceptable
> > > and even recommended to use a new devname to help ensure clarity and
> > > avoid any potential conflicts on lower or upper software levels.
> >=20
> > > In
> > > addition, modify the meson_uart_dt match data for g12a, a1, and s4 to
> > > their appropriate values to ensure proper devname values and
> > > functionality.
> >=20
> > IMO, this is a separate change that should be in another patch, had to
> > go looking through a several of unrelated $subject patches to understand
> > how the binding patch was going to work.
>=20
> I apologize, but I'm having difficulty understanding your suggestion.
> Are you recommending that a distinct binding patch for meson-uart-a1 be
> sent as part of a separate patch series? From my perspective, isolating
> the binding patch may not provide all the necessary context as it is
> reliant on a separate 'compatible' declaration within the meson-uart
> driver. However, this declaration is interconnected with the devname
> support patchset. Therefore, it seems that all of these patches are
> linked together.

Maybe it is just a case of how the commit message was written, where the
SoCs responsible for the changes appear only "in addition". At the
moment, it seemed like an unrelated addition that was sneaking into the
commit to me, who was trying to find the code change that made the DT
side of things valid,

Re-phrasing the commit message to explain that the a1 is the reason for
this change, rather than mentioning the SoCs as an apparent afterthought
would make sense to me here. As would splitting reworking the code to
support devname stuff in one commit & adding the new match for the a1 in
another. Whatever works for you.

--Tecr9VZAi6Q825ui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKRvgwAKCRB4tDGHoIJi
0hkeAP9Lzm0lKzEJQ3nWw1mwEopF3oZdVmvGVOFiRIQgcx/mqAEAvkAFRCWE9JpX
UsLys1kHTzKs1mYt4FxBmbpH8kN20g4=
=7yrx
-----END PGP SIGNATURE-----

--Tecr9VZAi6Q825ui--
