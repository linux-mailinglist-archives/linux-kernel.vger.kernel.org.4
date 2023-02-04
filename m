Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397D368A9AD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 12:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjBDLnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 06:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDLnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 06:43:14 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07551BAE6;
        Sat,  4 Feb 2023 03:43:12 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j25so3149128wrc.4;
        Sat, 04 Feb 2023 03:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+Sm+kfqwSUzJQ4KP+9G1CP7oj6Tf3jeZZjkaMN7C8Q=;
        b=EFUfpmET3n1ARMc8G+XCFXqCc7F91j4cgyg39ectegBHfFbs6vCwpqNlqrFWSdUmTg
         dnJf8zYg31SiBhcvz0IzpvUOTFHJyvY62oLveQh9YlspZob0lJ8RU+jNNCJJ3uk53gty
         sl6wk9Uq/po9liQYoqxTVqF28+bPvHO/KwsnVLFR4AIZKHlyG36pJkknY0YeA5crv8JR
         QV3qoI8183af8I+chEPIvr/Dp/nPHSGNsCNshIJxo9DJidtOUv3Xi/OCc94epRoZViBu
         fPcfQ4e8wTK3McgN1W909DQylJdI4O6XJsIgisKKLFCisAIdcv3veHUauNJOjVYO0us8
         u7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V+Sm+kfqwSUzJQ4KP+9G1CP7oj6Tf3jeZZjkaMN7C8Q=;
        b=JKWrHEZxa6JZ2A3lKjCIG/5bUak+5EuDJ04/nvq18NGEDGGtfe5jVemtofoCtEltTg
         5NXIVyJobIBYpKs1VRClk5okNm8P9p20oiQ/M1gkwG/RMQE2MHj2U72Y+/x4zxBo8GGA
         8TzsGZvYaLKv17GCnZiHvY0K+myNSS7amGHPzSuexRYUyFtKL6VTs99WWPXwhSYga2Vt
         oVJ4k6aXgXbgak+KDV/y7RCA36LBi5jGcxZwUXgOW4dfuCdnbrzSbI4T+qpzdiPDRbd3
         1GArAKnXOVyz7kVB5AquS6qIgXIF/HZfRwhUQLq8dQF+ZcIYaUM0cx0ZLv7fimCQPeTP
         dI0Q==
X-Gm-Message-State: AO0yUKXLpClYupV9Zu9iBK/MAJpaelnJ+TTNpmAPPR+pL75KfhtlNRO9
        7BDgCq/BdgeqbwaUsrIBPH0=
X-Google-Smtp-Source: AK7set+bg4XgkhaqdxGx6athTsrEitT1MA1GLJh+U8v84gSdV36l2Hj+rjOMzsjIDZVeG4yCa6GCvg==
X-Received: by 2002:a5d:514d:0:b0:2bf:d1a1:ff5d with SMTP id u13-20020a5d514d000000b002bfd1a1ff5dmr10648918wrt.32.1675510991279;
        Sat, 04 Feb 2023 03:43:11 -0800 (PST)
Received: from ?IPv6:2a02:ab88:368f:2080:d12e:7ef:c89a:f600? ([2a02:ab88:368f:2080:d12e:7ef:c89a:f600])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600015ca00b002bfd137ecddsm4373342wry.11.2023.02.04.03.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 03:43:10 -0800 (PST)
Message-ID: <398401ce6a1e37b42f895b86fa2ed90c2676e15a.camel@gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: exynos: drop mshc aliases
From:   David Virag <virag.david003@gmail.com>
To:     Henrik Grimler <henrik@grimler.se>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        m.szyprowski@samsung.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Date:   Sat, 04 Feb 2023 12:43:09 +0100
In-Reply-To: <20230203204000.14410-2-henrik@grimler.se>
References: <20230203204000.14410-1-henrik@grimler.se>
         <20230203204000.14410-2-henrik@grimler.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-02-03 at 21:39 +0100, Henrik Grimler wrote:
> They are no longer needed after commit a13e8ef6008d ("mmc: dw_mmc:
> exynos: use common_caps").
>=20
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
> =C2=A0arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 --
> =C2=A0arch/arm64/boot/dts/exynos/exynos7-espresso.dts=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 2 --
> =C2=A02 files changed, 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index f54f30633417..c895b70b3cec 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -40,8 +40,6 @@ aliases {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0spi2 =3D &spi_2;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0spi3 =3D &spi_3;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0spi4 =3D &spi_4;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0mshc0 =3D &mshc_0;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0mshc2 =3D &mshc_2;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chosen {
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> index f3f4a6ab4b49..686f0923a4a7 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> @@ -18,8 +18,6 @@ / {
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0aliases {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0serial0 =3D &serial_2;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0mshc0 =3D &mmc_0;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0mshc2 =3D &mmc_2;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chosen {

In dw_mmc-exynos.c, there's a caps array specified like this:

/* Common capabilities of Exynos4/Exynos5 SoC */
static unsigned long exynos_dwmmc_caps[4] =3D {
	MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA,
	0,
	0,
	0,
};

As I understand these capabilities are added to the mmc controllers
based on mshc alias id. Shouldn't these capabilities be moved to
device-tree before removing these aliases? This also applies to the
32bit arm patch. If I understand correctly, removing these aliases
without adding the capabilities to dt removes the capability
"MMC_CAP_1_8V_DDR" and "MMC_CAP_8_BIT_DATA" from mshc_0/mmc_0.

Best regards,
David
