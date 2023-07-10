Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8850A74D707
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjGJNJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjGJNIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:08:32 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A1B128;
        Mon, 10 Jul 2023 06:08:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99364ae9596so577511166b.1;
        Mon, 10 Jul 2023 06:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688994500; x=1691586500;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4Yu4nZ9o/MAugiHNW1oP2TWBog7+wh9NiTblk14kDg=;
        b=ViKLx3vuJ5Z2OZiH/tMNs7+36C5ErzoM+wXhMsBLmBioA4d/87VvFYg9xu7yF9NYI7
         eW0cRRSun9o7/uBwbj9nMt1MxZ2ILgZ8TJL6Qbw0qOjL3bsRT3ZUoCACT5dzlbz+CGVp
         t9wLe+JD8luMvDMLgGkXaC6r/WstGA6qKjIKBmIAn8B2ibPW+yuWsRN7leV1a+r4uxNj
         u+hZVI2YPLOuz3AeCDWCh2PiCBEMstSEL2fBx8AVNUXNq28fWnwYpknz6ZRs8fdzmGFB
         KpjD24mWQEkMUYbgDUeKuX3D9Tr0BjxOh9BA1kgHsmGbRKIljItY/qy8B4DcqhccOgkC
         y3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688994500; x=1691586500;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4Yu4nZ9o/MAugiHNW1oP2TWBog7+wh9NiTblk14kDg=;
        b=WirI5RBBL8Jd9POeObAP2ic3AidoARfZZNLBO4/aTN345lvjR6N/1h41q18gpkjYt+
         mTPHyNKkvv5CkUpsgZ5EBw4+2cY/U+6oXW2DNgFBXs2GaUrBvudy6pbTp9oMGLLv8l3J
         ECm72GuAQtJJ0oms6V5Ih2TEnX4eCAdNs05FtXJwWkEgiSp6/k0NWcesrVPxN7Zyfa+J
         X7Bik6eKV2yWOeM3aS4vG0biZjvDzgE6NkA/Agj3efKgAiJJESdyCSbPhyRSbBmiYMwB
         iiIoWOYSE536GF/IoGm2uETHiF//JyQv7OlX1AZO3CTEMpnMLH47k/yNlQM3u8x9/H1T
         q2Dg==
X-Gm-Message-State: ABy/qLbUwDvkNR42qEsNylS9w9btTStPt8r+4vMgGikUlZsLB3eAxJLR
        QOH9roAI/OKm020OKUcMbak=
X-Google-Smtp-Source: APBJJlEZSid4m5LqiMkjIuq9pqoFUus2yiqHgqNIdRxQzpkVtb3ChiIS1Aia+iMuLU7ts1DBLslKyg==
X-Received: by 2002:a17:907:9008:b0:988:9621:d85f with SMTP id ay8-20020a170907900800b009889621d85fmr11123647ejc.58.1688994500400;
        Mon, 10 Jul 2023 06:08:20 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i18-20020a170906851200b0098669cc16b2sm6048866ejx.83.2023.07.10.06.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 06:08:19 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:08:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 14/18] soc: tegra: Move powergate-bpmp driver to the
 genpd dir
Message-ID: <ZKwCwqHwqCEIHMKv@orome>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-15-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bFL+MChN9/7KXUcr"
Content-Disposition: inline
In-Reply-To: <20230707140434.723349-15-ulf.hansson@linaro.org>
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


--bFL+MChN9/7KXUcr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2023 at 04:04:30PM +0200, Ulf Hansson wrote:
> Let's moves the powergate-bpmp driver, while we leave the pmc driver in t=
he
> soc directory. To move the latter, we first need to split it up in a few
> pieces so the genpd parts can be moved alone.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> Cc: <linux-tegra@vger.kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/genpd/Makefile                        | 1 +
>  drivers/genpd/tegra/Makefile                  | 2 ++
>  drivers/{soc =3D> genpd}/tegra/powergate-bpmp.c | 0
>  drivers/soc/tegra/Makefile                    | 1 -
>  4 files changed, 3 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/genpd/tegra/Makefile
>  rename drivers/{soc =3D> genpd}/tegra/powergate-bpmp.c (100%)

Fine with me:

Acked-by: Thierry Reding <treding@nvidia.com>

--bFL+MChN9/7KXUcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSsAsIACgkQ3SOs138+
s6GpGw/+PL9CvgiLkda1wJNl1l2p4aij2hHBUbv5HmJ26j99KaMSJHfXSr+FU8zE
hY/w1nVVm2hUjn0k3rLo6Pe/vNGw4XzeA+Ifp17KoqHhEk2aboOZdLyLK/KULYS+
ADH9C+s2nunBpXTbwODqP8/8GysMwTotkKPGn3l0VvD7pzKE6Bsx4cUdi0LV1vwr
AVfHAOBOy1HB27K3oM5tppuA3OiRcwCUJPtFty3FMv5UDHFOcKmYOYLRK6R0PIA5
o+SANCTlpioBcQIW8rQo4yJwFHvllTr6j8slRvzbmuL++vwKYNZTPoZXhiy2rKD7
squsr1qQNjJRHayNKoapV1ElZNan1L7X8zgoqW29FAGuJeuRx6ecqlBTEiD0bgsp
daoiZAdfPLc9ZmR+A9aNDtXzM5owlXoxG6ZRLqo4J93nQDT+8S1PyN3cbIWQB7PL
uq/m/aFpLGzfsw+82q9XfVdtZpjEe9F4JcEhAeP5ZrdmMthzAra/aYxd+IyGDdE0
I34tGGKOLOw4EeCYJ/4XlLrCVEz4oHlXHEJtqmrMFUM1fKwvZY12X2RIfOw9v+Mk
f4Jej8JDO4LkYaQKZh2myc/XoqniY5FR5NMRbhSEiKDAqq9MIBhCPfBqIRA1U79s
TfYkYPBbSqZ2QtJLSeIrH61+7CkXCySKqSNU+lRJk3DUbERgnYo=
=rRak
-----END PGP SIGNATURE-----

--bFL+MChN9/7KXUcr--
