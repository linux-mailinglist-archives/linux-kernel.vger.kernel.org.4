Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCB673674E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjFTJNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjFTJMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA5A1A1;
        Tue, 20 Jun 2023 02:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DC3661087;
        Tue, 20 Jun 2023 09:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B572C433C8;
        Tue, 20 Jun 2023 09:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687252341;
        bh=Kz1VJjObJlh7O7SFllyvvnKC+T2YPg+YAnme017Z+eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sKw0SzTUl8EvZLljd09yKbjyqdp5cahtABMGDY1iwDmCb1VOY9z74+2ES4BLZA/AO
         4sAy0D7YMlnQ3P+IF+uj6AOwXLxoOdot2nWB43Ea8G+vrAo0x37Mt9zXmDP2EJK12H
         jimw4imn6eO2hgUFqATFnUBHz9bQ21H4NJWxiOxjsW0quR9xzxivP7A2rhsJ/KgHOx
         Al9r++4Ad6rjwQs0zTZJekDcBy4lTuQWuDnwOoEWKubdC1LmzYiNs6lUxYN6NxPSYC
         acv8X3WVdJG23Z+3cBmywa94bWJV3ByfVBBvBF/tl26jJcuYvMJ1EwILkPUh1M/RZy
         ZWzKxSpU89Jbg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBXPR-0007fU-GL; Tue, 20 Jun 2023 11:12:21 +0200
Date:   Tue, 20 Jun 2023 11:12:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] gnss: ubx: add support for the reset gpio
Message-ID: <ZJFtdWK5I13YUUcu@hovoldconsulting.com>
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
 <20230523064310.3005-5-wsa+renesas@sang-engineering.com>
 <ZJFSjrf41PHe400c@hovoldconsulting.com>
 <ZJFsGWepuvkSjL9a@shikoro>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M5C+drIlaUYiTH3C"
Content-Disposition: inline
In-Reply-To: <ZJFsGWepuvkSjL9a@shikoro>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M5C+drIlaUYiTH3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 11:06:33AM +0200, Wolfram Sang wrote:
>=20
> > > Tested with a Renesas KingFisher board. The chip correctly disappears
> > > from the I2C bus when the 'gnss0' device is not opened.
> >=20
> > What do you mean by "disappears from the I2C bus"?
> >=20
> > Does this device support both I2C and UART?
>=20
> Yes, and on my board, both are wired.

Ah, yes, it was ublox device.

But can you elaborate on the "disappearing" bit? How exactly does it
"disappear" when the gnss0 device is *not* opened?

Johan

--M5C+drIlaUYiTH3C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZJFtcQAKCRALxc3C7H1l
CEBpAQDg4l5eDw7fijbkeQJPqL6qCxJNnHQFO137fzjo8UOZpgD7BsiFgclS6pCZ
4SYB9I0X23b9VCOxi6Mh8c42CDK7mQs=
=Pv+G
-----END PGP SIGNATURE-----

--M5C+drIlaUYiTH3C--
