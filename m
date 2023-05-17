Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B85705C36
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjEQBQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEQBQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:16:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3301BCD
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:16:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D387E63AB4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9902C433D2;
        Wed, 17 May 2023 01:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684286161;
        bh=YbwCfAzNBB7CY2C7jwdZq1e5lFcfLtjgsnIuxXKajjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0qmIIuyvZ8Ett7xuhW+YUarF3MNmFfwm+xQzqe8bZQ7P/eAWgGjEcJzsve9x0wYx
         JzGpMyZgXRxfa6oD77qWEcH1Suen4iWJicVYJVzkW2+F4+AADLTTOAGa6SYLF0z4rd
         3T2e8V2MueSfeCyqK/DZu09udtnbq8G8bg7dUiOIWIZUZuRZro00DSsvZkUbXUvBcS
         6XafjqBuGxrGK+DpeD9V0nwQiZ1cfBKpVpfpO8kLR+hZoORMwbtghwNCuCkojFVFaH
         S1sxnMW/dFn37kjfJzdOd/XrJvjzrxbuUS4Ay9a7wPBqZ+h6xF2Csl3/VmQEIkVMEs
         3S7mxFbSEkImQ==
Date:   Wed, 17 May 2023 10:15:58 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Jim Wylder <jwylder@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: Account for register length when chunking
Message-ID: <ZGQqzlU7XPF+rS8c@finisterre.sirena.org.uk>
References: <ZGJI2zU/bxDPxLAh@finisterre.sirena.org.uk>
 <20230516155223.2070731-1-jwylder@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="azaE0N+hnG1ddcr0"
Content-Disposition: inline
In-Reply-To: <20230516155223.2070731-1-jwylder@google.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azaE0N+hnG1ddcr0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 16, 2023 at 10:52:23AM -0500, Jim Wylder wrote:

> +	size_t max_data = map->max_raw_write - map->format.reg_bytes;

This still doesn't take account of padding bytes.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

--azaE0N+hnG1ddcr0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRkKssACgkQJNaLcl1U
h9BJ2wf+OkPubkQAjklIEkJjTFBmuP8csP9qe69XpAAyBKn9pyjOj4f2AbhluKKE
BYAFLE7r3Ktphde14ggzFFbhd7k1/MvwKvuZHfKN7RwW+xaI5w12viB9/L+Gsmv3
jYGuV/9wEAhPVC03kPEJQr5nd1WOvn1R971ePTei1Mqmg5ysgPkdlLCiuAotkNVu
ZzGLPm8bc84CfbOoegu1Ic9eML5H2OUpmjrUwlbAdApW3RJvPSmsUrKjSPxwUV5p
V9mE0OiyXx8BcpH8xa29sBD5Sp6Ynlnzk31wCFrdA2KlESX4akr3fGgsJCKkJcWx
U7+0GTtBLYvrdUM0VlabZvVq7WBU9g==
=a1Tk
-----END PGP SIGNATURE-----

--azaE0N+hnG1ddcr0--
