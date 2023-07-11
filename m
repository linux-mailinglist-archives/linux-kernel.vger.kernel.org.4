Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC0074F3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjGKPqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjGKPqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:46:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6466ED;
        Tue, 11 Jul 2023 08:46:16 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31434226a2eso6754713f8f.1;
        Tue, 11 Jul 2023 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689090375; x=1691682375;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSHzWr4gaLs4jyK9BMNn2YEQIAnAbtQY/+dliKHHYxs=;
        b=UYS+7tIh6u+ojy0oVfob+Sev7z0uPPCQbErkQpQk1O+aw22pl77XLL8DNQLpZ5C5VX
         dCLihQlJnJ2hS7roLef3cvntWUiIFWKvkGFPW37HzuzQzBMUXcgPXlBvk7JQt0jeFzRk
         GSF2ADgVJthd+Qi0UAOuuE2Gao+crsO42QZZBLl7v9vw5LYSUPEBMOa5vu5nXPXmLWqT
         nBEeunutG3xUBZx4X438J7tJP5tIhQ6J8b0ofwTJtF1nRUrQC9oKcUX5KUGBp6ll3BQG
         iP/pNUCvbqlB0OZVZCzt4a1wNWzPP7ox5rY6xj4Cu3w/cp7ojsfkbSK9AihF3dHbANXY
         V5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689090375; x=1691682375;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSHzWr4gaLs4jyK9BMNn2YEQIAnAbtQY/+dliKHHYxs=;
        b=ax0n6vajVtonQpVQwMj2dUkMapAqiEMKm3uZbtPZ2KWKAZzf6Slhli7+WAeImyRhVh
         GSymB38GTilSYA0StbdnJDMVMTKMH7UYJUWQLpdVkjZxyqjAW8jAJQ0GhI84oH4eaRVm
         P/vUegjaAV0z14+j6hwjZpkIz31k1iq69gqrzfQuldB5mzueVrg+LGFpuj2FzIgim3MC
         V93W6ddMJzDWHjgECO1cd2gbMf6Qww6RXAsFI0RMIowKftEadzdeCeTPMW6GYYiyF8Eb
         XF0fmVzBXHaSwJOIdrWQgOzJ9fpglQzxlzla1vW7UCGp7zcwBpGYQjXpTmHUjBbd6PXR
         tMUg==
X-Gm-Message-State: ABy/qLZKe/M+9J+EswLKVw9Xm07ktCOQHtlkLsHreSRbj33IIad6PkX/
        sJeVBN8zWsi0LJT3j1Fe8QaRNmjFlwY=
X-Google-Smtp-Source: APBJJlHYOoGUWXHQEGRrv1wSYYMjVMio85ATQTXMSE8aJyyC4C8fPFL3liKN90fsUX65qG2C6jlrNQ==
X-Received: by 2002:adf:e290:0:b0:30f:c012:b529 with SMTP id v16-20020adfe290000000b0030fc012b529mr21025161wri.56.1689090374932;
        Tue, 11 Jul 2023 08:46:14 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d46cc000000b0031455482d1fsm2568456wrs.47.2023.07.11.08.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:46:14 -0700 (PDT)
Date:   Tue, 11 Jul 2023 17:46:12 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ASoC: tegra: tegra20_ac97: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <ZK15ROig1u7kaXfO@orome>
References: <20230711034846.69437-1-frank.li@vivo.com>
 <20230711034846.69437-5-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrPPLIbhK53dQkQ8"
Content-Disposition: inline
In-Reply-To: <20230711034846.69437-5-frank.li@vivo.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrPPLIbhK53dQkQ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 11:48:45AM +0800, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  sound/soc/tegra/tegra20_ac97.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--yrPPLIbhK53dQkQ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSteUQACgkQ3SOs138+
s6GNFRAAoGU/u5P+4DbrdieXiUfZLIqdhM4uAmLJHkY7i7xuluvvsk35OBeA4Fj1
I4mpibVDYTja7Wx6j4C8BGr5B8kk1V0dOu4wk6gQaN4zjGb2tN8bkA7v8R/6saP+
OD3H/0t7ZZrtm/XDBD9R2Pv5gdbptYfwA/j5NpWwGSSc7iQ2gyInzbk0UKIrW4ci
6GEKBL3qYk2dhgyD3QgSnBQecfMbkzbGzcqyT+7P8axhjclJstTZs2dlozBIC2tf
L/Yd8n+S/3GfIH7oI0qgGbaPuoWqEmXgAL6dvddR8021kcQQJvnAl//w0EudtLXh
Ae/auR0eLEt9YklWLXWgEIoBmGvcdqvnE29vW885RS331+th29aK39oOfRptroBJ
FZ8MuXyUwDO0GQNkFIm6WyNuXmqxf9yzRfauGDDuPAlpPHe8plW2Zr+iTBMbjPp0
Y72o6OCRKLyBlECkT3xYxzOwDj5qcxGgChPxKTPgyYOZ3Etz6CWys3YO+Mn+0q3s
ilFNpaHpER/TkiWHaf1f1Afoszbic/DV/wBZf6zOZD8Ggfs6Q6QhaTJfGvUqBNVI
AqW5hC2Ya06qUrUpB5G+NR2/F+QX8VS0ub428mai6SUemlmYat8PvDlUMpWbj06p
JN7dyctd89Gxw+iiQgF9euFNixjCIha5XTgdXGny+Zp+802AJGQ=
=zwSX
-----END PGP SIGNATURE-----

--yrPPLIbhK53dQkQ8--
