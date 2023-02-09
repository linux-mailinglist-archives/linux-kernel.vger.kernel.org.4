Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB3D68FCCC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjBICCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjBICCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:02:44 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5733A25B90;
        Wed,  8 Feb 2023 18:02:42 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so4704002pjq.0;
        Wed, 08 Feb 2023 18:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2fxHLSSkjd2gBaPqrUy06GUa2igJ/NteR1ux0m4AxU=;
        b=KSZcawBfCEusNKjw99nBJeFxw3WPMe/KyOvtBZHVw5YW/DTxS6OLbUYvCS9G+NJm70
         mwgK2m1MawIVypnUZSDUL5ooqvX52HCw/iNnfQQ2NrYDFp17s5cefLMKgElAeaTRx+sp
         34ow9t+FxCzDAY45HPR2ZmcrMkvlLb3U+kBbCB7BCJ4R4thiesJpD8m4jOFb7eVEpwco
         OuhFsoBFDczXU7GgZXfthXym73ci9xTGv2qmpQEA7iP6eRQyH0YwAawADGmtTkZcuNFR
         N3Bc1NihCdIx6KGnCjfglcwV8++p5wDsF6ZgZrQWqf5g+enspmMwQi8qeh/a5sq6eYVu
         KuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2fxHLSSkjd2gBaPqrUy06GUa2igJ/NteR1ux0m4AxU=;
        b=GBTQRZ4he9upUP1Gs/4CfCkiiUplyglLHn5P1vqWdfv4EdATrKBVGSPPChMntKsGBD
         zYWr5hclOrPbo8V50BE2aAtSOIzeIaicvKp4PAphnlPFRfuUsKIm46i//yGp8sx6DnyU
         fnDnhCzeya7XsWioW9YeWeGSVuw9Qq0FFiIoR7nC66GNvJ6zIsC4ECTLc5hzqRQkYuza
         e+yh+EsW88PZEiEb4NnkyEA4hkVKcgxhMyMdpiB8wJHFidYIU8/nLP9xP4b+GhqfY3ir
         oLeQuZKRWr2XZXLOtcrqeIOLLaTi5SkLD/0J89a1Vls9O7yX2dHBszl7pvSx7hj4YWTP
         psvw==
X-Gm-Message-State: AO0yUKUS48ZleHjrQwUAPuIycEvdhuiuCTEadOjUxk0bGwqFzFR1D8ZP
        wv7ZG8gwDjdcVNctk1nA/7O6AN4YT7n+Ng==
X-Google-Smtp-Source: AK7set9boXIbPx56DkwTV7WOExTM1A9N8lAUSIGwpgu/SuCa/+u3NsWnrbYVHr/7FAqfK6RznLu3/g==
X-Received: by 2002:a17:902:b48a:b0:198:adc4:22a2 with SMTP id y10-20020a170902b48a00b00198adc422a2mr3075077plr.29.1675908161514;
        Wed, 08 Feb 2023 18:02:41 -0800 (PST)
Received: from debian.me (subs02-180-214-232-72.three.co.id. [180.214.232.72])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902654200b0019919b7e5b1sm126062pln.168.2023.02.08.18.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 18:02:40 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id D50B81056B3; Thu,  9 Feb 2023 09:02:37 +0700 (WIB)
Date:   Thu, 9 Feb 2023 09:02:37 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sunil V L <sunilvl@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH 24/24] Documentation/kernel-parameters.txt: Add RISC-V
 for ACPI parameter
Message-ID: <Y+RUPcCgH48XdbBB@debian.me>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-25-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cG9EA2l6QrebhrXH"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-25-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cG9EA2l6QrebhrXH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2023 at 11:52:25PM +0530, Sunil V L wrote:
>  			For ARM64, ONLY "acpi=3Doff", "acpi=3Don" or "acpi=3Dforce"
>  			are available
> +			For RISC-V, ONLY "acpi=3Doff", "acpi=3Don" or "acpi=3Dforce"
> +			are available
> =20

Something repetitive here. What about "For ARM64 and RISC-V, the
available options are only "acpi=3Doff", "acpi=3Don", and "acpi=3Dforce""?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--cG9EA2l6QrebhrXH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY+RUOQAKCRD2uYlJVVFO
o+9EAQC8GivmfHn93hRgfCI68JrrUjUfdRGd1PEo48XaFxXfpwEA4gk7qbFhwMKz
RYZmDaevf6DABr9JSuIpV2NrsUIsTwI=
=LwV8
-----END PGP SIGNATURE-----

--cG9EA2l6QrebhrXH--
