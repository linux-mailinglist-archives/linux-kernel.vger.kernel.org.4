Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C29D6E53ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjDQVd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjDQVdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A9F558A;
        Mon, 17 Apr 2023 14:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E51B62A8C;
        Mon, 17 Apr 2023 21:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745FFC433D2;
        Mon, 17 Apr 2023 21:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681767230;
        bh=DevFUD2pXPhn+7qfSYqBFbAMM38Bh/J+7pB96YIeCO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADfEtqMR+K4KEUM0j4f0TkpVqPh5F4A4S6hW7z0Ozghn/n4W0SwN+di2Rii8laW3E
         KEEblr/tirCyldF9c+zbPrpYJhpGlvSPqaZnrjffWzBC7XBo/++bapkyingkVo32sP
         4FSGNeCkMe9CfxgasFku8iN8zkQXkHfWVhhAxl6mdJiw1LzwaFB6Jk56rwjrVo2ab/
         pq+GI20Ik6SYZ9AZZweW+vTTvEZ6hq0lA+KQEVPaL5parzQyLz3EKho4sXGx0epz4s
         kwq88bnUHlZW4t4C2HVvhm3wrkYMR6UnCBfsBHSDPETfGhe7p5UbgzNNTylmiJuMF0
         TvMi2lclY9YpQ==
Date:   Mon, 17 Apr 2023 17:33:47 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        linux-iio@vger.kernel.org, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] counter: stm32-timer-cnt: Reset TIM_TISEL to its
 default value in probe
Message-ID: <ZD27O3l1WMPSQnzy@ishi>
References: <20230413212339.3611722-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="if/W+Y61PnsCB3GM"
Content-Disposition: inline
In-Reply-To: <20230413212339.3611722-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--if/W+Y61PnsCB3GM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 11:23:39PM +0200, Uwe Kleine-K=F6nig wrote:
> The driver assumes that the input selection register (TIM_TISEL) is at
> its reset default value. Usually this is the case, but the bootloader
> might have modified it.
>=20
> This bases on a similar patch submitted by Olivier Moysan for pwm-stm32.
>=20
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Applied to the counter-next branch of the Counter tree. I made a minor
fix to Fabrice's Reviewed-by tag line for the missing closing chevron.

Thanks,

William Breathitt Gray

--if/W+Y61PnsCB3GM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZD27OwAKCRC1SFbKvhIj
K+cOAQDeYS4l9+RlqHr4D7QYrKZxrerhqbYBTIvV2vktTXzPIwD/dhyY5SuBy/hf
gGPzZn8MPwGhXr9LAN8tnKpuZwaoCgc=
=AAdE
-----END PGP SIGNATURE-----

--if/W+Y61PnsCB3GM--
