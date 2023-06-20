Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4726B7368F0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjFTKOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjFTKOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:14:19 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CFDDB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=OtkSZMqVwXfHlvtazHdX2c34BCi7
        IFfkmHYyFwDhrDo=; b=wQM4SOvKfmiavNdCYoSo2Evpj1WCKS8/byv7llT6u5lV
        H8JgnGjSNpazMB/seov+vgkhvLztXC9AzRfMk326uW3BTnDTzsVBWNO9lRpk+Qn1
        lUiBmbJJfv2Vbpw3+Kregm8rsEXkC4ghx1gaOX3K8MEvhALXHHRuAcHSnU9YQPM=
Received: (qmail 593364 invoked from network); 20 Jun 2023 12:14:12 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2023 12:14:12 +0200
X-UD-Smtp-Session: l3s3148p1@WUuk6Yz+HLJehhtC
Date:   Tue, 20 Jun 2023 12:14:12 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] gnss: ubx: add support for the reset gpio
Message-ID: <ZJF79EoY8YGasY3S@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Johan Hovold <johan@kernel.org>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
 <20230523064310.3005-5-wsa+renesas@sang-engineering.com>
 <ZJFSjrf41PHe400c@hovoldconsulting.com>
 <ZJFsGWepuvkSjL9a@shikoro>
 <ZJFtdWK5I13YUUcu@hovoldconsulting.com>
 <ZJF0U/mIniEksVwZ@ninjato>
 <ZJF56yaeyIGiK9qu@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KVe3SAa9teWuowhV"
Content-Disposition: inline
In-Reply-To: <ZJF56yaeyIGiK9qu@hovoldconsulting.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KVe3SAa9teWuowhV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Rereading the commit message now it makes more sense, I guess I was
> thrown off by the reference to I2C. Perhaps adding a sentence or two
> about the alternate interface and using it as a means of verification
> would make things a bit more clear.

Will do!


--KVe3SAa9teWuowhV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmSRe/AACgkQFA3kzBSg
KbbkbA//eZDCLJoNplAWx/1jp66jPagr3kA3MhMiMW2tV027C4OvJouyil3cBp/t
is+myAkZC2pUrhZlLO7TO27jhT/Dj50HGIf5uJpKy3HB4jKw9RVM9i9rknTnR2uR
ggQ988maYjcRg6ZDHoGGs+JefAnuhR6IQAP4g4Dx+fWKGv2iWgXbhnQR8OdDI3EJ
ptWqJxY6H1LlB+2nMcHo5GVUQa7i7jPzJSZXFSCFoc8eFDSXzDiGx6WGF18COydK
SrCCQAZZ7MUVjtLFe9f6Mn+HwTB+Vr3VtsDIBJKEUCU+B4mUXGzv87NGIKlchBto
wMt1djz8WbdoJeuH+mz8WS0ie2A3xq7/5MkU2QI0AKjg6DhG1PU2DgEoHQZiQKq3
1Rm6h1f1vXwlVxdIgcd+c5/Fj5/zZES63fTcx+PgcDQXMLB7dR02iW943vizxLNI
x2aQbmjsWSz66uebBbDzkCcMBFQcdEAt0GYjnAzIYOzJoSScEdEAMgAx0uNvhv6w
KPmvZ13QdGsdyzIPV1AarXYH6gmOtuXeY1REytsxP4sFGFswInzWKPahFv6vvT8g
2g4yCY84YoQHt0uyZME2aCCAxBuE8OIYny3ZUW2nSltFExAOdoIfAdCq9JTTq3EW
A6n30P2O61HDLYBgn6gEfLufQ0M3FkN2N5wbTCkjDZ8CyYKwR9g=
=FUHq
-----END PGP SIGNATURE-----

--KVe3SAa9teWuowhV--
