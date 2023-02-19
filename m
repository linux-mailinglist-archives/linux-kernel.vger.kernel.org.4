Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F19569C2AF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjBSVVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 16:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjBSVVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:21:51 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB3ECA27
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:21:50 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id t10so804164qto.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMbEmEBJfIiTufRlf0oSs/e2AjtHR4L/8A3mn4HqD5I=;
        b=IrxCeJx9rm08e1zDuuZSnuj2Ch8NHcwPzl4iQ5XPcEtWl1EubiyeoYw2OrpABGNSti
         AC9JHhTckI9zZ9FjuzQE054oyrhUko1a4C0BXL7BYRdkMYOjwTFHI2bRxUFALVnjb+Lw
         3jXJtZjDHcWAYrfH5je6EToecYwuasmrZp89GE139BMAr1NzGRUczkS8UQqVanr5Nk/7
         j4nd/TCYGllKvTUCDWK2ipq+52CVVnPmMlMvZTXrxc1JfjTYJYIpnmMkfiIs0UyiCuzF
         LVUB+Q4WpoOJu/mWNzQCH6ylW8A+rPrERuhbexEMLN2ly9gytchHnWOy6RC1Jz7xtUIk
         NaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMbEmEBJfIiTufRlf0oSs/e2AjtHR4L/8A3mn4HqD5I=;
        b=bYSTiXHZMTA3IJke3JJYBwtnXZN6uvQB9DPt0BeerJ/8A5bbB6eEPKs1QH9XVqUtJB
         Whp/NKcRMmHozdqx56DY+FlZNi047bTveCxYDr/SsiUy0V31weJCsV2513NtlzdzTS1E
         SbNq+7sVgle0gjllzzPoEwj8SooLk+FJDzYmNpo/RbreynR5U3ZWMxdpipGchnlY9+8c
         n4tOnT9eXVPwxI2sll9LX1AqdkcwSimj7a9v2MEyChp0EgXsPxpgfEnyyHliX8MNeR5F
         C3UqFtBIO4rTYx59JQfIzmicQBDKuHKVzf7MgpjvkApn+h7b8zO6GEmejWfl4MTxVpb4
         3oBA==
X-Gm-Message-State: AO0yUKWXwdyQsJgsYlaGClH9gV8e7AayGbknCurw+LZgwrufXR5Uk1MY
        26OJgMpNVKtW1eooI1Im8JdfTl/xtZ4=
X-Google-Smtp-Source: AK7set+Q4+MWC4o3D3yFW4Tp0H6BCaEA5AI/EweHSrf532gHU36T6BmRKiMTSf1nVYvKpJy8PcPbCQ==
X-Received: by 2002:a05:622a:1895:b0:3bb:88e2:7625 with SMTP id v21-20020a05622a189500b003bb88e27625mr11154317qtc.24.1676841708884;
        Sun, 19 Feb 2023 13:21:48 -0800 (PST)
Received: from hotmail.com ([137.118.186.11])
        by smtp.gmail.com with ESMTPSA id v14-20020ac8748e000000b003a81eef14efsm7675266qtq.45.2023.02.19.13.21.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 13:21:47 -0800 (PST)
Date:   Sun, 19 Feb 2023 16:21:46 -0500
From:   Storm Dragon <stormdragon2976@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: Bug with /dev/vcs* devices
Message-ID: <Y/KS6vdql2pIsCiI@hotmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iSaAElCxPAbb9cvS"
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iSaAElCxPAbb9cvS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Howdy,

This is my first time ever submitting a kernel bug, so I apologize if this =
is the wrong place. As per the instructions I found, I first filed a bug in=
 Arch Linux:

https://bugs.archlinux.org/task/77575

I will add the contents of the response here:

For the record, here are the 2 associated mailing list threads [1][2].
                                                                           =
                                                                           =
          =20
The reason why it affects both LTS and current linux is because it appears =
a security patch was applied to both trees to fix a UAF (use after free) bu=
g.
                                                                           =
                                                                           =
          =20
If that patch is problematic, you should report it upstream to the kernel f=
olks. Maybe even email the patch author directly. It's this patch [3]. Plea=
se let us
know what you find out.
                                                                           =
                                                                           =
          =20
[1] https://lists.archlinux.org/archives/list/arch-general%40lists.archlinu=
x.org/thread/EOSHIVGUZLNAD7BPHSUGOXFYSAFWDYH7/
[2] https://lists.archlinux.org/archives/list/arch-general%40lists.archlinu=
x.org/thread/S6R6UDUMX2LWL4HJ74MFNYOES45UBFLF/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/drivers/tty/vt/vc_screen.c?h=3Dv5.15.94&id=3Dfc9e27f3ba083534b8bbf72ab0f5c=
810ffdc7d18

----------End Response ----------

Methods for reproducing the bug are included in the link to the bug above. =
But I will include one of them here as well. As root:

[root@mjollnir ~]# cat /dev/vcsa1
                                                                           =
                                                                           =
          =20
    cat: /dev/vcsa1: No such device or address

The contents is displayed very briefly before the No such device or address=
 error.

Thank you,
Storm

--iSaAElCxPAbb9cvS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEjjImGMhZhYoKESBfW+ojcUPdwZMFAmPykuYACgkQW+ojcUPd
wZPcTBAAidrxcDrx+XJEVwqi8Dz9VpJs6SHqvKTVjdhqXHA8QXHINeTD80WF3JHx
CBAQqv+x1cxbyuc2NNdlD57Xfz5Rnfo2eJ35hTDe7kQSa9gvXUY5NDabjxS7xs/f
VEH0i7xxzo7+TOEZM3+3lWY4cxVEnJNhrcoDtrYXpfiNW4XMR0kAvtpuiPASpSdU
LHmaWjfKMfAQkkbHqOxoNl4B6jrF+CjGSmVZgEXX9uFt6SEZKF1iFLQP7EIsF6ji
clQHCluF0aWxq9l3ybjNsOfqsuS8nn5mg1U++XyttKiReFurix1YM0B3Yx4UwZee
tg/06Q9zAUWMUwJV9dTHp0p9Zr6lmKFBRLAnDlE0W3t4YS6daMOJ+KXjGPOIfq45
wU1QqdI1BkjsIjEVWpuoeTziWxIXIhG9JzSeyJnsqEDb/DPn3F2MJ2+Qdy26388O
7AQSe3UbQ1yV8C93zEdhsl7D0BQZEjwqhPz92ehzp5Ft4j8MkRuiKnCqhol5xn22
iKqWAoz6X6p6PncyXQKhBuvRiY79mVp8A/vpgfRVzmjWSijG4GVQMX0gieauvXZe
ll77pn9OsZwfdTZ4T1fLTdKdyRwglLNvWjiJCCTFaTPzAXKZEN/YPsV68SzROEgG
/LW6A734eDZhR/c0HtM2ymi2FOCk+LWiQQnXozsSxkkl/4JY4SU=
=iL7C
-----END PGP SIGNATURE-----

--iSaAElCxPAbb9cvS--
