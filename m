Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208D170AFB3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 21:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjEUTDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 15:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUTDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 15:03:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFF8C6;
        Sun, 21 May 2023 12:03:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f3b39cea1eso2044138e87.3;
        Sun, 21 May 2023 12:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684695812; x=1687287812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JROmKJWhJiJb6emtVJhY8hL33KzRuu8mE90DKJ8FcMg=;
        b=NQkzC5Fe22Mjxk3PfyPJtGwLiMirRt7YDTYXj2VZR+SEj2mb71uZxh8D3bAPwQ80A+
         x+YlP7qsIWDbjSUrWBsgGktPZWZpBhcfZRiJyXVUFtKm2OgT/K7RKgd5Wqadp8HrmSA+
         pYS0Gz1oEXa5XxLW4sZFcDJUKbgmLXc4VeoZwsG7jihJvS4Okvey3O7DXLBaEWTjE6B+
         m/FGFnswi8o027zfpFqbAZUqATZX/8yscBeRaXinEdxsmOcHJD3cvlRmDpJgpStqfM3Y
         TU7I27X2QRlHQOJwdIVswy00DCDIXFN6ITpn2RsdotC5b3APdm/q/HvH/pAVIFTJBN9K
         K6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684695812; x=1687287812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JROmKJWhJiJb6emtVJhY8hL33KzRuu8mE90DKJ8FcMg=;
        b=IZjcYL8VQ/aHnyXMgC8RKl34Geslis6UYUSE88MYAUxCeTUm1+yTD3vEei4sTt51ne
         Xx+DcX9Go3l9/dFBBeO1HjH831JeLPRykNAzFNKAnRExWsrpSVV+VKTY53HewPLvaqkz
         q5l/3XhB5a+dgZmUo5kug3YRsz3/4jTcLn1EARinExpSXqPSSzOpmzcbm5+D3bokhvYp
         3WIRLmGEbGy2yO+G6jxsZw5oTwqNVZwfb5GPTar8341T2EnE2uaMySaFB7ibTvytvRea
         Bsg5Sk6OY/xdVIbsccNWzW7bYm5cexPoxoJ/ndvNgMVZJRBhf6Y24jGN5CoRmUHeog3G
         EJpg==
X-Gm-Message-State: AC+VfDyAvJZuxKprrrnP0Jiq6ByyH9I2sk/jE8XJGnsKiAzblFR3wx6m
        ogqOvaCsyp+R4Es3RO0v4G1cJs1Mm2md7Movig9rKwM4NclK8YrV
X-Google-Smtp-Source: ACHHUZ7LzhaCvPnNSJykHJdewycERVa9aEW/ZCyfUp71/cGgzTdO1ECoyOFChpkyd7mJHnoiQQ3gLFIRgX00Inp8Zss=
X-Received: by 2002:ac2:4205:0:b0:4ed:b842:3a99 with SMTP id
 y5-20020ac24205000000b004edb8423a99mr2602511lfh.59.1684695811422; Sun, 21 May
 2023 12:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msxkE5cPJ-nQCAibJ+x+hO7uSLpasGm81i6DknQ8M5zWg@mail.gmail.com>
 <CAHk-=wiStOAKntvgzZ79aA=Xc0Zz7byoBxBW_As5cmn5cgkuoQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiStOAKntvgzZ79aA=Xc0Zz7byoBxBW_As5cmn5cgkuoQ@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 21 May 2023 14:03:20 -0500
Message-ID: <CAH2r5muxwEMA9JpE6ijSbZEByxRmtNSiwcXMbOz+Ojo8_APJUQ@mail.gmail.com>
Subject: Re: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 1:06=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
<...>

> We talked about directory layout issues some time ago, and there's
> kind of beginnings of it, but it never happened, and the parts that
> *did* happen I'm not super-happy about. That "fs/smbfs_common/"
> subdirectory is just fairly ugly.
>
> Would you mind horribly to just bite the bullet, and rename things,
> and put it all under "smbfs". Something like
>
>     mkdir fs/smbfs
>     git mv fs/cifs fs/smbfs/client
>     git mv fs/ksmbd fs/smbfs/server
>     git mv fs/smbfs_common fs/smbfs/common
>
> plus the required Makefile editing to just make it all build right?
>
> And if you prefer just "fs/smb" over "fs/smbfs", that sounds fine to
> me too, but I guess this all really does just the filesystem part
> (rather than all the printing and whatever other stuff that smb also
> contains).

Should be easy to move and more intuitive, although I would prefer
that we use fs/smb or fs/smb3 as the directory name instead of
fs/smbfs (since that old filesystem fs/smbfs was removed in 2.6.27.
So reusing the fs/smbfs directory name could confuse people looking
at git logs).  I am fine with doing (and related Kconfig and trivial
include path changes):

     git mv fs/cifs fs/smb/client
     git mv fs/ksmbd fs/smb/server
     git mv fs/smbfs_common fs/smb/common

This also might be a good time to take another step toward
moving people away from the old, less secure, SMB1 ("cifs")
dialect by adding a second .ko file to the client (e.g. add
"smb3.ko" in fs/smb/client) which would have support for the old
SMB1/CIFS dialect removed. We would keep cifs.ko for
compatibility purposes (cifs.ko would still have its current
config options so would have SMB1/CIFS enabled by default
but smb3.ko would only support modern, more secure dialects
and also would be smaller than cifs.ko since it would build with
CIFS_ALLOW_INSECURE_LEGACY disabled). There is a
precedent for something somewhat similar to this e.g. the NFS
client has four kernel modules in the fs/nfs directory.  On a
somewhat related note - at the Storage Developer Conference
last fall there was an interesting set of discussions around splitting
out the RDMA mapping layer ("smbdirect") by removing RDMA
related code from ksmbd.ko and cifs.ko and creating an
"smbdirect.ko" module for various RDMA use cases (not just cifs.ko
and ksmbd but perhaps also could help some user space apps,
Samba etc. in the future) - this "smbdirect.ko" (RDMA mapping
layer) could also go in fs/smb/common in the future.

I would be happy to do the move (to fs/smb) of the directories and
update the config soon (seems reasonably low risk) - let me know if you
want me to send it this week or wait till 6.5-rc
--
Thanks,

Steve
