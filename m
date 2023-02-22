Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A928669F28D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjBVKNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjBVKNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:13:17 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87601E9C9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:13:16 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y2so3996877pjg.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMzkfJKl/NL963MsWeYzJQ+qxR9gSumsB1EsPNTZsUM=;
        b=Cr7MLhjegqppzuX0Hgckm6SVOEOERQT+ZlA8UJxCOWmnfsem3dxr6hS2EJnnZroZCW
         /BtnO+UXQpojmcvxXFSoBoXhjYOo4i0SwW8/WgUCgJ//U3H0EthrM5yYdYsIqp9rHv0Z
         1vi9CTNTdmwCxrjTyysNFD2gn7XqHioFY48jyCR58DW6ZNqXObb8+8iVGWNfuy6sred4
         CjqMGQxanaH1pVvS1s2xQQRf4P21pzMLl1KYfzcXVR09t77Y3gw5coGSJtJLzgMFcy2k
         Hy3mgZGx4CXyhrwJT9HZ2nm4QdH3FmV9UGMbDIXLxAtb5WDX3382d433NQY6HK+K6Vdb
         xZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMzkfJKl/NL963MsWeYzJQ+qxR9gSumsB1EsPNTZsUM=;
        b=JgiEfoPOqnFOCtZhOwH/QIOPwN9KpWzIIXIy4/R2PoCOLLuS0lauH0FyLOZ+i9Kqn9
         rKem0tXdhxon6uVDq8bjEdLBIwea8BTm6gOSJSTfSKwrhfqQY3zxuO4HYGiRAvQwoaIg
         9ACwgrIGpYDf5zFe7uJA9T5HkAB726Rm2xVkcYuQzWJAL2AMesGzmw9kXwF9yytY9b5m
         peEe9HDsLGY0NNhU+GrLGjSpS1ZCVZELfgvmjtaGdW2YXyYMURPWtrHkvBBcYo2eIwft
         rv7Zm2HNV1vEaNSg0SuVBHOX6Yzf3PvydMn9p2j2amaEIBIsRK31rnUmGGUQcjrtc0bT
         DZ0Q==
X-Gm-Message-State: AO0yUKUp7yld6pyy3ONpJHrv4fhB/OYZwmDR/Pn0+C4U9PR+wUc0QVWD
        jJI69s73kjOdjNyLhMfC18IreEy6iYU6ABaoNaO4FZLyZuQ=
X-Google-Smtp-Source: AK7set/wF/+I6/0cuLQuU4fZYbzunk7ayoJP7gNrNOFrdFcnZU4OyY7gi2nKaAMLLfs6MPmcZnjGmhW3CaWCd2bfu9I=
X-Received: by 2002:a17:90b:1803:b0:234:22cc:ee3b with SMTP id
 lw3-20020a17090b180300b0023422ccee3bmr2057351pjb.87.1677060796113; Wed, 22
 Feb 2023 02:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20230222093730.1826523-1-suagrfillet@gmail.com> <Y/Xl2/pfGYq5e89y@wendy>
In-Reply-To: <Y/Xl2/pfGYq5e89y@wendy>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Wed, 22 Feb 2023 10:13:04 +0000
Message-ID: <CAAYs2=jvYX2L1uGJs3AWsD6UkmbQ0rCHGsgJXw=7z9HcAvgiFQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] scripts/gdb: add lx_current support for riscv
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, akpm@linux-foundation.org
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

Conor Dooley <conor.dooley@microchip.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=882=
2=E6=97=A5=E5=91=A8=E4=B8=89 09:53=E5=86=99=E9=81=93=EF=BC=9A
>
> Hey Song
>
> On Wed, Feb 22, 2023 at 05:37:30PM +0800, Song Shuai wrote:
> > RISC-V uses the tp register to save the current task_struct address
> > as its current() defines. So lx_current() of riscv just returns the
> > dereference of the address cast via task_ptr_type.
>
> FYI, there's already been some patches posted for this:
> https://lore.kernel.org/all/mhng-bdcd75a5-e6d6-4090-8292-a32eb46e4464@pal=
mer-ri-x1c9a/
>
Deepak's patch is much better than mine, which also takes the
userspace and trap handler into count.
So no need to care about this patch.
> That version already has review and ack tags from Palmer and others.
> It seems to me that Andrew is the usual applier of patches for this
> script, so I'm gonna add him to CC here so he is aware - but as it is
> the middle of the merge window the best course of action might just be
> reposting that patch, CCing Andrew, after v6.3-rc1.
>
> Cheers,
> Conor.
>
> >
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > ---
> >  scripts/gdb/linux/cpus.py | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> > index 15fc4626d236..6825a9834394 100644
> > --- a/scripts/gdb/linux/cpus.py
> > +++ b/scripts/gdb/linux/cpus.py
> > @@ -173,6 +173,9 @@ def get_current_task(cpu):
> >           else:
> >               raise gdb.GdbError("Sorry, obtaining the current task is =
not allowed "
> >                                  "while running in userspace(EL0)")
> > +    elif utils.is_target_arch("riscv"):
> > +         current_task_addr =3D gdb.parse_and_eval("$tp")
> > +         return current_task_addr.cast(task_ptr_type).dereference()
> >      else:
> >          raise gdb.GdbError("Sorry, obtaining the current task is not y=
et "
> >                             "supported with this arch")
> > --
> > 2.20.1
> >
> >



--=20
Thanks,
Song
