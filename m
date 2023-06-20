Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31357736706
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjFTJIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjFTJIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:08:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE17D1726;
        Tue, 20 Jun 2023 02:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 517DE61074;
        Tue, 20 Jun 2023 09:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE146C433C0;
        Tue, 20 Jun 2023 09:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687252119;
        bh=6K9XDF/21Kxo3x9Gv+zHsaAn6wzoNhZIF0+/bJdAbFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tqS5NUlkh6uAXBZXmlnHFlzygRf4llTkjJAObGyeuA241P8Vd/gVB5KUxnYgMywU8
         e5x5C5Ibf39FT9N3xgHNiwo9ynVjiJXCraaCydz3Lelawhb8fAwbPMCrqCdmG3/0+U
         RsskhEjEZwJX1n7BvQnPbgRzPdLiZIJPnuMg3pARiOGJ3acCFmHqj6QJSO0ML7AT1k
         v78RHmFTQKcqu2cxSYV1W6iwTGIWhOzInzz1jU1VO0QNAmr8P30fPsApP5E+5XpFyZ
         8Ru5gBCBjkvjCfGkEZsHIfJQay1AzjwAGaE617qBcJQEYfWm/En8tv/vOFwcmMvmO3
         zlAko5VuB81zw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBXLr-0007dq-Pt; Tue, 20 Jun 2023 11:08:39 +0200
Date:   Tue, 20 Jun 2023 11:08:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [RFC PATCH 2/5] gnss: ubx: use new helper to remove open coded
 regulator handling
Message-ID: <ZJFslwLFNMmd9cw4@hovoldconsulting.com>
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
 <20230523064310.3005-3-wsa+renesas@sang-engineering.com>
 <ZJFn04P7_JhC24ST@hovoldconsulting.com>
 <ZJFrm1KYVfEDD9s1@shikoro>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PZMhN7r7/EUnYlHX"
Content-Disposition: inline
In-Reply-To: <ZJFrm1KYVfEDD9s1@shikoro>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PZMhN7r7/EUnYlHX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 11:04:27AM +0200, Wolfram Sang wrote:
> > I'm a bit torn about this one as I'm generally sceptical of devres and
> > especially helpers that enable or register resources, which just tends =
to
> > lead to subtle bugs.
>=20
> It is good to think twice with devres, but I also really like this
> helper. En-/Disabling the regulator matches the life cycle of the device
> itself. The boilerplate code it removes tends also to be error prone.

So can the "trival" devres conversions be:

	https://lore.kernel.org/lkml/ZJFqCQ8bbBoX3l1g@hovoldconsulting.com

I meant to CC you on my reply there.

Johan

--PZMhN7r7/EUnYlHX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZJFslAAKCRALxc3C7H1l
CFPzAQDAklV1JVCJjyVnBEQ3HSkwI0ocwpWtTLV/ynk6aRuSZgD9GurYczhVXHbB
wkaHrvVwVkC8+cBBPY38dB2t8nheVQA=
=2M6p
-----END PGP SIGNATURE-----

--PZMhN7r7/EUnYlHX--
