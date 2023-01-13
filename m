Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4C966A0E4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjAMRn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjAMRnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:43:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF328B76F;
        Fri, 13 Jan 2023 09:29:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2973B8206B;
        Fri, 13 Jan 2023 17:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C65C433EF;
        Fri, 13 Jan 2023 17:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673630962;
        bh=wHTzxLTSWIWcmvmjm8HxsOOrxP/zpZaqZsO3pYaP3PQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RfMMpuLL52GwyfuIE4Byu78vWrHe+aDNzSfAQpkJk1YS92uABw45T0K+vhzy7zAoC
         kVU20RfTNSxjkom8K97OOcrzd6kzJnTZABZn5wpzgcTbt2AItUZDdvfPp5zC68WQSt
         tX+BHKQsBWwwaWNE3HJxYUo7sEmasjzZpSziEQ7eXBwdQjVILVTbOcQA10DlG75H9Z
         Sr9wdrAPF/WkxKAsvzNa3T2JXGGhPmSnlaRntkcc3wjAlE0GzyJHdDISaLxjVJf/VH
         lBzgG3e3BXnwP0mlEXQCIqzhGzpogYDxRvRL1pclxHXz+YBvlRwmI1eDZpoXOoC0iZ
         MYNthL8mvfjuQ==
Date:   Fri, 13 Jan 2023 17:29:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next: BUG: kernel NULL pointer dereference, address:
 0000000000000008 - RIP: 0010:do_wp_page
Message-ID: <Y8GU7Pqq/z0wxwgs@sirena.org.uk>
References: <CA+G9fYt_b04YNCCv-iTZTtwb5fmNEQ0abiO46qW_-SrA1GQX8w@mail.gmail.com>
 <Y8Fkjxsq5EOtGiql@casper.infradead.org>
 <CA+G9fYuahjaNs6ia1UOeF98hUhonAt0Z4YOFGcqOKt3J4tRvTw@mail.gmail.com>
 <Y8F+iKuJWAFsUg2m@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TMhMJ435BNU2n88d"
Content-Disposition: inline
In-Reply-To: <Y8F+iKuJWAFsUg2m@casper.infradead.org>
X-Cookie: I know how to do SPECIAL EFFECTS!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TMhMJ435BNU2n88d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 13, 2023 at 03:53:44PM +0000, Matthew Wilcox wrote:
> On Fri, Jan 13, 2023 at 09:14:15PM +0530, Naresh Kamboju wrote:

> > [   15.980869] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > 2.0b 07/27/2017
> > [   15.988336] RIP: 0010:do_wp_page (memory.c:?)

> Uh, are you compiling your kernels without debuginfo?  The results
> from syzbot & 0day are much more useful:

> https://lore.kernel.org/linux-mm/Y8FnAwWOxLrfoWTN@casper.infradead.org/T/#u

> for an example.

This will be a consequence of x86 not including DEBUG_INFO in defconfig
- a lot of the testing systems cover unmodified upstream configs as a
baseline, it tends to make life easier and be an indication of what
people want covering.  A quick survey says most architectures are
setting at least DEBUG_INFO_REDUCED, it'd probably be a good idea for
x86 to do so as well.  The logs from arm64 and probably also arm
(depending on exactly which config was being covered)  should be more
usefully decodable, Naresh you mentioned that those were also failing?

--TMhMJ435BNU2n88d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPBlOwACgkQJNaLcl1U
h9DLYgf3YlPfc1pcH0HO6HljwMCx4N5dyA5iHuN02tOpucDFEofh4Ca72a+QwHbV
w6c7eGAk+WTO+HaPHSpSRxgvT67Xnk/8s4r5xnTAXvb3CC0cUcPob3zBa8aNH2ms
ZbQm4dd6fva7sVJFzD1NhlTd/lOeyWIK0bZ+rWtHb2uEmbroBtyyJMYOy9KBCA5i
0vC3rXkfGeyk2bab8Io9sAx4BJbg4cSdeSX3Fg3xXgspTpuz8xr9/UKKESkZ85yB
C/Kr98r0EmRg+5BIVdtdesDUE1+5PkpXi5mp6zCOUVe0OhebQ6Wy8rHsVqE+sddM
zMRKyHRObgl5CJISgH0PDTJUhKtQ
=9Dfl
-----END PGP SIGNATURE-----

--TMhMJ435BNU2n88d--
