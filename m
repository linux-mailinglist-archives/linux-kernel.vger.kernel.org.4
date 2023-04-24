Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383DA6ECC16
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjDXMc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjDXMc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:32:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1D3449D;
        Mon, 24 Apr 2023 05:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D2BF60AE9;
        Mon, 24 Apr 2023 12:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F1AC433D2;
        Mon, 24 Apr 2023 12:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682339539;
        bh=3gbP4eBWBVtrqJ7+u+sGO1ZzsNqx3kgrpsbN2Whx/DQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=meYGuNmTBHXZPY+tp0KWWGjcwL8P1Dd9hi7AxW/NtCYiYZGyAq2sMqM0zWB7HrrAn
         ehCFWPn3zyZgxo5Uci+8ZnxQlKvpUp3JtSbYP5A6wgzJd6fAYmke3N/Qw0C83XcCXw
         iBDpJjZNmIS3tIIo+1SY4RX6990oCAlaVVOw+1fTAqXblkPuFrR7QjbGEZbP8PkpqZ
         SiL+3bF08de9IWgpg3WDeOkh0cGH2G8M5NmdGVhQHJJL97spA4nEwoqSl7LFL26reD
         Qr9NVnSsVS7YSOxPibrES3zWcKR9+5JZ1sydX5XNsfnWY1dC3tTReMsyu67fQ3jHqv
         fRKvoPqhxz3TA==
Date:   Mon, 24 Apr 2023 13:32:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     Yingsha Xu <ysxu@hust.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: remove return value check of debugfs_create_dir()
Message-ID: <a4706089-399b-4663-9ac8-216f12ebe7ca@sirena.org.uk>
References: <20230423061155.2540-1-ysxu@hust.edu.cn>
 <eb3c6aa6-6820-4e94-8eb0-5abd3b627fcc@sirena.org.uk>
 <368e31ae-31b5-839f-72e3-20a27239cb0b@sony.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UOBnuC81RE2vEHCp"
Content-Disposition: inline
In-Reply-To: <368e31ae-31b5-839f-72e3-20a27239cb0b@sony.com>
X-Cookie: A rolling disk gathers no MOS.
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UOBnuC81RE2vEHCp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2023 at 02:20:45PM +0200, Peter Enderborg wrote:
> On 4/24/23 13:54, Mark Brown wrote:

> > This is very much a question of taste with a range of use cases
> > available.

> No.=20
> https://lkml.iu.edu/hypermail/linux/kernel/1901.2/05993.html
> We can do things with the debug information without filesystem enabled.

There's issues with partially created debugfs structures getting in the
way of people trying to debug things, just completely ignoring all
errors can create confusion as the diagnostic information people believe
is being shown to them ends up being partial or mistructured without any
indication that this has happened.

--UOBnuC81RE2vEHCp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRGds0ACgkQJNaLcl1U
h9A0Kwf8D3WxDd1y1d2Htc0oO336q9R8aFm20uS/m3PtMgWJ8ObnGc80ooAte+0A
/Xk2h2N04jNqM4+iwzk3ByOyonC17cJH3ZwIzLXnu5DC86Ua9tFlwib0ABw7sJbE
tTCNQsIEd+UX+CNms6ffY7KMZHGeeEm4V2zTEVkRMwbU72AQ1aWSknAnLYP9lxpT
LS4/3dwJxJ8XCDdf6AiNT0IXS/6Vmb9gCL0RJaPSoL+B9v0iFeWJbJbQEWfzHNE0
NGxPV9bRV5Mi9Cw97y59SPpVRKg24cedVR6+t5bIM0EY9T9XTGxhMsp02DUYm2IS
uszEQu7LIM1h2BKsVZ6AyQVXCTpxxA==
=kFY8
-----END PGP SIGNATURE-----

--UOBnuC81RE2vEHCp--
