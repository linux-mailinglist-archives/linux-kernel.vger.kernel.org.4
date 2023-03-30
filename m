Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9A86D0B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjC3Qas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjC3Qa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:30:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A4BEFA8;
        Thu, 30 Mar 2023 09:29:42 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e18so19698634wra.9;
        Thu, 30 Mar 2023 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680193776;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yN1+Jn1orcHwBA+J1Kqg+1Ee+kAAwlGiXyYhRzrUkxI=;
        b=IxJYcWSTnbePkTHm5muh962DShLEtwyD6DwDMDrPDsyzRpAjDZnu+drrIvuUYGzRkM
         UcTFEbKkxEJ4WuGCgw3SbgyIfdlaDzk4buAayfnQHT2sRJOP4R4iwKfb+aorswot9p4j
         bfl8a5D/RTyop/iqTk8wocHODC4LHvWQ/pMbmalkEv0pu78fAy2K3+qvD9ihDJWtT+Q2
         8uJbSU+fCW9qLlqtbDUNMeBMySs3J9ADwObm+3T5SjVHyJmDbX4bLeyZhHRMpWpf8ws+
         lTghBOqCc/UGFuooO0qCzI3eVED4dTWtwfq7deM8BbQ9k/WJi4BdkSeOVIKJuLiBkEQ+
         RdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680193776;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yN1+Jn1orcHwBA+J1Kqg+1Ee+kAAwlGiXyYhRzrUkxI=;
        b=kJy8fxjaRnDdMVdxDecxMgoZBdXM2MIlMhV2sf6DT1oRL1WgSoSXSlRKoWyXe57gEW
         cms0HXw0h+B9xjzdu7x1IYGUYBK1VW3R3/Zo8ScJPYbweafsi9rSsy8+xxtid7zWDJ6L
         mj+tg98axfDwSSFXICDhA5atRS1mJJOQEsI44ahO3iJyWc6XqQ4IIo9ps+G40PZnyw2W
         As0RTIIl+CqfyHKBHneS9e2Oqrnsq4js1w7hMmeP2L0YgMBDnFPHOhnunIkXEbGrS7Ls
         1vxfT9gn0n++nPmEV+nC1V1Dro82LLVjG5Lfj8z+/+ADD8TG8QW9JgCUMJKck1oyUyJ5
         XMWQ==
X-Gm-Message-State: AAQBX9cUKN0RX5SaBj2EHFmQnTbrDQ8Z6kotmY2aEheUSU31aorKxuQU
        FKOfIr5/PA0719mty/d6Heg=
X-Google-Smtp-Source: AKy350ZdBKGl6sCjqiNiB3Fnxp2T1UpMp5P6xbf3RUuIn0/fgl3PPQ9gQduzQgKdriCNRbld2GH97Q==
X-Received: by 2002:a05:6000:114b:b0:2e4:cbef:9f2a with SMTP id d11-20020a056000114b00b002e4cbef9f2amr2516042wrx.2.1680193775696;
        Thu, 30 Mar 2023 09:29:35 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d684a000000b002d89e113691sm24238578wrw.52.2023.03.30.09.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:29:35 -0700 (PDT)
Date:   Thu, 30 Mar 2023 18:29:33 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thermal: tegra-bpmp: Handle offline zones
Message-ID: <ZCW47Ux5wa9XYd6j@orome>
References: <20230330094904.2589428-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q074XcMAmYlwWTlF"
Content-Disposition: inline
In-Reply-To: <20230330094904.2589428-1-cyndis@kapsi.fi>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q074XcMAmYlwWTlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2023 at 12:49:04PM +0300, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
>=20
> Thermal zones located in power domains may not be accessible when
> the domain is powergated. In this situation, reading the temperature
> will return -BPMP_EFAULT. When evaluating trips, BPMP will internally
> use -256C as the temperature for offline zones.
>=20
> For smooth operation, for offline zones, return -EAGAIN when reading
> the temperature and allow registration of zones even if they are
> offline during probe.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v2:
> * Adjusted commit message.
> * Patch 2/2 dropped for now since it is more controversial,
>   and this patch is more critical.
>=20
>  drivers/thermal/tegra/tegra-bpmp-thermal.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--q074XcMAmYlwWTlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQluOsACgkQ3SOs138+
s6H4OA/6AxZ9lvyK8vFq4QrKH+cmYkVUB6/VsqXgF42eaxIzYPBLqnaXqqXkR1Ji
qPZe5uTay/R2v6gxgg9V97aK43DNTL4dQV7DHxk1sa+Oepe8JBEnzUEjSdUmC391
ou98SDwyRHj8P6VoNM1BPVAfSP2F1j1jZn2f/hrr0qZ7aj2NyZltoW0G3bdyDA2e
sLG+9GRmddEmWGzPqezNUnKLmkOgx4huodK0uk7Pi2gR4YLLcgRmj+/61p5AOeAl
Dn0ihEzmVEzxczbY/PDzEe/Gmw55Zgs0BDGxU2I6pTvKkhDBzECJwG8Dk6RGaVqM
Oq81jGTSTwK8ZqdgxCjSNN71tv8sc2RI5WcJ5ImFh7+WFVooyW5DWBD3SJAF24DI
IQaSzen6n5eYx/EJ3P7ZWO6JtSdUPUj+VTRyxGgxijYv/NHQQ7cf6T4xY/HDgABU
c5W49SLYWv2NrN8NiYkAuUqVHDK9Y/MftdQyL//sa5wnzX6BHrGBWW4nQ9Ndxlhh
mgTSaPWEYMAFT8lQWJhwRox9xj/z+fBUF2lO/aqx2tyXYvL/iLtygGtXEWzKmQmj
ewHCpJgmh5mdMLfQwAyWKeftO0Y2ylgnqW5xUdR6qiqfEtzhMkbXJXcfoRR3T3gk
MQKTVBlYMw2XDrklOZRrV6VoPZb7hvnayvUmqNtQJUQkezcO8js=
=d+wm
-----END PGP SIGNATURE-----

--q074XcMAmYlwWTlF--
