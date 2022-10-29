Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5FF611F50
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 04:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJ2C2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 22:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJ2C2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 22:28:31 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD99F1D3467
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 19:28:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y4so6360807plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 19:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H9ysr/bjm0ZC9gEtJk1P7ow/P+t56kY5dDvtQcNi4MQ=;
        b=FGrs5I3W0Ji7vhkQCs00jzZ7Aj0Air8e0TbGIn/F1GL8m9dZ+qJbqndA0WYmV1jxAP
         EVzEpQoUFeTxRQq9pfDXZbrfBJUcgpnFyX9RHKykTiXF61xswZDX2af1pEW0/Msqh4fT
         lfP0+/bAtHZNsaHudqD8epUZQbQMIy6vpU8GWvSidtrV6XROlE38hSftnqRxE/Rhpdm4
         ThNy2HC4fp5HFdMdItboHykF9otcV+Sum9rIUd9hAe01fL5JnqiU5EqiRG6v844AMbjD
         Q56Jy5wPbUlXpvzZKD986FsZQGg7KTlo7CT1QJ8tuMFZDiXLzbKfVCgp0F+nJlF+jTTX
         SLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9ysr/bjm0ZC9gEtJk1P7ow/P+t56kY5dDvtQcNi4MQ=;
        b=uqOpJXfk1K7BrI53/EzIo/ptd+MAN3IwRWsZQtIYG7MYtpV2UO4ImJDxpxnWOFNVe2
         rW4STVJVkVGKGtlaMeXs6A3lu3Bi1BZ/KPGVXxgT/RaTy/+r9fkIRMmNEYcbbMSzuSGO
         dEx5Shu6BhrSkIP5Omcfrvu/tVQNvdasJdm8CaXE9uXZJvmUjYXsU74PpHJ5MWbRYmQp
         DbHCOP9WTxDubgOk+dpIHxExmyBROZ3cG5J+k7yj7ff1kttXB14qa86CJtGXpl2W8jgE
         LLxZY4/cBE+z7DMv0sH6aNg7qHOCn9P5n9ZFz+pb1DZ1j6U/OJNHActmog3u9i+MpKGO
         2Pew==
X-Gm-Message-State: ACrzQf3u7o3MhQYKyXTyvHSMwdlx5K2IwFhMqpbzcjnoFMFBPr5DEBI5
        VHLZ+Oy0+DzDzt6T2XC8C9o=
X-Google-Smtp-Source: AMsMyM4nPcwAfXy2Nwfhr15BiCSuQ4amKaNnrsmBP8YEDBDAqedWuo8T7hIeLXZWNndQ7IRpfEMoog==
X-Received: by 2002:a17:902:9b82:b0:183:fffb:1bfe with SMTP id y2-20020a1709029b8200b00183fffb1bfemr2147655plp.173.1667010510259;
        Fri, 28 Oct 2022 19:28:30 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-25.three.co.id. [180.214.232.25])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b001783f964fe3sm142833plg.113.2022.10.28.19.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 19:28:29 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0A054100A5A; Sat, 29 Oct 2022 09:28:26 +0700 (WIB)
Date:   Sat, 29 Oct 2022 09:28:26 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v8 0/6] staging: vt6655: a series of checkpatch fixes on
 the file: rxtx.c
Message-ID: <Y1yPyt5NsvfSL3UC@debian.me>
References: <cover.1666978292.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ADH5S7zY59Gn+n8g"
Content-Disposition: inline
In-Reply-To: <cover.1666978292.git.tanjubrunostar0@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ADH5S7zY59Gn+n8g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 05:40:52PM +0000, Tanjuate Brunostar wrote:
> The fixes are similar, mostly long lines splitting. I had to make
> serveral patches to ease the work of inspectors
>=20
> v2: fixed a compilation error found by the kernel test robot and
> recompiled the code
>=20
> v3: tends out the error persisted in the second version. this version is
> a correction of that
>=20
> v4: did some corrections as recommended by Greg KH
>=20
> v5: shortend changelog comments as recommended by Greg KH
>=20
> v6: did some corrections as recommended by Greg KH
>=20
> v7: fixed some errors on my changelog comments
>=20
> v8: fixed some errors pointed out by Philipp Hortmann
>=20
> Tanjuate Brunostar (6):
>   staging: vt6655: fix lines ending in a '('
>   staging: vt6655: fix long lines of code in s_uGetRTSCTSDuration
>   staging: vt6655: fix long lines of code in s_uFillDataHead
>   staging: vt6655: fix long lines of code in s_vGenerateTxParamete
>   staging: vt6655: fix long lines of code in the rest of the file
>   staging: vt6655: fix lines of code ending in a '('
>=20

You messed up your patchset...; the shortlog above says "fix longlines"
but individual patch subject says "refactor". Well, refactoring
means resturcturing and improving it without introducing new
functionality or changing behavior, which is really changing existing
code. However, your patchset only do visual formatting, right?

Also, have you ever at least compile-test your patchset (make W=3D1 and
enabling CONFIG_WERROR)?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ADH5S7zY59Gn+n8g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1yPwAAKCRD2uYlJVVFO
oydYAQDtxv1qvxNsp2r080rxws4fOrvmdai2HM6FMB9NuFZJBQEA2zlbqqEl8/+q
1qKuGuRxbHVjustXYCAhX+veICs/XAw=
=KkOZ
-----END PGP SIGNATURE-----

--ADH5S7zY59Gn+n8g--
