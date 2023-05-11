Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A63B6FE977
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjEKB3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbjEKB3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:29:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9124EDE;
        Wed, 10 May 2023 18:29:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CAD96142C;
        Thu, 11 May 2023 01:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2011FC433D2;
        Thu, 11 May 2023 01:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683768589;
        bh=xkZSZx7oD/2ihuOPs+EXiDXcMNsLja6hgA3JirBl9vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o94DUBaAqSQq9GKYZaNxFs6khoM6lGobAI0Z/QsFOW2c9a3HRSgKInsmbjDUit8r8
         BT3n3p08wmJOISJy5qLBAfZ/Fp6G+ppWH4TSA3RaN35KqrNZUZHlo4K/WM9V5v2SDz
         1bhO118eEgs4wtEj7VlYlDRrdsVAsZd0HpHefHam3GaAYMTKbmYdFVtpwxeFO0PdPn
         R30WK6u6Xg98mN7SYpLKuYIToz62Y2ViLrorj8OaNzwqGG9XapUXIQIP/qnPcFbXPp
         NMZzWGDjZ20zpAe32dYS5nmpwXGs8Dn19tCauisnowMP4OryOl03RE0GIrwW8nERm9
         d0hsUqpg7rZxw==
Date:   Thu, 11 May 2023 10:29:47 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com
Subject: Re: [PATCH v10 1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
Message-ID: <ZFxFCweHVgHyA1E1@finisterre.sirena.org.uk>
References: <20230509082244.1069623-1-joychakr@google.com>
 <20230509082244.1069623-2-joychakr@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pS027X83bgCbZaBz"
Content-Disposition: inline
In-Reply-To: <20230509082244.1069623-2-joychakr@google.com>
X-Cookie: Obey all traffic laws.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pS027X83bgCbZaBz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 09, 2023 at 08:22:40AM +0000, Joy Chakraborty wrote:
> Add Support for AxSize = 4 bytes configuration from dw dma driver if
> n_bytes i.e. number of bytes per write to fifo is 4.

This doesn't apply against current code, please check and resend.

--pS027X83bgCbZaBz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRcRQoACgkQJNaLcl1U
h9C/FAf9Hem8cgONjfxUCIYwUrdYf9sxLL0K60Ve30VRssMNVxYb15by8J3HwxPk
xviubx1/Wn9x3PvBRYVE0pBfG1CUj77t5/TwcptqEo3WCHbxV7o6RVdJ6YcVGB3y
pFsLUJjNqR3P+Ylp7nzcFcHpejxI7wM34gyFTyiEf+a2S0pD3uPeF9voA9vjODoy
dMfzmhGzhlR6twvGPSievnbiYO5EMQu21043hmZ8TeshCPXOU2VjfUTe+3QqxrQ3
dJMmUdalQRNGSSIA5nIZAFk2HMjASotEdcENFIOWVO73H/PHp1J+58VOhnQx9ndU
aAS3jMymQX9FclHzu32RkGGd6KM6BQ==
=8a0l
-----END PGP SIGNATURE-----

--pS027X83bgCbZaBz--
