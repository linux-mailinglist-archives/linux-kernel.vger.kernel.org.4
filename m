Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CAD65E386
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjAEDdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjAEDdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:33:42 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C09485B6;
        Wed,  4 Jan 2023 19:33:40 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v3so23693095pgh.4;
        Wed, 04 Jan 2023 19:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qcdL9XcVmlLqpF5U0DRc9acjWZw/D5BLsYnfwMge6Vs=;
        b=BBSHFqtRnvaKbaDMJgczggZXp1f+zzPaKdX5Nt9zKoejNkMXEzAzZS9BbypkCdMTdN
         EMkzrrBJoVYafpRIlea8oKDaVKj0Ezj1GCFDBVU3arZFqpfSLvdZnXH87HFIl77kTXO2
         UTO+1eWiaM6cOP47r9ZKwl6scgfWsA52SvMCzYKCPCj5B8CqsYXSjRjS3sku7V+HncjO
         FhihGidHRk967tqkfCWYXtxJe7UtCB0vA8cRUl6drD555jHyK5ubmRTlPa9Qz8Tc9yau
         U+vv2v9BAMDgYiyEGiiaSAUBTeW/FszDQ0vs1nD32bAQViL7F+n63iEWxuE7ysWYv/kU
         w36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcdL9XcVmlLqpF5U0DRc9acjWZw/D5BLsYnfwMge6Vs=;
        b=lFIu/UEWnRFMMNK7LNfBnFz6zqgWXffXLwEUCL5auMmfA86GTTdXCooMqILbH08ONs
         61cfBTLYHa0CbtFhA13VvHYa67RuwvZmLUEqlrCVfwOxq1TlEzd6siNHDiYfuKZAKbUT
         lS254aAnkxFNl6D66UsQctmGmS1pBTpfuZXMz8qKWdrRsB4u9JuJk1fFrn+6PlBcOJO/
         07uob11Hm+vHS2I2QvHNERHMUXcNPaJLVRzZBSjiGxkUxUuGfHuJuu1kVJegV0JOr1Ic
         0hE6tK3Wq5PoFoprZiyZFCRzcbR07C0EX9AaPzcoFxFEl5IH0r3z0DCqRWUNgKmGGMqc
         AcVg==
X-Gm-Message-State: AFqh2kr1kz1mCYWIHT+vUL6elkGELR3h2Y1RFUK5WArCC6/B2Fv5La+6
        z0r35ugJzteYU9+FfxWe7tQFDSfppBo=
X-Google-Smtp-Source: AMrXdXt8F+kQx5VAGFLEqz7f8WOJ91KOddQgu7Ssqif0uOEHHxee+wSbloJQBwYXkv9biR+NB4hnvg==
X-Received: by 2002:a05:6a00:4148:b0:582:a8f2:675 with SMTP id bv8-20020a056a00414800b00582a8f20675mr9827303pfb.20.1672889620010;
        Wed, 04 Jan 2023 19:33:40 -0800 (PST)
Received: from debian.me (subs02-180-214-232-82.three.co.id. [180.214.232.82])
        by smtp.gmail.com with ESMTPSA id f17-20020aa79691000000b005825b8e0540sm7532549pfk.204.2023.01.04.19.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 19:33:39 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 5BDA2104732; Thu,  5 Jan 2023 10:33:35 +0700 (WIB)
Date:   Thu, 5 Jan 2023 10:33:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Devicetree <devicetree@vger.kernel.org>
Cc:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 0/2] soc: qcom: dcc: Documentation improv
Message-ID: <Y7ZFDuvSS0fDjX9Q@debian.me>
References: <20221230135030.17002-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VhJvQuLYVzKp0V6O"
Content-Disposition: inline
In-Reply-To: <20221230135030.17002-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VhJvQuLYVzKp0V6O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 30, 2022 at 08:50:29PM +0700, Bagas Sanjaya wrote:
> The DCC (Data Capture and Compare) patchset was sent and partially
> merged [1] without Cc'ing linux-doc list for documentation review.
> kernel test robot [2] noted htmldocs warnings as a result, which is fixed
> in [1/2]. Later, when inspecting the sysfs description, the wording
> could have been improved ([2/2]). So here is the improv series.
>=20
> [1]: https://lore.kernel.org/lkml/cover.1672148732.git.quic_schowdhu@quic=
inc.com/
> [2]: https://lore.kernel.org/linux-doc/202212300426.eMLsZsvA-lkp@intel.co=
m/
>=20
> Bagas Sanjaya (2):
>   soc: qcom: dcc: Fix examples list on
>     /sys/kernel/debug/dcc/.../[list-number]/config documentation
>   soc: qcom: dcc: rewrite description of dcc sysfs files
>=20
>  Documentation/ABI/testing/debugfs-driver-dcc | 163 +++++++++++--------
>  1 file changed, 96 insertions(+), 67 deletions(-)
>=20
>=20
> base-commit: f02a537357a61e7892587c0f3455f8295cc9075c

Ping?

I think Stephen Rothwell still not happy today [1].

[1]: https://lore.kernel.org/lkml/20230105141326.5e339f2b@canb.auug.org.au/

--=20
An old man doll... just what I always wanted! - Clara

--VhJvQuLYVzKp0V6O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY7ZFBgAKCRD2uYlJVVFO
o5itAQCRTmH7oRjKKEAKB8R6M2i6hiLB5E55KqtfFqlCqc8D+wD/WihWoxNi8LBK
jw/a7Qi1mhbCrswfaJ1OOgkxxKK8dQE=
=qa2K
-----END PGP SIGNATURE-----

--VhJvQuLYVzKp0V6O--
