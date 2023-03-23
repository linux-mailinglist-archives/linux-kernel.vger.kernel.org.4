Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113B26C70EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjCWTRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCWTRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:17:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583549000;
        Thu, 23 Mar 2023 12:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A951B8220F;
        Thu, 23 Mar 2023 19:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99678C433EF;
        Thu, 23 Mar 2023 19:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679599046;
        bh=t2fKFQycO5bMhtMShqAmTqjWXbmR7ABgwZ9hE9vbbO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sv9hDyvA+CJBvCs2nrf3nppcKC97c95IbuTArMW9F2m4z3CmaNXXQYyOozwm/5hUS
         6mpHk4LewEl5Q8E67w/vpahxuk2+hi5oPpAsrsEnUFvPYQqcJ3DJ/q+8ihyfAKUKP9
         J7HllZQzFrNterW6trCzi3QmBuBXzrX2rw1e5wA9a98HXUZOaG+oFJuGUQUP+xOG3I
         bfVj58P1n/iX/M33ssg7d/CSyM/bpfEC02jeYrYoC9YPusbtnfSQhRdGHXvI5+1Rpy
         Jt6C5+ZEyc9sF5MQGkW7AVlkJ3uP/VHTM5vbu+qRVPNVbCAST5XlXOt7oNfs/EbOsk
         l3dwiYKMAntGw==
Date:   Thu, 23 Mar 2023 19:17:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Saalim Quadri <danascape@gmail.com>, alsa-devel@alsa-project.org,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: alc5632: Convert to dtschema
Message-ID: <4a553ab8-4cd3-4ce4-8225-20f43b70a5be@sirena.org.uk>
References: <1a2e0f7a-771f-5590-fc54-b9dbf059a925@linaro.org>
 <20230323171111.17393-1-danascape@gmail.com>
 <5e0ca610-70b2-90fd-45b8-6b0da089eb4c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7CQC/ouNR9GP9b1L"
Content-Disposition: inline
In-Reply-To: <5e0ca610-70b2-90fd-45b8-6b0da089eb4c@linaro.org>
X-Cookie: A lie in time saves nine.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7CQC/ouNR9GP9b1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 23, 2023 at 08:08:33PM +0100, Krzysztof Kozlowski wrote:
> On 23/03/2023 18:11, Saalim Quadri wrote:

> > I have a doubt, for the maintainers list, is it required to include all the names of the subsystem maintainer
> > in the yaml too? As for this codec, there are 4, shall I include the names of all of them or the one to whom the

> Depends, choose one or two names, maybe the most active.

Note that the binding should have maintainers for the specific binding,
not the kernel subsystem.

--7CQC/ouNR9GP9b1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQcpaMACgkQJNaLcl1U
h9BsEwf+Nx+o3rV+MH36b07ERBsVKvXQ6FnQ8HOLP5a2hTkgLHsrsA5DabtTZL2n
C0ljaxQnG9Zshd2NXFLJo9fUQQV7pY/P00ChOR1xj6pYmGuo5rUNBgUJDOv815T/
tMeE8doM4fB1VtDB+N00BKQ/mwQNmi2IegqyfsFAUXrq2BXEkFU+QusiyVjV2Kds
YA8qCHEU08XOeR1Atx5fobkG5e3+4jzPXkdb7RJWwqBj37UxAKkP4Gro1FAHg3R3
p1rujZCF96UHOmNNexX42a8Fnx7PvVSKTM9r94qsKPXtwEBzABc2GwhXnYgEf+hh
oGfSbBgbFmixgevj37S8rj0UcwBbqQ==
=h6F7
-----END PGP SIGNATURE-----

--7CQC/ouNR9GP9b1L--
