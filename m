Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6890D737E58
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjFUIuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFUIuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:50:11 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8031C1731;
        Wed, 21 Jun 2023 01:50:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-543cc9541feso3097543a12.2;
        Wed, 21 Jun 2023 01:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687337410; x=1689929410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFfbVhmX+rRlnfYZflmEzqdlANTovVuTRalq5Bwba3g=;
        b=gUOgcNgDy6mx9Wys0vaBKGuyhmyiklAP7sAQKRn/l5VGoOm3XUNvFJ8QT6L3gx8uZk
         +YlexuNp9Pu2Q2obpiBMBPNi/LX+5GnpYYPIPyx4owgYs5Qt8m1wG2lXYddfv5DGP4pe
         Em7HdmQhWLSlN//gqyu1erJOwpZjOZXrmJu+Do8YqvGCd/Z2gY9Dg/094I12jOZzfTYM
         dsWFv94O4+QNbYxkRj6Scbqc8XzsJDUhDHWMcZ+mJnLSwCh/I7rPBf8h8RPEHZvBtTyJ
         WOR0LQq0nuag5RQRS+0q4Tw68z6PKEXzvOdqcsbe82K4I9RVYbp1auUmhZIO3RxM5UUa
         fVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687337410; x=1689929410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFfbVhmX+rRlnfYZflmEzqdlANTovVuTRalq5Bwba3g=;
        b=lgUUv6bsFi1LoKLKZ9iE/w/so9npoolgI1pWkmdheyIT1EkIwu87DXvXRNpFc7n9UL
         CLJhtwaveu7ksYJA1GlYjLbOeGhPIf+A7C78jR+rbX/0HvWgoKc6KX8bu0qfq3DPmKIL
         /MLufscaS51nr7iWYSVrLtJ5DgH38oLpFI9SWAj0kI3pkvgxzoY5zcb01z/MJl4Li6nl
         UiQkgybYILZcaxryG4NhH+iqsYjK+ZEuklMONxYjQv4KhBRzjYxJ6J5FUY1/KYu3ar9T
         hI4NkDaPeLWAiCzPc9tzGPG+Y5+gvvUWViYYbZKrnBhakvX1miYSPef1OGUvPQCeOMd9
         +WkA==
X-Gm-Message-State: AC+VfDwPbAjwy6AfmYVC6P0FlnSXz5GKClHlkxQLIvkdXt+VSpV9WT0b
        ChtT+RjlIhHU5BsESw9nbJxGlLt4D2FsXct9C2w=
X-Google-Smtp-Source: ACHHUZ7V6OsQfpEdCg1TMZD1Tx9riuhvSXWOLmE8oQVIwYR42vLRipuKolNWNt5MbQfWxvS0/ztdciV4l6uTfmChAUA=
X-Received: by 2002:a17:90b:a46:b0:25b:ec0c:bf2 with SMTP id
 gw6-20020a17090b0a4600b0025bec0c0bf2mr11378446pjb.20.1687337409583; Wed, 21
 Jun 2023 01:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000051197705fdbc7e54@google.com> <20230621070710.380373-1-astrajoan@yahoo.com>
In-Reply-To: <20230621070710.380373-1-astrajoan@yahoo.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Wed, 21 Jun 2023 16:46:14 +0800
Message-ID: <CAD-N9QXZFMFGp3Vw4449Bx1-ttDVSF3hiwSw=e6+D096UDNfvw@mail.gmail.com>
Subject: Re: [syzbot] [net?] unregister_netdevice: waiting for DEV to become
 free (8)
To:     Ziqi Zhao <astrajoan@yahoo.com>
Cc:     syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
        arnd@arndb.de, bridge@lists.linux-foundation.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        nikolay@nvidia.com, pabeni@redhat.com, roopa@nvidia.com,
        syzkaller-bugs@googlegroups.com, skhan@linuxfoundation.org,
        ivan.orlov0322@gmail.com
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

On Wed, Jun 21, 2023 at 3:38=E2=80=AFPM 'Ziqi Zhao' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> Hi all,
>
> I'm taking a look at this bug as part of the exercice for the Linux
> Kernel Bug Fixing Summer 2023 program. Thanks to the help from my

This is an interesting program. There are many kernel crashes on the
syzbot dashboard, which needs help.

> mentor, Ivan Orlov and Shuah Khan, I've already obtained a reproduction
> of the issue using the provided C reproducer, and I should be able to
> submit a patch by the end of this week to fix the highlighted error. If
> you have any information or suggestions, please feel free to reply to
> this thread. Any help would be greatly appreciated!

Please carefully read the guidance of submitting patches to linux
kernel [1]. Be careful about your coding style before sending.

Note that, Syzbot has the feature: patch testing. You can upload and
test your own patch to confirm that your patch is working properly.

[1] https://docs.kernel.org/process/submitting-patches.html
>
> Best regards,
> Ziqi
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/20230621070710.380373-1-astrajoan%40yahoo.com.
