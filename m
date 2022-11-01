Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3BD6149FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiKALyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiKALxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:53:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C5B6393;
        Tue,  1 Nov 2022 04:52:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i21so21389693edj.10;
        Tue, 01 Nov 2022 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5buWvgvvFxJX2MlWuLLvx/toLUlPXCUQviGf4Ex78s=;
        b=qvEbhm0NIc8XP7rsvYjbz6Y55WOdQspths8YZQX57YWI6J0CF/jJZ1S7XC/Pn9n7tl
         5Bp0LAmeOwlTfK/3mWak8hcD7YvSPUss2hEh3wv7juBeTdj9vx6Pbzc6D9QnutN/lbCC
         aRHmnUqKPEGxAmXK/UUhksyELYSazsKxMuIsc6/tDDyOT2kpd5V7X7J6t8uRoazoGtOm
         Yj41q1oqEKVit+ssiY7xKUL/oUL9UsVpMt8/MoFDnuwiIOZUZLW0DWMoaAt09NyGCSh4
         hpesdZmRpCOZueRkJfNtz+75XUZvHWRyAg6CVfhYnk7gQ1t3zkpftkYLAjKXLo1E7KV4
         eI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5buWvgvvFxJX2MlWuLLvx/toLUlPXCUQviGf4Ex78s=;
        b=ZtN+AcsxE7Bpg414BEw3axsJx4vfmxfeCvExcEGzUAAfD18+QhMQnPTVIRxPselaJd
         jpvpRyBx2wtfWi6Rf2Jv9x5XaVaVP02+4op3fXFtGJZAMmwxHMppuosrUZZxwmlMznl3
         U0GZvKc6Y2rJvh+RO2OCs7U9Hp15FVd9YfN3tWLCFgekGS7eM63IexNm3ATTo7h0yvCX
         GTm1vPRALJ3kH8Gsx2NZIPu3bewHlkOiVFwrHixIvfCryNS6nOOuUGJBMdLQeMXgpSqI
         Ut3lSjejScFVpf6pFC9N8McREQJJYUXKXgQxOIu0TTjiIfOMiDJss6cxIEdn3kJ9uGTQ
         0zbA==
X-Gm-Message-State: ACrzQf2gVPbLFCmGWB7FsApY5KzyJlqCcdeAkgvVyvxyu4FkGkRsUutP
        IVNOVulZMuSzY45K5vF9Ioo=
X-Google-Smtp-Source: AMsMyM46HgziX/cjbMhzxCCi6oNbVZBN7kqirAdwm1u9P9yeQPQq3AcrYmEHtTG2i5P+09xeCfkTRg==
X-Received: by 2002:a05:6402:3896:b0:45c:93c3:3569 with SMTP id fd22-20020a056402389600b0045c93c33569mr19037293edb.37.1667303537360;
        Tue, 01 Nov 2022 04:52:17 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h8-20020a17090634c800b00731582babcasm4195136ejb.71.2022.11.01.04.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 04:52:16 -0700 (PDT)
Date:   Tue, 1 Nov 2022 12:52:14 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bo Liu <liubo03@inspur.com>
Cc:     krzysztof.kozlowski@linaro.org, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] memory: tegra20-emc: replace DEFINE_SIMPLE_ATTRIBUTE
 with DEFINE_DEBUGFS_ATTRIBUTE
Message-ID: <Y2EIblbX0eDgpJ35@orome>
References: <20221101081611.8179-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/qX+lKIUA3ZU/Gtn"
Content-Disposition: inline
In-Reply-To: <20221101081611.8179-1-liubo03@inspur.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/qX+lKIUA3ZU/Gtn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2022 at 04:16:11AM -0400, Bo Liu wrote:
> Fix the following coccicheck warning:
>  drivers/memory/tegra/tegra20-emc.c:902:0-23: WARNING:
>   tegra_emc_debug_max_rate_fops should be defined with DEFINE_DEBUGFS_ATT=
RIBUTE
>  drivers/memory/tegra/tegra20-emc.c:872:0-23: WARNING:
>   tegra_emc_debug_min_rate_fops should be defined with DEFINE_DEBUGFS_ATT=
RIBUTE
>=20
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/memory/tegra/tegra20-emc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This seems incomplete: the rationale in that debugfs cocci script says
that DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe() is the
pattern to use vs. the less efficient DEFINE_SIMPLE_ATTRIBUTE +
debugfs_create_file(). So this patch should probably use the unsafe
function variant at the same time to take full advantage.

Thierry

>=20
> diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/te=
gra20-emc.c
> index bd4e37b6552d..c2b4caccfae9 100644
> --- a/drivers/memory/tegra/tegra20-emc.c
> +++ b/drivers/memory/tegra/tegra20-emc.c
> @@ -869,7 +869,7 @@ static int tegra_emc_debug_min_rate_set(void *data, u=
64 rate)
>  	return 0;
>  }
> =20
> -DEFINE_SIMPLE_ATTRIBUTE(tegra_emc_debug_min_rate_fops,
> +DEFINE_DEBUGFS_ATTRIBUTE(tegra_emc_debug_min_rate_fops,
>  			tegra_emc_debug_min_rate_get,
>  			tegra_emc_debug_min_rate_set, "%llu\n");
> =20
> @@ -899,7 +899,7 @@ static int tegra_emc_debug_max_rate_set(void *data, u=
64 rate)
>  	return 0;
>  }
> =20
> -DEFINE_SIMPLE_ATTRIBUTE(tegra_emc_debug_max_rate_fops,
> +DEFINE_DEBUGFS_ATTRIBUTE(tegra_emc_debug_max_rate_fops,
>  			tegra_emc_debug_max_rate_get,
>  			tegra_emc_debug_max_rate_set, "%llu\n");
> =20
> --=20
> 2.27.0
>=20

--/qX+lKIUA3ZU/Gtn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNhCGwACgkQ3SOs138+
s6EUSxAAlVXhq5ZD2hDdAO5/Hp6yGsNzcysyl6Jk1WAJnNdEdyfAGgLA0UeNKwDc
WnLcPprwrRMstAAydSMqN/Ula2lmWMB0GUJOazoK1mzHezU56ERmrechuax6ttcG
yoqdQWSGEQvSo/ufUPhX93EM9S3B8N6UO5eGlwZaXBMAA60ow1YiyJZhZGYf3yRO
+2Xi3yVxrmctfkWyh4z/C7mJX2k2tT13AWK2hucggbL9SjxZNlkjMP88bhZd99TI
eeGhzYGn752RS54/Km73Pzi7dKRuLfp83rQ6fWr9tDzifaHPUZL8s51Ud9h3xNhU
p+JEizKubblvp31MnukXp5xlCGg8WDCOj1tZ5Apt6x8zhjyppWJfpeAr6GgpJyTo
GsqkuTXBwEZ912VHlB6S2AfEDUsBAtCEzuF9pqPN0Vub+gsH17o8df/hngQco8Ik
fXYdVoo0loIwsv0Uhcp1pP7NanhxaWCc5xw8qGiurR3fLkiNn2XreFlpozY1eeRg
kBV+CmQLU/cSpe7z2q1DeuisTs8tj2Yg7issW0wC7DEnbGAp3h4oJ08BNe2BrPKb
QeBFc1fqCE9uO72oJNvWOHdjNc57IUgSxci9teEVFrlPgUVKfRKgyOhMKrsabYUW
WUywKwOcaDXMSzVpNJL1YnjMKij8/qfGnlVi2AQAHplN4aFD66I=
=IsQ0
-----END PGP SIGNATURE-----

--/qX+lKIUA3ZU/Gtn--
