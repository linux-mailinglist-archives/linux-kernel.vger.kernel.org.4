Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554846FB0C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjEHNB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjEHNBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:01:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E03B35D9A;
        Mon,  8 May 2023 06:01:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-953343581a4so684662866b.3;
        Mon, 08 May 2023 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683550881; x=1686142881;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2LoaJtLMloogdr4NC6JEd1vFe6odGnmP5Fk9z+paqg=;
        b=PGmP/t7LQouSPkbJznjaC7lqWZB0IeYXiEw7NaxILpmfsoxfiry+eylMEtTY6MbFIM
         CJtk/cpasnxrot1/Jq+qCbePSdrCUzuiS8oEyMdYepBtW5bGUhIWoOdG8/As4AYOFiG+
         J8JfRx4COY7V0+m7aszywcO0v4nhMstfnyEhRz4hwwjVBnk+rJUiBLdcWm7aOejlwrXh
         YrIX4n9XsiyQDaA0fJwriWLg9jeV5nqk9Of6+uJ2+a73hEXZ9EaJa19/KHWXqt9uxhln
         c88e1wUmJPd+h46O/WtEGrHcHIe1CVn54bbHhKETb5zRng3sRC0230CnHI8HlW/cXxc1
         OG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683550881; x=1686142881;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2LoaJtLMloogdr4NC6JEd1vFe6odGnmP5Fk9z+paqg=;
        b=b9zdrg3bnyYn3zdTTiOaM5Nd95xSN0tEpHkFing0nsLGdOe7KNNHBRAllEFjCcPNZO
         J28wZ8OBKE2Ge+3elnF9IHJC0FLO335n1fxFDkOs2If9p2X4y7MxNbMs9kFCn8EjZEO3
         Dy8vgsyi2T1n6v1RJPbawtiM/mwUEBNvmxPHKU8BhcCBIJv+zvbkJvM0+9vuWo6pyCTB
         89UYmnyfKnkzOzUvFAJ1+KV6CHJzI4hNh1tCHaHAf7EZD9DWyGIlfL+Pu6I1varbqaZd
         vKxAnvJ5atZCQpL3+kxXJ1ZJKJ4SFE+fscT05BwtRyobC584MZ776ina/fHvg+3wMcVv
         WFug==
X-Gm-Message-State: AC+VfDwdT8XFjZnGMqiGVdP9a/IlyjBibYnE/sBo3FI7qSNp979xg21x
        qusVKD3ptQJ5DU3sBS35EoxpxHdH0E8=
X-Google-Smtp-Source: ACHHUZ4sKYaqSYVrC+06V4KP0qfp6QDadf9rT+aLDf+SWuqt+YszVzjOJtL8SsqCQuB5ylk6qGYDAg==
X-Received: by 2002:a17:907:94c2:b0:966:3114:c790 with SMTP id dn2-20020a17090794c200b009663114c790mr6021565ejc.37.1683550879441;
        Mon, 08 May 2023 06:01:19 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fc0f000000b0050bd19ec39bsm6078598edr.83.2023.05.08.06.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 06:01:19 -0700 (PDT)
Date:   Mon, 8 May 2023 15:01:17 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     jonathanh@nvidia.com, Stefan Kristiansson <stefank@nvidia.com>,
        arnd@arndb.de, kkartik@nvidia.com, sumitg@nvidia.com,
        windhl@126.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] soc: tegra: fuse: add support for Tegra264
Message-ID: <ZFjynangQpNfYbZ9@orome>
References: <20230508122048.99953-1-pdeschrijver@nvidia.com>
 <20230508122048.99953-4-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J9cWw5sqWcv09zQj"
Content-Disposition: inline
In-Reply-To: <20230508122048.99953-4-pdeschrijver@nvidia.com>
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


--J9cWw5sqWcv09zQj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 03:20:50PM +0300, Peter De Schrijver wrote:
> From: Stefan Kristiansson <stefank@nvidia.com>
>=20
> Add support for Tegra264 to the fuse handling code.
>=20
> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> ---
>  drivers/soc/tegra/fuse/tegra-apbmisc.c | 3 ++-
>  include/soc/tegra/fuse.h               | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Same comment regarding the Signed-off-by line as for patch 2/5.

Thierry

--J9cWw5sqWcv09zQj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRY8p0ACgkQ3SOs138+
s6FTbA//XFQm+ljRi5uoKMqDe4mEZ53rAy667NhNgHCEUfUmcfEWKlo0wHNh9vNS
CFV7bImRVc8J+nKOhL2dlKircLAtVgDVS7lW5+iuWj0j3Z124Rg/xH6ShZoMLLat
wT8TdW01jCmcr1gtEAlns2r8ra0MRfWcZYl7JureRByltJtgcm9aSqPAom0ddXI4
FlqwKvPZbdsAPvjsvk+cwEmy0KtLyUeI8Rae+I2nM+ub9PITAJOt5icHBkwjtL5S
DuJnoG7mH4stKYvRSA+FYBosMx5J+So1A7joMyZAZkcUPVXRYWW2PidarSfK6MT7
eVW2c5pNaTBLPU9qvn8gjYISmcoMSa/OKlfzL8AHtgR4pt4/xxvn2CeLQH4nMVrl
u1LviInXYvC+w6IODcrfmvZokf0QQ9ySh4IU+q7ULJ2nl6PitheLRiY4DTKFISVw
oUsGWDZuMamiI1XGBCKKFdzHN/5lxwNlLA+rlI9bfroHWc1SgWOIyzShV6tr5vza
oE/FXTt2ton1dkeBlAuO/5aBA07C5eUCR51phZXUaj6Gtu1j6Y5YLWnGFvYV25du
/HntdcMprgxhZjUAbiR0/jFrPAKIX3F3ScD+AaYrS2KXJs2BNdDujyPo831WCqCo
RHavwkLWq5u/xqLvFPFgSSSWd3E46TU/kJJYEDT3XPzwlBul5yY=
=TW6/
-----END PGP SIGNATURE-----

--J9cWw5sqWcv09zQj--
