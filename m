Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705777355A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjFSLVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjFSLU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:20:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D3C113;
        Mon, 19 Jun 2023 04:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1689E60AFB;
        Mon, 19 Jun 2023 11:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A417C433C9;
        Mon, 19 Jun 2023 11:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687173645;
        bh=TCyP3MTK9D8/2GgV8QtO5pJImHNQEoTXD9BrcpmOPeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EeN13VgCF7HvQLeN8f3NVM2QepW/cThlIGx6tTXmWV3CvQITV7FMDjf4WnW8kBJL8
         hfPmb0f7IFPXPytBrqVR2jcjxvA4GfC16k3MnX5qy+QwZK0Fd3hos+4Skl4lYjNMC8
         90tXi+BRaqVDnwbsuxvd17HBj6UbRP/8DywVVqy02PHyRbfmZ5I8uSaluKxvI6x0Qh
         IhS9aMBTMmFa7PiVBAvhdPVNOdumKKpEWJW4cuPRfLhtcwvJm5Rmrkb2BCylvA0ren
         4JZSE9sedpOpucIyL0HGiE+J+a81RVwdxsmC9U1xZYXBuUEo0hNM9IrKqdfNduPq5N
         fCejfIFAbg1Qg==
Date:   Mon, 19 Jun 2023 12:20:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     YingKun Meng <mengyingkun@loongson.cn>, lgirdwood@gmail.com,
        krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Dan Carpenter <error27@gmail.com>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v4 1/3] ASoC: Add support for Loongson I2S controller
Message-ID: <ad4722ec-0fa2-4bb2-879b-47bcbd96bb0d@sirena.org.uk>
References: <20230615122718.3412942-1-mengyingkun@loongson.cn>
 <cf2f3bc9-3141-8d7b-b57d-73eac70a21d2@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="srSkMy3jZsgNxOgV"
Content-Disposition: inline
In-Reply-To: <cf2f3bc9-3141-8d7b-b57d-73eac70a21d2@oracle.com>
X-Cookie: Prevent forest fires.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--srSkMy3jZsgNxOgV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 01:41:48AM +0530, Harshit Mogalapalli wrote:
> Hi YingKun,
>=20
> On 15/06/23 5:57 pm, YingKun Meng wrote:
> > From: Yingkun Meng <mengyingkun@loongson.cn>
> >=20
> > Loongson I2S controller is found on 7axxx/2kxxx chips from loongson,
> > it is a PCI device with two private DMA controllers, one for playback,
> > the other for capture.
> >=20
> > The driver supports the use of DTS or ACPI to describe device resources.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--srSkMy3jZsgNxOgV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSQOgcACgkQJNaLcl1U
h9CWMQf+Ici0ppIkITqxxvXumQa86CMD72Cxfz+kO2FGvaIcayPescQ3j/43UKIb
AjvqoIA3Y6nX4w0WbkTr0pBPhV0jAxNHrv7Pc+wAEDdu8FEpFR/UXPllUwVusGqf
cm51zP1Z/xPr3LluBa0J5y5gWcf1X5iXe3tEWVlSp+09cs0yPkaS8BNU6nk9rn2J
yzbB1623/h0RJPrAG/6x71iHnOTyK+ebyLyRTNRfNOdii503bKf2BIClwLp6Zsqu
BOIMPbFpZQUWgRamCUxpBi+evdWmu0xIxTDzOsY5gQKfRib+4Ey538+NSEp0Qaoy
MoNr1GOae9rRO2D9WqCiQygvSudLeQ==
=C+Ao
-----END PGP SIGNATURE-----

--srSkMy3jZsgNxOgV--
