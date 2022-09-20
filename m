Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B60A5BEE41
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiITUKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiITUKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:10:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E9271707
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:10:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1E76B82C4C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4404EC433D6;
        Tue, 20 Sep 2022 20:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663704636;
        bh=ju5UjKZq4kslVshB6alWMSvgvdnqmkZJiyboxP/Sff4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AkmXgPtvvY78KhUlfTn0PIrfzaeVyu1AFAHcFPR6PwkkUHJVYDvjk9Q4UqrXLjDFO
         F3ztkEnaFrersuDVY5Q6k216S3OusOXZZA/2fzUtwqcW6WW7govXwdPm0vj9TuWv9z
         kIwWao3nVwY+i+SwJH6B8+slOHB5WfNNp1eoLMeAN2R6QZ5+oyPzjhi7ojQWisIY7r
         +qAPl2OzyLaOGsHlmfz92zHo6UtJll7l3MXPPlMTv5v55jhODtrdHEJhAuxH5u2bRv
         SnGaRaFjftRcJFDIiFVFqHEDKb1DtJItSzyJyDIU1oVp8yvGxITdpZTkA4y2vgTnNF
         z0lMldD/JAv2w==
Date:   Tue, 20 Sep 2022 21:10:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Saba Kareem Syed <Syed.SabaKareem@amd.com>,
        Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        Travis Glenn Hansen <travisghansen@yahoo.com>,
        Sebastian S <iam@decentr.al>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 1/2] ASoC: amd: yc: Add ASUS UM5302TA into DMI table
Message-ID: <YyoeIuQkI3SNkjD8@sirena.org.uk>
References: <20220920194621.19457-1-mario.limonciello@amd.com>
 <20220920194621.19457-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t2Iu1/keNZTUJyRf"
Content-Disposition: inline
In-Reply-To: <20220920194621.19457-2-mario.limonciello@amd.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t2Iu1/keNZTUJyRf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 20, 2022 at 02:46:20PM -0500, Mario Limonciello wrote:

>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216270
> Signed-off-by: Xiaoyan Li <lxy.lixiaoyan@gmail.com>
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--t2Iu1/keNZTUJyRf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMqHh4ACgkQJNaLcl1U
h9CCjgf9Hx5OKV1Vuzb2J73P8H4hnThiRcynSMMsdSpg1Q52BrwFhqanX2gQT/F9
X85gdtbaO2rq1fnnmh286DILsbHJBTlnV08nqJIFwmuk+pc+e8mdCeDcwR3utvVp
N27JV7MqczefPADMQUdx9vXTDnkh6H7phv6/HAzgSCIxS+kNNOaorklmfaiw+94E
2qnKP1duYWlNRYqYYX5XkR9d7MM7f6Vo0/Flh5KpDGffrYl2GbblZwLSNKvpmXHn
5+fecbHM8tU6CSIo1VQfzPg4TqO7sh8RJ9WWaCAEaay+6gvb68G0Y900IM9BTkcJ
CS0LVbZF9tS+CV2GuPG7zUjfHy8jlQ==
=KOkl
-----END PGP SIGNATURE-----

--t2Iu1/keNZTUJyRf--
