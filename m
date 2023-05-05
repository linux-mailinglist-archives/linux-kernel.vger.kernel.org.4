Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E1E6F7E28
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjEEHuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEHuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:50:22 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C80015693;
        Fri,  5 May 2023 00:50:21 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-643846c006fso1670974b3a.0;
        Fri, 05 May 2023 00:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683273021; x=1685865021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oru9keQDVBK6npqBM4S9de449hp81ljjzaEYEoau9RM=;
        b=Vme9jfN+FSOXJ8lg8xQYhbNq84HX8FRxXNHn7CUmZfce2j2uvVq/G5ldnXl6vY3fgW
         fTwC48MOgLIghoHNEa5xiQBQdu/JWrtdMe58thn5TB2j01Dk/vyN/EeS/OjCTDmC8dte
         7OCY8E7p2U8LsbeYgKyOGZs9R3uqNdgmGfJBPhu4YPvQp3Xzlz9AqSMaLlkAFvi+6t2b
         vNj1KIHUASQR/Gj8/TXU0+6S4jnAIp44XL9asnnAN/hfAN9QTzAPTFQPTpgfWVoqsCLT
         OlMSkUj0YTq9Bi5zRJopuF1L9XSp3MHRXV5IWbxtm5y/rqUfU9bAbmbhPax/HFZzMmAi
         Oamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683273021; x=1685865021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oru9keQDVBK6npqBM4S9de449hp81ljjzaEYEoau9RM=;
        b=X0qSOJ9EM1u36jdeWnwOlCkToKrXsJ1TTsURIOiuEz/9Ee4ol9p0kUjWGoqtLNifcs
         K5VR4MvymJqqiUMZ+12qb+1uAqLqkNxV64fP1ZLM04joyXphJfzPUTFsAiclIzQ/Hqgq
         lLopoSGRq7HUvnW9LSrVo+JJGzLVk6VrVWpD9nVNbqCE5Eka5T6aTNFHEi6bdfmvYy6G
         xl93cx1bwq4f1fJbozf21m7eO45Lrpo3s1VRLaqYbevxnONM5ow7XIl7n7WOUonYFyeA
         Qq9ael8wn0cKR+P0/22SMQb7STQGHYTSFh4QDcQiTbCwA3vdvqVIhsIlC74VQ8S5egyM
         L7gQ==
X-Gm-Message-State: AC+VfDzPnj0gZ3UJfb88vmsKKqBudZtiT1ZhpI8/np2epdtknWDS/ORl
        5wlu9XZQEqAHv0hDhkmYlGocgkI7T5I=
X-Google-Smtp-Source: ACHHUZ7wVgABaqtJxZUFblIEbRkPPqRC4EGaLAuYeInz/AUMDh+BYZ0HPyQHK6N0+BLa2qnh07OD5g==
X-Received: by 2002:a05:6a00:2408:b0:63f:18ae:1d5f with SMTP id z8-20020a056a00240800b0063f18ae1d5fmr1060699pfh.29.1683273020918;
        Fri, 05 May 2023 00:50:20 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-14.three.co.id. [116.206.28.14])
        by smtp.gmail.com with ESMTPSA id i20-20020aa787d4000000b0062d90f36d16sm981021pfo.88.2023.05.05.00.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 00:50:20 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id AF196106280; Fri,  5 May 2023 14:50:17 +0700 (WIB)
Date:   Fri, 5 May 2023 14:50:17 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Wang Honghui <honghui.wang@ucas.com.cn>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dc395x@twibble.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi:dc395x: Correct "structures" spelling mistakes
Message-ID: <ZFS1OSaOYlK9tl0e@debian.me>
References: <9721BDA46BD84475+ZFTPVLLFKTMn4lSE@TP-P15V>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zx8j1cF/oiupMyZi"
Content-Disposition: inline
In-Reply-To: <9721BDA46BD84475+ZFTPVLLFKTMn4lSE@TP-P15V>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zx8j1cF/oiupMyZi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2023 at 05:41:40PM +0800, Wang Honghui wrote:
> Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
>=20
> As title.
>=20
> ---

Another comment: you also didn't write changelog after three dashes above.
Did you forget reading Documentation/process/submitting-patches.rst?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Zx8j1cF/oiupMyZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFS1OQAKCRD2uYlJVVFO
o7cRAQC8t3XcyR3zGimO7rvCfFOIIwiqdHs4FEEP0OfCeb97KQD/W2WVlgl5BK38
u8P3lQL7GNrGQAxdE3HDM/kvJrM3sgw=
=5U5V
-----END PGP SIGNATURE-----

--Zx8j1cF/oiupMyZi--
