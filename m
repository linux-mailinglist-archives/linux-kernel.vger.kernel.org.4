Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDE86C2A20
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCUGCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCUGCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:02:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA71302BF;
        Mon, 20 Mar 2023 23:02:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EDA761968;
        Tue, 21 Mar 2023 06:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D98FC433EF;
        Tue, 21 Mar 2023 06:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679378558;
        bh=JKeqgeZ9XCp6DiUMuG9vjt1IGNkbdtPcb7rm17UEFNw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Eszwr05ICGcBd/ZQ9KVINbhknWJbxm82pgmGw1L2R0Fmbq/3nJHKq8Z0YFFu7Ftzt
         DDgi0QLs3sqETt08v+PtevO/pfHq5EqF781SZQRhwR2kUItQzJco7sZngW6VSlKFiw
         ZDntyCkr+I1GbJys2gcVfzmhjEAYEisL+2pQKTs/0kzmbvc5ptPTNOMfGBdfgIj4ag
         dwkuEOr77bNT0OCML/ug8X73mCjuGjCKz4IZxVqR6NtFmATt8WxTuEWoHVDWS9X4HR
         IvxHbsAsVxYdVZ235NyhLAYIOIbXpTYFnZTeEp5k44HVGE1k16qoh56Jn9TddWgvl3
         pU9EVv1Sfmn2g==
Received: by mail-ot1-f41.google.com with SMTP id d22-20020a9d5e16000000b0069b5252ced7so7960980oti.13;
        Mon, 20 Mar 2023 23:02:38 -0700 (PDT)
X-Gm-Message-State: AO0yUKWP9ivVy+h/hRqxmF7vAro+i77/ZFvOgiZB8U4UX17yliX7SPRC
        t7+fMxH6cNZ2F9mvi78gQXyZip6VBSfXxSkSo3E=
X-Google-Smtp-Source: AK7set+X3PZrDWjMrr1l9sphztPjjtsiJzgaROLky8DYxsXJTu6nsdWF2KtBt1GuS5ANrBEGysNWnOf8wGzDQRvYKMA=
X-Received: by 2002:a05:6830:1e8f:b0:69f:4a8:d9b4 with SMTP id
 n15-20020a0568301e8f00b0069f04a8d9b4mr443665otr.1.1679378557793; Mon, 20 Mar
 2023 23:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230311114248.36587-1-adobriyan@gmail.com> <20230311114248.36587-3-adobriyan@gmail.com>
In-Reply-To: <20230311114248.36587-3-adobriyan@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 21 Mar 2023 15:02:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNASCCKXGo2ODHFdijgJ7b0CTyK50Lo4VUsJyBfsfZWSMog@mail.gmail.com>
Message-ID: <CAK7LNASCCKXGo2ODHFdijgJ7b0CTyK50Lo4VUsJyBfsfZWSMog@mail.gmail.com>
Subject: Re: [PATCH 3/3] menuconfig: reclaim vertical space
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 8:43=E2=80=AFPM Alexey Dobriyan <adobriyan@gmail.co=
m> wrote:
>
> Menuconfig has lots of vertical space wasted: on my system there are
> 17 lines of useful information about config options and 14 lines of
> useless fluff: legend, horizontal separators and shadows.
>
> Sitation is even worse on smaller terminals because fixed vertical
> lines do not go away, but config option lines do, further decreasing
> informational density. Minimum reasonable 80=C3=9724 text console has onl=
y
> 10(!) lines of menus presented which is less than half of the screen.



I think nconfig is a better fit for your system.


In my understanding, the concept of menuconfig
is to use a similar appearance to the 'dialog' tool
although we have largely modified the code.




>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>  scripts/kconfig/lxdialog/menubox.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialo=
g/menubox.c
> index 5eb67c04821f..dc608914c636 100644
> --- a/scripts/kconfig/lxdialog/menubox.c
> +++ b/scripts/kconfig/lxdialog/menubox.c
> @@ -183,14 +183,14 @@ int dialog_menu(const char *title, const char *prom=
pt,
>         if (height < MENUBOX_HEIGTH_MIN || width < MENUBOX_WIDTH_MIN)
>                 return -ERRDISPLAYTOOSMALL;
>
> -       height -=3D 4;
> +       height -=3D 2;
>         menu_height =3D height - 10;
>
>         max_choice =3D MIN(menu_height, item_count());
>
>         /* center dialog box on screen */
> -       x =3D (getmaxx(stdscr) - width) / 2;
> -       y =3D (getmaxy(stdscr) - height) / 2;
> +       x =3D 0;
> +       y =3D 2;
>
>         dialog =3D newwin(height, width, y, x);
>         keypad(dialog, TRUE);
> --
> 2.39.2
>


You missed to adjust dialog_textbox().


(1) Run 'make menuconfig'
(2) Press < Help > button to show help message
(3) Press < Exit > button to get back


When you do (2) and (3), please make sure
the size of the grey window is not changed.

This is how the current menuconfig works.



I want to leave the blue frame.
My personal preference is

  height -=3D 3;
  width -=3D 2;



--
Best Regards
Masahiro Yamada
