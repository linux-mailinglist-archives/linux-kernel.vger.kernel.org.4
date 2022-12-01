Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20FA63F610
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiLARTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLARTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:19:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EB9AFCC2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:19:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E8FB62085
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 17:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C0AC433D6;
        Thu,  1 Dec 2022 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669915155;
        bh=J3qpPB1+Aa02AnbYQF9W9JopidPa9UyV+yZNnQAzE7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aok14xtgfm8yhDqhqlDD2kEU8jOJhuobilFLOGEIX6621B+9RqxaGI3rt3Nq5lfEp
         2HuCeR8uumVNG7Wya9/YA/wx6w4AXNOh4mADeIdjw0zQ1VQKMyxiNzaDiDxTvZOJNO
         7JQmTYOJz753dD84aW+xf0YVNIYWO3UYEV+x3BUMlur9+R5H/xGZ84h3f28No6ScJd
         2H+5SpcJam8syYqXKQ3IKCNVFSlfFF0Tm124zeubo640BQ+xsRIaVtL80T4y/vGh20
         CVysH7Cw3UrwJhZpEYNA/3P0yT5r2og7ouLa/Me0mIzdZ6WHDtP8IY2WtoHGg5VHkG
         4ZnukxO8E7OJw==
Date:   Thu, 1 Dec 2022 17:19:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     lgirdwood@gmail.com, javier@osg.samsung.com,
        mirq-linux@rere.qmqm.pl, christian@kohlschutter.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: core: fix resource leak in
 regulator_register()
Message-ID: <Y4jiDYmblQsRGwcd@sirena.org.uk>
References: <20221201122706.4055992-1-yangyingliang@huawei.com>
 <20221201122706.4055992-3-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PxXMnz70Spqy/SJk"
Content-Disposition: inline
In-Reply-To: <20221201122706.4055992-3-yangyingliang@huawei.com>
X-Cookie: Leveraging always beats prototyping.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PxXMnz70Spqy/SJk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 01, 2022 at 08:27:06PM +0800, Yang Yingliang wrote:
> I got some resource leak reports while doing fault injection test:
>=20
>   OF: ERROR: memory leak, expected refcount 1 instead of 100,
>   of_node_get()/of_node_put() unbalanced - destroy cset entry:
>   attach overlay node /i2c/pmic@64/regulators/buck1

This doesn't apply against current code, please check and resend.

--PxXMnz70Spqy/SJk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOI4g0ACgkQJNaLcl1U
h9AScgf+OKVzLQHCiUWAsZCMXeEAhn//VzjUI8EsR28vY6YMjLrY6joY2GqRieIc
N3FW9346TG31V84iCBpPYeJSKikMQZx8jE5DlVQTrNox+cNJ6aMg5yVarcpNHFHF
pREYFrGoT639Obo8X4TrgXOjXI8V5wh6VFmAczJ8jU6ubW0UPnPtMPbooqgN0FTi
7USs5y/tjpBm4Irp6PKVgBWDjIyMY0YVXwcJ4/xXk4giwqbrn9n2i/lLRUYANVus
t27L5Ee5KIPqb7MVOlmoxR2RsMSDH5OJ9NtZeXEK5lUXx3vTXCMRM6PrL867x4iM
VRAPCfuHRFwLZkrwgTZlDjya2NkhEQ==
=ksww
-----END PGP SIGNATURE-----

--PxXMnz70Spqy/SJk--
