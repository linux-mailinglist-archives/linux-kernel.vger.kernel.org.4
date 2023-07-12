Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057E875086C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjGLMfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjGLMfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:35:22 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727F310FA;
        Wed, 12 Jul 2023 05:35:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991f956fb5aso797334366b.0;
        Wed, 12 Jul 2023 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689165319; x=1691757319;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQ5QT9Y2z5k8290PBWq4R/nhxsQwgMfwlib+q3S9m2E=;
        b=Jjpcp4K/72PU6UzEaFZX2JVZg179aD1b7/heYRBgEmhEN7ZVGFwu41TZTLpZl5SV2C
         aUC4+6Ur0gRNt7E9coggV7MJ8nPCjFZBc9Uw44ONAoG1KaIqJw32ALXABYGK/Z96czxO
         cboPV4P/XiuEsF74X6HmmKHXy4ngDLYg1XQizcSvmKJAab3x6s3DAPxTWpoW6LsfFfZl
         MzR6nb62G5oRHu1PJ9I6pFt2eVgokQnjJfguS9iiOX3tPNhc3vMeDSQG4A8zs/SbaWn2
         m2igoINH8GpguT6Gcjff/pgof+RYfkbqk8Z4yO+F1aEGQYD4TgWEzQkhGSxXERTvLdWH
         gPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689165319; x=1691757319;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQ5QT9Y2z5k8290PBWq4R/nhxsQwgMfwlib+q3S9m2E=;
        b=Jj0Nsnbyuv/krXgMIXbkU75JTY9DCNq7y/cne8kDiBdJSDiR7m6vVuEtlT5vWNfJjL
         Vhh13lV9uEjky7V9J16SDLKHrzy6391CQKsb9WG39Ui8dqaYMA7HI7OPSzUQPxZ7l3BV
         CANsVVL9wonDv3THeNQq6lbO1iy7Q3Rk3ikNAfl1zYaqPfwGA32Tu/7mMigKPAxy7g9F
         3t1SRy83zThbbGtNbbTB8sVeApZfGrvxBho8tWpILuw/7nYOUhj1cyUabchp+y/JEfDZ
         FfBXClaXXR+Mk7tmwXh9DO81VDBLU7cMQFT7Gcmxph2Wpu/bYKQqKiuFqaBcbqbWmGM+
         UkPw==
X-Gm-Message-State: ABy/qLbTdKFgvEgVFToqpT0/dITlthCCq4VapYMRA3jQRlVtne8RFIzG
        soNFbTADOnqye2Y3wcImmsg=
X-Google-Smtp-Source: APBJJlF5kI9uN+IMlmCM362LKPJaDvp1pAv83fCzoMckOn30+ACelw9+C/MuljWSL4gk5YwTyM3/uQ==
X-Received: by 2002:a17:907:2cca:b0:982:8c28:c50d with SMTP id hg10-20020a1709072cca00b009828c28c50dmr17008261ejc.58.1689165318725;
        Wed, 12 Jul 2023 05:35:18 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a18-20020a17090680d200b00992d70cc8acsm2478913ejx.112.2023.07.12.05.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 05:35:18 -0700 (PDT)
Date:   Wed, 12 Jul 2023 14:35:16 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Baruch Siach <baruch@tkos.co.il>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: Re: [PATCH 10/10] serial: drivers: switch ch and flag to u8
Message-ID: <ZK6eBDHqrRGygnAk@orome>
References: <20230712081811.29004-1-jirislaby@kernel.org>
 <20230712081811.29004-11-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q8BDYnGN5aY+jyjl"
Content-Disposition: inline
In-Reply-To: <20230712081811.29004-11-jirislaby@kernel.org>
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


--q8BDYnGN5aY+jyjl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 12, 2023 at 10:18:11AM +0200, Jiri Slaby (SUSE) wrote:
[...]
>  drivers/tty/serial/serial-tegra.c    | 7 +++----

Acked-by: Thierry Reding <treding@nvidia.com>

--q8BDYnGN5aY+jyjl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSungQACgkQ3SOs138+
s6H5VRAAhq/skn9OkUmQ8MZdgowjwVYH5u7IEdi7lmT/5pZ/CE2HZR/u6Uo/T/Pw
pqX437nDAAuy8lg/IAYHu83xQ1LUrlKUA25RmY6aNCK/9Qdz+k6UtVQnOvVZlrjG
esZEZk8F4RTicz90R/fZYBLi+CriLTmydc4Bx84OQ8HQ1bBv/z/MnY5z+/jbygG+
lzI3fpsrc3HmB6KctgcQn9eG8Y65fPt8nas7r4td1cBoYkHfbBuhNCuL3SizN28q
JX2lRFoV3OOTHvBM+hTKmlg2Gh9iPQUkBYS5Uk12dD1Gy9F4l5/VjT9XkZBWssTA
7VvssfJpQBabPYvsUawglCFPOkCk/lJM3eUILpPvasDsS8/84KIyFUmtodOrFo8u
MhJn6xtzVCqlEB/5hmO0q6NmPV1PioZY8KjiN+p9sIv6JRF4eie/xkvjj1s9wCx0
ICx1hwU8oFbhTmzqxg/6kt7lAVaajnw9Wd8XO+XfKntkn7DiPH5wfVcNbL3NR44d
Fx2rTmJXd2BGwFZ729AKIFXyGGhtqc46ISy1m5VbVuZDK7fwtFqxMe6Hsn7afiRF
d1T2Xjs6qjKO04nQn/L31dsIN3zN80iV5lzCvsfsKUL6zkGeHlW3+qbzuaS0HzQE
+krY4R+uFqz5i/qtp5GNWtDBUgE4Gg/2ulZxiv+ca5Id6/qF/8E=
=B/zm
-----END PGP SIGNATURE-----

--q8BDYnGN5aY+jyjl--
