Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C2D70DB84
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbjEWLdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbjEWLdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:33:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58781121;
        Tue, 23 May 2023 04:33:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DA1C624B0;
        Tue, 23 May 2023 11:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABCFC433EF;
        Tue, 23 May 2023 11:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684841610;
        bh=3mVudTd0kFY4TAOh8iGgobeDIvly0omcI558Swt/BEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNO6WZlKwtuN506NQFF14svIff5nA90RmepWIWZB9XsjtTFG98TAI2Y1aw/23wa1+
         v4ztOMiXHtKJnDGAsk2wQpmu3YpSleXN2+Os9+N9kVUD145vFFBmypQuqATZ/yIA3s
         5HR2K0ISj4Su37xw493gY5krPY//c6A4iQ7jTRbQF1a1+Q1W6JAWk7gvOgEUexLPjY
         9OXY42JM0A1TA5E+n1go8MKy/6C9aPknVVGOYh7svWsYmJzB0Y92RZi8YRVBV7aBfg
         f4y53jsEy3f+JznQqHUdTn2OQ8eFrq2NLaBQsUeIKD/uaolvzbdPppHWFsm6NCsWq+
         k2SEsgKPDFlIQ==
Date:   Tue, 23 May 2023 12:33:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     qii.wang@mediatek.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
        "Tim . Kuo" <Tim.kuo@mediatek.com>
Subject: Re: [PATCH] spi: mediatek: advertise the availability of Dual and
 Quad mode
Message-ID: <97af2a29-8aef-499d-9f07-bb262ec398cb@sirena.org.uk>
References: <20230523112608.10298-1-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NLalJAOfHCQ26xry"
Content-Disposition: inline
In-Reply-To: <20230523112608.10298-1-qii.wang@mediatek.com>
X-Cookie: Beware of low-flying butterflies.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NLalJAOfHCQ26xry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 23, 2023 at 07:26:08PM +0800, qii.wang@mediatek.com wrote:

>  	if (mdata->dev_comp->ipm_design)
> -		master->mode_bits |= SPI_LOOP;
> +		master->mode_bits |= SPI_LOOP | SPI_RX_DUAL | SPI_TX_DUAL |
> +				     SPI_RX_QUAD | SPI_TX_QUAD;

I don't see any changes to handle these modes?

--NLalJAOfHCQ26xry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRspIQACgkQJNaLcl1U
h9AQjwf/Z7rx0bZ8ZrN0OeYVi+MwMAmK3a00KnP5C8kE1UYf7pWyiVo4AJergA0c
3r3RTV5UN9kiD+MPWyzuYeeHj7gEESvkATksH9Q3LsARbufMdlTR989BRTuT6zBO
g8RyyXcA4ukw84ad4h+5AisMnpizk6ADKuB2y6a2hKUZDhsp2MYFcLC8EJmTzl0n
fC+itAF8PJMWs9f/EeWim0KCcFqpM9zisRfHnsfdSQ5nIPb+ausQLHcpU5F8DQcI
2t1d9bOPovH9wkYpbyvbqcce/qcABFidHVisq7t1DY12bYiE4puj0S/0CsI/OLTj
cZ8co2SHZl/WzNO4pRfkHqVYFu4B4w==
=cE3K
-----END PGP SIGNATURE-----

--NLalJAOfHCQ26xry--
