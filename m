Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EEA617BE1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiKCLuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKCLu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:50:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C22120B1;
        Thu,  3 Nov 2022 04:50:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id f5so4500443ejc.5;
        Thu, 03 Nov 2022 04:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUxUnVz4KwscwvItj/JWQPnZNbe/YqqdvUQpx4qWrg4=;
        b=CWfyk3UvNByTXPLSjAnhhpZVYdYBVI5+6CP460plPyQ/H/gznhnDinW93kMdDtAJJM
         v/0crrZGPWI/ZERbU0QXoBPvOEuoPvAWtMEf4VVt7EgxvxIt0Y2+5BrHa4Fq+zS6a6+O
         SNv82uzwAgTH25u5OoQrraeqoclDgSs1cSdoh1wvM/Oh0tZq//ZSt7LjcxY4sRrTkQV7
         X8wLfXLPpuGlWM5CHcKcDYLIFDpOFYqPAEwRAWmZe4mt0LULX1ZEtR4n/lNLO7zRPo6i
         LwwXe0iFOzjdhScnTN+Uu0XxnQQWHmrXfyJ1B/gJgUtGiS6WtXvG+P7XYkObGF2hDHtb
         LNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUxUnVz4KwscwvItj/JWQPnZNbe/YqqdvUQpx4qWrg4=;
        b=AmXljRj443H9No1Nx90GmANDdtdMX8edBN0fkGmiHZkLK4xHCRp3qPSdc/cVQhUcTj
         qgIMt3x6ipS6gaFnu/UtHHIhNiL4dqlc5WDzCUiMPXq8APBCqdwNYIIVi3ZtpubBcg4T
         T2PIbKYskqGcM/YY2+qz+Q1zWX7A3rYcEAOWvPLjilgy6q0jTeJZu64APYNIsW8XgURV
         CQxfZg7JXjNm56o5AZ2yqynJhtTSap4hJLWdP1MCQVdXQNhXE+AXnCDnyXLFjP+OsJ7d
         QvrXhVJFLy2xSZlRwynMq7Sg5aLEWO5wPVCKl09pzXPQAjy9npiOCrh019RZ5Aeo0wOV
         FruQ==
X-Gm-Message-State: ACrzQf1FRbC8cy9Nm3Kp4a1XSZ1V0x+z0xjEhBlXWqFytrJIOng8TW+Y
        ePXUM8FMIp5HfoEjCcQq5KM=
X-Google-Smtp-Source: AMsMyM58RdljNVkQKSCwsYNxvpDpLjhu+27gmH0JBqSURgmKxt21u8yHG8jRctqHRB7l0ftlya2Ibg==
X-Received: by 2002:a17:907:d2a:b0:7ad:e0c5:4bd7 with SMTP id gn42-20020a1709070d2a00b007ade0c54bd7mr17459986ejc.177.1667476200065;
        Thu, 03 Nov 2022 04:50:00 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id hu16-20020a170907a09000b00771cb506149sm416335ejc.59.2022.11.03.04.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 04:49:57 -0700 (PDT)
Date:   Thu, 3 Nov 2022 12:49:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sandipan Patra <spatra@nvidia.com>
Cc:     jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, kyarlagadda@nvidia.com
Subject: Re: [PATCH v5 1/3] dt-bindings: pwm: tegra: Document Tegra234 pwm
 binding
Message-ID: <Y2Oq5CTYWfb95mQY@orome>
References: <20220919141455.31084-1-spatra@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uVbCqSvkKLPPMu5H"
Content-Disposition: inline
In-Reply-To: <20220919141455.31084-1-spatra@nvidia.com>
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


--uVbCqSvkKLPPMu5H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 19, 2022 at 07:44:53PM +0530, Sandipan Patra wrote:
> Add compatible for nvidia,tegra234-pwm with nvidia,tegra194-pwm as a
> fallback.
> The PWM controller blocks are identical to ones found on the
> Tegra194 SoC. No driver changes are required and compatible string
> "nvidia,tegra194-pwm" will be used as a fallback.
>=20
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
> V3 -> V4: Mention fallback compatible
> V4 -> V5: Update Compatible with both Tegra234 and fallback
>=20
>  Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--uVbCqSvkKLPPMu5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNjquIACgkQ3SOs138+
s6EPeg/+LdKoUpBi4PEXRj0hcXiVslQ3eeZOQhbct9G+nM4/9fLD6zVIEqbKYiLh
2JhSOYszQEZ1sRbYkhlT7vrdMHOrezcODx/jnF+nKfU25xsrQhQWWrRuRi1IXHV2
VPBIwlU2xsd00JGPVHAUZD6xJRiFs2YlSd4VTg0bk4YOUNP4FMPovbrzkVNWDXJX
5PP1bKEq/4hgx4lYnp3TLvaY2nZeKot7nJQO74Cbyg9aPfROpIjuYzIJBxbTaEa5
PVVDbddZzobGU7a67326v0/7IaTXEq91ADeO6rXFSE82SX5xQIjafX+A475q6Ipt
C47+VDea9rYo9UJ6GX6nOoU7m0RJdyCcvTaHKL0Ze5Uxds+A1t6XIWJ6ApguHX0f
E29ASIEwaHMNuV0+IHgLoRNTAcyH3Icbm9i2+USuZbAUweejlFfJT7OE1eXlxjs4
9/DXR8iGBvUtiev671QLVBoVx69K7NKceHn9O+8ScMWjPBY4v1zQjLkrLIn8UCy0
QpMZ3mBPxOsuvsRUNZftA1cd+Uxa2prpL78kVjo2kHlo3L+bFqYr7c8+ZR7AQ4B+
mtYCMxvbHC+5fpQVVNszIBSjS94HYKVasAbQLIfmhkrFGT+qqmHK6EklX5urS50M
udVkDzBH11ZoyAc94+QJ7QPUeUQNGhOVjSScOA4MBq+6FxOCiCM=
=TBhp
-----END PGP SIGNATURE-----

--uVbCqSvkKLPPMu5H--
