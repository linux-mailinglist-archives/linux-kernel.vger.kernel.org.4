Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378A45B866C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiINKbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiINKb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:31:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B5F4E60E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 570ACB818D2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 10:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30D4C433C1;
        Wed, 14 Sep 2022 10:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663151486;
        bh=l4wW4IhHFdzTrRQDPvpAZ3ls+LMCcLxPlRB4jghtJK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pc4mogNGati1t0kHPVDyVBgeGhO8+K0arXo6U2+5idoDs0DIufVZL88zZ51rz7HYK
         5Bns2n2XXn6VZ127ILfg0d7IgDU+Ij2YcOX/MdqiLbfWrHleCEXkK3sx/MeAW8gSwE
         m88IQjRJqk34Yd5Ae3a8EtApn16cECHYa66w/TY7H2jXGb5SYq6p2EaiPJrGs1hBiG
         gg4mRpI5Z/Ffb2VlGN255pUAdgPEXwkTOHzZFliXsAOaMnoQkiToEY6UK5DfXPaGr3
         iqWJAmg3PUcgP7Pmxg8ZqhqcL6q1rqtRYqw+A9SaPLqCEO6Dx6tOwuQ7DJ9OuN8Kyp
         bQni8vdkg36Cw==
Date:   Wed, 14 Sep 2022 11:31:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>, cezary.rojewski@intel.com,
        tiwai@suse.com, ranjani.sridharan@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, perex@perex.cz,
        liam.r.girdwood@linux.intel.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: Intel: fix unused-variable warning in
 probe_codec
Message-ID: <YyGte0fkdquTxLC4@sirena.org.uk>
References: <20220822035133.2147381-1-cuigaosheng1@huawei.com>
 <166314841746.314266.6045600836637107787.b4-ty@kernel.org>
 <87zgf2tfn3.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C4xa30MXwHAwdNRz"
Content-Disposition: inline
In-Reply-To: <87zgf2tfn3.wl-tiwai@suse.de>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C4xa30MXwHAwdNRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 14, 2022 at 12:27:28PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > [1/1] ASoC: Intel: fix unused-variable warning in probe_codec
> >       commit: 515626a33a194c4caaf2879dbf9e00e882582af0

> I thought the buggy commit 3fd63658caed9 was present only in my tree
> for now, but if it's in your tree, that's fine to apply through
> yours.  Then I'll drop from mine.

Huh, right - I think you're right here and it is only in your
tree, it just didn't trigger any issues in my coverage tests
prior to merge.  Probably best to leave it in your tree and
either have a double apply or I'll revert it from mine.  Either
way it'll get fixed by the time it gets sent to Linus.

I'd not remembered that you had any extra stuff for ASoC in your
tree, sorry.

--C4xa30MXwHAwdNRz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMhrXQACgkQJNaLcl1U
h9C+jQf9FQwAjMtYvHZ3if8fr7vf+rJEXBpY25PWq5EI+r8ayTVRgzF1WmM1+WVC
a1JeMj4eyHdSDxCOEkg+DWiE0cxk9MwgmySqmEowRaK8v7H85UDYdeqCToyZLv4J
gTc6MvXhXrO1XStNEcASI0+SVxJg8PcBMpiGi3O3bAfFjpDLoBAkrlGiQnU3hyal
+MZBvmtlMmFbFvLY1ev0/PCwDlRohCPVc2S/uWVa8oPW7qb+Nfkw7AbYcBUsU3KY
kKjf9/m6F90yMW4yUzvlOGp43SJcKP4tqQA1d8Da3s4IRw2FJOzd7R0YN9d7eAyq
fnBS5184hFfUTDFHlMAEFkAQ0N0XSA==
=fVaV
-----END PGP SIGNATURE-----

--C4xa30MXwHAwdNRz--
