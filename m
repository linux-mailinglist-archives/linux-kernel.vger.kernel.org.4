Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A9E6FE076
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbjEJOgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbjEJOgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:36:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7307AB2;
        Wed, 10 May 2023 07:35:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50b9ef67f35so13069328a12.2;
        Wed, 10 May 2023 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683729354; x=1686321354;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jy9mHnnlUd36FnWW3GV3jUyIBkRWzWw6MZcV58/+PnA=;
        b=V98ALotLDfv4DY06o0tBF5rwW0BVK5uoRkl0g/h59wULhpTa/Qq/at9tcAA3plSgJ4
         nU4XRoGRdc9567D7SGt28uVzci0JGTDr+bjSUD0b/dF1U0aRHJe9YvvQYnu259SRnnwO
         f5dSCCSWP1xI9MXkPGbJ/7VVHyXvU6uSL+opYu71Si8BEh+C9QpRDUF71f542PgOp+1e
         7ar6nxKLYyqP/26sekZy0zybHhn/ChUirIVF+LMCYLmJ7z/nD0ftxEv2KxA/mLrm5Gna
         7JDBVD4g5CePytXKunBUtypELcDHXDtOJ6cpT8IVY4il6ogdTV+6kYJC0jfEwvetD4qD
         95nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683729354; x=1686321354;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jy9mHnnlUd36FnWW3GV3jUyIBkRWzWw6MZcV58/+PnA=;
        b=F6czP2iMHdE661EgHgnI16CnKu07CRchNv/ytxgroGB9sYOzFDcOGmtCqrvg64UxK1
         YI2FxpRwRMT8qs79W6qAF7ikID5uja9LwovSgX4ABZpvqSZFM9xPyWb4kJYpXFyZ5ZRX
         KtX4BbLWT9WOMPJfC//EdLTXc6F2AE6yHmoZdZyuhvkrb4ndRwjIlVmv7tCCHvqHSVX7
         sdC/Br53GzQ2m3GP2zl8JdNvvF1exPyjrJueXwwT/YEvM5Nst7cO+boJlqVfssMHtj+C
         Z3VrxmnoG+inUa3wBBjgJ1FYY8923umvaIs3sb9zUw2+FzcVisb9dnbKRGkzDZl/2RsX
         /OYA==
X-Gm-Message-State: AC+VfDxH8xC68e9FPx2iE0JX4QNiX8SAG/yrQwRpRl/p9VYFVj++sfzs
        LR2LawFoAl/BVfDUcRepuzI=
X-Google-Smtp-Source: ACHHUZ57UqvsEczex3L7aooCRx4VflWIp2vb1vqzLGm/7pzcIF75/+CxecWEqn6O6lhCWxKFbfhG3w==
X-Received: by 2002:aa7:c147:0:b0:50d:1e11:eb9 with SMTP id r7-20020aa7c147000000b0050d1e110eb9mr14636320edp.1.1683729354458;
        Wed, 10 May 2023 07:35:54 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q22-20020aa7da96000000b0050470aa444fsm1902932eds.51.2023.05.10.07.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 07:35:53 -0700 (PDT)
Date:   Wed, 10 May 2023 16:35:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     jonathanh@nvidia.com, Stefan Kristiansson <stefank@nvidia.com>,
        arnd@arndb.de, kkartik@nvidia.com, sumitg@nvidia.com,
        windhl@126.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] soc: tegra: fuse: add support for Tegra264
Message-ID: <ZFuryEViA0T2FQxZ@orome>
References: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
 <20230510113129.4167493-4-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4k25NvkuctWTnVXi"
Content-Disposition: inline
In-Reply-To: <20230510113129.4167493-4-pdeschrijver@nvidia.com>
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


--4k25NvkuctWTnVXi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 02:31:30PM +0300, Peter De Schrijver wrote:
> From: Stefan Kristiansson <stefank@nvidia.com>
>=20
> Add support for Tegra264 to the fuse handling code.
>=20
> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/soc/tegra/fuse/tegra-apbmisc.c | 3 ++-
>  include/soc/tegra/fuse.h               | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

The preferred subject prefix is "soc/tegra:", but I can fix that up when
applying. Also, capitalize after the last ":".

Thierry

--4k25NvkuctWTnVXi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRbq8gACgkQ3SOs138+
s6GqLA/+J6moqTyFHPsSkQOWqqsHqHtZS8FlYiEK96pP1toNWGPC2unVAKoYL8pg
wUsyLX0FdjiA983FXOxEzerMwmPa8FVpwrSqTNm99aVGcezrAEr7/CK53+dcEigz
cYneLCPIEVX6P8NYW8GGmdNob0Kayc1B6T1LhLF1kEfdgKGVwrIJU0psSMma6VVu
Z+3HjSxeui+KssRodmK/5vP1DTvlpKvpII+yUvcRKo3fKa7d7QY5tmKI1M7IPMz9
5rziHgcxDGus67oddXv/oYiJc/Co4TuHAG44uNRQxRP2zRYvuHklvdtmIyraI7UN
GPBfWws4+zVoscF4Rqjlpoif42oE5lVowdD4R3D/iTPxNhVWFcG5jpFKCaH/6/qp
u8dzwQ0KNQVSGTQZ8DI6wudJ9+ATLQftdofn0l/F48SZD/eL4Hl3+7dp+7cncuH/
tgiD4nKPzLlOt2nkWlsdr9gzAwBiTPChLMb1NUnK9eVKvoHGfwK/PkqyWDlX5bI/
J7E42dJ7sedLhjTIsawJ7Xu1mB7eylKdAaLfwpT5guNtSb/vcmi3ekwI3+Mky0Mm
+F2FWlLkeVPH1r++5yE9vJrcxfe+aDXOMFOceBk/tnXSAiaPwTx/AND7S2V6wOn7
vwVxgWISQms43OsuD2W0g0RXjEFvgwfRHQKroB3iKCfeR+9d4WQ=
=qnWx
-----END PGP SIGNATURE-----

--4k25NvkuctWTnVXi--
