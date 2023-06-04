Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88DF7215EA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 11:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjFDJxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 05:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFDJxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 05:53:12 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF99EDB;
        Sun,  4 Jun 2023 02:53:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5147f4bbfdaso5047381a12.0;
        Sun, 04 Jun 2023 02:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685872390; x=1688464390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iB2FRr+iV4uFJJk72mDgzFzP+Ys3k17GDqpjb9bxqMs=;
        b=nUd4cQ8v6H3eScmxHQqV++PApfZ3+7ucw1+5vtk9QnrwE/h3oDbr631cGvfsX6tE8X
         e5oAanHdF0IHE70lbzXe/qWD8hz5I5M5AJBULo10fDGyrXbBCkJipu9QlKQ2+BzdWmhU
         cS7vvRuk0Amv1fxl3AD5mIt4H9VewDstKSGg4MuHb4Ni7Oovn2EtrPNudIwdMvPQ3XfK
         rCoewAV02ufHx9id+DWo6oNGlyabQ1TTdPgprqq4mjKQo43sADuyoNi3P3gXQP112S+F
         ARBmyUwsfobuUKW+sIJ2wfG6a/GazprJy615u2ek4tXaTxh3zIE9SbdBK1anq2KLqzo1
         qLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685872390; x=1688464390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iB2FRr+iV4uFJJk72mDgzFzP+Ys3k17GDqpjb9bxqMs=;
        b=ihLT/93XVtxI3XoGFPRgCswTzvDaYHIKFdybF1LxTzcBJrqa1QAdzwsJM3uyMi3UaH
         JXT//YSO7g2XlM9BUk2saataNWl/apD1A1TqQHq+nj4vVQIXdIUcPZY8hYfniu8TRRaJ
         4ClZdn6pV7jtFeCMzvOjJ5bw4ZSMX3vgyFUZcjGV2RBhCdBc3Gn013xv0zsGj7IpLxes
         kQNwhgGd9yU36yUJ0WqsBXO9h/AZp/JmKw9k8Dnf47kU+0v9/pYxrX9pR1/HHPvQ9S0j
         lTv2VvJ4Z2qJolrENcbeTPwigRBYInwBdbfacBXO/SFqfPjIcIuqnjsKXA4lraaSR1nC
         h53w==
X-Gm-Message-State: AC+VfDw+NMDi5aJgT9Cqw6A/L09SOhtMoHU+PXzC55d8R9Cm8OxlHSc7
        eEAiu5G6neo6ssxROGdiLo/w/RAOn2PPpHz7JmI=
X-Google-Smtp-Source: ACHHUZ58FUBQiGi5Ds9JmJwAS2B+xK7MFRStELAVOENnrCmJLi/I/KeBEk7KpaNp9+RPVda9PzvVF4wSqOMcfksQGlQ=
X-Received: by 2002:aa7:d657:0:b0:510:487a:ca3d with SMTP id
 v23-20020aa7d657000000b00510487aca3dmr5563421edr.23.1685872390104; Sun, 04
 Jun 2023 02:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230603143543.855276091@linuxfoundation.org> <ZHxNSQkgrZsyV6OT@debian>
In-Reply-To: <ZHxNSQkgrZsyV6OT@debian>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sun, 4 Jun 2023 10:52:34 +0100
Message-ID: <CADVatmOVpK4PvcEB89PU7qCXhGxqJ148AtAkyS6JoKv4QA6XDw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/35] 5.15.115-rc3 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2023 at 09:37, Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi Greg,
>
> On Sat, Jun 03, 2023 at 04:37:18PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.115 release.
> > There are 35 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>
> Build test (gcc version 12.2.1 20230511):
> mips: 62 configs -> no failure
> arm: 99 configs -> no failure
> arm64: 3 configs -> no failure
> x86_64: 4 configs -> no failure
> alpha allmodconfig -> no failure
> csky allmodconfig -> no failure
> powerpc allmodconfig -> no failure
> riscv allmodconfig -> no failure
> s390 allmodconfig -> no failure
> xtensa allmodconfig -> no failure
>
> Boot test:
> x86_64: Booted on my test laptop. No regression.
> x86_64: Booted on qemu. No regression. [1]
> arm64: Booted on rpi4b (4GB model). No regression. [2]

mips: Booted on ci20. No regression.
https://openqa.qa.codethink.co.uk/tests/3695

-- 
Regards
Sudip
