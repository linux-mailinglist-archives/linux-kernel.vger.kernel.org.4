Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167F35EB620
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiI0AMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 20:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiI0AMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:12:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28A2A2617;
        Mon, 26 Sep 2022 17:12:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 299B0CE11EA;
        Tue, 27 Sep 2022 00:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C95C433C1;
        Tue, 27 Sep 2022 00:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664237537;
        bh=yJTEwalXAj1ZcOxSPqdSxW64r1dUrfta6pJjhKY+Tq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHx5HL8v/5bO/aYAEsadexy7YLwfs42LwiBLPiYy4rMXI1FglqRvP3XDVGG0M6TWh
         osDik7ZxzeRdkhNBED8VJl4n9wzfGm/05vTJCAS4+0gmWCd6vMairWnKW35IAc/PL8
         HzwM9l6NXbRJC475duQPJ5qN1WaYLRqhys5i+DOVlDDL7Yt51G8LPMTYiiu7rvC2l4
         /gy6GyNH8pTbJA9NXQcA85Hf/bx+YrgGCcr9oacZC9BjEPPDCuaNAKePkahcst3ptX
         ue0nS3pG06A3YvRDcax+oj8NbYDmCLwxTO/RtPV1bk1LVdjrkb/N0U64G4iUIp1zxS
         KCmNxPgQRC8bw==
Date:   Tue, 27 Sep 2022 01:12:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Manfred Spraul <manfred.spraul@de.bosch.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the
 jc_docs tree
Message-ID: <YzI/3MjHgbXFHoHG@sirena.org.uk>
References: <20220926210631.657728-1-broonie@kernel.org>
 <20220926224621.47llaskp6mihi4dd@tarta.nabijaczleweli.xyz>
 <878rm5rbka.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2xIGPcpkILOvyfyN"
Content-Disposition: inline
In-Reply-To: <878rm5rbka.fsf@meer.lwn.net>
X-Cookie: You may be recognized soon.  Hide.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2xIGPcpkILOvyfyN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2022 at 04:54:45PM -0600, Jonathan Corbet wrote:
> =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz> writes:

> > This also reveals that I missed NBD_REQUEST_MAGIC
> > (needs to go, same reason as NBD_REPLY_MAGIC)
> > in the first pass, but that's unrelated here.

> I've been trying to make sense of that merge myself.  Is the right
> solution that I should just drop 32ba63d4b2e1a ?  Manfred, thoughts on
> that?

That'd certainly be a viable option too.

--2xIGPcpkILOvyfyN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMyP9sACgkQJNaLcl1U
h9Dqfwf8DrT/gFo1CSOWg6xhBl30XSPHqZqYYSQ4lSxI4MdyrMaMzPd71vChA+RF
4iKb3kJmWMXLiojv20iWmNlp14K4uPpxjnoTym8EEy6wLhL3hYbQBM6rmnr3E7oW
uG5iLpWwfLLPNCcnbVos4gk4Oi0j/6iI8ABNYLHnTntM7ImifoofFGjgoN3/bdn6
XXHM6DjAAfNmYFk6gjxn8b+1N9vQhaQW6bVL2bxLUHeSV977ekXzYle5AJfvpTXL
F6hyHvBNo8QvDIbiVn2RvJ7P0+uiB/Bx9MLlV5csupKdoqP0Zb0Gb2Nxfkhl81OY
lKzT4b7jqZRnd3ndMmwrnJP31DGtFA==
=+UIy
-----END PGP SIGNATURE-----

--2xIGPcpkILOvyfyN--
