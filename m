Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F9E60F931
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiJ0Ngg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiJ0Ngd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:36:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6F2180253
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:36:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E2A1622F8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5E3C433D7;
        Thu, 27 Oct 2022 13:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666877791;
        bh=fcD3i38tih/t450LyEv0RqQmZcGH/IRBhD3dzjW7Ntc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p2dD10/n12DRMFyjak+v7jZXOk9zlkcHhT5zkKeAvSDmH4ZNifqdEJowSy4MfCt0R
         +R+qYpZtqVX/LIswpRVepyUp3RNVGFAFuQhHljbBupOFwyludIvqvi6lJ0xnJ225r9
         /zxrKcUw0JG/BX86NeaQ8R5yWoJnWQeHqvJZOQh274ijer8NDA6JIQuCw9qjb45v6p
         LwUZ4zKsKZYf/F/YetfAkco8c+deTpKiXAkkxAwbw62CnTsTB0wy4LHfitNlaEluG/
         GNa0oVV2sc16a/PKbNS0p7TyIPdmAYz1x39DPinXHpqX+pN2l9Sht/I00ngRReQySz
         0S7sXqIps/fEQ==
Date:   Thu, 27 Oct 2022 14:36:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "C, Balamurugan" <balamurugan.c@intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Chao Song <chao.song@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Wang, Rander" <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        "Song, Gongjun" <gongjun.song@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        "Reddy, Muralidhar" <muralidhar.reddy@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Ajye Huang <ajye.huang@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>
Subject: Re: [PATCH 2/2] ASoC: Intel: sof_rt5682: quirk auto detection
Message-ID: <Y1qJWDXishQ0pWkM@sirena.org.uk>
References: <20221026071409.3235144-1-brent.lu@intel.com>
 <20221026071409.3235144-3-brent.lu@intel.com>
 <6916c126-c710-330a-ffcd-50dd3cdc47d3@linux.intel.com>
 <CY5PR11MB6257D168A60B712088BC7CF797339@CY5PR11MB6257.namprd11.prod.outlook.com>
 <bba5dc19-c0c4-2409-6cd2-c8fa91950444@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aSBYaSpkfMbKyRhv"
Content-Disposition: inline
In-Reply-To: <bba5dc19-c0c4-2409-6cd2-c8fa91950444@linux.intel.com>
X-Cookie: Forgive and forget.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aSBYaSpkfMbKyRhv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 26, 2022 at 08:30:00PM -0500, Pierre-Louis Bossart wrote:
> On 10/26/22 19:13, Lu, Brent wrote:

> > I'm thinking about using kernel module parameters for those boards which do not
> > use default SSP port allocation. Not sure it's doable for machine driver module.

> That's not a working solution IMHO, the kernel parameters should be used
> by expert developers only for specific and short-term debug. It's not
> possible to add a dependency on kernel parameters, that would prevent a
> kernel update.

Right, and it really doesn't work for distributions.

--aSBYaSpkfMbKyRhv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNaiVcACgkQJNaLcl1U
h9CpWAf9EuU66Nkj3rIR3UHKpodUXBtYkdKdRpjY+l4zDJeggtk6ReDLj3r8Ea/+
JpKpstTYUlLNorsKoXY6E7N396S8hk+JVGJus+V4Xmea5OFBVQfTu41ueUTkDNBT
r0d/QSs9l/UGm++YNyWOIgVoftSLfbFwsqqFPw0opUM3ImbB4CDft52x0Mm6StHQ
riUAV2y+uXmzMK+oE+w8QyegxHttJXkjHcFcM0ok5iAoA7g7bezVVFEE1ndw/T1M
1HxIMVnKbI4xGcaI6w33rguriufF4mATS0lao/vejizB7OUybHtW9gaQfA73xKDA
IQMq7EDowX6yJuFM6BLon8N+QfLQaw==
=spCX
-----END PGP SIGNATURE-----

--aSBYaSpkfMbKyRhv--
