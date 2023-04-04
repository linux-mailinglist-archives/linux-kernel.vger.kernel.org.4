Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3B36D6F76
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbjDDV6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbjDDV6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:58:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9539646B1;
        Tue,  4 Apr 2023 14:57:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PrhSM0fCjz4x1f;
        Wed,  5 Apr 2023 07:57:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680645427;
        bh=mzuca2PSgg78QbSLnxysLgNmygZTvKo9G/vazc5wdSM=;
        h=Date:From:To:Cc:Subject:From;
        b=byXgA4R10T0jDk9atKL9+eBpoDqYuqqRhpHBwQwMWgH12ByvilGW/q08gqyzC/0/p
         WfEiLYir4VRKfEGvqZXeYaykYbaQ3kBieeeMe/Qpg0v7noHTzmNc27oa/PJW5phq9P
         +UDAt3hJMCCZjllwGCI1EMNvbYeIdpUsWAG8Mx25bS6JlUNJBmU3eu+ua+ZPXHJnmb
         zmUUVwlDwE7frZEpd8o+WTt0/TUHh1zreGSZNmuKeVw1kzgqYGXvTYgo1Upjd/jofZ
         Amojx3D18t+yO3CaayLFZaV+STvjsDs98NDEDF9S7K8GTPWZyAnClpZD4AzUaY0lDt
         xxdjG7bYS/K0Q==
Date:   Wed, 5 Apr 2023 07:57:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the cxl tree
Message-ID: <20230405075704.33de8121@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wFO2dpAMQz/.=.Hn5wAKdcy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wFO2dpAMQz/.=.Hn5wAKdcy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  570739ce619a ("cxl/hdm: Avoid NULL deref when component registers are mis=
sing")

Fixes tag

  Fixes: 757f6448b100 ("cxl/hdm: Fix double allocation of @cxlhdm")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 518dd2bfb981 ("cxl/hdm: Fix double allocation of @cxlhdm")

--=20
Cheers,
Stephen Rothwell

--Sig_/wFO2dpAMQz/.=.Hn5wAKdcy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQsnTAACgkQAVBC80lX
0Gx7Mwf7BA8VJZvWae247wPMASDweVtm/JzlV7GjqrqcqpFVv/s0932pqjRp5RWu
2kqfWdlAC6hWMaxblDiNQppSl/+Ou5M4q9xtChvWenVjJQWw7PX71SbN7qBrqcxn
kKZTrlgx+qPG1MumdZ2vh1BTeBa8OO0uu2iCO/W0yRuwSFwXcNRLbjT5V2ilGfZr
3tSS5z0LNKlzLGLYS52QKbLQtR3d2NeaVxskoVe+n4l/QRSLFt1Ji76s9OAVx6wU
2YDhbriI8DGEj+6Gh9JT107s74RVV4UNDVxPUFZ6bu8CFO8bwKIPwROuYDpMHYhw
t99tu/PLJVAer4r+4VvJxEgMUndqyQ==
=FLDW
-----END PGP SIGNATURE-----

--Sig_/wFO2dpAMQz/.=.Hn5wAKdcy--
