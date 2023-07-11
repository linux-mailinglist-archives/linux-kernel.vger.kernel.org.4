Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A14374F414
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjGKPuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjGKPuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6594911D;
        Tue, 11 Jul 2023 08:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0250661549;
        Tue, 11 Jul 2023 15:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A565C433C8;
        Tue, 11 Jul 2023 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689090607;
        bh=Rfrk1uyNxWMBBOGH5Jxn2umsc9+1UwzSvXH/XCQVTMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQcn8OvC6bRBN7WzpsoGdLVO3L4xuskzngmmfRCEj2SQ0jAC+8jd5iN20p9gHRbpg
         XUbhNgU9wAusI4gCQRZQWpSdosA5W/FQG4z1AWEgo24Qhpez1zvl8Qd08L+UQadjys
         qOLdKWVQ3JbXYchCASI4opWSvhez0uMrvZY11sAMGFC7hweCIW8F+sFtyDKkG13nS0
         BpkHBiCRn9aeI6z28Cfu2Vk50UunuJFeo1j1nrYJyD6L4Kr0GqQXWYq2XqyGdtwIe+
         r8LZOFGfyssDNKEB3zOQjK+1KK7aegmO8dmKUMp5no+2+L0MPlqIAyMOrhHo2iXkMt
         IC4BE92YJ2DdQ==
Date:   Tue, 11 Jul 2023 16:49:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v2 04/15] spi: Replace open coded
 spi_controller_xfer_timeout()
Message-ID: <dafdb3d9-572f-49d3-82d7-f0d7667df5dd@sirena.org.uk>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <20230710154932.68377-5-andriy.shevchenko@linux.intel.com>
 <cfaffa00-4b61-4d81-8675-70295844513b@sirena.org.uk>
 <ZK02efTYxV3czigr@smile.fi.intel.com>
 <5959b123-09e3-474b-9ab0-68d71cfdd9a2@sirena.org.uk>
 <ZK11flZf/1grJ1Bd@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z/wyG6sqMhUk9SL4"
Content-Disposition: inline
In-Reply-To: <ZK11flZf/1grJ1Bd@smile.fi.intel.com>
X-Cookie: marriage, n.:
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z/wyG6sqMhUk9SL4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 11, 2023 at 06:30:06PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 11, 2023 at 03:14:54PM +0100, Mark Brown wrote:

> > Like I say we *should* be fine with the refactoring without this, or at
> > least if it's an issue we should improve the validation.

> For the speeds < 1000 Hz, this change will lead to the div by 0 crash.
> It seems that the current code which this one removes is better than
> the spi_controller_xfer_timeout() provides.

> If anything, the spi_controller_xfer_timeout() should be improved first.
> So, for now I drop this for sure. Maybe in the future we can come back
> to it.

I don't think this is the only thing that might fall over without a
speed, what we've generally been doing (and do try to do with speeds, we
already need to default in the controller's speed and so on) is to
sanitise input on the way into the subsystem rather than trying to
ensure that all the users are handling everything.

--z/wyG6sqMhUk9SL4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSteiEACgkQJNaLcl1U
h9DAYgf9GamF50fucbXVx/aZUwGY2hD+eGYGVpMwfSRhuUlWbnbam1vDqMkEllpk
X95Rur4vRJQA8erYbUKnhyABsYUSGd8CKx8/mDgvePWDPlYZ3TkdMV8z/j59HZbA
WhFO3yBSJzNOgDxpftw96yBP7l7eZZHabEpeUAOx+SZ04jtNfdnRHeHBIBKL+YUT
eFnArWnhTo4dUwNTaAojL5Lfgos/MGY9ABY3b2E4ZkjSaHCUTOa2rxKo9zjc43tE
gdVuQ8cvshKLUDx2CFZ4oux+stLEOfjcsmR0prxZp3q9t2ywp1CsOHBY1ndd/8Ds
SnUGepjz95NgZBU7ewJoIuRhKJUQtA==
=GGl+
-----END PGP SIGNATURE-----

--z/wyG6sqMhUk9SL4--
