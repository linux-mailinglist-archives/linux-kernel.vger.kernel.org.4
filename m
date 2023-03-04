Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867256AA7D3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 04:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCDDaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 22:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDDay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 22:30:54 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC3B4C2C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 19:30:48 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z6so5219213qtv.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 19:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677900647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+eBwPA/JqsVm5vj/Ml1ihlO2pILS+5ZKJ/mBtvuGi4=;
        b=eE9LJj79dqEPEhKIISYwkrB+AHzCPK66NDwmeeAUyia25qqA30NVJFaZjp/rLO8CJz
         aMJAoRrjXRoeKd+ogy5mme1Z4uNsMZ3DdASHmEgpuc5XrzVz0bK/9C4ij8PECDw0k2Fa
         fLSd6et+aZ3z0EKMenUGkqCErjVV90NiqZtIM97S9PvWkhlpk1/1t1pxbyWDLyHDUK17
         6O7KK23jocOiM2D0E+TgZlohC+Wb+cpHQ7R3V2YndijcNUqnEN3sVpKd+dObngNwyAFq
         b7wNV0zOIrbgBe38qultCnHjnSam3I9J2ytjBQYirdGu1TpZBJHO4MGeYlqLsQJ6Lu3R
         MJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677900647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+eBwPA/JqsVm5vj/Ml1ihlO2pILS+5ZKJ/mBtvuGi4=;
        b=qWYydd+5tPIHIZ0xctJutkAADNzaOnHwfSpb56CBe4FvP94edQsCFoAncSxt2nBVom
         y6MbV7sJJ7NCkYpDOudVuUFEnZCNlMuFDOLMAXbPypOlTilrepvHTKTcZnSj6v1apqKf
         PbKf1DeSNUvQ78bricnK46AMWqxzuZNOEAG7thmKl2Ym/gRBsUC1CxxYbOzPxxV9D4UI
         jSUdGfQfoxNhNXzfk+W6VJEWdYly12vMYZFVpeifWJGbG7j16FmDm8XqnmMrfRHr4/66
         y4oae2dxCv/tywXWid7SaVUjW0V83fH43oonX1qnh0qVKqrsAoGWv3VqfbNq//WZ3mov
         FZOA==
X-Gm-Message-State: AO0yUKW5Xjpsz+A07zcIa4aNjrzxfxnWkqIH0OLar2tmbgPZztJR2/R0
        nOrdfXNk8uJFR5CvWljMf5g=
X-Google-Smtp-Source: AK7set9GoQGi8COx+y/sxA4I1QBjI6JoE4eKP42DF8IXcA016/4iVmY7aPlEVFU5VejklN7Ddq75/g==
X-Received: by 2002:a05:622a:14c6:b0:3bf:c04a:8d47 with SMTP id u6-20020a05622a14c600b003bfc04a8d47mr5395267qtx.18.1677900647610;
        Fri, 03 Mar 2023 19:30:47 -0800 (PST)
Received: from mjollnir ([137.118.186.11])
        by smtp.gmail.com with ESMTPSA id q79-20020a374352000000b0073b27323c6dsm2841684qka.136.2023.03.03.19.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 19:30:46 -0800 (PST)
Date:   Fri, 3 Mar 2023 22:30:44 -0500
From:   Storm Dragon <stormdragon2976@gmail.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] vc_screen: don't clobber return value in vcs_read
Message-ID: <ZAK7ZP6EWk2iDXh0@mjollnir>
References: <Y/KtG9vK0oz0nQrN@hotmail.com>
 <20230220064612.1783-1-linux@weissschuh.net>
 <Y/OacHw6nL/ZtrH3@hotmail.com>
 <00e5aee7-c7b3-4077-8c9f-4f28ec220567@t-8ch.de>
 <ZAJqrfcfoM2eO5VL@mjollnir>
 <ce24d06b-7967-4b50-8913-ad42717e4c05@t-8ch.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Af/011kSTUcbXUbJ"
Content-Disposition: inline
In-Reply-To: <ce24d06b-7967-4b50-8913-ad42717e4c05@t-8ch.de>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Af/011kSTUcbXUbJ
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 11:25:00PM +0000, Thomas Wei=C3=9Fschuh wrote:
>No it isn't.
>
>Is this reliably reproducible? I doesn't happen on my side.
>Maybe you can provide more detailed reproduction steps.
>
>Just to be sure; did you reboot into the new kernel?
>
>Does this mean the screenreader now works correctly or is it still
>broken somehow?
>
>Thomas

I found the problem when I was writing the steps I did to reproduce it.
I did install the kernel, I did reboot, but I did not uninstall the lts
kernel I was using currently, nor did I run grub-mkconfig. Now that I
have done things the right way, it works as expected. Everything is
awesome again.

Thanks, and sorry for the false alarm.
Storm

--Af/011kSTUcbXUbJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEjjImGMhZhYoKESBfW+ojcUPdwZMFAmQCu2EACgkQW+ojcUPd
wZMudg/9HeGIraLJ4lt8G797gltBCQib2gxf6oIdY+SmldKHRTyYbzOyprMKJ/AE
RtOhgnKsOvxh9IyqdW/49zqlZPxnM8iPEbMi/dQCw0ovnSG5BQQIvAwvlYms3fUG
yg/t7gWriVxzcmqsVPMw8j6ZyL82Jdv8gRhYiBq4cYrvLpPhTQqj/WPi/RLPid26
tt67xMYIntb1jV6t4QtP65YNX1VQWrlGKepF/I4iqfvPRyePV9NXAIMyOjMA6+Hd
P7h9uhaFhZ6mURP25sUOFqPEqathsh1W/mFYC9d/yDshKl67sFQ8W1tkwdJC7zZW
VxUd++ZsWP89zaS+HIbQ/Zdsezu8wdFL2GyXwuhD84QvfvK0dtHmomcfMrnQh8V8
02Jv9pElDmo2xssicbkfACGHSEv+VW5m2HLEmAVsHRKTVC/82Tkc2Upw61KhTg7T
8MlbIrkJ1lwDe9oT+YjIyKvaJg2Kc9NW1akvaCimEIWTZFwUir0diJ6fKSTAspDf
s574xwzCISUIygOzbxRFA/miOWDOGY+y7ici8/V9oawhvYyGK7ihBv4+DlcjacOA
LMO/jdyIK6nY+K3ZJ6XJWaT8zv2rO7/odYqtJq75NaHKZNWBonPAT9AALLbpLzWs
NiRUO4yRNR7ljLnjZmj+zi3A6FAkuENG4cYes5KVRaD4MK0dtks=
=Q6lJ
-----END PGP SIGNATURE-----

--Af/011kSTUcbXUbJ--
