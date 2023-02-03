Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8BC6899F8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjBCNpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjBCNpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:45:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFDA8DADB;
        Fri,  3 Feb 2023 05:45:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABFE761F20;
        Fri,  3 Feb 2023 13:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07716C433D2;
        Fri,  3 Feb 2023 13:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675431908;
        bh=Wy9AG3K14zxfoptbmsfeEPp7B0QajzYRcPSYgD6sS9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IVX/4FUkA4eGysc/L3Byu8nQ1t6WweFMKY1v79CHby8//Fxt+7NbzX14csykuwjGr
         J2KjvUkas2yEs2QW0XTCi1+6xLZWbilWIt1XwR1/pb59yV0dW1on0bLfp8BaR08P+e
         H/CujClHD55QOFdEzuR5tvD60zIIqqJFxopZ5DGg86aXhG3yTX3M+VuaNiHt6iuQvQ
         Zhr42yfItxaWTuw9S3Nmdvs9WaR2TZZaSmC4et0zQ241a6wqb9l1g15jKIFrfyVRLz
         FoBRCXmWxlXvStgFSu8CSptF4O7lQHP/YkrlWS7jDYhgGWWDi+QFtE5PQn+qqLhqUd
         nBfdCbnjG4wIw==
Date:   Fri, 3 Feb 2023 13:45:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: uapi: Replace zero-length arrays with
 __DECLARE_FLEX_ARRAY() helper
Message-ID: <Y90P3kik6ONZg3U4@sirena.org.uk>
References: <YzIzUjUuJKf0mkKg@work>
 <fcd83e77-a3fb-9061-771a-8509ea6f5950@embeddedor.com>
 <Y9wmnfTi/p4FuRmd@sirena.org.uk>
 <bb43c410-bd8c-66fe-19a1-0f41442838eb@embeddedor.com>
 <Y90ExljX2qCsowhu@sirena.org.uk>
 <652684af-bd10-99da-1ed8-104407493428@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a+RL9goM+en75Ex9"
Content-Disposition: inline
In-Reply-To: <652684af-bd10-99da-1ed8-104407493428@embeddedor.com>
X-Cookie: No animals were injured.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a+RL9goM+en75Ex9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 03, 2023 at 07:27:03AM -0600, Gustavo A. R. Silva wrote:

> I think we have run into this same issue (you not being listed in the
> MAINTAINERS file) at least once in the past, right? (thinkingface)

> IMHO, the sensible solution for this is to keep the MAINTAINERS file
> up-to-date. So, get_maintainer.pl can continue to be useful for people.

Sure, feel free to send an update...

--a+RL9goM+en75Ex9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPdD90ACgkQJNaLcl1U
h9Dg2Qf/dc15eT5JBy548fG5ghzHAthljy6CLlz2riJJ5d+aSaHFP2ozN3R/3yeF
hekVU8fH9qUuXDnP9/mno2TU769tac3aNP7lr1iVTW8hlXi9W3ya8XtRg40cAPRz
rnDs9hfIigQnDnxpcfGSXkEqpVt14seZHfQSHIXF9GO+lZztPRcZ0IlTRm+3BB2g
lPlMwGRfiHjS4/knP4zpurCO7n7sBJIfX+lLySlOk74J2O3s3nM9M7XlXLggCMoX
zqSzSsk4mO1pkYHJ4LnxAhE55TdGgGfvFmPAPPVu/BDPemXfIf5W2vTcim3IU0vM
qdxpb16RGx6lETBw+SUik+epxfrMKw==
=Ltsr
-----END PGP SIGNATURE-----

--a+RL9goM+en75Ex9--
