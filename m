Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67A67366F1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjFTJFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjFTJFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:05:00 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B491C2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=DiP2U40UtFwil/Dsz7aaiyEyMqvQ
        6WmB/Gg1VXwHL6o=; b=PBc1Vdp+/b4EbMU920mQkdVruY2PwqO3mxFa9AZ3vsEg
        lDBF/+xRuoAkxGFZQUlVSd+zhJ2tN45+UpVyPk8ney3lO0SSEXBYvNAtLhu5pG2I
        wVGU0MkSuWs2RM56HggZPVLqsUgIVLqNSZVRfJ1Tpx0Z23EGxBkb957I8N28y/E=
Received: (qmail 570015 invoked from network); 20 Jun 2023 11:04:57 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2023 11:04:57 +0200
X-UD-Smtp-Session: l3s3148p1@G1UA8ov+ILtehhtC
Date:   Tue, 20 Jun 2023 11:04:57 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] gnss: ubx: 'vcc' can be optional
Message-ID: <ZJFrueorhE16j551@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Johan Hovold <johan@kernel.org>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
 <20230523064310.3005-4-wsa+renesas@sang-engineering.com>
 <ZJFSGtbJEaq7UN3Y@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C+6xbFZvUsEFBHTR"
Content-Disposition: inline
In-Reply-To: <ZJFSGtbJEaq7UN3Y@hovoldconsulting.com>
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


--C+6xbFZvUsEFBHTR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The device still has a vcc supply even if it happens to be always-on on
> a particular board (and this should be reflected in the DT).

I'll drop this patch and update the DT.


--C+6xbFZvUsEFBHTR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmSRa7kACgkQFA3kzBSg
KbYgHhAAqYG4sNIevTpYts+VHj+mSTALh7cR69TzG5CNYnDQwybOltT8EuPeOagx
uxIyc83JwINBkGEsYPgYYg5b1s+ZP5T6Mpw5KQFiL4CFN4R8H/2/ZzqOIsVFnoFw
lAMCPp1uY5lAJrt+EleyZaJlp8qUbSE4hQk1Xm0pvExXusWeu/3LQtLZowjoH99H
Wlu3xRT0BmxcSsamasUUH0+Mi9MNT0qSA9EgQ39NSao1AgHokDjj5hexn7+NP+s+
d7HdS0oqgdLlesQXYgZqwg0yKEVPOtJy36otZdhwKJnR22xz8e843nmfSKBZYiqu
J/czVkRv1BIb8YKbAd6ZWHFv3ZDPckd8WNUeu4hB6RA4fPdAZP8cmoQ7AVAjafge
wxnHnMgggeSGCdmf48TCbOOxg+uLFhBiPEbXSvkmxt3JvJPKWUgagwsJm/ZftZOb
4y19E1s7aSC9nggpLwzKk+oFYXOXju9Ozwb1UvzDHLwiizGozXMlA9sx+RnU8p49
pDl8TAY5cpNibZoV2KqhsQa/sWXwJVlWIz9pwzclQxybRyvWsL1uQDuHkVJkHAtO
rqz3NcfmdQ54nsGvFGcneX+ANjCmhaHqq6Rv+CjMzz5lEt5sNx5xLU58AbLCmOZZ
FD9WL9t4w1M5picE7FaI0Q/7FZt2VvjJS1qKNaRUIDM/i/djfBk=
=LRFz
-----END PGP SIGNATURE-----

--C+6xbFZvUsEFBHTR--
