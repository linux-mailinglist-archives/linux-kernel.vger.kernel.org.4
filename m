Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B673D6D4336
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjDCLQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjDCLQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:16:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D4C525C;
        Mon,  3 Apr 2023 04:16:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CF8F61924;
        Mon,  3 Apr 2023 11:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7E1C433D2;
        Mon,  3 Apr 2023 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680520584;
        bh=x4yaxHMcHRn3ghPQdmYuP41Cj25k3+MY0shbgMk6PV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pFxpCL7Wwpc+lJfLLKOZDvowzwQmPYvEK3OomWoKk89YJl9l6C3WStCB7Rptly3A9
         R4pgSgi12+RnuHAgqR9Y2GqV0uI4BeWuFqm03S8n57GvvJnnLt+8Q7YM4CHlYYaED7
         zY79I4WB+s+uawJMQBp9Xf377+lySxxb6mQnTr1e4HMH1BEDmOJM6JJRwus3e7ecMy
         AaE+rgaCtjCSnKpa6MEJ9cJgbcUVYNWc9ZhFhDcU56imiENu3ger/7No580+6obZub
         GVb8Bv9scEDWHDSr2XrxgIJ1/mRPwYLGaZzNaAvTa8SEWJQm5y7QW4ZMgccJYCkVbf
         dkA+VSl8k1x5A==
Date:   Mon, 3 Apr 2023 12:16:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rohit Ner <rohitner@google.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <manugautam@google.com>,
        Joy Chakraborty <joychakr@google.com>
Subject: Re: [PATCH] spi: spi-loopback-test: Add module param for iteration
 length
Message-ID: <7e40de58-1a43-4d70-955b-6dd5b87b8cd4@sirena.org.uk>
References: <CAGt9f=TBi3qcbhUPymFGjCFeNNZZ0KQoXSUOT5uA6Dn8PMmnWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vu4cYD21rSTalHOB"
Content-Disposition: inline
In-Reply-To: <CAGt9f=TBi3qcbhUPymFGjCFeNNZZ0KQoXSUOT5uA6Dn8PMmnWw@mail.gmail.com>
X-Cookie: Do not fold, spindle or mutilate.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Vu4cYD21rSTalHOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 03, 2023 at 09:39:10AM +0530, Rohit Ner wrote:
> SPI test framework is designed to run each test case for
> a list of lengths.
> Introduce a module parameter to limit the iterations
> to a single value among the list of lengths.

This doesn't apply against current code, please check and resend.

--Vu4cYD21rSTalHOB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQqtYIACgkQJNaLcl1U
h9CQnwf/RILMwoR69Cp0S59rbEmkChS39T51gGTmM+6bEFv4EtPAHIsgyWtx3I4p
2/jomvuxP3YRym8p8AIuiyeAKTLycJDQ5iYi97SyzKOf3MPBiH2aXlfGubYCo4dy
lZ4Y5lq/PNhyTXy1W3dyJtwscIuiZdnXErjSKAY0xM48ff2YgSpuJPCtmF4++Os2
KGOgJn0XBfzet0WPh5+g3dHgbeN3nKr8kIHphM0IjtsWvYxFCcK0tjKet0UVyuAT
bLd/o/ug+4FJRCQfSroAA6Wl/qwzJZXhTmOTmuFVCWQXpqvxvZr3IZwiAS58CHFA
6811+ItgzMKOZQsIsJItwUu2EL52uA==
=TUvf
-----END PGP SIGNATURE-----

--Vu4cYD21rSTalHOB--
