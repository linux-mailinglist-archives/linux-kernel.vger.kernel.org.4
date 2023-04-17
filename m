Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FE16E4843
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjDQMux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDQMuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:50:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E53B91;
        Mon, 17 Apr 2023 05:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDAFA622DE;
        Mon, 17 Apr 2023 12:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD73C433D2;
        Mon, 17 Apr 2023 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681735849;
        bh=UczuSqIXTjtZSosfxGSRKj9p/J65j7kPX67F1Nv0d+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tIqWMEChQL+v74duVfeFOL6Xy8ZCAZuAgBXzQJ2dQpFb1rfGECjVvn9wn3cynNAFN
         cGeuvvYtlO0KrJAxTI8jC31wEoWskiUX6laljtaxm71+N5QOoAuA+EyIMRRiN3jJ7T
         48RrY41sPxvtkhZYRHzppWpe3QzHvnJ7Bg6CsuH8+Oh8LJ1hxWxeSBif9rN2CejMjl
         4mpvsvYZcb9rLFgPWtsnEA5HD6m0gi2+RtyvDrHWF/SRziQMtPHbYIMPCcVUUA2Xsa
         Ikwzw7B1asgoP6/Lt7MnWbU8WKk3JCIjrTXexTURkj8smB0jpJigeKn+gHEYd2ZOb7
         YWZ7rjSl59EjA==
Date:   Mon, 17 Apr 2023 13:50:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>
Subject: Re: [PATCH 0/2] spi: cadence-quadspi: Fix random issues with Xilinx
 Versal DMA read
Message-ID: <62436618-577f-432e-bc5a-94a8dd30483f@sirena.org.uk>
References: <20230320095931.2651714-1-sai.krishna.potthuri@amd.com>
 <BY5PR12MB425810A4B57D1C12AE170927DB999@BY5PR12MB4258.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f/V95cXqf8Qetk3a"
Content-Disposition: inline
In-Reply-To: <BY5PR12MB425810A4B57D1C12AE170927DB999@BY5PR12MB4258.namprd12.prod.outlook.com>
X-Cookie: Two heads are more numerous than one.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f/V95cXqf8Qetk3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2023 at 06:05:15AM +0000, Potthuri, Sai Krishna wrote:

> Mark: Do you have any comments on this series?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--f/V95cXqf8Qetk3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ9QKIACgkQJNaLcl1U
h9BPXgf9EOlILDXHQ5mr85hW1hitecAy59tAmt9s0G7/Jp3fYR3Sv2smP5ldmTbs
6wLd4SuUVbYY9Rdf84/fnSIBw8dEsH+aM4xCa6S7o0W/VfP66oCNk2TuA4SBcdfd
eDqO0FiuMsM12A2oEtYuxdg2PtPGi2zCQCGzyX+ga943BtIv7RBXjW6POoeL6ZgJ
oVrgxkACS5OyBKlfH+lS0671q9V7IXseW7LRaT7zQ+r071d4g6t1v/wnLOu4DIV0
LpLaTNTHWLMxJBE8+kDmqXWvHLHdYk9SKRSLpply/5GXgZ3RoCheVtun2/uCZN4B
1LRu85gYZKGebszyUA/5kkCR/htkcg==
=OeFJ
-----END PGP SIGNATURE-----

--f/V95cXqf8Qetk3a--
