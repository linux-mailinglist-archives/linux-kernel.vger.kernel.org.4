Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8378565A481
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiLaNHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiLaNGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 08:06:34 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA7CCD0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 05:06:32 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 1so35179371lfz.4
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 05:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBGbVeLERTPbA0k06YLcGXylPGf0RR08qgiJKyhAgig=;
        b=WWEtSDlnz6c6HzlhaA9dEkYzQA1iaP8c4/XP5GaTdsqXnZil1ozb9/hcMKwUGi2p/S
         zPyfDRp3dyXJEj1XfckztZFZRJSJgj72zj974x93+FUl1lTvCm1eDfOQMjJFAeI/jx94
         jWABYQiSx9kjCxy4ZQtZm/IoXRgGRqOjz8VpjhtiP8bko8Vvb3/hR6UBpa84At5NJexO
         8rm7EJODrZ71Ogg/yLEZUUvqClFegSLXYQeVmd5ztmKM1CI+08Jb9lZh3ymjOf8G8QFz
         ambWveroW6WvMxPZv7JD+KTrlfXRwLe4SQg39P6J7Dqo/thZ9ZsZHtI/fRQcSCAA6p/g
         kP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBGbVeLERTPbA0k06YLcGXylPGf0RR08qgiJKyhAgig=;
        b=6qhPArb3rzXSrPvBLa2LNWlEGbpa/jc9rJzIf/iVB9n2iLEjeeviG3TI/YP0dAsHFo
         waUsdTgfd7k2KTxs2otEgnKiKZg8sSl9WZmHvuiWUlJMjpwFLLfshGkI+oW9CaobpDRn
         ekEwqIIAwC6ERUBoljWou6YDT9xSC1mZ8XBJR+eSkY/p7R0Qoa3RM8pgpgWdy6pIZ7/d
         cYtJy49SgMDOWYTZQd8fkevRntjvJLBvEO8G2L0BjP2TdOssSjNYPgqKNl4OQS6vEFwa
         gmD+XI7kdFFrROUIgrauKcrkSE8Miqokr4LPExzDyIeC5+B9MC7FDjjWjdLrv+isj1lj
         8tAQ==
X-Gm-Message-State: AFqh2krHGLaCpKzcWAOCu5yZYVCX3al8S5YrhNmsR4xYgOp1eB4B/CVV
        +GBeXTEcP0ORSzQKWa/GwW0p6wyNgHtWRkhkWkA=
X-Google-Smtp-Source: AMrXdXu1q1j1m0Ays79I6M4lmtwyk3fHffsZ71kRbkTpSC6Axrrg+GGDqovd5wrSiaMbc6X0hjOpqKl6omA8wUZWqt4=
X-Received: by 2002:ac2:520c:0:b0:4cb:1fa4:f690 with SMTP id
 a12-20020ac2520c000000b004cb1fa4f690mr361626lfl.330.1672491991049; Sat, 31
 Dec 2022 05:06:31 -0800 (PST)
MIME-Version: 1.0
References: <20221231055310.2040648-1-yoochan1026@gmail.com>
 <Y7AHvYfZreO/G/kT@kroah.com> <CALQpDLfMjAE9_VtMO6e_iiPrciFNbksLQT3AB3QTGwZCNf5=sA@mail.gmail.com>
 <Y7AhLWSPE+2hnZ2I@kroah.com>
In-Reply-To: <Y7AhLWSPE+2hnZ2I@kroah.com>
From:   Yoochan Lee <yoochan1026@gmail.com>
Date:   Sat, 31 Dec 2022 22:06:19 +0900
Message-ID: <CALQpDLc4+-0st-U_s+09QCb2nmv=nQizheGXjhyKJLGS45zmZw@mail.gmail.com>
Subject: Re: [PATCH] misc: hpilo: Fix use-after-free in ilo_open
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     matt.hsiao@hpe.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

Since I don't have a real device, it is difficult to verify the bug dynamic=
ally.
However, this type of race condition (i.e., b/w remove device and
fops) is prevalently founded recently[1-3].
Therefore, I think this bug can be triggered if a real device exists.

The main reason for this race condition (i.e., b/w detach and fops) is
there is no proper lock mechanism.
I think the detach device function is delayed until the other
operations (e.g., fops) is finished.
To this end, I use kref to wait for the other operations.

The tool I am making is currently under development, and it can find
the race condition between detach function and fops.

[1] https://lore.kernel.org/lkml/20220919040701.GA302806@ubuntu/
[2] https://lore.kernel.org/lkml/20220919040457.GA302681@ubuntu/
[3] https://lore.kernel.org/lkml/20220919101825.GA313940@ubuntu/

2022=EB=85=84 12=EC=9B=94 31=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 8:46, =
Greg KH <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, Dec 31, 2022 at 07:05:36PM +0900, Yoochan Lee wrote:
> > Hi,
> >
> > I haven't tested with a physical device cause I don't have a real devic=
e.
> > I found this bug through static analysis.
>
> Then please verify that it actually is a bug and that you have fixed it
> properly.  To send patches that are broken wastes everyone's time :(
>
> Also, you did not properly describe how the static analysis happened or
> what tools reported it as is required.
>
> > This type of bug is similar to [1] and [2].
> >
> > And I'm sorry that my patch is incorrect.
> > It's my first time patching a Linux kernel myself.
>
> I suggest taking the tutorial on kernelnewbies.org and working in the
> drivers/staging/* portion of the kernel first, so that you can learn how
> this all works.  Do not dive in and assume that fixing issues that a
> random tool spits out is even correct to do.
>
> good luck!
>
> greg k-h
