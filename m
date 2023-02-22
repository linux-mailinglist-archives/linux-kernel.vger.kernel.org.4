Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3561169F4E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjBVMuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjBVMuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:50:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEDB3403E;
        Wed, 22 Feb 2023 04:50:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 567A0B81588;
        Wed, 22 Feb 2023 12:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CBDC433D2;
        Wed, 22 Feb 2023 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677070232;
        bh=lXJSnYFpOaH9S5ry7Q34tB4Egx1wpGFAl6NuADLurBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LFo50uq2a2lA9uGWYxtbfavlMVkm3Yw72WJhQ8xxz1mRv6jd9TUTNMIKxGTUysNkr
         Nb+k0Y2e0731kuVnUNSdhcFr8SgH2tESnmrJMz4MoUT2GiIIpUcWTL4UlSUKj8nza8
         q5thst7AHxbAJykp867AghZyOOBLmzqb9eyzgr4fLIhilcVBGOO04sckVNohyC+bI9
         uC8vi0f6X8jbilfirxI6p9QksJ+8VTLFHuRn+oGtnsSuzq/K2Kiojo/UTpmypEemUE
         ZsgVCUAEnQ/8IGyRxe0mrbXm8CUE5HV2X8yql0QQ7274S66o3maduQP4PZvSGHu7le
         W4EkztwzvYlHA==
Date:   Wed, 22 Feb 2023 12:50:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: wlf,wm8524: Add a property to
 specify power up sequency time
Message-ID: <Y/YPkgOreByREmOz@sirena.org.uk>
References: <20230222113945.3390672-1-chancel.liu@nxp.com>
 <20230222113945.3390672-2-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pnbOLaS+zEft1evo"
Content-Disposition: inline
In-Reply-To: <20230222113945.3390672-2-chancel.liu@nxp.com>
X-Cookie: My LESLIE GORE record is BROKEN ...
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pnbOLaS+zEft1evo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2023 at 07:39:43PM +0800, Chancel Liu wrote:
> This property specifies power up to audio out time. It's necessary
> beacause this device has to wait some time before ready to output audio
> after MCLK, BCLK and MUTE=1 are enabled. For more details about the
> timing constraints, please refer to WTN0302 on
> https://www.cirrus.com/products/wm8524/

According to that the delay is a property of MCLK and the sample rate
rather than a per board constant, it shouldn't be in DT but rather the
driver should figure out the required delay on each startup.

--pnbOLaS+zEft1evo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP2D5EACgkQJNaLcl1U
h9CbBwf+PFUPJ7J2/dmJK6wM+TWjfAtu4keu+9j+lOKo3Pnkd/BlCPx73MZ+DWsZ
9HspBYBZ5wWZLV4CJMusG+v9Th9nB5ojpBW5hLHVlml9+IfdIm3zE9gm72M8pRZa
xP8/dlMRVOwZgA0BO3xsncSJ+2N/WBHEA0A74LUYJlpSMYdSwi0LlFBF/6CilAm+
CzpVBYBJj0/8SgfMv02kV/3BYRepWg/U2BhDJr++vWMs/ELAGs4P+UK95IEDT3ca
Ueu333LU0a2J09wYLIy9UpY9UFZGpKnFTmreetXFBPySKtHUWhgzjtVGvXE+AiRS
fcC4ecoxVBYJmBgSyvhxLef+uHMgFQ==
=HX3c
-----END PGP SIGNATURE-----

--pnbOLaS+zEft1evo--
