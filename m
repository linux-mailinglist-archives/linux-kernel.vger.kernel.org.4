Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F39736D69
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjFTNfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjFTNfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:35:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877E0E42
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:35:14 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qBbVj-000348-FJ; Tue, 20 Jun 2023 15:35:07 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id F0B151DDB73;
        Tue, 20 Jun 2023 13:35:05 +0000 (UTC)
Date:   Tue, 20 Jun 2023 15:35:05 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Simon Horman <simon.horman@corigine.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] can: length: fix bitstuffing count
Message-ID: <20230620-carmaker-carmaker-c9c2260cee1f-mkl@pengutronix.de>
References: <PAVPR10MB7209CEA1F5AD12B2E5C8ED86B15AA@PAVPR10MB7209.EURPRD10.PROD.OUTLOOK.COM>
 <ZIrC6DpjjtmpIsI9@corigine.com>
 <CAMZ6RqKzkEL+zfNyqn_f46K_h3_cX-BwGQJb8X5hH-vms0P=cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5vqvtfit6tmnyh4c"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKzkEL+zfNyqn_f46K_h3_cX-BwGQJb8X5hH-vms0P=cw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vqvtfit6tmnyh4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.06.2023 18:58:04, Vincent MAILHOL wrote:
> > Lastly, I'm not a CAN maintainer. But I think it's usual to separate
> > fixes and enhancements into different series, likely the former
> > targeting the can tree while the latter targets the can-next tree
> > (I could be way off here).
>=20
> Hmm... The fact is that only the first two patches are fixes. The
> third one is not.  The fixes being really minor, there is no urgency.
> So I was thinking of having the full series go to the next branch and
> as long as there is the Fix: tag, the two first patches will
> eventually be picked by the stable team. I thought that this approach
> was easier than sending two fixes to the stable branch, wait for these
> to propagate to next and then send a second series of a single patch
> for next.
>=20
> @Marc, let me know what you prefer. I am fine to split if this works
> best for you. Also, I will wait for your answer before doing any
> resend.
>=20
> > If on the other hand, the patches in this series are not bug fixes,
> > then it is probably best to drop the 'fixes' language.
>=20
> I will keep the Fix tags. Even if minor (probably no visible
> repercussions) it still fixes an existing inaccuracy (whether you call
> it bug or not is another debate, but I often see typo fixes being
> backported, and these are a bit more than a typo fix).

I've taken the whole series as is to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5vqvtfit6tmnyh4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSRqwcACgkQvlAcSiqK
BOiuAAgAsiTi4KQX+ACCtDflRuoZXbnAbf69UfUlZuprEeZ1Onk1p/x+nYh5fR7U
BBgojXIVMau34lTCIDJYiDD1p8YKu/KV54UHtHL4bfZ+y3e65+5amrLb1ceoAd6n
DVSnUJv8fbgPxC5GKDwRT+6pMCFzGuaHJsWXSWrgCuNzQGV2tUtFOGzah/0iE13G
z+CvRwG3ZnUAsuixmcN8DgixMnhOX/nXcFYz4bB5g3Ux9X5nfwrCZj9RJkzF1iw/
B4TkqxW99Dq35ptvGa59yFA3BYDZBkbyBawAijnaqgIyE5rUhF1wQRGMWxOqfE8H
I9yORnmFb9xnoimX/WYyjg/9Iwx6bw==
=VLYR
-----END PGP SIGNATURE-----

--5vqvtfit6tmnyh4c--
