Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA3174B161
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjGGNBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjGGNBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:01:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159E6170C;
        Fri,  7 Jul 2023 06:01:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3143798f542so1870425f8f.2;
        Fri, 07 Jul 2023 06:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688734901; x=1691326901;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEPdhA9OqeXhZvOSKX/1N2XG0OPdz7SbUSadjEjucFM=;
        b=Y4p7/j4T4Jf2fWQetVUXTC5PW0H6mRK4mv8utqnJ6/awuuEdbPgYTiu9uffI//xi1m
         lUcGcmx6BdmYI3P/A3ydfzVYdmn7E3iquPCRxamyBNpHG6SAL6FofSacJ5hKpoo7EOhV
         +YLiay1MdyA4SLDbpClewkb44ptMmL0ThIIE6ofg/jqN0Y2NpKJ4+l6mI5ykru9zDruw
         N9JwG2nLzMXtn/NzGgA6dIT0uWRb9FH2e2kSY0/8hjLYOljCN3iHr2DpyNxQt0OmdSZ9
         z3H6l/5CyyhGV3COMIhXQJlQBVmZdNqTY1Gde5II4/4+ssmZ4VfCltdoq9vdv3q+qP/8
         IhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688734901; x=1691326901;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEPdhA9OqeXhZvOSKX/1N2XG0OPdz7SbUSadjEjucFM=;
        b=WPudWT7X7XJuld7s4iDgKwwTjxIN3vlix45zQoPeVMCZm4igrtLCsVlwCEFHRml+Ha
         6s+piyzH+lAW7VE1D1Yfpr7wppbyDYOlSfUcQWOcxzxpg1UUW26meQuPb26UsCsbTk7l
         YtxEkpQzdTAJUsBJOlT6syvLS6+qYCzTLm6mZS8vcOGa5q9QlIbbHIqsiMkDD2fKtH/W
         WvSnK1dH721DDQYvSN2slynx/cvbU5rROnTko0P3mM4bH8iZx2S23d0mMqG+HBL3ZVjS
         Ic6ln7wFALPrBJXKwZQmaQ+nMPibJOHeOywEZm2ZYgxQaeAf1xuPMpaiDVB9egXOa4KL
         ERbA==
X-Gm-Message-State: ABy/qLZeq/GjrVoJjOSA+KncsNPiGVbd/Qew00rkf63GZtvXby+d6s0g
        X2IicCtje7MmTZH1KRfjIzI=
X-Google-Smtp-Source: APBJJlG5HpoMLxOYPEEeQS0rU1s/3xuEzsqJA6ntbQ2Di0r+V/zWqOTk99GUcKK1Yasp6kU0pJS7nQ==
X-Received: by 2002:adf:cf0b:0:b0:314:39d0:26f6 with SMTP id o11-20020adfcf0b000000b0031439d026f6mr3828713wrj.18.1688734901265;
        Fri, 07 Jul 2023 06:01:41 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bce16000000b003fc01189b0dsm858476wmc.42.2023.07.07.06.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:01:40 -0700 (PDT)
Date:   Fri, 7 Jul 2023 15:01:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] spi: tegra20-slink: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <ZKgMs3aDA9J_8h5K@orome>
References: <20230706032727.9180-1-frank.li@vivo.com>
 <20230706032727.9180-6-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LA5n/9LcFjbpAUwR"
Content-Disposition: inline
In-Reply-To: <20230706032727.9180-6-frank.li@vivo.com>
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


--LA5n/9LcFjbpAUwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2023 at 11:27:25AM +0800, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/spi/spi-tegra20-slink.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--LA5n/9LcFjbpAUwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSoDLMACgkQ3SOs138+
s6Elyg//Zb/mAM94ehClI9NR6HYzc9Y0SSCu5Wc69VKe3CyRLndF5uMHEtXlXa0r
m5Es9WdAaKkLlI5eV7cX4HvL3iZFP587MDT5JOQoc08jct+q47nJqJ7sRFE1Bi6p
rP36Js5as2Pzn710LGAt45W6Wre/tZCt5dwwPtcI6ETHT6jSYqJaDnw0Mmpx3ttM
fN7ruXPwLZect9Q8Cq0OuutlHcd6+tYHgVCzDAvpEtVfMWDpki6dHydGKsZfQo+Y
MiLaixhY7/Xvz2KBkYcaCHYPaYjM0saptwDsyub4PWoYtn+baMC4jcGcvBIk04HS
voFNRXRIITfMEWX0q4rbueBOpbxYE9S2WkTyMyzgR1Z0/QOK3Vb+klpdgNGff1hV
EdutLDn/PnCDJCBIbz5cUNpi4oba9YQ0nOac6OoxzcIX+sOjPfRNnqZAcmn0nK3n
cSczzUjMxOjoJVuTL+9itSkuMEHbx8TMpQWwaRQlqdrTMp6ZwaGePk8Zc40j+Iv6
ISZsm/RwrWdBZNy8My6qk5Rts4fLk9Fp90g3fMr74YSq9VxDAe00RtE711zoWHOV
DEb6OEI6TFiqiNcceQBKWi8bwrBKXk5KXoHI7U0pShVY1lwCRJ2X7dtcMpAfuewI
EXM3Pi7PrVXddepUdKQNXMqRtJplet8zntoObf70MtQOuvAloTk=
=HYBv
-----END PGP SIGNATURE-----

--LA5n/9LcFjbpAUwR--
