Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA9E6DF4B7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjDLMKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjDLMJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:09:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A0E1B0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:09:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A61A62950
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E744EC4339B;
        Wed, 12 Apr 2023 12:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681301386;
        bh=Q+87XKVYuHwf+nmYe7F44XKhOf48mLS9pm4sbsH0fJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ucgwjt/JPi5iZBPiy03c3YjdzLa/tyjWToGByShxa6PtzxhvkezWW1ZuIqn6RWHpw
         ulsHMsvuSEGNIYzRORzPn719W4w3bCU5mjd3wnrk8aKgdzsqwe+NPPoGRB/nK3pvGO
         YQwuBSKS1PjkopVhcwBMwPPwoyJ0k4xev8HS1P6vdMDcXn5aI1XcRTQ2DT2PY0mEVk
         4f48BGrJdpgJUt4zI+JdF80ZlxlyMYO+qMS8/+h+ZBgZup/aRP8Mv6tlzaKyr6DU9v
         RoabMnbBLovhI+2sYZdIqiVpqETP/2ZC+OzJ8xQADo425ZxwNdI80KNNh63q59Ej7i
         ihvHDpBg3+xgw==
Date:   Wed, 12 Apr 2023 13:09:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Baili Deng <bailideng@google.com>
Cc:     Guenter Roeck <groeck@google.com>,
        David Rau <David.Rau.opensource@dm.renesas.com>,
        support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: da7219: Improve the relability of AAD IRQ process
Message-ID: <227d1f11-dea0-400a-96c9-dee568730a13@sirena.org.uk>
References: <20230410092634.4870-1-David.Rau.opensource@dm.renesas.com>
 <d9dac02a-328d-485e-9aff-158852eeb990@sirena.org.uk>
 <CABXOdTfGD_fyi+itsr9Nd834Pb6+4Ej8M9SM5AN=uhXQ1K4DiA@mail.gmail.com>
 <CADP_shKfY6-F_4+_eYv=NC9XcgVA+0H3BkCqH8D9wkqJ5SpMDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HGqq5x0t3aI77m3z"
Content-Disposition: inline
In-Reply-To: <CADP_shKfY6-F_4+_eYv=NC9XcgVA+0H3BkCqH8D9wkqJ5SpMDQ@mail.gmail.com>
X-Cookie: Happy feast of the pig!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HGqq5x0t3aI77m3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 12, 2023 at 10:32:47AM +0800, Baili Deng wrote:
> The change in the patch done to address the issue Geunter mentioned is that
> da7219_aad_handle_gnd_switch_time() is now called before interrupts are
> enabled. To address the msleep() issue, the delay is now added as a delayed
> work of its own workqueue.

The point with the question was that this sort of stuff should be in the
commit messages.  I can't really tell what the change is supposed to do
as things stand.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--HGqq5x0t3aI77m3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ2n4QACgkQJNaLcl1U
h9Anygf/ZHIBfSJdWGpYgQ5BSRZ4BRIeIzoPwlN7HkXB7lURVXdyGnp9YPjzvLa1
9wRVQOX7rhvketKQX64797qKzSplQoOKLudaRkjdWQHllB6HZpciEJ56kdHMKZoP
3u4HU4fMSIgNw5DV2lRJ47q8fjxm9pB3G51eSvFgpgPFWXs1OKzU058x5n8QYRzG
LDE6UlciSv2m+jW8Z12EPVNxRKmX6RS8C+Jy8GYFGhTU79mdIpeoAAHpYnF2eFfS
s4pEBCm0LCE1ySS/rf1Vf6s6Ayn+Gu1vavK/GaXa18MXJ08aozU8VxeIEr/vxgPN
BkMGapPp/y8XiseNNXv1m4bMF26HFA==
=n3/l
-----END PGP SIGNATURE-----

--HGqq5x0t3aI77m3z--
