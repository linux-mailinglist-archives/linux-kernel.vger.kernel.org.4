Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DB4644977
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbiLFQiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbiLFQhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:37:33 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAC1CE8;
        Tue,  6 Dec 2022 08:36:47 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z92so21127146ede.1;
        Tue, 06 Dec 2022 08:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cu4l7c7T/KB912u2Bgs9LaIHGYUGD4KvKD2RT7SocLI=;
        b=PMIsbCZcJUnwlcb85e4se4Lhmnkg5/p3CZ/cDZsAukZ3f3i3tmY4g5sANJgykCYirK
         mlvGaIPbXgCyzpAmH06sYNk8vCmaADFoE6zZqQHb8hGg4x0/WHv6Z8hYJ0LBIWS+LTtc
         u+Elv8Ugh2Cba3MU9nJxstXdxBM91J+/NK6gRkjIOK3iiQ+uH5og/9UApeMWkOKnd9cj
         1HfW0ZgVT20uEcispZUyLDadLhenYxpl6mq5JxMXKgftr+gVs0wv+tsc+y54FBjZx7F/
         u//HOUZNxymJ9GIObTMD8FDbnCFX9F/nCVNnq/jzUgW6MoBC+f52FSuv+e3PAFbJwBdU
         tGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cu4l7c7T/KB912u2Bgs9LaIHGYUGD4KvKD2RT7SocLI=;
        b=QqgvWJFuBx4Dlbq3c2K4BFr3EmtAo1gXs7Sd9pixTs2mMVmgJm5rpnyKyOuk0VBvhx
         v35X45QzmJLTsm0tTIJ6vLUPqkhCRoPQmPETpEzIwCzHW3vh11ExPn9wJvDbhJ9TazUl
         6jD/L14lToXbia9j4D0IlzI69fJpDBqjz/izRfhtPed2g2Zn0qpUhA2kDS28X8CXArqW
         XgivAtJTMLQs4ByUQ5PSubW39xwPDmwq4WpmBw6+UP8hRlgs653/LQq1IKsBjXpXx+s4
         TTRRWFltKV8RtmMICfxgcGPBB5NMqnSTkgXtzV+58CqJKJN6cSxv9cP6ax1ZM6GI4M6g
         KTXA==
X-Gm-Message-State: ANoB5pntnd1xbY5FVipUuD9fid1wW1UiXIMmnOThvcw8AGmdAM44wGBs
        QzY2jSR9CrnpEqENlvtSdK0=
X-Google-Smtp-Source: AA0mqf73SzGZEjm/ohEPWqbfiYGIO3rXn2gObtryTw0s7vUBeNfZ9CzBOpFc3oS8A3V5nkWXr1+saw==
X-Received: by 2002:aa7:d1c5:0:b0:46b:a536:e8d0 with SMTP id g5-20020aa7d1c5000000b0046ba536e8d0mr26626675edp.261.1670344606270;
        Tue, 06 Dec 2022 08:36:46 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id y20-20020a50eb94000000b004589da5e5cesm1168852edr.41.2022.12.06.08.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 08:36:45 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:36:43 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Joe Tessler <jrt@google.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Jeff Chase <jnchase@google.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 8/9] media: dt-bindings: nvidia,tegra-cec: convert to
 DT schema
Message-ID: <Y49vm34cwgilAA33@orome>
References: <20221205151845.21618-1-krzysztof.kozlowski@linaro.org>
 <20221205151845.21618-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Go2Ynh+Vu1nkhJ/W"
Content-Disposition: inline
In-Reply-To: <20221205151845.21618-9-krzysztof.kozlowski@linaro.org>
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


--Go2Ynh+Vu1nkhJ/W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2022 at 04:18:44PM +0100, Krzysztof Kozlowski wrote:
> Convert Nvidia Tegra HDMI CEC bindings to DT schema.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
>  .../bindings/media/cec/nvidia,tegra-cec.yaml  | 58 +++++++++++++++++++
>  .../devicetree/bindings/media/tegra-cec.txt   | 27 ---------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 59 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/cec/nvidia,te=
gra-cec.yaml
>  delete mode 100644 Documentation/devicetree/bindings/media/tegra-cec.txt
>=20
> diff --git a/Documentation/devicetree/bindings/media/cec/nvidia,tegra-cec=
=2Eyaml b/Documentation/devicetree/bindings/media/cec/nvidia,tegra-cec.yaml
> new file mode 100644
> index 000000000000..9a4025ff7fad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/cec/nvidia,tegra-cec.yaml

For consistency with other DT bindings on Tegra, it'd be good to name
this nvidia,tegra114-cec.yaml since that's the first generation where
this IP was added. Not a big deal, though.

> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/cec/nvidia,tegra-cec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nvidia Tegra HDMI CEC

Again, for consistency with other bindings, NVIDIA is the preferred
spelling. It's not a big deal and could be fixed up in a subsequent
patch, there are a few other cases where the alternative spelling has
been used.

The rest looks okay, so either way:

Acked-by: Thierry Reding <treding@nvidia.com>

--Go2Ynh+Vu1nkhJ/W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmOPb5sACgkQ3SOs138+
s6GLkQ/+JBbjUjYZFvRHaZqueKhqQcvpNxzAo/fyN5BnZRl/Dr6r9OkfSNoSVuEm
io5uqdiYDfXXvkApiv7BbHeNaXH8BX0PxRZ9J+hsE41zpGVHRHE+dmRlcE+rhY54
/TpkHx0VCMROkD6C1KQShCE4n9CQGRixLL2sHdhIWxmkaC2fLR609+duNNQ4t8Up
ASXC4hJuo1TaO31lGydUoB6S7SeU+iSO71B68Pc0HZ2cFib1ZnsdLPgK1gMJyO9q
ooyvj+IZsPX+YMfId0bMq9owxQRdqZhxSx58LOELQPR/5Ac8Cyfll70L9eZ9uw/8
5PKT6Eb5ilJnjfCDzF/ef8BGMBL1Ko5qoZBAdqE2Pgk01joFuRIclgZBHcujEaMl
ymMSnEla9I8thLrJ+8grukft6H6FcuKDnqsn4jhCoIm8b7tID+jyKCbmaBxb0AmC
VBn13BuYlSv6czihQawg9cfUyjnam/f6t/KksETr1Ne6HzC0qN7ZrxXNjcqFVB48
mrmKcUbT1adE4eq5czWTEExxckY91LIGSBxZVO6JFRp+13qv4HUV6ZfC8bHM+0x+
g8WACmp+9HsfNHLR53X2ASF7UIzPicMXNMw2SHK2Zx8y2/WF1MdWRkYIj9NpfkhD
eIbGX2q9nIG7nsmqzH66uQO59Wqdv40FseT6dQM5KPpNNz9Z8eI=
=2Wsf
-----END PGP SIGNATURE-----

--Go2Ynh+Vu1nkhJ/W--
