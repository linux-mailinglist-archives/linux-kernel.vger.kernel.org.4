Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A746E9925
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjDTQGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbjDTQGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:06:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3666A48;
        Thu, 20 Apr 2023 09:05:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id z6so7561096ejc.5;
        Thu, 20 Apr 2023 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682006757; x=1684598757;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIrWFxNQFlhme+9qVbuyjFRPmgNp9vvWt4N75xCa6m4=;
        b=a9rxcvGAOssBpy4B7PyIEPBItlmSNahxnycgB4kVPzpIz6OZ9CMc7H97kEQ8rirzr1
         g4e//k/2hJlZY2UcTf/ZV7W78D0oif+QDSD8y/Rjn3IS8zvtuB+EizeU3l7A1BdTG049
         /TJWVOz7m+8Q0LcUIHXBV6oCE8u8hCi8ncoqi1GYe/MbKP6mPGOlXoG+YVsOwtANwTGX
         hE03Mn2G4krPSPrc1K/FPi1bTYIyLwIqQRteyPxens4/5ubijN1xjmZtZ6xEWcBqVc0o
         933H5jxC2QivNsdcAo30+PfZbexvs7vECbotqh6MI5YhKteAcECf5k46gh7EosS7RUg7
         bZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682006757; x=1684598757;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIrWFxNQFlhme+9qVbuyjFRPmgNp9vvWt4N75xCa6m4=;
        b=Q1r7eBXFNHjTW2+pUwrJeWi0bJ3D9gLvh5fg/Jev8A5MQrfokmifJJhILMlhXsx0YH
         lOe4jgrKZRXwhxPahpRLNhDuynbOt3scPKnKTyON5OtiVa5q9EnuOx6+rjiVtn+BRsZb
         8hWkDQWvC/yD9uEPOFbHTtQUTVUxlzuyhWfsur6VCv2pCOgzwnEibtTZmTiTvkoLgE36
         Qz1cotI9fza55L6H5mfoqRY51Q7gBhg4AFs0MbReppJSC1P8aoMVW1+7RSRTWuNDuQSQ
         n23lr4Pf0IIdfc/xCYTIqR/kSrbuvAzTY5jVkLXVnTPl03tCvFF8YSWsflUZCnaUjeS+
         s3ng==
X-Gm-Message-State: AAQBX9el0LyXMRI/tSd+cbc227SckVB90EGVRB/0lGaUUDipgLVsYySo
        UbdIS5KLnwKElMSF/me1XLE=
X-Google-Smtp-Source: AKy350YlLeT7OF1W7F6jluIK5b7JRjgtxjCjjoHaFXqLQ9oKKT4V6FsG5KV+u9+otG5Z3zZDBE9Jrg==
X-Received: by 2002:a17:906:1c06:b0:94b:d57e:9d4b with SMTP id k6-20020a1709061c0600b0094bd57e9d4bmr2070785ejg.2.1682006756729;
        Thu, 20 Apr 2023 09:05:56 -0700 (PDT)
Received: from orome (p200300e41f053a00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f05:3a00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l22-20020a170906795600b0094f25ae0821sm887732ejo.31.2023.04.20.09.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:05:56 -0700 (PDT)
Date:   Thu, 20 Apr 2023 18:05:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
Subject: Re: [V6 4/9] arm64: tegra: Add Tegra234 GTE nodes
Message-ID: <ZEFi4vKVtstiAno3@orome>
References: <20230414004455.19275-1-dipenp@nvidia.com>
 <20230414004455.19275-5-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NPoYIIrP4+2LC65A"
Content-Disposition: inline
In-Reply-To: <20230414004455.19275-5-dipenp@nvidia.com>
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


--NPoYIIrP4+2LC65A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 05:44:50PM -0700, Dipen Patel wrote:
> Add GTE LIC and AON GPIO nodes for the tegra234 SoC.
>=20
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--NPoYIIrP4+2LC65A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRBYuIACgkQ3SOs138+
s6EhoQ/+NM3QPHuY/4aEUx5uEy94QwELsFH6cn5FTtmq3kevgv+fjstZ1Ojxy3Nf
tx34APCxIWm85Bs6qI+xs7o0ikd+WrttTV6CxQhpOiptO88eDr3vT2aN6bSqTBR7
LR5HvaOnn06pRkYHbMGM6OTRLCAEU5J7Cz3C+n1oG6mE6405ImpAAImYZMyPH7Be
ITbUFGF+ZH6cucAlxvoi5GnBn8zoN9hYgLphhQs7qOqSqV+bVxVBvFJq2ZXBhQPp
CKHvoKdN6aWcynnLiPDZsZ1uvVfjV/iOUMwgb/lyl5SW/nrXQqipBPN6l5ONvG2F
xUt/auV2Ipsn3x8vlEKts2qrzVwl9ojiy6Is/hUp95L/srpJUeix0zPGU38thBSp
aVbsNXy6T2yQCpjFE9kVO3uuIvJGsOqSp6tt4CYrrEryt93ktU9dEjREbkaLRDRa
5oSnzNVDKmzith3Zi7uPUL7eKvtQflnMbCOhn2HvAyVcjijyWxaQvqYuDC9tZhs/
31R8aSgpVF8in6IkQnztLgEdXehAi4yuq9TWOeKRgVJUYAXBfmg+kfXchmRVlxVl
d5UNYfEqmPjjxRbJPL7491G8JXtV6V53RrSuEuZizMdUgT3Qp2ut4J+DaTXMHiSc
NBfvENpdOfv8MBtwt7Rs/kyZZJC5D9RT5jKMomseLewcNM+X6ho=
=vZgG
-----END PGP SIGNATURE-----

--NPoYIIrP4+2LC65A--
