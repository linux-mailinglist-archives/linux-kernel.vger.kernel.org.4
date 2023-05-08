Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D8C6FA879
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjEHKlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjEHKkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:40:45 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605AE2A85E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 03:40:20 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-5e7534b6736so7180526d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 03:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683542419; x=1686134419;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOLarLbPEw2BzQnlH1NcQezuXJK2sUMhOzGscxqhSmI=;
        b=szGEV5YbuseSTT2QhxnkprtYX6zVniR4AZX710LSV2FNdm2UEe1dsq9MJMXE67D25P
         VDItCbJ2B1EtrmvWegZIJ7dKGwCYVFsO74nwYdsAn43Pd7pyj2Egeyu54mHT1w4PF1Tu
         CnLg1TkOZiy/Fkdiy4izaXMTb/EzTOuGba/2TTCSnbGVJBdvcxBrilwMN3sZcMsUIO+k
         Wm7AkufaY45+fCrZJsJ2dzYxWGsi81HOa1IJGn5zI7b3pZjxExtz+1GeXlxhX9YcM/u+
         UUtYfRp+rJJQ94IDiTem5ZXUBXkpZc3kUU2+QIJSN1vXo0ccDGKSMvcvZnI+v7vWhVV5
         7Olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683542419; x=1686134419;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOLarLbPEw2BzQnlH1NcQezuXJK2sUMhOzGscxqhSmI=;
        b=PwnNy5A9ImtSX9YyXXPVCsLb3NnpZxVuQ4PSelpmk79OOZnLbQaHveFeWEsER5hJYi
         zFzWEISwCB/DO2VkCqGfJp5lpYkg4FFzWIuTZZe0yqFgj7EKpTm/UeFFdZtvUDG9bNJm
         2wwghL4UdYgDm0RNXrS3YDHcIXny/rG+9+fnBre7kDNizeY5KE8ftwDVOCBUEyTI7GOf
         m3Wl4zmBBmKKKvMgJrRXD3f73EqGJQhjKmSomkiN5K7FjQk9gmEp5ytmg9TzlvOwdjnS
         RdM0V1PpV4nqadyAmnUeYg0wHdQvvF0xXadHlGxuNWP6p9ItqnJM0N9lHP6XuAwL5/Dp
         yrDA==
X-Gm-Message-State: AC+VfDxp2CcgJj4nnPgEVgYzrxlbzGD2zF+0sYG3+Sbu9KiTQ9HjCZ+S
        uWzbtn23Ox5HRp1Tr0XqlCNES7bFrPiTrwSmu+LNClcL3OWRoBlWxKc=
X-Google-Smtp-Source: ACHHUZ5iItQygWtfgG27YbkNns42GQ2GwBwYRcbTfphBkNC5JHBOvYHayfIU5uZmZdKKjmsB6uKI5PvuZadFGQsXIRY=
X-Received: by 2002:ad4:5ecf:0:b0:616:73d9:b9d8 with SMTP id
 jm15-20020ad45ecf000000b0061673d9b9d8mr12826533qvb.3.1683542419276; Mon, 08
 May 2023 03:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPiR4Lwd0NTecp8GMN9YVLU4OXTiHm-z7Gsa_4-LEm1ZQ@mail.gmail.com>
In-Reply-To: <CABXGCsPiR4Lwd0NTecp8GMN9YVLU4OXTiHm-z7Gsa_4-LEm1ZQ@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 8 May 2023 15:40:08 +0500
Message-ID: <CABXGCsOWCp=KYFFvWA6ExUotUJe=YViZEsomqkCJb7dwNUFAwg@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
 - RIP: 0010:amdgpu_bo_get_memory+0x80/0x360 [amdgpu]
To:     "Olsak, Marek" <Marek.Olsak@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
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

On Fri, May 5, 2023 at 6:44=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
> I need to say that it may not be easy to reproduce this bug.
> For helping reproduce:
> 1. I looped script above:
> $ for i in {1..99999}; do sudo curl -s
> https://raw.githubusercontent.com/fatso83/dotfiles/master/utils/scripts/i=
notify-consumers
> | bash; done
> 2. Launched google chrome with 26 opened windows
> 3. And played in the game Division 2.
> A little time and luck and I get the desired backtrace again and again.
>
> I am ready to answer any question and open for testing any patches.
> Thanks.

No one can reproduce this?
I prepared a video instruction which can helps:
https://youtu.be/0ipQnMpZG1Y

1. Run script which would calculate watchers:
$ for i in {1..99999}; do sudo curl -s
https://raw.githubusercontent.com/fatso83/dotfiles/master/utils/scripts/ino=
tify-consumers
| bash; done

2. Run the game "Devision 2"

3. Run 20 windows of Google Chrome with such script
$ for i in {1..20}; do google-chrome-unstable
--profile-directory=3D"Test-2" --new-window --start-maximized
"youtube.com" &; done

I hope after it you see the desired backtrace.

--=20
Best Regards,
Mike Gavrilov.
