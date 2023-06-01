Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055F07195B0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjFAIec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjFAId7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:33:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A892C139;
        Thu,  1 Jun 2023 01:32:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9741a0fd134so76494466b.0;
        Thu, 01 Jun 2023 01:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685608337; x=1688200337;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cI+l6ESnfAazH1kD2P3Xgb+cec2fyp1S2nIg5j+2tw=;
        b=mdD9NFJevTp2DqC2rtTN8acTQtFYi6Y+XddKhXyxgWkpVpzRpSiUnrp1UnAuO10O8P
         Qc8JxiVphzPKO/q4uFmKpZMXwBa0bWwTe6UAthKP43iBCxVTOtw0hc73dcCHg2vcRU66
         QCfCEumJ+jL7+dj1FMQWemX8h54WvqQSWyOGzGaDz4hkazayD2cTbSgFj+k3w9DCLdoj
         kG9UilZBRA9igIIMmiDzQ/pMgFoUMrJ4jlnRYhzULeBqFEpv/aToa2g/JEtBy7x0nTBz
         F0HXzmxNDSsf2J//BIJjZghhFeNHh9hotM6HT+Q/AGOCbG3wi4KvPiOC/9SnjJP3prAl
         cMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685608337; x=1688200337;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cI+l6ESnfAazH1kD2P3Xgb+cec2fyp1S2nIg5j+2tw=;
        b=M7WYuLbmKzGTLfLk9ACiERl51q+1A8+sEEBwkgzeuj+BUs/63NvY6Oro6VwKC1o2tf
         148s3C59Lk0RQSJnF5IA6UCL6YRlUt6FuIqkaueQ1I2GMstJCtga82ff5Z90/pSNOok3
         YLIb/nx28i8uAdKM6+qBVeQbGSRk33iUIqEFVujo/MmwhCS1KEQ/tzevGr6uiOfxNedt
         8OmSjBP1sk0eB095a5Ho5m0wRh0Yo+NPWVXhswe0djucrYLba+ZzeBzdFazL3rtyNLhV
         Jrv/THvNk5Mrh/WF79eMTwpgTXMs6QSBMp8MdxerzVdvN+LSfiCA6mJNuyCJtPmXZD0L
         1owg==
X-Gm-Message-State: AC+VfDzNfc3QFlPrDiftjhbfp8PHHPNCpQNRSRIXyw3lElvCLW2dk5fl
        EBeRZXgmCNp7cY04ubx+Ix14mzLjIf0=
X-Google-Smtp-Source: ACHHUZ4k+gW7lKH9fPPPkSY1zvDMKPoNa5y4bxGYbyKpgjgxrQrt4nz2pPf1Xzfe94Z7YAb+V3KZiA==
X-Received: by 2002:a17:907:9717:b0:966:5a6c:752d with SMTP id jg23-20020a170907971700b009665a6c752dmr1848579ejc.20.1685608337235;
        Thu, 01 Jun 2023 01:32:17 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a17-20020a17090680d100b0096739e10659sm10214946ejx.163.2023.06.01.01.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 01:32:16 -0700 (PDT)
Date:   Thu, 1 Jun 2023 10:32:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: tegra210: add missing cache properties
Message-ID: <ZHhXj46ORgrHekXh@orome>
References: <20230421223152.115285-1-krzysztof.kozlowski@linaro.org>
 <05d08314-2f6f-c91a-0e8e-74fbb4dfef46@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Afd1bC+53j4AbHPy"
Content-Disposition: inline
In-Reply-To: <05d08314-2f6f-c91a-0e8e-74fbb4dfef46@linaro.org>
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


--Afd1bC+53j4AbHPy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 06:30:03PM +0200, Krzysztof Kozlowski wrote:
> On 22/04/2023 00:31, Krzysztof Kozlowski wrote:
> > As all level 2 and level 3 caches are unified, add required
> > cache-unified property to fix warnings like:
> >=20
> >   tegra210-p2371-0000.dtb: l2-cache: 'cache-unified' is a required prop=
erty
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
> > ---
> >=20
> > Please take the patch via sub-arch SoC tree.
>=20
> Hi, Thierry,
>=20
> Can you grab this one?

Sorry for the delay, this fell through the cracks somehow. Applied now,
thanks.

Thierry

--Afd1bC+53j4AbHPy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmR4V48ACgkQ3SOs138+
s6Fo+A//V0CA0FFZa0FtBPcP8JNnAylGdHJSvQTFmxsPn8EijD8royNalVKqjfDV
wsZ9tcyv/wQ11ItBwyTBvScfg6XekJMxOuXLzrAhINL/4MUGQm4Xe6h2NUp9kJrt
uWdRQb6Dsx/GSiT7+o0qffOq3WFF1fLh9/WmLbYth2xa06QNoBoDeeJqakuO85Mv
2MmPYJbCkb99U8GrfEz4GyDKC7hpirq4tOsCiS08RWFer5gM0yuK+NVoMGg2HIUR
dT7DOdR5rp099J+7dpXtvux8D9mWQrGMA2dCIcRBtcE/idpCc3YEQ4A14d3Yzucj
B1HGZoVPKzJA0EAIpZy3TJf5h9ge+iS+FAu+5x0dDu/FZSD9troLvOOFHkUONok9
E2waMs26MFdKFYnVgy2QAA7bUzwsks55DodpNAF/cVDcXcOdyZHC5WLPjmxm112Z
PRctcUQuI1KjTF8s2mJAYOTdUesQ/PqtfmhF+CfgR1bigj5ChODVHT4GKdn21IdY
azWULEB491W0fRGRFBOG/vMxv0WgoH3UAFd5XL+bw5U9TfGkS6TQn45KbHewgrOL
gLJtCCCU/OMonsLlVuMAMFkHC3C00iUz7hLpCMTy8489KX42YDK2fb69mVNYlAfb
JRTAinM5BQ2FsuPxfvoykV+bmJa4lpXI6JexeC8JaBXRNbHsyLg=
=1h8n
-----END PGP SIGNATURE-----

--Afd1bC+53j4AbHPy--
