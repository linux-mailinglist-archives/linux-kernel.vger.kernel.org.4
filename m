Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E38B705567
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjEPRtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjEPRsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:48:52 -0400
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68A1A257;
        Tue, 16 May 2023 10:48:36 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.94.2)
        (envelope-from <m@bues.ch>)
        id 1pyymf-000LJS-3V; Tue, 16 May 2023 19:48:24 +0200
Date:   Tue, 16 May 2023 19:47:52 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Arnd Bergmann" <arnd@kernel.org>, "Kalle Valo" <kvalo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>, linux-wireless@vger.kernel.org,
        b43-dev@lists.infradead.org, Netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] wifi: b43: fix incorrect __packed annotation
Message-ID: <20230516194752.50ae12db@barney>
In-Reply-To: <b53f3673-f6b1-4071-9bcf-9ae5815593eb@app.fastmail.com>
References: <20230516074554.1674536-1-arnd@kernel.org>
        <20230516191245.4149c51a@barney>
        <b53f3673-f6b1-4071-9bcf-9ae5815593eb@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LydMZaBgIzo3HKHo7_xf/iA";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LydMZaBgIzo3HKHo7_xf/iA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 May 2023 19:45:16 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> Should I resend this as a combined patch for both drivers?

I think that would be fine, yes.
Thank you for checking.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/LydMZaBgIzo3HKHo7_xf/iA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmRjwcgACgkQ9TK+HZCN
iw5T+g/8DVJ2wyaO2Xg8k2CkNMDjP5bFJVvaUnLUQoYFT22CY2Rlkop53SsVpkgL
A7/SxrptKK4vPNgO0QjwN8+Nl8KbL320XH+YEFi+f64uJUBrpAusuVOmK5BZ13Il
V5ljNaJCWQyAVuYV7YlHFoe/EfSOZI5Ca/KVGzmJbcjCbt9vs9MiRIG8ClBdCS39
NHCDvWw+o7HzmExK9dfeO2puN9dHW54U6Np7sDQ9CBLrM3PDB6STBiIVSNnDvG1Q
b2M9mQEcK382pf53+6IJP6xuXppT94TDihTWTzeAmlRIQyMKAkDA7PgSYxr3T6+m
U4vPiCjq9mFZO1Mw8BZbLoVkG0JrX3ffO1LisjKqrLw7y6V4CischbnV4Ye6hTaH
dw8Fx2QPIsAIjb3kLgEY3BezcURQbRqLb3GPRdFHAS+pi8QbE9Hg5epbkxqW7iLS
ff9VDUXftth7fdv0+bMQ8YUuox5unQno/Dc0xaKXshxE4LpXowMlm1RIl+/CyUJ+
+eG1+cdd/NIt6Qw+ped8XxDOCEDeXfwWTrsjMK0WHMUnzItLKeFBJy6yDW9qj+6Y
RikXtPHZkrgJA3+Cfc8HWnuo8WFhIQvawGBjqenbVyI0FnuIFnzpys/ukNe/TiQd
g7yDBD5EJtNoyK0ez+/NJHOKt0lmcUKselAFpE7DZisStWWnLRs=
=syVX
-----END PGP SIGNATURE-----

--Sig_/LydMZaBgIzo3HKHo7_xf/iA--
