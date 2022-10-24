Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30460ADDC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbiJXOhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbiJXOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:37:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07384E52D1;
        Mon, 24 Oct 2022 06:13:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m15so31007088edb.13;
        Mon, 24 Oct 2022 06:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eefjOpwqUgqLvI2qTYyhOzgO7R2o9dubCnai2J+55E=;
        b=KNlxG3zeWK00YxdBtVeOWpZDIj1JndaDrEn7hmPSHMxBTjl4xHUB40rCs3sAScId/a
         EIJUwSmWX2MRL4Tzv4j8KZ4m2eRucxprC0GGxmykNX/+raW/yZ6inwzV/EQitXyzNMSU
         ZPesH+Gdksc2emrIaErmvFmSTC9XhrRqIyvNkLsaStVXW7CDfhyjN3fD22cb0pJ1+Dkw
         6y5g2v7u7pxrdf6jlQYrIJpdeL1wPoFsP17tU9ggHOYx+eyofF9wQxFwYFOLs09UIqYW
         T8Lle54SFCQ06OUQgo8l3gczfk/izz/NEyxP5hk8uZFFpvZ1C7ahYHuHUfr/T5Y5W+O+
         t1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eefjOpwqUgqLvI2qTYyhOzgO7R2o9dubCnai2J+55E=;
        b=BE5daiOL19A4lAHD/gpJY0u1ldqG8WBW/mA7zgGu+MGZaNbTlqYa0mqqCA02O+UlzG
         fZiZ1TLJD6WBAWl7HWfp0WzQfmm4KgyWDpG6hF7IN1A2ESm7BY/rgB8K06/yEDOzWjCH
         6QnChAXbAozGgz2ofFtMLreBgyjuzW7eWroihZutG9MzPPXpFImrhn2lqYZaT7XReov4
         qe+ZFo3sFz17RzOHGY+aeMeMvlCbSXGgSyBBbE/oYD8XlXtC3sUrtEKypZGm1eVkepxQ
         SgHtC2degUG93VYuNPCnV65IgjgcJEKVuLIV9XfOx/pAv0PUaRGUyL4l2TbgtlU+Y+S6
         CBpQ==
X-Gm-Message-State: ACrzQf1vlpukAHVCFEcUFFWNoCBFIfTIGDUYO2yyMHfeFkTxZ+rBG9sr
        W6/BPUeE8LfBpdDb35g0WNggk/dwX24=
X-Google-Smtp-Source: AMsMyM59IXtHOeqn8p3h/IwMdCiYiAoe2fHTz3OH4L5lKYUKXwSBy0HRKq+dMHYlMRXAWsFz52/N6g==
X-Received: by 2002:a17:907:7f02:b0:73d:dffa:57b3 with SMTP id qf2-20020a1709077f0200b0073ddffa57b3mr28278702ejc.19.1666617041458;
        Mon, 24 Oct 2022 06:10:41 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id kx21-20020a170907775500b0078c468bd604sm15610424ejc.57.2022.10.24.06.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:10:40 -0700 (PDT)
Date:   Mon, 24 Oct 2022 15:10:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 0/4] memory: tegra: Use DEFINE_SHOW_ATTRIBUTE to
 simplify code
Message-ID: <Y1aOzlVL7s431t6R@orome>
References: <20220926130025.1061373-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u/u6YhmL1Qm85hwR"
Content-Disposition: inline
In-Reply-To: <20220926130025.1061373-1-liushixin2@huawei.com>
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


--u/u6YhmL1Qm85hwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2022 at 09:00:21PM +0800, Liu Shixin wrote:
> Use DEFINE_SHOW_ATTRIBUTE helper macro to simplify the code.
> No functional change.
>=20
> v1->v2: remove duplicate blank lines.
>=20
> Liu Shixin (4):
>   memory: tegra20-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
>   memory: tegra30-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
>   memory: tegra210-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
>   memory: tegra186-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
>=20
>  drivers/memory/tegra/tegra186-emc.c      | 15 +--------------
>  drivers/memory/tegra/tegra20-emc.c       | 15 +--------------
>  drivers/memory/tegra/tegra210-emc-core.c | 15 +--------------
>  drivers/memory/tegra/tegra30-emc.c       | 15 +--------------
>  4 files changed, 4 insertions(+), 56 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--u/u6YhmL1Qm85hwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNWjs4ACgkQ3SOs138+
s6GrtRAApM1YtiuTyqjuzCWjkN4z019SfhTiPGEANNjpUOcBycJD6Y6dBr8a15Oh
3qSzWL5BlEt7b4GTY6Yz26GQgnoqSNYgq47KvDgw2vr8gSlh0nPAjsbRa/klVgIa
w+fqHwXM76k9iuakVDsVrlmmc3/llMybhsvMHGnT6WHIqpKU39tTUERTS9wW9XFN
gh1rEIbo8Vz4PfHphDoR2+p+PT8REPSyimmeOg0la+diZs43f6mprjmvS8xxMk14
Lvdf+emlK9opIWRNOW871hEm+EKxeoQWd72X2UPWt9/K4yMK/XSKqHooqqZjot6d
+Xy3wb6oCOXrU0NifKKa5LxqBxmoGUMDFX4NowXPXzUZci0knjHtxHQ8aNCNf/e1
mDxZ5Ya9+9klWwQHUTCaXs28fN/+PkQ3bFlPLYtC37FvITtVhstb9pyEPf6rza+C
8uwXan6G3Oo28nboVHbOiOzF7mKHdFsXL7Iv7v12Ue6lSUcAwhNlTNVu+yJ8NaMq
l/wCOpbVtVCM+nFx4bi8Zu71n1wGq2IdmkZ/brzTMiOsvnSLarctc35XIks+R8JR
s4RdVjPREhRkS3B7+D0F7HPAvJU09Zu0k4KQP2kExbuGdotka3WPaTSPYFOD6bnP
YYKCA6Vay55lJr2j9whxVyaVydw/rppz9Arc72Zj+ofMEMDbaD0=
=4Fa1
-----END PGP SIGNATURE-----

--u/u6YhmL1Qm85hwR--
