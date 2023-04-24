Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6648C6ECB9E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjDXLz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjDXLz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:55:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDACEE45
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:55:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26E3C62014
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CC1C433EF;
        Mon, 24 Apr 2023 11:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682337355;
        bh=glewMWZKTeNdvbCtF84pldO14qWrt61fP2MSRhuaPCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ST2WdDcN0wSkEVyW6+bVur+jz3manJismlS16g8CLpxUipItW9eZm8OC8oWSQZpJU
         X0fkNrDwfP4s+j8GCZhAORRr5djlLqXff9UXKcZxtT8BmQMDJFpns/IUgP1/HKnZn6
         opCkcMSYoUrpQQoZINJ19mNRLHm+7GcJLHWTSWM50Yxf+9671Vdhz0DU9/301zx3Gy
         JU1ha7RMZJMakzkkmTYWcbqxZAgL0eKJv0xSyq57rvak3iTzlJVoyx0Su48lIfX6K6
         phoTq5x33ye5FvK3bLqn+gl4mgO729YhpgBCeiv/93qxyJBd3LPHyG8/JWDdLUQ+jZ
         Q6caGt0fwiYPw==
Date:   Mon, 24 Apr 2023 12:55:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yuchen Yang <u202114568@hust.edu.cn>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: regulator: core: remove return value check of
 `regulator_init`
Message-ID: <888091b8-b83e-4999-b5a4-04e6d6d36bc2@sirena.org.uk>
References: <20230423122732.31135-1-u202114568@hust.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mIGrXAIEMSPH6/5l"
Content-Disposition: inline
In-Reply-To: <20230423122732.31135-1-u202114568@hust.edu.cn>
X-Cookie: A rolling disk gathers no MOS.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mIGrXAIEMSPH6/5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 23, 2023 at 08:27:31PM +0800, Yuchen Yang wrote:
> Smatch complains that:
> regulator_init() warn: 'debugfs_root' is an error pointer or valid
>=20
> According to the documentation of the debugfs_create_dir() function,
> there is no need to check the return value of this function.
> Just delete the dead code.

This is very much a taste and use case question, you can't just delete
error checks without thought.

> Fixes: 247514344492 ("regulator: Remove ifdefs for debugfs code")

Don't just throw random Fixes tags on things :(

--mIGrXAIEMSPH6/5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRGbkUACgkQJNaLcl1U
h9AXiAf/XBzcj9QeR1CURHm+U7taFrdDb14xxyuSgSLnNzF38GRpaTkhOHM5wt9z
gsVlr/XJZfb8NWAOF6WrMcrc3tYSV6CutVJnodwiC7exRAfTHR7h4dfdOnLydSPH
ZkhxfiPLf2KHrCI7+WZyKCUi/ywVe0fn9z/AOSC204RKZSvq3tiaJ11eJQq0/MYL
R2jAaG/xZoPCI5ny68RelEYP10UKJrjjSz4myJ7YKftUCpJoCgU4ZF1GxuXlgpWG
8qU+BvoG6uwKaDZqy32S/nlXwofbramY5TLG1iEV8P3SenpFRKOsAUs6FtbRvUzR
gckVQ9ARmP4ghLQP6E7UlckSDnf1hg==
=Zqk4
-----END PGP SIGNATURE-----

--mIGrXAIEMSPH6/5l--
