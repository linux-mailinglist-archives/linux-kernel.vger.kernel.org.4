Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9D56CDB3D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjC2Nwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjC2Nwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:52:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ACBC2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:52:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63225B8232B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 13:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFBCC433D2;
        Wed, 29 Mar 2023 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680097965;
        bh=tY3+1vFhOirM40vPbYkObuXOJ7tqvmbmhcySnP4jWro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O4yhJzQl5nKtyqlKnhAOGYjDqRWK23t8SVM6E5dPIsuLSBK2+nWmgnVsMY04FPK2D
         uanmg7wiO++ULsgWYkPo5mbCXOFcrgSpMWYlp89IOgSsJSlZFG1Ov9viJaQdOEwFLd
         sjB68lBIMUU1/VxFqMbCcjR29j5Xk0c9TwVOBVZ+kwPgwPBe+Pje5FU3F4JxzSjZdf
         J8u9tQHTNjgIFVVYjIpth+KKaQOR46QXjWQ+CtKJ0vEMYiDkmvoFMBWw+/ueBqP/45
         FdWlDXDWdZBi3uPuI3d3icvZLCC6UDYbxQcmyebxbmzpdLqx1kWCqY+4iPNAkMXdOO
         2t9rxz8N/BFtQ==
Date:   Wed, 29 Mar 2023 14:52:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     =?utf-8?B?5rKI5LiA6LaF?= <zhuning0077@gmail.com>,
        yangxiaohua <yangxiaohua@everest-semi.com>,
        Zhu Ning <zhuning@everest-semi.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables
 sound for systems with a ES8336 codec
Message-ID: <ZCRCqJ7oG6oefo9g@sirena.org.uk>
References: <20230320203519.20137-1-posteuca@mutex.one>
 <20230320203519.20137-4-posteuca@mutex.one>
 <141a3320-ff65-459f-9d00-c8bed691dcfc@sirena.org.uk>
 <87lejpwxzf.fsf@mutex.one>
 <ZBr9rJn50ovG1w9W@sirena.org.uk>
 <87ttycjyw3.fsf@mutex.one>
 <ZBty1CdPaWm0IcRi@sirena.org.uk>
 <87r0t9uc08.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FsDe0pyTf46JNN5d"
Content-Disposition: inline
In-Reply-To: <87r0t9uc08.fsf@mutex.one>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FsDe0pyTf46JNN5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 28, 2023 at 12:20:55AM +0300, Marian Postevca wrote:
> Mark Brown <broonie@kernel.org> writes:

> > Surely if nothing else a good first step would be to have the
> > CODEC driver do whatever disabling the jack does on suspend
> > without needing the machine driver to bodge things?

> I would go for properly analyzing what is going on and try to correctly fix it,
> but it's going to take some time for me to do it. During this time
> people with these laptops will not have working sound. Wouldn't it make

Did you try my suggestion of having the CODEC driver do whatever
is triggered by disabling the jack on suspend?  That should just
be simple code motion shouldn't it, not something that requires
extensive investigation?

> more sense to first deliver a working solution(even though it's not
> perfect) than to make them wait? Also this workaround is already present
> in the kernel, so it's not that critical that another driver uses it.

On the other hand if we're getting the same bodge done repeatedly
in a lot of machines that suggests it's something we should stop
spreading...

There was also the issue with automatically muting the speaker
when headphones are inserted which will affect UCM files.

--FsDe0pyTf46JNN5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQkQqQACgkQJNaLcl1U
h9AOYwf/ZwnNSUNFjDGXksy8GfP2Xr84EbJeFIfVFR6AMp8OwyxywdjeNMR67cSx
yW9tIwQaJQhyo7CUOD76RdZm80yqAuZA9cK0IOc3Sg5epntjbQkF5rEhvoYTw7rV
tVM0TLzI8B/qaGLkDGyTjdfFn2M9GbkYrDPXnjta6Jrw56iC8uKiP2lGDTsjFTv2
dM4KxRY4KHhZjDqXEPFOlwoLF/cz+xkfBqFVpQea+D3UFeM+FabbHzsR4GkJYk0G
pUj0jx4WF4qHsxXUl2OnF4tmx4H+3l7NohncMqS2llTQwuK3yObBFLpnJc3hHTiT
1EsIVCwvdRpJBbP3JkCVgDilWVu8jQ==
=NZyJ
-----END PGP SIGNATURE-----

--FsDe0pyTf46JNN5d--
