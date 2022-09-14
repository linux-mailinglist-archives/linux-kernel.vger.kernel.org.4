Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E476C5B90B3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 01:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiINXCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 19:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiINXC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 19:02:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0585E86C2B;
        Wed, 14 Sep 2022 16:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1696561F46;
        Wed, 14 Sep 2022 23:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB03EC433D6;
        Wed, 14 Sep 2022 23:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663196547;
        bh=3kkWgbvO9bEVvPrgr2yHaS27i2sauSwrvj21/TsPcVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iC0zA2V4RI+NMWe8YKz6QNGcKu/qYLXVoyzGDJpptjnKTYzSmV9TlzgX7O8p0hAPL
         r/vKNEumu+IdDPwO08xicOWw7CS/e5MxkGfsyreKLVbASuxFuJ/hOda/OMxgSRUMiJ
         r3x46I14i4CTy3hz5yDSoqkPUgVaCk1E3SiiOjTcXAWUVLIPIKplKPaghad7SO9Kyi
         oWL+WnpnvMkIKFQj3bcv3IeSzW5AVkvpu5HQ19bxK9Aphi69CAvwc1dnlNGTLrDFqQ
         Wr0WC8tZFFxvdkbG+UUBVHEuAt+H8VSoljOBGiwSiBJ787Jsb3ZhqLk0hvFpkm8WDP
         IWhYdh1K2TNlQ==
Date:   Thu, 15 Sep 2022 00:02:23 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Lin Yujun <linyujun809@huawei.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        akpm@linux-foundation.org, wim@iguana.be,
        linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] rtc: stmp3xxx: Add failure handling for
 stmp3xxx_wdt_register()
Message-ID: <YyJdf1AswoJNUcu0@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Lin Yujun <linyujun809@huawei.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, akpm@linux-foundation.org,
        wim@iguana.be, linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220914032159.94812-1-linyujun809@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0GaYQqpmyMEinp5d"
Content-Disposition: inline
In-Reply-To: <20220914032159.94812-1-linyujun809@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0GaYQqpmyMEinp5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +		if (rc)
> +			platform_device_put(wdt_pdev);

This is correct, thanks.

> +	} else {
> +		dev_err(&rtc_pdev->dev,
> +			"failed to allocate stmp3xxx_rtc_wdt\n");

This is superfluous because rc is initialized to -1.


--0GaYQqpmyMEinp5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmMiXX8ACgkQFA3kzBSg
KbYo2RAAiL2PQuOoLXMbiSpW7Xq2C7tLSYErAQDhF4eWx/rfgxJ6+iwsqL0iaCyH
ehlDH+yrJivfDTpsOlj+u/CMoNq+PQTbKK82WLeSD86L8/gT4jeCFq1w4LDPdv4Y
C2xmtQngRYrnd+LZwRECDoTSL/yzoW7+kdJ59HoPEvwSIEDd8yVgpiyxJ/yX6T1t
KkT21eZBKhnAUw5SrKtSthUu/KCDyciHQFnwC7b8AyecgdmoWy+8MIjmulnyNBn7
sINWTsKy3q0kQLAnILl2FeCnuYshc7RK+pgu79Pq3ZZGdD4PvV7kIZhH3NtTO2q1
+yzhIEPeIYSM0aVEAdrZstk1waorixEkQY6Q4yAN2ibDBQN9KoSI7ztHkIrGUU0J
k4B+k3KaJCUJ/QLsvsme/wgA5+9Qdo8tlu3QJepCTzyGpEyrpVEBMa1rps204JxX
LYS8ivW31wEj+PVOhKWc09VnxzQGnteB7lkTcan8Y+ZQsz1P4dMW8Tx9Q4Uvclgt
dAyztAxGZCRBiNzHKR3som5pexW31dE3T7DEKbZoJoquoyfsNdr+43ln4xPNlLv+
xE355xb5Q/7lzsNnJEmYH0ep4z2lQVuwzmuxWgum1TA1WqVlqGAM89klDqPZ6Yi/
RrtwsKkTq0SoNBVex8j9GvcIbDkL9bAeVxfKBMmvSST7MYHb8kI=
=E9lP
-----END PGP SIGNATURE-----

--0GaYQqpmyMEinp5d--
