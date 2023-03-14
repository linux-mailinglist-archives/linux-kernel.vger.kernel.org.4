Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1396C6B8CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCNIQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjCNIQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:16:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9023877CBA;
        Tue, 14 Mar 2023 01:14:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ek18so27348018edb.6;
        Tue, 14 Mar 2023 01:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678781681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d75oHP8HBftXqxPqvi9wKz4wfMt8octTv5XCZRKc83U=;
        b=cJlD7zK1p0mKZzgAVWtwExe0cl38Ew/tKoDTN+7MTrfGlcDnYgZa+s6KVBFq23hwxY
         HjNvqWzJOzKokTND5svRt/+1tbrEtcffP1KX6RrLTn/tc8pKblkxzO0v8gswEwIKm5bc
         PUR8CkeQ5yizsX4zNZpwLYc1MnBiOXaJyW3aaOX9BVFgl6A3Ocu/HjZDeu9+pgDyxEYF
         OL0DAilJ7AHSZnOKAfCVNqi9QkhHwJQeNv1Ft0HuT8kxpOvo1FvYh2hoQa/kVQJtSnZm
         AIcn5SnG6gf3CFavRN7oZokH2f9t6ic2vza4sORPuei8EScO4pHaZy4BtEtkYtp1NlWI
         6bEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d75oHP8HBftXqxPqvi9wKz4wfMt8octTv5XCZRKc83U=;
        b=x0Yref2jVW8AqEwP9bvKkj8H+b63K91cPveDQzo/n6Wz0YSihXPB+dIW+atHuNg/RW
         sUMi9lVSEtT60Cp2MDcZkQycZBkkVArMuaOUNebe16BRwvaZzEPCqmKfjt9GCncONHzg
         UzGt0zI8CVZ8UZ5+fC86nooT9w+qlEnM11R7+WO/W4U5TH2DERrRt8Eh05t4ttxc4yVY
         GNJdi9t/DeLeIXFD1/ZwvKSxAyYopToSVqoc5JpzhIyxmJ3EkVI8H8/ulgo0cGJ1p7b7
         IntN/4mD+ng1pDO21tOgKJIZEkbdD/k0j01FCYduZhEDPj87kjrIIynfkZI7d1Av3TKg
         MZHw==
X-Gm-Message-State: AO0yUKURXnodQT+qV3n1I4GxM1MjsfJwacFFeMB+pyWW/cosDEKM4kJ/
        NDdgHU5XWY+vPkjSciOOLJLnfoRmTOUV2MdN7+E=
X-Google-Smtp-Source: AK7set8pJnX2wuv4RIU3EwFypf2hXbfjrrF3yFt38ltX8TCx+1JM85TwmlS4cemsDw/px6kKTdAKaif2Z0FykSohYn8=
X-Received: by 2002:a50:a6c8:0:b0:4fa:da46:6f1c with SMTP id
 f8-20020a50a6c8000000b004fada466f1cmr4749594edc.2.1678781681540; Tue, 14 Mar
 2023 01:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230314075609.5232-1-lukas.bulwahn@gmail.com> <ZBAqXXGnqJmySgkM@kroah.com>
In-Reply-To: <ZBAqXXGnqJmySgkM@kroah.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 14 Mar 2023 09:14:30 +0100
Message-ID: <CAKXUXMw+1a9ptkViye9sTKv8TwgGq72tBC6QR0FYRpXr942JEA@mail.gmail.com>
Subject: Re: [PATCH] spi: docs: adjust summary to CONFIG_SYSFS_DEPRECATED removal
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 9:03=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 14, 2023 at 08:56:09AM +0100, Lukas Bulwahn wrote:
> > With commit 721da5cee9d4 ("driver core: remove CONFIG_SYSFS_DEPRECATED =
and
> > CONFIG_SYSFS_DEPRECATED_V2"), ./scripts/checkkconfigsymbols.py indicate=
d
> > an unresolved reference to the config SYSFS_DEPRECATED in the SPI summa=
ry
> > documentation.
> >
> > Simply, delete the sentence referring to the removed config there. Also
> > update the documentation, as these sys/class entries should always be
> > symlinks, as the commit message of the commit above suggests.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Mark, Greg, Jens, please confirm that these sys/class entries now alway=
s
> > are symlinks. That is simply my guess after reading a bit on sysfs_depr=
ecated
> > also changed compared to the normal setup, but I am not the expert here=
.
>
> They have been symlinks for years, the only subsystem that the
> CONFIG_SYSFS_DEPRECATED logic still modified was for the block
> subsystem.  So your change looks good to me, thanks for doing this:
>

Thanks for confirming, Greg. That was my wild guess and it was just a
quick update while passing through that one section of that whole
document.

Lukas

> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
