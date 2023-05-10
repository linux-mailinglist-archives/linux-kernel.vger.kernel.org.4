Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41656FDF2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbjEJNvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbjEJNvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:51:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA98D047;
        Wed, 10 May 2023 06:50:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50b9ef67f35so12969376a12.2;
        Wed, 10 May 2023 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683726633; x=1686318633;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+NRHnDQmtTk7kOK/E7Ot7+POkQx1TFwx1KqzzawooI=;
        b=T1J209ONe76N2wX7u/JUc9rMVSkbMSVHKKW926SHQOaE06Y+0D949w+TEW6FhyNhvc
         ThIy37HctL7FfOOEfEurSufhnrskuFYY7r1IkZE5CAmzeMBlUs3Fxa5XpPqfwjdmtbc4
         4tf5Iny/Fe/ol9VtLhfRP37oEORlqcc3kpaMWmsefDvQ59Mt/svdnIP6wg/pBqJJpeIU
         9uj+LJhVXDS1uzGA+95DR2LwXU8SpOYvH/Xks+hpn8No5X9g8oyoNCgM+Y4H24BH1E7T
         xUR9X+bKGXwqVCeCKhEeZ7kK30ebOcEL573v5O2tYye725DilS1qLnVJhBYTrBumJ+yn
         5/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683726633; x=1686318633;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+NRHnDQmtTk7kOK/E7Ot7+POkQx1TFwx1KqzzawooI=;
        b=a9k/Ztp+jv/ug6GgNs33iQ39EzgYLZxRgLnJrE6Ulxd8oGoToS1OTudd/l5upkpiu2
         nvI6W1FsZd1lNUgnFd2Ne72O3+GmWUSQacxS3HvHFH3ipy3+ubyn7dKiDcoRFUNjB/KQ
         Ji0W5JLEUsvyrTAu96yWxR0vuyexXc4RF0AhC74lFAKIQKUCTLtDFvXr8GY8SAYMTa5l
         NJzlyCKGs5oNK4kjbx3GYufHrmNuyiYLVacqwMR4qOgsXbvFRlOFg28swBqzjGfSBi3r
         gcFXX2zNXwJ76JivsbvRoVeRTto0z42sFMhHDayOKn7FfDY1u6SZR2pgkGfN+A87su7b
         ZGtg==
X-Gm-Message-State: AC+VfDwJ12x4AhzTemSWenap+xcfrbN7XazFjm/AI1AGNeIBGczi510z
        WJaNFT8S2Dvh9DhZt936V2UtRr0OvuE=
X-Google-Smtp-Source: ACHHUZ6FjMuW/TA5vop1TNYFjqOIvOv/90CAYvEUB/AR5X6fNYIP/S0Wxd25bEyjRKKaXdeb7EPHSw==
X-Received: by 2002:aa7:d954:0:b0:50b:fb60:f431 with SMTP id l20-20020aa7d954000000b0050bfb60f431mr12028964eds.7.1683726632687;
        Wed, 10 May 2023 06:50:32 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a17-20020aa7d751000000b0050d988bf956sm1951348eds.45.2023.05.10.06.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 06:50:32 -0700 (PDT)
Date:   Wed, 10 May 2023 15:50:30 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     jonathanh@nvidia.com, Stefan Kristiansson <stefank@nvidia.com>,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/6] mailbox: tegra: add support for Tegra264
Message-ID: <ZFuhJlsl6E-Q0Mr7@orome>
References: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
 <20230510113129.4167493-3-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WU/wqz1QpITItEav"
Content-Disposition: inline
In-Reply-To: <20230510113129.4167493-3-pdeschrijver@nvidia.com>
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


--WU/wqz1QpITItEav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 02:31:28PM +0300, Peter De Schrijver wrote:
> From: Stefan Kristiansson <stefank@nvidia.com>
>=20
> Tegra264 has a slightly different doorbell register layout than
> previous chips.
>=20
> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/mailbox/tegra-hsp.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--WU/wqz1QpITItEav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRboSYACgkQ3SOs138+
s6GO1g/+Ps7d6jn8VyMJ2IrMq6fZxaIShN3dO8XIfthzgUGZA9kLJxFu8k8tcDNi
cRatP7WxDxwcpLA/IVdwvuxE9zo3f+3r2jX1vWgoAMT22YmvAZ+T45A9obz97BIj
wID2KT7GPpTBW6EsWEoC4+wZLV6iefn2lqsCHXryyFN9PGlrY+QSmua3p+4DHh1s
z65OBbI6I7EgKSnZkIud9MEw/SV1n6Ags8aVXsq9/y0h6J6pxyxWCMVN0x06A06b
ciKKlkCVXtrRxs0iKFRsyOIdQJemC/ouBNkrEcqdkz1q2o20R+9v2yd/JJG2IcqZ
HJhF9uGAGIUP0Tx3B+kC7n7bXiEg42BN8SzpOpbvcUJjfEFmjxhhIHogxf+lQZPs
iIBJZr0VsVAzZFaRP64g/tKpmlWaWbPDs/d6y1tu8+oxMtLZKiCHac9gSpU+TByY
5czOzydKbQ7IvBIeC5ay0fOaSufEjbMGelX1v67+BpTROdLFpejULEMCFnWFTAZG
OFZE/QnkEhtIsBNZUIUhbIl+oziAJtwIsRVAMWYAOp+22hj/OgXtSxpCn789ekLN
TgTYixyZNg6UJfg1clN0jczs3/l419CCI2kNnZxEU4rPc3X8nV41bGauU/k5ekE8
VZBAIJJNzEMGJhOAwOKzxGR5+/N5qyqCwcyRjdYCM4h9ple7LfM=
=lJYU
-----END PGP SIGNATURE-----

--WU/wqz1QpITItEav--
