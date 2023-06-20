Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E7073691A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjFTKWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjFTKVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:21:54 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F371110DC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=9+yhoa6Wa843GKsrl2vX1pLwxGjn
        5+p+iHpqH4HGTDg=; b=2EwJNv6//UVWTRbxStDip87qMnFlYqdAOR9uq7NnVSHJ
        H6o5NGdPBIwKPiHc8+wi1vB5FBZVRt1le9xcI1hiRWDAhyd3geEj530Zy8UWL/Py
        H4ECMEbf5NWDeFGAyNRa2wKeNruWqJLU8Sq5m5wqL3NDsbtJWmGiKG3TYiqGAyY=
Received: (qmail 595569 invoked from network); 20 Jun 2023 12:21:40 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2023 12:21:40 +0200
X-UD-Smtp-Session: l3s3148p1@lKlUBI3+HINehhtC
Date:   Tue, 20 Jun 2023 12:21:40 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] WIP: gnss: merge MTK driver into UBX driver
Message-ID: <ZJF9tJokpbFtaeLG@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Johan Hovold <johan@kernel.org>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
 <20230523064310.3005-2-wsa+renesas@sang-engineering.com>
 <ZIcC/sg59Ti+lL1N@ninjato>
 <ZJFRnIFUokVvV-pY@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l1DyS26WdehukoW4"
Content-Disposition: inline
In-Reply-To: <ZJFRnIFUokVvV-pY@hovoldconsulting.com>
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


--l1DyS26WdehukoW4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> First, some of these devices support vendor specific protocols which we
> may add driver support for at some point beyond currently just exporting
> this information to user space (e.g. to change line speed from the
> driver).

Speaking of proprietary protocols: did you ever get in contact with the
gpsd folks? I stumbled over this mail from February this year [1] where
nobody knew where this /dev/gnss0 device came from. I'd think we should
be in contact with them if we want to support e.g. line speed changes?

[1] https://lists.gnu.org/archive/html/gpsd-dev/2023-02/msg00017.html


--l1DyS26WdehukoW4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmSRfbMACgkQFA3kzBSg
KbaAbQ//Zj5EpMGVaC1+g8lIrfUi1LNCtTavkQlzynU1TILfuz3ychgYkJ5DrI0c
xxtLUPuFHnR2+3iHAspA1qKOZBes59oapwzYwflcJ2YlTUatxi3Z6jaJE9XX73hQ
WqIeckCaU5fUhlzWhvZyG4btNHrpdIzHb+FZVQgJyKLEWQp7iXe7nBIr23m9SH+I
CcNIHc8VlLRu1W97aP+t+ASjS4tXunsjf9R4iQFt9p1Rv9kSY0o3TB2scQd2O8CH
kNc3+COcwu7+EFS78FSEYXBuOSTYYrTfL16d4QW4eSv8xcNJpe4tcGxF61czUucB
xO89JlUgGPvNQCFSdLzEku0DtTFjPeMm/eOD0y/EOF7Gjo8UnqKPNSg+7J4tOV0H
MIqhEV9nV3rGgVKGsVPTVSCgcJfOJqa1jo3+BTwYgzyzFdIqbcI1t0eBXnZMJU2Q
ASYJb0XcFJ8Kc/AOnafDqzo50ocb3HgNtRjBptiSJO3qNBkme9MApjHN0epBvUmi
STO02W+lmvUbWJbvAYiv71yAAOfPff9802lL7/ml4I1nukmUoGNKCF6bpkykWbZ1
zRLbdOLNJyCk436+4Fp658CId9jBVvcVBQ2dS9dF3KNvWxzGlWH/PWdE0hgpV9Kz
0NMf33Hjq8y9HHgn6ZllHZqnVX6AW2UEuDkh8ojOZWGu9TsoCjQ=
=AkFG
-----END PGP SIGNATURE-----

--l1DyS26WdehukoW4--
