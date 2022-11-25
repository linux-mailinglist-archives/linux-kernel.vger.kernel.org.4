Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C30638DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiKYP6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKYP6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:58:00 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AC71D676;
        Fri, 25 Nov 2022 07:57:59 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id i10so11244267ejg.6;
        Fri, 25 Nov 2022 07:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8Z5dOQRp6OhEdqyyn8sAKSEZNM7w9st+eFFZ82cYm4=;
        b=jkPUT1xAJwi8ntirxedYCWZV1YBzRJ63B4L6GAtBwCxKMtejIKUPDC0aQEqjHu+MfU
         BN77NUr9mgmmq4GmuRi24XeMZRxWm6yd23zh+0j1IaqaxBt+okdbPFjnOyCiaIxXDVvL
         C/mi93gHMWNQncJw1K0EIJxwsFj4ihahFk/JUrk/QupQoaCn74/ZOKhjX88jXIWCXeck
         MT0Pndw6nV5AlfChI17DFEqYKkTnsvn7zW0NfE1OljiS38lUKe+m9GD4I3y9kPJhpLu1
         1zwtLXR07Ck4cOBZNUj+QRha1Dwt4XC5ecex9vao4eGn2wYypIectJQRJy+LBxg/b7bb
         7Gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8Z5dOQRp6OhEdqyyn8sAKSEZNM7w9st+eFFZ82cYm4=;
        b=ylem6o1XUrh4+O0WeJY/a9HK6hPbPnnCTh1gspknIbrD5ArnuoT9eIZkmnDQahn7ZY
         8f7ts4f4mqeOuSdH6XMiXTIsSqoAo9C8Jd5WmAgm7qdFGwTnhGdHyhbcHdXIUCzyYxCr
         Q5e41PiBYD3shon6CECY9JnOUEGnv7d8ERCvLiuq5v9kKMLZxEG0PvEvEGZE+yN9JdGw
         UA4drLa4A7pcBL6wuEFY0JM0lJgtu4HZFQY9kHqilnmRe/4ER/l/kPn8//d28EHGQLQq
         tY/7xYhqCuZeapDJAVyDpc3KnNc1FpYdf91xNoEetH2W85NtOC2SEcmglQqVkn291aeE
         Vlbw==
X-Gm-Message-State: ANoB5pnl6B1vnBVk2xalQ5/m+uWZo72gm3gjoX7Cy8XJcIM1u0M5W1pK
        lMaPbTmCW1qdPOwEUGs7ViM=
X-Google-Smtp-Source: AA0mqf47CIAz9aEhFWXmBnasgcd0IAFn8P07zAPbQ5SbpGd90hGaopgrL2fH7NFM0SXdaiIpm1JxZg==
X-Received: by 2002:a17:906:40d8:b0:78d:5966:b093 with SMTP id a24-20020a17090640d800b0078d5966b093mr17443489ejk.343.1669391878324;
        Fri, 25 Nov 2022 07:57:58 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c17-20020aa7c991000000b004619f024864sm1904879edt.81.2022.11.25.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:57:57 -0800 (PST)
Date:   Fri, 25 Nov 2022 16:57:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ashish Mhetre <amhetre@nvidia.com>
Cc:     krzysztof.kozlowski@linaro.org, jonathanh@nvidia.com,
        dmitry.osipenko@collabora.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [Patch V3] memory: tegra: Remove clients SID override programming
Message-ID: <Y4DmBBthyfnv4noI@orome>
References: <20221125040752.12627-1-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="npMtys/iPIsXNhkF"
Content-Disposition: inline
In-Reply-To: <20221125040752.12627-1-amhetre@nvidia.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--npMtys/iPIsXNhkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 25, 2022 at 09:37:52AM +0530, Ashish Mhetre wrote:
> On newer Tegra releases, early boot SID override programming and SID
> override programming during resume is handled by bootloader.
> In the function tegra186_mc_program_sid() which is getting removed, SID
> override register of all clients is written without checking if secure
> firmware has allowed write on it or not. If write is disabled by secure
> firmware then it can lead to errors coming from secure firmware and hang
> in kernel boot.
> Also, SID override is programmed on-demand during probe_finalize() call
> of IOMMU which is done in tegra186_mc_client_sid_override() in this same
> file. This function does it correctly by checking if write is permitted
> on SID override register. It also checks if SID override register is
> already written with correct value and skips re-writing it in that case.
>=20
> Fixes: 393d66fd2cac ("memory: tegra: Implement SID override programming")
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
> Changes in v3:
> - Updated the commit message to point out the bug fix.
>=20
> Changes in v2:
> - After offline discussions with Thierry and Jonathan, removed SID
>   override programming during resume as well.
>=20
>=20
>  drivers/memory/tegra/tegra186.c | 36 ---------------------------------
>  1 file changed, 36 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--npMtys/iPIsXNhkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmOA5gQACgkQ3SOs138+
s6GrJA/9GVwQZqdfV1yAEmKx/wm+lKlcGrX9VMjny5hGbplhcTCjFwJ3fPus9gOc
QCT7o0axifglvRt1uBQamHlzS/0E+WDAWK1XRQ/A0UMUPZ4v+HMvxjw2IYlztk1/
eJqa+kWmVFFxPZVpFNTdKvf4KtzWFtVGGRvuUHGgcsbMbsNYqz/ucVmNmf5qfcF5
6G+U9xutYSCimxA1zhX8D73z1Pp/ntgCl9Fk8F/2f1TbuqAndT14LhsRSCKM7Z8F
LIsS9fc8yk8Fpj+58Oj8FFbtZ7Rhxa1VB6VQ3rGcdddWo9eEyE2Df0VdkGCkRNVB
zotmLS0WvfNcUI+tLiXPcIexkSqbaIP3oO22SfbXfkERBFvRS722ycms4dUHf2PP
YpYetXktCcpOzfndEaHghRss1nwrGUab1EWCctqE4h0hq2e6ZvJo0ULYrPKX3IW6
+z9lGYDf7mIMGjga/OIuNmcDvSdeRc2HC1MmDLmKqUkm0VvM7O4rBxi7l1Sd++jG
nzU1Wb3H1Tq5ECWX3qt0OPdvyd+Ref2lfafQ7STB9zrUcJRU/Ru7UShqKiq94IjZ
5pXsN/YEsTxRbbohSz8Wa9CmO/ee+q8n1wYaeskRNXHQDGZ6NxAufsupjm/74TqQ
FI6/QkdPpgehVsWQ3gj8nMYXrVgwjU6n7fdatWRJq7rNkkTowmo=
=Uj4H
-----END PGP SIGNATURE-----

--npMtys/iPIsXNhkF--
