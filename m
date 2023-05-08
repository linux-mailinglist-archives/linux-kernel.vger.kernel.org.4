Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85FE6FB0B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjEHM7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbjEHM7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:59:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3CB37C43;
        Mon,  8 May 2023 05:59:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50b383222f7so6804878a12.3;
        Mon, 08 May 2023 05:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683550758; x=1686142758;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q74pMOyCxaqs94RKeJssV3CKN2kjLrMUntWRD90yNaM=;
        b=sptLpC5P2ZSokyNcLWZwH2APbZ7jBslgOmBilp4AyjHnJ4vkKwHMKWHiE97Rc3lL01
         woy2dMGXzSLLP3rY8F6kgYxyJx7F+un0SQp9vykMw6R1Cv4Ef1hhzf7WSntSVoCPAtK9
         UwUrauWTCyCNhe+3725Am2gJUQCmHdH43J+XN6ltyi4vdztjqUmvMnFrU+aZ3r4RAKg/
         v3dlmqkMmyW/EkVbYbIoj7Xdvu7BW4d0iU/6x4g75d/MXQpHpb6UcgQWxf6a1mJIbIxK
         6IicUISy2yV6Sfi6OWPgGpKMKfQqfZ82jnLb3ZGwbKPCrbYaNETSE4V1lxY/ROlr3iD/
         ModA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683550758; x=1686142758;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q74pMOyCxaqs94RKeJssV3CKN2kjLrMUntWRD90yNaM=;
        b=EeTh0MCT0Fk/YJ+SsvioZxo0LKZ/JSKFCCU1Lp/16XNVxCRise/s3EVGzoG7d0THhC
         MHm8i1LOCnRt0+SPHj41c/7A1APzURP1l/abt/4uhCWw1/QmA9390jaRLKfMYhLcXdIJ
         MkJnYP9mWfjDZjWqAz2wnvmO97nfAujul99k594EyRMdz/yHnMlvLdvrwTRHUv4GAKXy
         oI6kz9eo5ZL0b10r1gKxbMXSOosWOsgDK4ZsyvFpQJ1IqDsFpp2s6tm/j0p1NzAhF4Nq
         371xlUGzdh6UqNgUMo8pCgZKcU/5vvewbYsCpLtVj9FOanHubELF2W3x2IMaoOTzOgMp
         0fJQ==
X-Gm-Message-State: AC+VfDz3gi8XXdnEE00GblrxJKDAiHwbZ2BLArFZZqegD6QKllXLBpbb
        Q9qnotfQy8/yBj3VLMASeGouOogBdmk=
X-Google-Smtp-Source: ACHHUZ6Nkh9M3TcPVExA5D8dkF9daiY76wnwxDuKBxodE8GYkb/nT0WU+yEOUhFRVDGBgjTJRVrzRg==
X-Received: by 2002:a17:907:318b:b0:94f:956:b3f7 with SMTP id xe11-20020a170907318b00b0094f0956b3f7mr7772770ejb.2.1683550757817;
        Mon, 08 May 2023 05:59:17 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f22-20020a056402069600b0050bd4b8ca8fsm6083776edy.14.2023.05.08.05.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 05:59:17 -0700 (PDT)
Date:   Mon, 8 May 2023 14:59:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     jonathanh@nvidia.com, Stefan Kristiansson <stefank@nvidia.com>,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/5] mailbox: tegra: add support for Tegra264
Message-ID: <ZFjyI-PeHE3ftfYz@orome>
References: <20230508122048.99953-1-pdeschrijver@nvidia.com>
 <20230508122048.99953-3-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ntfbQ+8GInZlRz/c"
Content-Disposition: inline
In-Reply-To: <20230508122048.99953-3-pdeschrijver@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ntfbQ+8GInZlRz/c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 03:20:48PM +0300, Peter De Schrijver wrote:
> From: Stefan Kristiansson <stefank@nvidia.com>
>=20
> Tegra264 has a slightly different doorbell register layout than
> previous chips.
>=20
> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>

Technically this needs your Signed-off-by line since your not the author
but forwarding the patch.

Thierry

--ntfbQ+8GInZlRz/c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRY8iEACgkQ3SOs138+
s6G3NhAAhJzqD7DaCwyoeT36HS7cyU0ZV48r+JlmxbwpJMcBYWK4TvW1QqsIAC31
pIB/3WR1w0SxmkUq+O3B3Eh0k5rZRFr50WOgxANQ63ZRkB9JcpSqnVcfCco4lmts
pKS/u1wjdPeusysx43KOPCEKBLXr/8Jm5ircUJirdVfSM04UatsbKuF1vEyTwB/h
lNyMU6m+m7j2+qgb7BFll9lXF3djnbufy9NRDRJg2khd2YcSCR9tLDCrH4Q2JcDL
TF4CsIF30oyx6wQhMXMbN7SkF3iHLKeLJ6YLDhqMn/TeDM8YUHqlI2otIAG0/JG5
gVGK06lcD3WHZz+5FG+UBGhi/rFVbSxsGpM7HeQfAznKQ1hiM2CIpTJ0ehk1eLQX
Yc0GvrCOLCv5SGaaAQ8jR4pAm4cijeH4ljo+UGbyQkMALZZQ/RyawqRxEQyKL1Fp
PlBtqCS9YVmacd8gPHIOOqgf0+nVrgTGEzcEBh18rxpXbd/Wkb90pgXt/MYvxwyk
nxUCS+69fewreMlOQc+dAr5pU1Xdkd0RpZ/+ptsHDLjfoNwv9L5bQRbKNWr9FMDT
4ADWkS+DVmIgsrnxZWEMV2PAe0QRORcbsPjsrkbYo5CIzzRU6VLZElV8T88GSGbx
ZP9jbkESbmxNfAeXC/r2PDNCwRQbiw8EC/BFngMt+c0R/TzS25Q=
=lkTU
-----END PGP SIGNATURE-----

--ntfbQ+8GInZlRz/c--
