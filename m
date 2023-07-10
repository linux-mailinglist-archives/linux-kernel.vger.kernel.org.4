Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF3874DC82
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjGJRaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGJRar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:30:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E48095;
        Mon, 10 Jul 2023 10:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D15E96116A;
        Mon, 10 Jul 2023 17:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B727C433C9;
        Mon, 10 Jul 2023 17:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689010245;
        bh=8daJmCsRggn9xziEjmtzfB/+TEmSHGqfTrQOxt4tg1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2qoXUnSHuV+TbWU69K3xBxeG6UAs5r8JvEuI+8qIwEdTjDJX9HPZn++uZHMNIQaD
         86g42vDDjo+xgTS9/scrmuWADvN0R48PLgUPQA8lzB5uIE7gczU7YsGie2UjWiD40Y
         soETF0P1p+D4lt8Jw6O9FNAf5+tzNnhQ6U1GTpxDacTetMTQd4tHQO7p92dxIvPKDo
         vCacGl+XShxk3g8tnOVtoXP+PJNeX8VjY17MSNUMQyZxhOaFwy902auPvHxrZTYMla
         iILw2xA2Gbqp0/Iihh6sd5pNaL6Cxsx8tHLlJ00pYbON+m3jOCfuniILkrN7AJJX38
         Zx5bmFaJNvHKA==
Date:   Mon, 10 Jul 2023 18:30:32 +0100
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
Message-ID: <cfaffa00-4b61-4d81-8675-70295844513b@sirena.org.uk>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <20230710154932.68377-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IbZ/DrTRficzGRpW"
Content-Disposition: inline
In-Reply-To: <20230710154932.68377-5-andriy.shevchenko@linux.intel.com>
X-Cookie: Do you have lysdexia?
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IbZ/DrTRficzGRpW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 06:49:21PM +0300, Andy Shevchenko wrote:

> Since the new spi_controller_xfer_timeout() helper appeared,
> we may replace open coded variant in spi_transfer_wait().

> + * Assume speed to be 100 kHz if it's not defined at the time of invocation.
> + *

You didn't mention this bit in the changelog, and I'm not 100% convinced
it was the best idea in the first place.  It's going to result in some
very big timeouts if it goes off, and we really should be doing
validation much earlier in the process.

> +	u32 speed_hz = xfer->speed_hz ?: 100000;

Not only the ternery operator, but the version without the second
argument for extra clarity!

--IbZ/DrTRficzGRpW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSsQDcACgkQJNaLcl1U
h9DEzgf/dy9EpgGVS5JKG+2sOnEEWzJ1/z92vL5sQoHWJT0M7rzfGdRlGddYvj2k
yOJg6fvzzY2vbGoYuqkSlYi95WyUFmwqjd+BwayzJ5gH0xKRXo4MwCHKIET3z44z
8pD55r1ow40GOeztLTsLwgiADUQSMRLm/Y33rrf2I1J+/AgrEV6V+oZnbWsmoI+I
0QS2ZIQk8m1oDghyOmEOzW+jqJQbDR6HAP0L9dUbd/zcJK9LDXHE5hepkLjQbC6v
oGrJJVbs+IYFbaNJrDNtxtF3JwlAtVWWSten66FG3fmreSDQwcKATVKiHWtLlhJb
a/T8TlFW3ianwYVf2yMOEojOIbZvQw==
=d1Us
-----END PGP SIGNATURE-----

--IbZ/DrTRficzGRpW--
