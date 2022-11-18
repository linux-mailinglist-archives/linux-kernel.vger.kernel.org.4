Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEBB62F973
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiKRPjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiKRPjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:39:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DB85986A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:39:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79C6D625F3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 15:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A944C433D6;
        Fri, 18 Nov 2022 15:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668785954;
        bh=iz4McvZM/E2o496nT649orB1f9ZWyItmYXL8nqRS8Ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s0ioyr4/BLSd6K9vPXPkioUu+r6OHx2WyltYbPuQuV9D3I5ajp32xVnU0/JBAi4ak
         SgOgmftikuBKUn2fBPm6Vsx1LnnUBEeU7iy8GkwO1OqFTtt70zO0sm4pQslPloC+jV
         FZvVTvUbFTvL5zmT6Vcl9fkT99j9gFzzsRvA/ZW5nZANycq1ugvTqv2K5OyuQjbBBS
         jC5xtElKQuoPoyx9OyO8zCfcqx6zvX4cbZcjS0KKuCvIyUTz/aKp1fhsyMo1PB/OPx
         lpp9W+KSTY/Ib6q83/EFHlxDvucyftbP8YB01C+Zr2qyzcZ6fX8nWlrZJ72KV4Ku4s
         8ywbeBckn8+nA==
Date:   Fri, 18 Nov 2022 15:39:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     tiwai@suse.de, alsa-devel@alsa-project.org,
        pierre-louis.bossart@linux.intel.com, vkoul@kernel.org,
        bard.liao@intel.com, peter.ujfalusi@linux.intel.com,
        ranjani.sridharan@linux.intel.com, vinod.koul@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC/soundwire: remove is_sdca boolean property
Message-ID: <Y3enHzY8XY70/nWR@sirena.org.uk>
References: <20221118025807.534863-1-yung-chuan.liao@linux.intel.com>
 <20221118025807.534863-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pRbbpnwvQFI8Ig1m"
Content-Disposition: inline
In-Reply-To: <20221118025807.534863-2-yung-chuan.liao@linux.intel.com>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pRbbpnwvQFI8Ig1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2022 at 10:58:06AM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> The Device_ID registers already tell us if a device supports the SDCA
> specification or not, in hindsight we never needed a property when the
> information is reported by both hardware and ACPI.

Acked-by: Mark Brown <broonie@kernel.org>

--pRbbpnwvQFI8Ig1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN3px4ACgkQJNaLcl1U
h9DxmAf/QATOeg5EyZ8P2MRRRpwyKOCKZGE0zoOp9QpnYXH+xHm+Fy44UW4Mpfqe
OEjHDEJQmZkmKRwyGbgnlDLMkqnfuseZAIVCwHQZRzLeQqVEM0DnU8rek2A2wbO/
8q6uDOpvImNxZuRhcSkKMYO8rPzZv2dZFxEJWjts7I/xi1unEwZkFBPH4itmjySA
QWndOIgtq01WIyJz2mYWS0velHGrQrGqDqRg7kwzjMekPzJSE4rJU/WBiXOg+F14
c+sxbz0HptCue1jpogtRcjDpYa/zqZt8ZfJsZHtAtOiF9d1NvhXhIO2SPNREArMF
/AF7QIIKIwW8Bu0P8kKI+IRjPM+53Q==
=Laz3
-----END PGP SIGNATURE-----

--pRbbpnwvQFI8Ig1m--
