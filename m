Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F89623275
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiKISbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiKISbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:31:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1DD388E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 10:31:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA03E61BFA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 18:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8993C433D6;
        Wed,  9 Nov 2022 18:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668018690;
        bh=7YsIIkDfc2VGjUqMDpp1L/swZBDll/zllPEW8lEiIVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4P3Ko/fGVlBFyl/nTnm0CJQOqgiQvlVrRq48N6qb/d9977MOrBXvxnW49/yC23RM
         1AVfemAEfhE3mPaXTsLTSwzadqdEkzop2XksRID6AbJaspLlRV/sWU64B6nFF3QUb0
         YoX/dBk+yBfgxhdmF75V6YI/kCQtzxmQwruCa4vBI5h63UJcrjlFuZmItvJOFSn9Ls
         yPEIk5SM7QeRzZMglGm0G17hNGHX8Ujrm3QrN4MwV6ipMIu6AtCYYlvlfwamkcUeq1
         dR6RHqoF8dx9V+EBmrXHMPLZ9iiPg8uEQx6q3K4z8ItErd4xZpthSAXfNryMFKgYIb
         SnOatZS3SiSUQ==
Date:   Wed, 9 Nov 2022 18:31:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH] regmap-irq: Use the new num_config_regs property in
 regmap_add_irq_chip_fwnode
Message-ID: <Y2vx/WwCwWhay+W+@sirena.org.uk>
References: <20221107202114.823975-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eBkwuCEkbanFir9M"
Content-Disposition: inline
In-Reply-To: <20221107202114.823975-1-y.oudjana@protonmail.com>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eBkwuCEkbanFir9M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 07, 2022 at 11:21:14PM +0300, Yassine Oudjana wrote:

> [   39.199374] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [   39.199383] Mem abort info:
> [   39.199390]   ESR = 0x0000000096000004
> [   39.199397]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   39.199408]   SET = 0, FnV = 0
> [   39.199415]   EA = 0, S1PTW = 0

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--eBkwuCEkbanFir9M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNr8fwACgkQJNaLcl1U
h9D0SQf/eEkGZYYb+75Q/W1PvQOGLzVGiwxb95t5dOcikD2BdW2VaNwLsLqELKSJ
hsT1HFEIsOlfDqjxHFqUL8lnUfWwOD/1MTMP18e42k5acl1yNUiFV6jddYULHiw4
ZvVtzLpz6Tcev36ROX0r5uwlCdFeNjz5UXvLnlqCExROYeVZeS1EJzMqBNKq+HiY
zLWPk2PQwO9RlRF2yrU/LpiPx3J0kTR9pelc6mbOfruSQBAZjo5VjL7QXqqlaFDD
+2h977wZu0Ot1O+kP8VEFer9KycDmFq3EnjAlh0DsW/Tm4Lgr9o+a7yeNDGVNNDg
ZDlH7+vtwyK8aD0oENbYx0Beg2aSTQ==
=/LBd
-----END PGP SIGNATURE-----

--eBkwuCEkbanFir9M--
