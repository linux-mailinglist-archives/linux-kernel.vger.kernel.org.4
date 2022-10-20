Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0218606270
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJTOFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJTOFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:05:51 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D99E10CFBE;
        Thu, 20 Oct 2022 07:05:42 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id i12so13576591qvs.2;
        Thu, 20 Oct 2022 07:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KrIqzYmU/1wKrczsH7nyUVVizlQZEJ/pBkqjwAMBKHU=;
        b=NDu0h6AkZcStYHBMaHpfX1sR8D8VpBQsQrqKSLf9nmDYhHSIo9xI/w8VxxenN3EPW+
         49lmlIV+T7tIcwSVj7eURlnuHnTa9nVs5QoqS0/wLQOoT1SyHIh1mChpLrVUDs8fAnmv
         Fq9FpBIrdgdYi3wjJNT6mZvvsqzeUVWPON5B50vYcyDaC0P7MkOMgeW920UpwqUGSp4y
         eEMOLHO85S8yf26TjUZ3bgaJuVIBaYualsGZzOoMmj4NGgl4WjmdKZgEoNZfB6GFKumy
         0yGZGp5qQjUa9+KgRw9eHgEfAaA22ncbpxwCjifgxATV3JUxmaSceKcZilmKWPelTPRf
         SEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrIqzYmU/1wKrczsH7nyUVVizlQZEJ/pBkqjwAMBKHU=;
        b=E+IJ3ZVS4+NLyq+s9HA1/LIGp+2h6bE+CcLaSf+ztOisZtAaiBE/6UbIV7HvvO4wtE
         AJFsfxlGP95M47sI3nV6Os1Z8Fpty0MzizfnDb5mQK28afFr3/ej+Zf+EVb24mo7N2l7
         c0sAXRGy2FrbFuQyn/MohhjMkd4qKcIOarDBodShez7nTiFMAVWpufmdrjDbfTSFcabS
         7OvVMGDZtf1I29DLcQoJ+2aIoQEz9qJFeznpndCrry2yIEIX1DPrvo4TfOtbxMbfEsAq
         rfwlzkbwEsiC2OriPsnlEQgxurclyKD4w/0C4rrPeOtQ2tgmDQ+y/wNQ6rpBva/XeXwc
         ByzQ==
X-Gm-Message-State: ACrzQf1kfARHiISrvCgamgeUL6WT2l1CwdVT3PmzkbqMaZZ61uS0i8qU
        N8HMHPCu1/zDHMBNObCORk8yExnU2jf5Jg==
X-Google-Smtp-Source: AMsMyM71mZUqVynE4F2i3G61zehrtCXIrWFmiiZcaHzDsXFqlzbJCy+8nbbiWLx12IoxBgO5ykbd4g==
X-Received: by 2002:a05:6a00:a21:b0:562:99d6:c30a with SMTP id p33-20020a056a000a2100b0056299d6c30amr13579048pfh.35.1666274730404;
        Thu, 20 Oct 2022 07:05:30 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-50.three.co.id. [116.206.12.50])
        by smtp.gmail.com with ESMTPSA id j5-20020a625505000000b00562019b961asm13480320pfb.188.2022.10.20.07.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 07:05:29 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A8970103F24; Thu, 20 Oct 2022 21:05:26 +0700 (WIB)
Date:   Thu, 20 Oct 2022 21:05:26 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, corbet@lwn.net,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolas Schier <n.schier@avm.de>
Subject: Re: [RFC] Documentation: kbuild: Add description of git for
 reproducible builds
Message-ID: <Y1FVphEyu23U0jho@debian.me>
References: <20221020103823.31001-1-ashimida@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="89DQWfDuiNa8StyZ"
Content-Disposition: inline
In-Reply-To: <20221020103823.31001-1-ashimida@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--89DQWfDuiNa8StyZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2022 at 03:38:23AM -0700, Dan Li wrote:
> diff --git a/Documentation/kbuild/reproducible-builds.rst b/Documentation=
/kbuild/reproducible-builds.rst
> index 071f0151a7a4..13397f38c358 100644
> --- a/Documentation/kbuild/reproducible-builds.rst
> +++ b/Documentation/kbuild/reproducible-builds.rst
> @@ -119,6 +119,16 @@ To avoid this, you can make the vDSO different for d=
ifferent
>  kernel versions by including an arbitrary string of "salt" in it.
>  This is specified by the Kconfig symbol ``CONFIG_BUILD_SALT``.
> =20
> +Git
> +-----------------------
> +
> +Uncommitted changes or different commit ids in git can also lead
> +to different compilation results. For example, after executing
> +``git reset HEAD^``, even if the code is the same, the
> +``include/config/kernel.release`` generated during compilation
> +will be different, which will eventually lead to binary differences.
> +See ``scripts/setlocalversion`` for details.
> +

Briefly read the script, I don't see what the correlation between git
reset with LOCALVERSION thing is. Also, does the exact state of git
repository required for reproducible builds?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--89DQWfDuiNa8StyZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1FVoAAKCRD2uYlJVVFO
ozlaAQCo9yDyW0/QdCKZ+rcNre9GZXMODpqNx+M21L/EvoDWjgEAuj/Lej+0YXPE
aj/+dQET+5XQQO/JuZCJ7df9U2AClgg=
=XenK
-----END PGP SIGNATURE-----

--89DQWfDuiNa8StyZ--
