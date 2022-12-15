Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602C364DCA3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiLOOAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiLON7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:59:43 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8BC2FBEF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:59:41 -0800 (PST)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 88D6C852E7;
        Thu, 15 Dec 2022 14:59:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671112779;
        bh=OyQTOu0hLalNreLx4H+Zadv07p3wZv6k2h97kl/KLO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qt4vQqpntYxeVDXKNIB2ajJBvtvJSm3gk0Q2C/PGGRPFtk8QOnrP7gs3IIs1Xofzh
         f7BXcEX//bOpBmbHk2o7yyqZyxi8roQSw2HJJyrU4BxSxMzz/lqgE5RwRkTb4olj4O
         FVBSWMgtEOhcCPndLpWpaeOfuEL5mo/drfWmffQIMvh2REpLn0uEE09atAep+eq87U
         MVKGvZF2EMNRaUKvZZPgjogcHm5V/KL3xeABKdCrzt/aOt0RvW3T0AvPsXZ3FSUyNM
         hG4bQdstASdPWGFJZOKcm60zr7FktmjEp1cRS747TL4zP1AnP77hOyONpIfyd0SFi0
         Tj4Qk5H5pZwYg==
Date:   Thu, 15 Dec 2022 14:59:33 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Stephen Kitt <steve@sk2.org>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ASoC: wm8940: Remove warning when no plat data
 present
Message-ID: <20221215145933.285f8386@wsk>
In-Reply-To: <Y5sAKNV4p4G5VVtP@sirena.org.uk>
References: <20221214123743.3713843-1-lukma@denx.de>
        <20221215093615.3794156-1-lukma@denx.de>
        <Y5sAKNV4p4G5VVtP@sirena.org.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S962smDBHA8uwC/.ZbsyNUs";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S962smDBHA8uwC/.ZbsyNUs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> On Thu, Dec 15, 2022 at 10:36:13AM +0100, Lukasz Majewski wrote:
> > The lack of platform data in the contemporary Linux
> > shall not be the reason to display warnings to the
> > kernel logs. =20
>=20
> Please don't send new patches in reply to old patches or serieses,
> this makes it harder for both people and tools to understand what is
> going on - it can bury things in mailboxes and make it difficult to
> keep track of what current patches are, both for the new patches and
> the old ones.

Ok. I will not use --in-reply-to.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/S962smDBHA8uwC/.ZbsyNUs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmObKEUACgkQAR8vZIA0
zr0fkgf+J3u56i2V715qK2QUByAbzlJn7JJSfXBN8Ri7dAeNvEc97P/MlcGmoUdD
CwRRENNSu1k9WQtcP9Yktcjv20WIZNssLd2/e7h65GKgiRVKxn1sS/OaMLpHtTgt
C5ZVXV7YASwExayzr8iYsTmM+vn1q/M8JMEHowh6dFg33pPyb9EPGRHcMnHMlhck
GrgCVXPmW7NQrUsYAiIzT7zeSNfT8sSYwcUsS74jnWwW8LJbKtoCK9/ma7dkFWXI
Y51wINr8Xo4UtKFcjNcM8K9nAg+/SnQsa891tkV4xy3fPfEjsJb7V6V6FU9d89N5
sOa8A9x6fbytB6eMP4o37xf54Kl/hw==
=kPNc
-----END PGP SIGNATURE-----

--Sig_/S962smDBHA8uwC/.ZbsyNUs--
