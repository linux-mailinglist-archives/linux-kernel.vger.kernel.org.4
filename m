Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EF46A5FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjB1TxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjB1TxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:53:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0018FF3B;
        Tue, 28 Feb 2023 11:53:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83479B80DE7;
        Tue, 28 Feb 2023 19:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49711C433D2;
        Tue, 28 Feb 2023 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677613994;
        bh=Y2iCQOI+QIptI1cAQ9K+Q84gdG4gXITGnMKH6Zu3i2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JadZaEPK9VGtVAUCHTICx1dxwwELfHxbmZjBNCAeSO6DplqIkZ4ZgHp1gUrjKYt5k
         X7GtnlE6c5EFA0kOyYMVREFolk/RkPyZl2Za0Fsk2Gen8Kxqb/xUQ7YtaHh2csJJWO
         mga4bkPDH2pcnwYhm1vhiJlmIpYc9aegsYAuSesP1jRHbVQ0c63DCxKtujtiBAperG
         LGRG5kH/QG3gH3pbxitetkFdCqPtf8zxmoZ3GJ6n8V3e1B2CZZ2UWMwE+9nmWB6V6s
         Wovk/gGzKeboJVoZWbuij8aFnA+Tbj3ixeCl//s7RJBqymzNfOGh0jz6hyR70UkC68
         SZdT8sAV08lSw==
Date:   Tue, 28 Feb 2023 19:53:10 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 13/20] reset: remove MODULE_LICENSE in non-modules
Message-ID: <Y/5bpr/93hJ3yYUU@spud>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
 <20230228130215.289081-14-nick.alcock@oracle.com>
 <Y/5TU/gxAxfVOedg@spud>
 <87edq9h9q8.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kp+/tWtv3tDQlrmv"
Content-Disposition: inline
In-Reply-To: <87edq9h9q8.fsf@esperi.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kp+/tWtv3tDQlrmv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2023 at 07:26:55PM +0000, Nick Alcock wrote:
> [dropped non-lists to defend innocent ears from my flaming pedantry]
>=20
> On 28 Feb 2023, Conor Dooley stated:
>=20
> > On Tue, Feb 28, 2023 at 01:02:08PM +0000, Nick Alcock wrote:
> >> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> >> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> >> are used to identify modules. As a consequence, uses of the macro
> >> in non-modules will cause modprobe to misidentify their containing
> >> object file as a module when it is not (false positives), and modprobe
> >> might succeed rather than failing with a suitable error message.
> >>=20
> >> So remove it in the files in this commit, none of which can be built as
> >> modules.
> >>=20
> >> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> >> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> >> Cc: Luis Chamberlain <mcgrof@kernel.org>
> >> Cc: linux-modules@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> >> Cc: Conor Dooley <conor.dooley@microchip.com>
> >> Cc: Daire McNamara <daire.mcnamara@microchip.com>
> >> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> >> Cc: linux-riscv@lists.infradead.org
> >> ---
> >>  drivers/reset/reset-mpfs.c | 1 -
> >
> > I assume your script just got confused here w/ $subject, since there's
> > only a change for this specific file.
>=20
> This file has had no commits since you wrote it last year, and the
> subject for that commit was
>=20
>     reset: add polarfire soc reset support
>=20
> so, er, yes, the script used 'reset:' as a prefix, mimicking the
> existing commit. I'm not sure what else it could have done.

Oh ye, silly me - I didn't think of that. I guess that's a common
pattern for commits adding a driver, as the "mpfs:" doesn't really make
sense until the driver is in-tree.
I'm not too sure what you could have done either, but I'm not
complaining, or requesting that something be changed here.

> (Regarding the rest of the subject line, I suppose I could have arranged
> to detect single-file commits and turned the subject into 'in this
> non-module'? But there comes a time when even I think that maybe I might
> be overdesigning something, and automated grammatical adjustments to the
> subject line was that point!)

Yeah, I think it's not worth doing anything about really...

--Kp+/tWtv3tDQlrmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/5bpgAKCRB4tDGHoIJi
0ityAP4ieRuQTEdqsGZxmgH0Ie+b5HZsxWdK57F1JJsroTqwYwEAj6GT1/w4OmV6
y3uemsRLYSiSaSApbXcOdwNMXgMnEwY=
=YIMs
-----END PGP SIGNATURE-----

--Kp+/tWtv3tDQlrmv--
