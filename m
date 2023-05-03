Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00B66F4F66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 06:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjECEQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 00:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjECEQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 00:16:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01DD1BEF
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 21:16:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b35789313so3393944b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 21:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683087366; x=1685679366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eHAjxhDB+7YUwNzRjQk8xRtJh2f350ZLzD0K4i9gzr0=;
        b=KkClDPe57Wo/TeP9myhaZO29QM3BPXYvuEjKyq+v3urZgQXrnnZpJGMXT22xmdJ9DU
         cn2y+hmxUbcGwAnNxmZiD/bnkkQh8pLiAqpNmJExV48L7HIsC3Y8Ug7Maw4VT2BYZ8yZ
         9tdPTFD7vK1q3CRILj93Z8q2ufqy90dXchaXPA9w5wnsWQq3QPbnZEiO7qnzmmci2bhL
         qQ6IVmZriRpZB9ldgQFovgGMiYoAY+PVmtFfwFN/QXWQnh/OtnLHltQvvCWKdK4zPk/9
         ZV1gAJnGMBJUgu1MXsKj2NH49ykNyPApTrTVVXMGf9jswI/rPkAzb85l3sDEGa9Iv/TC
         VMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683087366; x=1685679366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHAjxhDB+7YUwNzRjQk8xRtJh2f350ZLzD0K4i9gzr0=;
        b=IFVbJq6x3g1/ADGuSoVWrx5KTt06wnoYc+f3XMb+oCNYFfA0nrPedyWnvXeaNtMA+S
         FVLk787vdHMFyceaa/FTnttRgpbJyLcnXrHNnUIWQpPgSU/P2kbXvNJmCmRmdvIfQWu2
         FspRzr8XtJXQkiOK+3YGFp9Bo6jwnSlapowUFisBpTLub6E7MulQLCqjlZg50X1OGDAL
         vn7cT6dirSWGmGngTRR9m99hD+mxWV9GEhrzfLzUYHpwNC+3UyyGQAplrVcZFDXyNL7O
         taB9LdtmxdFtOR2lYqjTDOs0UovEKI6s3J6YxRfUth6edZRS3diDIJoxlHWMnhrMLcJN
         0PAQ==
X-Gm-Message-State: AC+VfDycIUKSmbZ5aoQEMlcfiQqrtSWKfAHaPys2YzSNrbpTy/uQxjON
        NgYwF/6QDr8I8unoFjOQBgI=
X-Google-Smtp-Source: ACHHUZ4+a/FZEiXy9raFBaye3F3S0+u66KMW3lrMrw6BNtxaNnBV9YsKaAVS8Mljw7POGxY5SKPoGw==
X-Received: by 2002:a05:6a00:198c:b0:63d:260d:f9dd with SMTP id d12-20020a056a00198c00b0063d260df9ddmr27392269pfl.33.1683087366253;
        Tue, 02 May 2023 21:16:06 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-39.three.co.id. [116.206.28.39])
        by smtp.gmail.com with ESMTPSA id a10-20020aa780ca000000b00642ea56f06dsm4058035pfn.26.2023.05.02.21.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 21:16:05 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 89350106247; Wed,  3 May 2023 11:16:02 +0700 (WIB)
Date:   Wed, 3 May 2023 11:16:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Danila Chernetsov <listdansp@mail.ru>,
        Anton Altaparmakov <anton@tuxera.com>
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Linux Memory Management <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: ntfs orphan? (was Re: [PATCH] ntfs: do not dereference a null ctx on
 error)
Message-ID: <ZFHgAhisxjKQxhLx@debian.me>
References: <20230407194433.25659-1-listdansp@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jVeXjOp7rLo2/O3G"
Content-Disposition: inline
In-Reply-To: <20230407194433.25659-1-listdansp@mail.ru>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jVeXjOp7rLo2/O3G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2023 at 07:44:33PM +0000, Danila Chernetsov wrote:
> In ntfs_mft_data_extend_allocation_nolock(), if an error condition occurs
> prior to 'ctx' being set to a non-NULL value, avoid dereferencing the NULL
> 'ctx' pointer in error handling.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Duplicate of 10-years-old outstanding patch at [1].

I'm not speaking of the patch itself but rather on unfortunate state
of ntfs subsystem. It seems like the maintainer is MIA (has not
responding to patch submissions for a long time). Some trivial
patches, however, are merged through mm tree.

Konstantin (from newer ntfs3 subsystem), Andrew, would you like to take a
look on this orphaned subsystem (and help reviewing)? I'd like to send
MAINTAINERS update if it turns out to be the case.

Thanks.

[1]: https://lore.kernel.org/all/1358389709-20561-1-git-send-email-nickolai=
@csail.mit.edu/

--=20
An old man doll... just what I always wanted! - Clara

--jVeXjOp7rLo2/O3G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFHf/gAKCRD2uYlJVVFO
o1n+APwKJYtr0b5BjIagktsmVL9SCph4PReoxPYXxgPt3fmPdAEAtdAvPwKv5oG8
Nqh5SWWZKXeVDdLmhwpR1GVqB4M0xAY=
=pf3a
-----END PGP SIGNATURE-----

--jVeXjOp7rLo2/O3G--
