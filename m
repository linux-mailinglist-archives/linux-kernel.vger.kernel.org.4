Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899C5660938
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjAFWEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbjAFWDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:03:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD677DE17;
        Fri,  6 Jan 2023 14:03:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id az7so2537200wrb.5;
        Fri, 06 Jan 2023 14:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb8EFkkICkuIqaB5CEfv+YzxiKjHZdVenUFRZRoF8qA=;
        b=YO41VDiTGtpe9giAkrnma1CBED9iGnE5Hd1sHXbdrdW88qTfk1/6bq/CxljYS6Pqg3
         Rya1McUPOZAfDSoTrwN0up6IKmuJjBHdksVT5FcBuKab0C+m3N6xh5Oa3bOKx+Ex93nL
         4KRdYh3GdudZNnIUmXwqKSGLUmh/TOy+gwOXkGrFC/cYvIHZJ1HBBzRPkpji8pgZEYrc
         XC9wHSOqZRx2Gq7zJMSi6q2CGVbfxoljLUhYR2NKrIdCxJsoz7kJY8suqjtt14Sfalcx
         QRQ6HLgY7WF4AG+/tlEsBmNv/BKrqV4JNPfIAnfI0+qK/M2bMqFY4U9OEcUWPRD+sZ7U
         iD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yb8EFkkICkuIqaB5CEfv+YzxiKjHZdVenUFRZRoF8qA=;
        b=auqrtMGUy66rwdc2UmTVrXmYhudF/nF1sUQBGZu7kRNBsyPX4l64pnhWo26RSQ7EWf
         psWT2h2bi6gwZUFlfVl8FaRZHPP4F029iRBFzBZow6RPNEWUosdDFAmsWhnjXOOt2w7o
         3kLf1zeNQ+ygfTF/XlG/OM7lr760l6vXDBPJZfoE7q/emTQSZXptibHgz/OhUiIEY6T5
         Ogj/b1s5c+c3H6PR7C4yphlTHJOHqClNXX/U9flDdomJibP0gNmnKN6RxwKgjbLWJzbX
         nJJ1Vl2Dx/OoH43FPk8McO8Gf+EHKo0AnhoLF4GmaQKNw0fucbSttl+Rst2y21vL/V0s
         OUFA==
X-Gm-Message-State: AFqh2koVdsfJiClyHsmuEs0zK45L7iOO77VXCUa5PjHvk4KlUD2Jl3NU
        8SOG2+5yLK1rJUEHvtEl6djqx+m3G/t5gqKnRZDbhwRMZY/9+WRl
X-Google-Smtp-Source: AMrXdXspsm6J55hrg1DBnGFAJ1zIVIHFUHWB9a6X3dKSjnz2oJEqtuW3GHTexBodsdNZJ50jlE5LnOQIqNJBNbjHcco=
X-Received: by 2002:a5d:5221:0:b0:2b0:6953:fac6 with SMTP id
 i1-20020a5d5221000000b002b06953fac6mr428822wra.131.1673042631801; Fri, 06 Jan
 2023 14:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20230106220016.172303-1-nphamcs@gmail.com>
In-Reply-To: <20230106220016.172303-1-nphamcs@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 6 Jan 2023 14:03:40 -0800
Message-ID: <CAKEwX=Me4JUhqmNa8k2SOmipNF6+dD5V50_mMmjWjYH0-rYwEw@mail.gmail.com>
Subject: Re: [PATCH] Docs/admin-guide/mm/zswap: remove zsmalloc's lack of
 writeback warning
To:     corbet@lwn.net
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com, akpm@linux-foundation.org,
        linux@weissschuh.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 2:00 PM Nhat Pham <nphamcs@gmail.com> wrote:
>
> Writeback has been implemented for zsmalloc, so this warning no longer
> holds.
>
> Suggested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  Documentation/admin-guide/mm/zswap.rst | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin=
-guide/mm/zswap.rst
> index f67de481c7f6..6dd74a18268b 100644
> --- a/Documentation/admin-guide/mm/zswap.rst
> +++ b/Documentation/admin-guide/mm/zswap.rst
> @@ -70,9 +70,7 @@ e.g. ``zswap.zpool=3Dzbud``. It can also be changed at =
runtime using the sysfs
>  The zbud type zpool allocates exactly 1 page to store 2 compressed pages=
, which
>  means the compression ratio will always be 2:1 or worse (because of half=
-full
>  zbud pages).  The zsmalloc type zpool has a more complex compressed page
> -storage method, and it can achieve greater storage densities.  However,
> -zsmalloc does not implement compressed page eviction, so once zswap fill=
s it
> -cannot evict the oldest page, it can only reject new pages.
> +storage method, and it can achieve greater storage densities.
>
>  When a swap page is passed from frontswap to zswap, zswap maintains a ma=
pping
>  of the swap entry, a combination of the swap type and swap offset, to th=
e zpool
> --
> 2.30.2
>

Link to the patch series:
https://lkml.org/lkml/2022/11/28/1140

And the suggestion:
https://lkml.org/lkml/2023/1/2/823
