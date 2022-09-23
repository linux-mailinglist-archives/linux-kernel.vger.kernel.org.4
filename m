Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F167B5E84F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 23:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiIWVdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 17:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIWVdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 17:33:00 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966119E8BC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 14:32:58 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id mi14so735644qvb.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 14:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=rSFjW36jJOKHdmnnk3/fGHSGvXpsb/XtXPbpN+m6od0=;
        b=WbGuo/Q+2JQls71JXy+DKjT5lrw9Kurr859OQWRjUynQP9sn+xsppwjjlQoPfdEMSk
         UtXtkNhx2Ve54PsfhiAsf3fxP9SOXsyLtjyMrQ/bO3Kr/89MWJMKEGObGFlV/4jC01E7
         p5Bu8AlF4rtevBUYS6v/GZpbDCqkysmu4vOtXv1fgT3Pwyj5wFKf9ckkGMeaO9H/x/xJ
         aJ84ZU9KLyjGw2pAVsfKPntSXrF7DP7wGMPdE91jn19BQ0UNfqAfL61/nL8Mfnkfn4IC
         pnqDIFsY2GMYomFs6QM6Tx6qkmipmV3Zwelkia49Vq4sLM7XVnY0vDgbvylNhcf5jG9n
         jGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rSFjW36jJOKHdmnnk3/fGHSGvXpsb/XtXPbpN+m6od0=;
        b=Lfx47yhj9oBw04i7TgiBpknw0lWJTy4ziPJAR2IDCISeSXSt/rEuZrJWBnpBpwdpOO
         qId/WaOr0gi8I4GBTyd0h+B753ZgfPGFvKuiGfq7isnfTWUgPl3rdUgoGnX2iiAX8OuG
         gD8RemsnHClgnAa8zYJpJDTRQ98Os10ixtOh1u5lYC5Ea9RCDGbA5UUDqHe2+b/wRwnT
         QL2Dejzn83lQTSTwB8+NualgVs3iRsYY3sSAz0rU+GFfUsBw0ioAxT9dP+yGlZ6jWdfi
         tku9v9AINNQJJoElWNmSXKLyYyVoALtlVUf7Tp7l2nNSjL8skF1NMHEKYeDD/NRzITG3
         k0dA==
X-Gm-Message-State: ACrzQf1uuFvNS4C4IFdQEwfsCHj0kAGbOmMm5j4O0955eCEbY1VXRHLh
        5IJ2bqzAOzi2eId0t5UC33D7B5eCrpE=
X-Google-Smtp-Source: AMsMyM7qf1MHs6jAk6JGH+Y+JEInqHcOSVpwobrhyzSADRCm0JJE5Wom3ODGyFKeuiOts9//gGR+Fg==
X-Received: by 2002:a0c:8dca:0:b0:4ad:6e03:c906 with SMTP id u10-20020a0c8dca000000b004ad6e03c906mr8735830qvb.74.1663968777751;
        Fri, 23 Sep 2022 14:32:57 -0700 (PDT)
Received: from Gentoo ([154.16.192.39])
        by smtp.gmail.com with ESMTPSA id c15-20020ac8110f000000b0035bbb0fe90bsm5881272qtj.47.2022.09.23.14.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 14:32:57 -0700 (PDT)
Date:   Sat, 24 Sep 2022 03:02:32 +0530
From:   Bhaskar Chowdhury <bhaskarlinux73@gmail.com>
To:     Daniel Mentz <danielmentz@google.com>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, masahiroy@kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel:gen_kheaders:Replace md5sum to sha256sum
Message-ID: <Yy4l8AVyoEJtV+Vm@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <bhaskarlinux73@gmail.com>,
        Daniel Mentz <danielmentz@google.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>, masahiroy@kernel.org,
        lkml <linux-kernel@vger.kernel.org>
References: <20220923110332.24090-1-unixbhaskar@gmail.com>
 <CAE2F3rDymUUDyXrxFyhSGe4k1jrsZih2DbXViA23wAND=XJuyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0rxz6OFaGQFUDwk7"
Content-Disposition: inline
In-Reply-To: <CAE2F3rDymUUDyXrxFyhSGe4k1jrsZih2DbXViA23wAND=XJuyg@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0rxz6OFaGQFUDwk7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 11:12 Fri 23 Sep 2022, Daniel Mentz wrote:
>On Fri, Sep 23, 2022 at 4:06 AM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>> Thought to apply a better encryption mechanism.
>
>MD5 and SHA256 are secure (or, in the case of MD5, not so secure) hash
>algorithms, not encryption mechanisms.
>
>> Replace all occurance of md5sum to sha256sum .
>
>Looking at this script, I'm not convinced that it relies on MD5 being
>a cryptophically secure hash function. It appears to me as if this
>script uses MD5 to simply detect innocent changes to a set of files as
>opposed to guarding against malicious attacks. I also found that
>sha256sum takes almost three times longer than md5sum. So, in the
>absence of security requirements, md5sum might actually be the better
>choice because it's faster.

Al righto! Then...no issues, give it a pass.
--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar

--0rxz6OFaGQFUDwk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEs7FAjU4eq1yogJSEAkGeLcGNq5MFAmMuJfAACgkQAkGeLcGN
q5OqngwAqKVulL0D7+pSyt+EoqX11vRhvNV24J14JrJdXCkg8RTrMDFnCHS8xo8y
ypsXspIKDFo0Qy943HS/5CNYI6ulx4fI6EGKB4T4oFqxf53Mb8hLiiNT9fURRcXY
t6R54tBi58wnyP8DMi56I/zEniTpvUhKh6hfaei8392CseZcb1RV+Vgq+q+v2UDq
L61XVfhqq3axJi2VCZLH3uTQUBW5UQjP3d+KkVHfoHMOMXpWV8K7AVdSYZRSjOJG
90Au0GjS11AoAtw43ZrIFVJ05rcPTgoZSVjvfQdv438p/M7hQwd+3Gxgz7I4Y5A2
o4aijZeHeI5qrJpvitR3m1PXQjdn7wRK29ImydEcJY7zrhhL50wLlCFViR2K6gN6
AaABCvOlXOm/7RCXcft8dGlGEIYR5b8gWGIipW7O6jlCLaY1y+MMVpO9Mhgd84GO
3JQvryuoJG3WPmY4TZGvQpuwWC+WPoArqbnTRgw0S+2vCtlcU8s3kWwpGBfMh3xc
Kmb/ob8S
=8hBt
-----END PGP SIGNATURE-----

--0rxz6OFaGQFUDwk7--
