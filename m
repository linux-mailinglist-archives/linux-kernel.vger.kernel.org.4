Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CF96EB71B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 05:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDVDjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 23:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDVDjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 23:39:16 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D2919BE;
        Fri, 21 Apr 2023 20:39:15 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b620188aeso3543732b3a.0;
        Fri, 21 Apr 2023 20:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682134754; x=1684726754;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEx+TGIuJZnBbxwHguTzi/50faZQmv8dGRGGLL12C4I=;
        b=IVe4HnCH5LxkQR2cBe2YVPTyj7/nGXDsIosU/ZNdQWLltEbZq2AEJea7Jp2LBAuYU6
         WPrL50LdGvV3ntGRNMCgAH+CPkTr+/zAQYHno14L8vOa/v3HAIKkTOQc2VYUhJEQ4jUJ
         7fpGLhseQxMIv64HIW51ARbEfJYcpF3lXo4J/hOiWLejOtxU+SYQpT0X1pXTtahRKRKg
         U3iZ870rXwixXKyXuGwVsN3+SHG3KQ3SvMVT5XrlEBSmU2w3F+JxQXdMWv0YUum1GQG5
         x8gJ+Gnpm23EX3sZuPVJ8zdu7bwZqIs1yzNHuoXGfw4SehPYb6rrImCJ2OPzw+3k4Z7X
         W6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682134754; x=1684726754;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEx+TGIuJZnBbxwHguTzi/50faZQmv8dGRGGLL12C4I=;
        b=Gt9LQHNbIEgsgvvpCwLP+CFIcshBO3UwWV5zbg8+vR5hCVeJ+HTztMRabt7Cn1fm2F
         doDYyRC+2TancHhGgdxQYYOEE77JJXM/Jwy84XMppUqYPua0tWb1K6IariykT7delAWM
         ua8TFdq5+SzEmxMtTWKP7feNnVaTY+EieU1H7Bkc5ywI4WxBg+NHmdNQ8ULWtRwnq53/
         qQJbSrYLVVFzZfDzkNbf3FAlWOMX50esbhJpmbrvbgztCz3Me4aI2cZA0Gy5RNdv8dMq
         hJQnto3PkFaQdVe6tTaC1yDmvXZbUZUOrOh594CdXcOp9dulHvf03rU0W+EgZFxfb1DB
         yhNQ==
X-Gm-Message-State: AAQBX9cOSPRVREbcZGILxdAjgXZfrUMb2PkOJxOYpf+El3vXBOJzQikl
        l+apCpWinaoD3y0G8dRDRznj6551SMY=
X-Google-Smtp-Source: AKy350bYLUdGxPB8nwMsacn/ZsQl6UidLcqdKvd25SIxOengymObyOzrqfuR04RPAulzpdLSag2+Gw==
X-Received: by 2002:a05:6a21:3389:b0:ef:a31b:af8b with SMTP id yy9-20020a056a21338900b000efa31baf8bmr9544028pzb.24.1682134754347;
        Fri, 21 Apr 2023 20:39:14 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id e17-20020a635011000000b0050f9b7e64fasm3157733pgb.77.2023.04.21.20.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 20:39:13 -0700 (PDT)
Message-ID: <7e3b424d-2aba-3326-29c8-2ccdbfb12f70@gmail.com>
Date:   Sat, 22 Apr 2023 12:39:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <87o7nitvd4.fsf@meer.lwn.net>
Subject: Re: [PATCH] Documentation/process/changes: Escape --options to fix
 Sphinx output
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87o7nitvd4.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Dropped most CCs]

Hi Jon,

On Thu, 20 Apr 2023 09:40:39 -0600, Jonathan Corbet wrote:
> Jonathan Corbet <corbet@lwn.net> writes:
>=20
>> The right solution, if it is possible, is to convince Sphinx to stop
>> messing with "--" altogether.  Substituting em-dashes is of limited
>> cosmetic value and, I think, is something we could do without.
>=20
> Ah ... I get it now.  We *did* disable this once by disabling the
> "html_use_smartypants" option in conf.py.  The Sphinx folks changed the=

> name of that option in the 1.6.6 release, though, silently turning that=

> behavior back on.  It only took us five years to notice...  I think I'l=
l
> just drop the attached patch into docs-next.
>=20
> Thanks for bringing this up!
>=20
> jon
>=20
> ------------8<-----------------
> From 995addeb4ab2a2c4beaf8b90a4dc8c1d64735d29 Mon Sep 17 00:00:00 2001
> From: Jonathan Corbet <corbet@lwn.net>
> Date: Thu, 20 Apr 2023 09:34:35 -0600
> Subject: [PATCH] docs: turn off "smart quotes" in the HTML build
>=20
> We have long disabled the "html_use_smartypants" option to prevent Sphi=
nx
> from mangling "--" sequences (among others).  Unfortunately, Sphinx cha=
nged
> that option to "smartquotes" in the 1.6.6 release, and seemingly didn't=
 see
> fit to warn about the use of the obsolete option, resulting in the
> aforementioned mangling returning.  Disable this behavior again and hop=
e
> that the option name stays stable for a while.

Hi,
Whereas the summary reads "docs: turn off "smart quotes" in the HTML buil=
d",
the change is also effective in the LaTeX/PDF build.

BTW, Jon, don't you test build pdfdocs these days?

The fix to the pdfdocs build error from Tomi [1] is not yet picked up
either by Mauro or you ... :-/

[1] https://lore.kernel.org/linux-doc/29380b3e-1daa-3aef-1749-dbd9960ba62=
0@gmail.com/

I waited to see if there is anybody else who hits this build error.
It looks like I am alone!

If there is so few interest in pdfdocs, it might not be worth keeping
kernel documentation compatible with PDF build.=20

        Thanks, Akira

>=20
> Reported-by: Zipeng Zhang <zhangzipeng0@foxmail.com>
> Link: https://lore.kernel.org/lkml/tencent_CB1A298D31FD221496FF657CD7EF=
406E6605@qq.com
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/conf.py | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index db16814f182f..3d1f74f76e64 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -343,9 +343,10 @@ sys.stderr.write("Using %s theme\n" % html_theme)
>  # so a file named "default.css" will overwrite the builtin "default.cs=
s".
>  html_static_path =3D ['sphinx-static']
> =20
> -# If true, SmartyPants will be used to convert quotes and dashes to
> -# typographically correct entities.
> -html_use_smartypants =3D False
> +# If true, Docutils "smart quotes will be used to convert quotes and d=
ashes
> +# to typographically correct entities.  This will convert "--" to "=E2=
=80=94",
> +# which is not always what we want, so disable it.
> +smartquotes =3D False
> =20
>  # Custom sidebar templates, maps document names to template names.
>  # Note that the RTD theme ignores this
> --=20
> 2.40.0
