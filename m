Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B49B74DC04
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjGJRMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGJRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:12:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D08E10D;
        Mon, 10 Jul 2023 10:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD81661127;
        Mon, 10 Jul 2023 17:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C96C433C7;
        Mon, 10 Jul 2023 17:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689009151;
        bh=vvAVbgZpcOMJ/qEH4hsXQCETNWbXWjh5iV2QQXaC0tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oro8aYvmVsJJ98tLydLUTYFS87pkQOLf5Krtz8ir5PIx2/x56qIU53TcWk3tyBZg9
         FqyVbrFAMXMNljNmfitBPZ3DhejlpOY6XWHiiar04lkpMA5pr62g/BFt/HsQtTdD/j
         2+yRpyQTFaFTgFNpAqWZgeU6S8JMVUTQ4GGLv2VZTlpAotJtpAXgV981jeDdTDwCDL
         MHIBfRdYs52NqSK1wUn3dIV+7ry5MM+N1MSs5v/Jy+3f+Kjizg/XgE+uxRBol87Yz3
         JLcC1eSEtgJtBPWjD9BQuzCJR3DMafBO/BhjW4t+xauuE6sM6I/xQkEdFhDCRZvuEs
         j0loaPokieDog==
Date:   Mon, 10 Jul 2023 18:12:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Rob Herring <robh@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alexandre.belloni@bootlin.com, sre@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 convert to yaml
Message-ID: <20230710-eldercare-affection-778b7e26951a@spud>
References: <20230524123528.439082-1-claudiu.beznea@microchip.com>
 <20230524123528.439082-4-claudiu.beznea@microchip.com>
 <20230524-blizzard-hunting-4da815e634e2@spud>
 <20230607204351.GA3984668-robh@kernel.org>
 <20230607-refute-acrobat-3b3f645da71b@spud>
 <CAL_JsqLyLs3Vfsd8LRd5_dUbzjE9LgMNnWa+8uP88Ab+E1oLfw@mail.gmail.com>
 <20230608-tiptop-unfold-66c4b8f4e620@spud>
 <82f1d66a-b8cf-69bd-4783-e2c867c11828@microchip.com>
 <20230613-library-enigmatic-267396f84d78@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/fvOucPn118co02/"
Content-Disposition: inline
In-Reply-To: <20230613-library-enigmatic-267396f84d78@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/fvOucPn118co02/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Nicolas,

On Tue, Jun 13, 2023 at 07:44:58PM +0100, Conor Dooley wrote:
> On Fri, Jun 09, 2023 at 12:09:24PM +0200, Nicolas Ferre wrote:
> > On 08/06/2023 at 18:49, Conor Dooley wrote:
> > >=20
> > > On Thu, Jun 08, 2023 at 08:38:10AM -0600, Rob Herring wrote:
> > >=20
> > > > For reference, anything done by Arm, Linaro or NVIDIA employees is
> > > > okay to relicense to dual license.
> > > Ah cool, that's good to know, thanks.
> > > Perhaps I should try to get a similar edict issued for Microchip ones.
> > > @Nicolas, does that sound reasonable?
> >=20
> > Well, we can work it out internally, indeed. But is there a public stat=
ement
> > about this somewhere?
>=20
> You mean, is there a public statement about Arm/Linaro/Nvidia being okay
> with relicensing bindings as dual license?

This was sitting at the end of my queue, don't recall following this up
internally. Getting an edict might be more hassle than it is worth & I
guess I am always CCed on bindings to Ack them.


--/fvOucPn118co02/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKw7+gAKCRB4tDGHoIJi
0iRRAQDA/gIPYRJcURGv5S6W/ljvEX7yrygRh24zGK97esFiDwEA/v0daV8787V0
xmXk0NdicJ0n2tVchsnCPmBr+PmLIQw=
=70wv
-----END PGP SIGNATURE-----

--/fvOucPn118co02/--
