Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEBC70BA38
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjEVKeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjEVKeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:34:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A2DDB;
        Mon, 22 May 2023 03:34:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4EA3611D1;
        Mon, 22 May 2023 10:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA42FC433D2;
        Mon, 22 May 2023 10:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684751650;
        bh=FR44QPdy1xMkW9fHdAR5I46GsKRf2v19Ir7LPyBWSeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VuFrmj00mAhLuZNgP6U1+gS0oCLUcmB2L7d3L4LNrKgNsT3NTE5Yft7aX0RiGZJar
         hYGmX9cRw4zc8E/P4SF8taLj916Ru1CiNK+Xz/yRQqzeIIo/O+fDT3rDEcF9QY4n2r
         Srs7Iil4KMZkcskpAGFXt3YpLLt6CrxJxr6QVcgcez2crn+vCnH9gEzAyOcOigBEeQ
         1ZzQoC+zaLna6O8P3Lz95+N1PpeFRP7QsnbNsqJvPM/9A9yb65xoos0t3UzxDv9unw
         7H96IjoJu0PxsWU/SdOJC24eUIM4oPT6kiZKW1ZPfM/h6bJCHV8XF5R/ivgUANTbMk
         rpvAeDkmSn70g==
Date:   Mon, 22 May 2023 11:34:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v11 0/2] spi: loongson: add bus driver for the loongson
 spi
Message-ID: <3c15d22f-4f94-4cc5-96a8-f565e58c66b9@sirena.org.uk>
References: <20230522071030.5193-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T+C3fAzlXLG5MzrQ"
Content-Disposition: inline
In-Reply-To: <20230522071030.5193-1-zhuyinbo@loongson.cn>
X-Cookie: A rolling stone gathers momentum.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T+C3fAzlXLG5MzrQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 22, 2023 at 03:10:28PM +0800, Yinbo Zhu wrote:
> Loongson platform support spi hardware controller and this series patch
> was to add spi driver and binding support.

To repeat what I previously asked you *please* send patches against my
current tree, this doesn't even apply cleanly against Linus' tree never
mind any of the branches in mine.

--T+C3fAzlXLG5MzrQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRrRRsACgkQJNaLcl1U
h9DEtwf+LVV0uSPCKHxw1FhedfdqAOvXmphI8eUZK45XQ/Y68YTet8fpWeyod93Q
CviGFkfMQGmo/Xb14dcet2FjoLikXjuEJixLSyaNPPdm0XuGxI7G6fFSsrSBubsX
4Ix1+P/vAgyXLBMj588zsFP2jDumchsYekFirkIHq1wP8End/PblkCadRwi/RoUc
3hnyW3JzWOFWr3V5VmdW4Ctpcc81nEfOw7Byto0/8ICCCGT2CG1hhFjRxYBWJheF
mjlW4uEbPIyF3maMK4crREEmOdsujdlehzsg/Uns/5vmpiOwAnxEWAg684vbDwsY
/TRHSLk9lGmuITQhM7QighmPn9bNGQ==
=2AXo
-----END PGP SIGNATURE-----

--T+C3fAzlXLG5MzrQ--
