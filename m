Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73689613756
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiJaNFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiJaNFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:05:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01112641
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 773FEB810CC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD87FC433C1;
        Mon, 31 Oct 2022 13:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667221520;
        bh=oMzkAhlToSQ+y7hnMNN1W88+rvPx+BGTFDdvn0Frk2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I4xEz5Aw5h799PKIZL/XOZeTwzJdDbxOr50R59iheDHX2LJIg3UCM++8a3SYt84lD
         RGZ1GZh+pAAXfBwKxFnzVvTxOEuCzQKmF0lEIrNNhdzjsMCFZVvFo3fPZMt70TCEiw
         fL/796Durl9Tqq6SHV3Ym++hvGbJwKORu0qvEHvMGLfmxXwH5qqkGxK6VXa+x89uf+
         t5EhDalh9WrUP9lhHku0rXtg4J4clb25yAqlEbM2JHfKOc7jB/1IBa1PPE4amUXJCO
         RWwikSfS0+6DaRCqyoctkH3fwD71g7JMa7Y+sMBnBWPmxGeddxtxuJ7cDZV0GMN91Z
         mpZ6XavmTXnAQ==
Date:   Mon, 31 Oct 2022 13:05:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com
Subject: Re: [PATCH] ASoC: core: Fix use-after-free in snd_soc_exit()
Message-ID: <Y1/IC1DWcKzvSDb5@sirena.org.uk>
References: <20221028031603.59416-1-chenzhongjin@huawei.com>
 <166697367874.746166.7503879951900455151.b4-ty@kernel.org>
 <b30fa009-9174-da95-5799-149837e199e6@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QZ7hMdAlNIB57gBZ"
Content-Disposition: inline
In-Reply-To: <b30fa009-9174-da95-5799-149837e199e6@huawei.com>
X-Cookie: Sign here without admitting guilt.
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QZ7hMdAlNIB57gBZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 29, 2022 at 12:34:19PM +0800, Chen Zhongjin wrote:

> Since snd_soc_util_exit is only used in snd_soc_init() and snd_soc_exit(),
> could you please add this fix to the patch and delete _exit for
> snd_soc_util_exit()?

> Or should I send a v2 version to replace current one?

As the mail you got when the patch was applied said:

| If any updates are required or you are submitting further changes they
| should be sent as incremental updates against current git, existing
| patches will not be replaced.

so please submit another patch on top of what's there currently as
normal.

--QZ7hMdAlNIB57gBZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNfyAoACgkQJNaLcl1U
h9CX2Qf+OpDCwX7t6meJI+8v+yhNft3jsdesFyhf8j8r9cuweHHXsC3nJ08PGC3U
7s6eJbdElx+yhkP3iK1FSWzs66z/FiDm0/+3xy/u2jf5H2vC8AB0MwvIDEkYiE5U
V/FJLvGDVuoAcwMtsoGE8YrHDjIOJfVPpoH/a+Mg0hcuA4kQHoLa1t4783Hz90B3
MxYASdDpZtraau3zs3mFDqzzyLzajH/HQ+EZmkW2KWtdy8mQb8na88QopJmez5J6
8gZc4zHCiOJfL1V/XCTjzgN4ip5TDzw7aBNdRhYIytpywRqeFOabwtXAkNJO3zvP
vHNovgi5bFuljp5XQ8D+wsDdpFVn2g==
=7rVX
-----END PGP SIGNATURE-----

--QZ7hMdAlNIB57gBZ--
