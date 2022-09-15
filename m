Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B0A5B994D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIOLE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiIOLE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:04:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A74B5C950;
        Thu, 15 Sep 2022 04:04:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z13so12413771edb.13;
        Thu, 15 Sep 2022 04:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=epQ8InS75MD280wupDQB3IBzd82ZH3sQJKCVkfM2TGg=;
        b=ciDGfT7HtzQDgSHYqWXlOO/+arroyPF21ToQUqDajPdpqQm1ZoGZdZmzbfqZ5lePxi
         jlyWDf0dlHru/Ip9EF6gRjb0syWftBFbkmjFlkIxvyVaQog3MfIrMyEPMoJj1RPihfbw
         4SL2WK+l4bns8g+KkMUctmZ4MhgDsUSRt02N8rrFb66mWjouPb/B7e2muf589amzbB+A
         BtmE6NUIBcaHz8XS6R8jpqsrQ1UfGUK8cSjr45Cu5+vCsdtPI+z9NDeaDB9w++jKyzYp
         BUKypeMc5+cGZUxYryldVNCyquhXIJRYQC/BiqQ6LTCiADFqscc4XekxpMHw6yFLfwOJ
         uo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=epQ8InS75MD280wupDQB3IBzd82ZH3sQJKCVkfM2TGg=;
        b=0kmQbVW3855xcUkt881oRXLH81hm/hXTSrL6XhLGwH034U3AdHXvJ/74G3BGB1TvLx
         8NeHVPv9e7mosRXkPqdFlmaAPE6zp3GM3favSyy+2YWNgt1Grrwm5gOCPC0Z4FmoGK4n
         AQfmgE75nGutdViO3j/svvGBfwL7osemeyf85zmlTu5FmwxHWJF25SIqbviiZ/hITJLo
         B07dzE5o1HwE6hqo+fbD0hed48Xr033j6uaGqV5NW6MqgFKj7b3tsBSAjm5yWat6UX12
         wJHYSuLrFSlKLd8JZGS4xAcW/72+DR7t35Ltdn722pfogkE+LXAJ9wmK2uy6Wuhv0fgD
         G32Q==
X-Gm-Message-State: ACgBeo2InFfZNq+7Hz5rSxJZJp+mAKB2rsFmt6welsJa/V8G4qE8n7GU
        +f+FHpIvwttZhBDC2iJD08Q=
X-Google-Smtp-Source: AA6agR4/jmZ6j70+E1u5vwISD+3igDZWFjvJ41mlLCc9W3Rx1k2I6VMawVE/+rA8V8wsI8982zq3OA==
X-Received: by 2002:aa7:da4f:0:b0:44e:864b:7a3e with SMTP id w15-20020aa7da4f000000b0044e864b7a3emr35151743eds.378.1663239893690;
        Thu, 15 Sep 2022 04:04:53 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7c90d000000b0044eda621b08sm11784112edt.54.2022.09.15.04.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 04:04:52 -0700 (PDT)
Date:   Thu, 15 Sep 2022 13:04:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: tegra: Fix comment typo
Message-ID: <YyMG0xBCp3j21vxP@orome>
References: <20220715050144.24638-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wjX9SZ+Gk/1NXCEd"
Content-Disposition: inline
In-Reply-To: <20220715050144.24638-1-wangborong@cdjrlc.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wjX9SZ+Gk/1NXCEd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 15, 2022 at 01:01:44PM +0800, Jason Wang wrote:
> The double `that' is duplicated in line 275, remove one.
>=20
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/cpuidle/cpuidle-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--wjX9SZ+Gk/1NXCEd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMjBtIACgkQ3SOs138+
s6GtVg/+PGXrwMBuRguZzhdIsG0XLqZ3sNbquJjNzLboECmthcYlKyi5d2xUNxNp
wf2CiMw95KgAxeLrqGI6c5ClWlkp8RJ6AcRNSUe/FRk5KCRJDEaELP/QeL71Xpo6
7HFUHXzXLxATtqn78Mm4Z25N8YMVQebfb6Zd4QqN5U7R1n+Psej1WStKUJs373H8
1XokCQBgI6x6fxN4d5KnULepFiwj/OxUIHCHVWYO6CQgH2RsXYg7/HtNoZ4doDAz
0/lDjM7xkwLZNdyMv5yYKM5ZXyHBiFQ9x3DOPEufKGdhB/hInravhqjKqWXeKcQ0
VL2QYNEXm9L4/lYrK3pp4eUPO3E+/L1+KT/RMJetYAL6VrXvucwWLbkdL40y5QeN
T1twnwbXGiZcp28X4KDc0W136Xia6VU0anmD4SVDQmCm0TLGW4qyBbF/J3Avt11v
7CtqTEgL37XQ47jstaKWcYC45KKWpuZg4IBFox0Sh+wmsOA3cuICJeKZn6uk33kD
HVF03XeKFq4qt0KI/CV5WzlVY1x0Gq6P7cmSMf04fWPULYsG1EIjg2wKi1ILmxOv
WHZEw5jS7Gx/Oe2Dcmc31uK/pgfHBeBW4oDDSyuOwLakBuq/wcwrKZZqjDvjIbrh
2SGoY3gvRiDc3VAQlJEzgTIeE/6dNdVS48QE5Wudx41y6Wqm9xM=
=V2qv
-----END PGP SIGNATURE-----

--wjX9SZ+Gk/1NXCEd--
