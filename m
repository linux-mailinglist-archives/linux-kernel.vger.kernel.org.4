Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD9C649466
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiLKNUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLKNUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:20:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A163FAEC
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 05:20:12 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so11814910pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 05:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eK6icE/W35Z4+4nFmcrJx5YTsJc83HteAeHiWSy3lOA=;
        b=VKjI08HWz6Qn0IkDVfpD/i27CaafC3kc7vi2sL/AXNVdrA2r+dMDvgMkgPnCjoMmA/
         tc5qB8OcsxGdbghJPyz4kM+RYgT2KAc+Ft3e/NrpgEd9ClPdULdW530fmUFuPkZdtKpW
         P1fa47cIv/HQ+k93DOE1NypvmEx1VKh0GuImtIpJ0UmIKKY54JwSic/lFZ2iKuLlZGSY
         k6Uz2ujNLCtJ7CHOz+k7T5NUPtI4Vtvf/Vsx46nvD9pec9ZlSMNdv+3BhniFJ4gSczXZ
         UhuGBKS+Ja3pjaF2Y2YyVXbJZoQHQdOhunO8oTjWrDDVFaMfB99CGqjzc/bIJGK1Ww80
         yD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eK6icE/W35Z4+4nFmcrJx5YTsJc83HteAeHiWSy3lOA=;
        b=gV/47AvjVL9Si7S4PcCZufQjkZu0GnXXn1J/IOIpe7/B8Zpx5R7DHCSVNbzdkyvyjM
         NxgW/Uh7BHXogZAqhMxhAjc4TtLdN7+6+DCq9M/w0swSzuWOTT/aKwoloGSInVClCtp8
         AAznCKdvJo2dvdLc2PEZKiWf2LX5gGlIqB7CHMkJt9tfv6pogacDUsrgbr+EMjL0337A
         th/y8202IiWOoSZgIbcU+nC7CU8jYEKNEOMXzm3EqEM3K1nKhdubWQVbjDFgBIfsIiVv
         r4KcsCEdKzPQnbVYXffRp0Kn8tfv7O4k2lJebL12KosLbCsGDMnc6usAi6QnkKkW8+6L
         Novg==
X-Gm-Message-State: ANoB5pl01RPwg3sO0226RdHC04kOBZssZECarXurK3TYBtEFdtsJnrYg
        zcn/0cKGQNHIW8+qBVQJjReGxVSI30Y=
X-Google-Smtp-Source: AA0mqf7cZY1QLYNROEyh08gC3XOYZUl9iPFeuqA5JKR1+iogrwsZy8PKteyzAQr9zdUJGyrUvR2nkQ==
X-Received: by 2002:a17:903:26c1:b0:189:5ae5:5b41 with SMTP id jg1-20020a17090326c100b001895ae55b41mr12117026plb.53.1670764812078;
        Sun, 11 Dec 2022 05:20:12 -0800 (PST)
Received: from debian.me (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b00186abb95bfdsm4350315plg.25.2022.12.11.05.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 05:20:11 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 03C12103F36; Sun, 11 Dec 2022 20:20:02 +0700 (WIB)
Date:   Sun, 11 Dec 2022 20:20:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Yuwei Guan <ssawgyw@gmail.com>, jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: Re: [PATCH v2] f2fs: continuous counting for 'issued' in
 __issue_discard_cmd_orderly()
Message-ID: <Y5XZAg6X8nK7/vBi@debian.me>
References: <20221211121852.112127-1-Yuwei.Guan@zeekrlife.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9N6Te5yUxbn496Su"
Content-Disposition: inline
In-Reply-To: <20221211121852.112127-1-Yuwei.Guan@zeekrlife.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9N6Te5yUxbn496Su
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 11, 2022 at 08:18:52PM +0800, Yuwei Guan wrote:
> As the 'dcc->discard_granularity' and 'dcc->max_ordered_discard' can be s=
et
> at the user space, and if the 'dcc->max_ordered_discard' is set larger th=
an
> 'dcc->discard_granularity' in DPOLICY_BG mode, or it's a volume device,
> discard_granularity can be tuned to 1 in f2fs_tuning_parameters(),
> it will may send more requests than the number of 'dpolicy->max_requests'
> in issue_discard_thread().
>=20

You don't know how to stop sentences (aka "abusing" comma), so I read
above as uber-long sentence. Care to reword? There are many cases when I
have to reply with such rewording, but this time I choose not to do
because I'm lazy at the time I write this reply.

> This patch will fix the issue.

Fix by what? I don't understand the code.

>=20
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>

You send from your Gmail address but have SoB from either personal email
domain or is this a random company? If it is the latter, please talk
with your company to fix the mail system so that you can send from its
domain (and receive traffic from mailing lists). In any case, your email
address in From header and SoB must match.

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--9N6Te5yUxbn496Su
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5XY+gAKCRD2uYlJVVFO
o5+7AQCXI2AY+nriPuRzD0OBzXYz5Zaz/ND5Ee1qjV0Eg63FuQEAjkhp9zrKt86s
Qjo9LMHDzBrzxWkqVxbR/cSE0F6WxwE=
=SmO+
-----END PGP SIGNATURE-----

--9N6Te5yUxbn496Su--
