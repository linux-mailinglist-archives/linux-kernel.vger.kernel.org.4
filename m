Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A5272620E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbjFGOCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbjFGOCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:02:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A20B1BE3;
        Wed,  7 Jun 2023 07:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3747616B6;
        Wed,  7 Jun 2023 14:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA386C433D2;
        Wed,  7 Jun 2023 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686146553;
        bh=hHtc9DnjpKrRzoPOZhm/tyxmqVCzPbq35+IYlssCytU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tn3FLD6kQqIAW9b3F+cEGG4Zvnwd70sE8UfCvewJatm780pmeo2735l0kx+zWnkDn
         7v8YW2uoOUSLc9fOqeVsJjHrE7JXWzoP4RZ/bFwhHwWoCpvLv/rlMxeAc3ZEvymG9T
         RyHaBuMSOsZjt37zCfuUr+Fe4C4qxrmCp41EH53P0V3KViBWnvMmLGAsTJJYbEH6Dv
         +95VkQuqDX4lY8vLUGqA4+VtVX5eAJBTI0nPaUdBWXLRpsJLbJgQVUhbFGUrFp7Np+
         2e8YgDdXwDzcC1YmpaTA/FRplyuBn48/GBIy4FyrK12d9F9kSde1My3vDqa94oBjIH
         yOiyCZCcYVsOg==
Date:   Wed, 7 Jun 2023 15:02:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
        linux-kernel@vger.kernel.org, Lisa Chen <minjie.chen@geekplus.com>
Subject: Re: [PATCH] spi: fsl-dspi: avoid SCK glitches with continuous
 transfers
Message-ID: <fa5896d1-6034-404b-9645-9f976283b505@sirena.org.uk>
References: <20230529223402.1199503-1-vladimir.oltean@nxp.com>
 <20230607120344.ui2ubzdkb6cbjm5o@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bHT21u6gNZuO6PWi"
Content-Disposition: inline
In-Reply-To: <20230607120344.ui2ubzdkb6cbjm5o@skbuf>
X-Cookie: Will Rogers never met you.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bHT21u6gNZuO6PWi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 03:03:44PM +0300, Vladimir Oltean wrote:
> On Tue, May 30, 2023 at 01:34:02AM +0300, Vladimir Oltean wrote:

> I know you don't appreciate content-free pings, but is this patch on
> your radar?

It's only been a week, please allow a reasonable time for review
especially when there may be other people who work on the driver and
should be given a chance to review as is the case here.  Had I not
already put this into my CI I'd most likely give it a bit longer...

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--bHT21u6gNZuO6PWi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSAjfMACgkQJNaLcl1U
h9AQsAf+IWeF2fOCDp1UCLj0RfisA5ZGazbbpRaaMxtyJlFA9L/FH7DjfkUm3tt2
e5lOws7HSYV8RKaR4IR9ZuNNZFvTEOYj4PjP4KWUgoTtzFQhqQ3yjD39M80KuFVT
NGVzDVXkJ5zchOYXVt5X4yM0kQE9FYwisi0ndZmqAbyB0/97a/+3wYX04WNjXgpq
u1Zfd7GgnA/eJDZx8BpuEVz7rHLnwdCnHgzDZm444goffpWSo5qF3O15pj5CHJkU
v6YhlusYYy2F3F2/5aZjYtlXoQ01sIhzIPKCaUwFQ31cts4nF485p81xwC2ONPEW
0BftzBc1cu2ZEunlCFfxr7yZhgbghg==
=DcO1
-----END PGP SIGNATURE-----

--bHT21u6gNZuO6PWi--
