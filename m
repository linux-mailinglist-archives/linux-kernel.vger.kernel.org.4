Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB7363F724
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLASJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLASJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:09:41 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99197A604F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=IFDPDHyResCflYkSCq5q5dLxxdKd
        kwEHUoejDRAdiGo=; b=D3n8XyEa0LLfouJhZHqwIxo/OISgmMQhEvkCENmFEOKh
        qYazhwaqag6I5KdHXJw350EX4XJAS4rHDBFEssaGbc4gffEQMcrSeDxMV7VPI85J
        u+wbYhu1sQQks7QBPrDpfHDalSJWdLMQ6uqvs14orx+dIjCuzXuQyGk7a194ESI=
Received: (qmail 728924 invoked from network); 1 Dec 2022 19:09:35 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Dec 2022 19:09:35 +0100
X-UD-Smtp-Session: l3s3148p1@Qx9iH8ju/s8gAQnoAHp8AKw37PRURidB
Date:   Thu, 1 Dec 2022 19:09:30 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/sh_cmt: access registers according
 to spec
Message-ID: <Y4jt2riYNH0Fq5tD@kunai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org
References: <20221130210609.7718-1-wsa+renesas@sang-engineering.com>
 <87pmd3s89f.ffs@tglx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aBoNTTNNNXWDqBN/"
Content-Disposition: inline
In-Reply-To: <87pmd3s89f.ffs@tglx>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aBoNTTNNNXWDqBN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#change=
log
>=20
> I fixed it up for you this time...

[...]

> Instead of quoting, it would have been helpful to have the lore links
> for RFC v1/v2....

Thanks for fixing it, Thomas. I will improve!


--aBoNTTNNNXWDqBN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmOI7dcACgkQFA3kzBSg
Kba3Mg/8Dvuz7SuAAiySNTpA5eAUSXzLEFGXi2UR1hLnWP3Yg4xQrtbTzBJo27q/
aVsamuuKiX+E6mxIF9dHmBZjDz8wmyQrpPbFAP255nggbjNR36uLgBCmMXokV0sn
VlbS3PrwmqBw+K/tRvrv58RRDAc6Rtgynw2O+8UTIp+odxlCbT54RY7RAqJH0CHU
T/7sJfz6owtlNy4bWdbBAeQJlk7tI1+NbRav6HLzpSy3UrxdM+uN4XnOpfRMdyS1
HMmDlXVxCuVFQNDWmY8gvG1eKL8nj0Rfjp8UjeJ3jmYIezjxNSwxoHoRhccWOa0/
cvS3GxkiZ3Ng3YJS7rUHadnD9xzPULMB3gOhIjPB6Xi1H4kaAvo552ozjJsvjOhU
NTuQLlXrOdWusOKXguuuATlLxworVi8VLt+87yPqn8BVYyjHBC11KH3RMLWheS5r
jXEc3qYAxo7QWOTexciORZeEyNnE1+einrsnLJW+jUgTn/MGPJvuEfsjFUw8Mbqz
O8a9uKibnBDx24fMhCftHuIf0NOfxCSdkNaXmRO7kJj4hw7lFaYDYTco6T9yBLx9
vjO96ed+71TdMOAPDG7GaMgxfWxPwIEYLk65TXUmJqNUZJtVWblhGGkgbN12/DcV
U0qHNmnGhFvbkiTDdtXJGi0uoZkIwxBcu2652GAk/aPc1OSyPP4=
=rPQH
-----END PGP SIGNATURE-----

--aBoNTTNNNXWDqBN/--
