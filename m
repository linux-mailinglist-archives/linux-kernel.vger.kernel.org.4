Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8387B61A753
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 04:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKEDdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 23:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKEDdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 23:33:43 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8D827DD1;
        Fri,  4 Nov 2022 20:33:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id v28so6069606pfi.12;
        Fri, 04 Nov 2022 20:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PqWuupQi575tTUpTn1o8/kCq7G4qDeLiygBhCrz4Zxo=;
        b=aGdUJM/eIC4PP+6b+bBppMXXwPX3CNiuwwB6lgiPNuyvmrM88eneutVazgDvc2MLQ6
         UJ4R0Wf47SGdcHq2b0/UA4d0wodUaZdfFZBAGej85/rMoU4MhjPEFB+3/wJZGPcFKlxm
         xyjSsO9d8JDye6GUuUe2jduU1TVtZo9A+PyOJtV73YMr4d8EAJ9mD1yi1q94u8A1v6c/
         sYJmUcWWFLssxQzvPQ8xoh1ULLvghWDEo7dLJO9mW53cox+STTdNM8t9ryEUtqowDMuP
         dnBdvnq6ZwQlg+M0HrzyjyANMH+OWUoLl6Yf8pakpEOhFenzfv47ZZiQY5/6C8umg61P
         fTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqWuupQi575tTUpTn1o8/kCq7G4qDeLiygBhCrz4Zxo=;
        b=ankdGW0Sq/fCut1nEeKR8fp652qASZ1YjW0ILzcRt+33lc8CPF1kHLiVxHWNQYg9JZ
         2M44wI3GheGLe3c2Nhy0pxpmFPTaykpDi7Y9lLNhu5r6uf5TDXKKnHfUYrM0GLSlCu9h
         Qb/Yz2k3lTMimMJhI8sUeX3sIpLez5oos1HmCOqMeXkzCa1eY6x3oonn4pxlaQvXq8yT
         JPwLj228Hc5L21elNjY8jUdnvRfZhtQjNXqrDv6+ziLzGKGKd7/J+T5jQD+Z2iYE6Dd2
         z3prJXtXSX95VtWxIZy/giFa+IzLOtBgAOLXitaxWRqc9MB6HSSM5cmQLsUHrTZZy1XH
         bBNA==
X-Gm-Message-State: ACrzQf1ZTfZMVuJxjtopSbdaD2t175O7DyeEW+ogwY6rUR6Zu7Z5wnJc
        bp9M1MXPNuw0nBGCzVPeoC8=
X-Google-Smtp-Source: AMsMyM4x71iF83RahSkMtTuALh2Y0HRgGol+0+euNhayw25UqeojetlLdZqHO0MX/qp+ZVFHPLcIoQ==
X-Received: by 2002:a63:5109:0:b0:470:22e0:d7a4 with SMTP id f9-20020a635109000000b0047022e0d7a4mr9087189pgb.71.1667619220342;
        Fri, 04 Nov 2022 20:33:40 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-85.three.co.id. [180.214.232.85])
        by smtp.gmail.com with ESMTPSA id w3-20020a628203000000b00562784609fbsm322628pfd.209.2022.11.04.20.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 20:33:39 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4619D1009A7; Sat,  5 Nov 2022 10:33:36 +0700 (WIB)
Date:   Sat, 5 Nov 2022 10:33:35 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH 5/7] hte: Re-phrase tegra API document
Message-ID: <Y2XZj4j/NQH2igvJ@debian.me>
References: <20221103174523.29592-1-dipenp@nvidia.com>
 <20221103174523.29592-6-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uDKYV1gmcRUMwZrs"
Content-Disposition: inline
In-Reply-To: <20221103174523.29592-6-dipenp@nvidia.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uDKYV1gmcRUMwZrs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2022 at 10:45:21AM -0700, Dipen Patel wrote:
>  Description
>  -----------
> -The Nvidia tegra194 HTE provider driver implements two GTE
> -(Generic Timestamping Engine) instances: 1) GPIO GTE and 2) LIC
> -(Legacy Interrupt Controller) IRQ GTE. Both GTE instances get the
> -timestamp from the system counter TSC which has 31.25MHz clock rate, and=
 the
> -driver converts clock tick rate to nanoseconds before storing it as time=
stamp
> -value.
> +The Nvidia tegra HTE provider also known as GTE (Generic Timestamping En=
gine)
> +driver implements two GTE instances: 1) GPIO GTE and 2) LIC
> +(Legacy Interrupt Controller) IRQ GTE. Both GTE instances get the timest=
amp
> +from the system counter TSC which has 31.25MHz clock rate, and the driver
> +converts clock tick rate to nanoseconds before storing it as timestamp v=
alue.
> =20
>  GPIO GTE
>  --------
> =20
>  This GTE instance timestamps GPIO in real time. For that to happen GPIO
> -needs to be configured as input. The always on (AON) GPIO controller ins=
tance
> -supports timestamping GPIOs in real time and it has 39 GPIO lines. The G=
PIO GTE
> -and AON GPIO controller are tightly coupled as it requires very specific=
 bits
> -to be set in GPIO config register before GPIO GTE can be used, for that =
GPIOLIB
> -adds two optional APIs as below. The GPIO GTE code supports both kernel
> -and userspace consumers. The kernel space consumers can directly talk to=
 HTE
> -subsystem while userspace consumers timestamp requests go through GPIOLI=
B CDEV
> -framework to HTE subsystem.
> +needs to be configured as input. Only the always on (AON) GPIO controller
> +instance supports timestamping GPIOs in real time as it is tightly coupl=
ed with
> +the GPIO GTE. To support this, GPIOLIB adds two optional APIs as mention=
ed
> +below. The GPIO GTE code supports both kernel and userspace consumers. T=
he
> +kernel space consumers can directly talk to HTE subsystem while userspace
> +consumers timestamp requests go through GPIOLIB CDEV framework to HTE
> +subsystem. The hte devicetree binding described at
> +``Documentation/devicetree/bindings/timestamp`` provides an example of h=
ow a
> +consumer can request an GPIO line.
> =20
>  See gpiod_enable_hw_timestamp_ns() and gpiod_disable_hw_timestamp_ns().
> =20

I think the wording can be better:

---- >8 ----

diff --git a/Documentation/driver-api/hte/tegra194-hte.rst b/Documentation/=
driver-api/hte/tegra194-hte.rst
index 85e654772782c1..13c45bfc03a75e 100644
--- a/Documentation/driver-api/hte/tegra194-hte.rst
+++ b/Documentation/driver-api/hte/tegra194-hte.rst
@@ -5,11 +5,11 @@ HTE Kernel provider driver
=20
 Description
 -----------
-The Nvidia tegra HTE provider also known as GTE (Generic Timestamping Engi=
ne)
-driver implements two GTE instances: 1) GPIO GTE and 2) LIC
-(Legacy Interrupt Controller) IRQ GTE. Both GTE instances get the timestamp
-from the system counter TSC which has 31.25MHz clock rate, and the driver
-converts clock tick rate to nanoseconds before storing it as timestamp val=
ue.
+The Nvidia tegra HTE provider, also known as GTE (Generic Timestamping Eng=
ine)
+driver implements two GTE instances: GPIO GTE and LIC (Legacy Interrupt
+Controller) IRQ GTE. Both GTE instances get the timestamp from system coun=
ter
+TSC which has 31.25MHz clock rate, and the driver converts clock tick rate=
 to
+nanoseconds before storing it as timestamp value.
=20
 GPIO GTE
 --------
@@ -19,17 +19,17 @@ needs to be configured as input. Only the always on (AO=
N) GPIO controller
 instance supports timestamping GPIOs in real time as it is tightly coupled=
 with
 the GPIO GTE. To support this, GPIOLIB adds two optional APIs as mentioned
 below. The GPIO GTE code supports both kernel and userspace consumers. The
-kernel space consumers can directly talk to HTE subsystem while userspace
-consumers timestamp requests go through GPIOLIB CDEV framework to HTE
-subsystem. The hte devicetree binding described at
-``Documentation/devicetree/bindings/timestamp`` provides an example of how=
 a
-consumer can request an GPIO line.
+kernel space consumers can directly talk to HTE subsystem while requests f=
rom
+userspace consumers go through GPIOLIB CDEV framework to HTE subsystem. Th=
e hte
+devicetree binding described at ``Documentation/devicetree/bindings/timest=
amp``
+provides an example of how a consumer can request an GPIO line.
=20
-See gpiod_enable_hw_timestamp_ns() and gpiod_disable_hw_timestamp_ns().
+To toggle hardware timestamp, use gpiod_enable_hw_timestamp_ns() and
+gpiod_disable_hw_timestamp_ns().
=20
 For userspace consumers, GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE flag must be
-specified during IOCTL calls. Refer to ``tools/gpio/gpio-event-mon.c``, wh=
ich
-returns the timestamp in nanoseconds.
+specified during IOCTL calls. Refer to ``tools/gpio/gpio-event-mon.c`` for
+example.
=20
 LIC (Legacy Interrupt Controller) IRQ GTE
 -----------------------------------------

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--uDKYV1gmcRUMwZrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2XZigAKCRD2uYlJVVFO
o8AOAP4hUzaq+a/2yFymft+ISsBiFcMR0EF08Jm0EKm6pu04bQD/fWuDpsSvy1dM
kq2KhhNX5LxzZ+zeUL5x+YiHkrC35Qg=
=CiD3
-----END PGP SIGNATURE-----

--uDKYV1gmcRUMwZrs--
