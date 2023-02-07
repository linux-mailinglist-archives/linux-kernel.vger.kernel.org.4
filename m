Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5568CEE4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBGF1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBGF1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:27:43 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153004489
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 21:27:42 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i5so5253241wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 21:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pic1LJjyWpfcct/+zv0Lpg3rt8hI2DLNXSbKvivh93c=;
        b=nBAR0KjH/l2jjGcR9Xr1ro21SaZgBCarJ3rN4CtCCjKhhOeugF8ulgXTDxmRT2f+J6
         Nqwx+cPmPJZAwFnU80BRUDXsG4BQqc2gbEwAbYfrr3FKKkay1UPmQcnrZx3vbW86BINX
         fy2M+D1eprGv783ZlJSOj9yA+ZUMF9hwnaXDF0VgpF2RhDk1TZcvNnEov9/nV+9Wu8cK
         pGVKRuA9ESqzx+KqvQbpH2NmLQLuDL4LwpIY4hslMHAhP4geeVTq5P7C8wkU7vQ1vOB6
         b5W01RhWscT6VCpAB3BstdhfgatVEWxO7LpExyAzRRA7A3Ayv94T425r04jC2q7Yt9TA
         vzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pic1LJjyWpfcct/+zv0Lpg3rt8hI2DLNXSbKvivh93c=;
        b=gb3/BkxmZsK2qJtp5+AE1XZjoZdb20ZxVMuXDjO2ljrHj8nXBx7OMryUztiUI66TOd
         5kB85/RZHWeqooTmrxbvogiNy/2ga9otDlDKKHuGeQue8MbWpsJPIRz4aBkirMu0F7sv
         KSOmYjM5DVW+bRWjcMWmZ85NdIYmitXbGBU2QhmVudBFqiWMawGLOuwb97lJ/U9YtP6E
         qjL1Lv626RoUs1qg86qSin3NGg+r7RhuZ9k5D3HrUf2zOj5/S29gStTDmldwfqGxR05s
         GTgTHwPLxZ/BdVqE/fsjyJSkINKtVVuiPi2AKsjaMljw8n4Q2B7zw74HBusSaCEBVvLx
         5kuA==
X-Gm-Message-State: AO0yUKUA6moXbcqWpLc/5ViSmYCR0/4sxnMAh4lC1RvaO/sfr77wzC57
        gLG5JqrOGul+P4Ts03GkXzZfS8P58C2IZ8cecqKOukibRV9KrQ==
X-Google-Smtp-Source: AK7set9lQaGexiAgaewKZPShLQdX151xlXRI4LpyIUWlNBRZu/5KXeQ28JBNiCY5jw1nxP6ssLpbcGJ1Mki6x4ZRQ1c=
X-Received: by 2002:a5d:5272:0:b0:2c3:e046:57a8 with SMTP id
 l18-20020a5d5272000000b002c3e04657a8mr41876wrc.55.1675747660689; Mon, 06 Feb
 2023 21:27:40 -0800 (PST)
MIME-Version: 1.0
References: <20230127091051.1465278-1-jeeheng.sia@starfivetech.com>
 <20230127091051.1465278-5-jeeheng.sia@starfivetech.com> <Y9hTGo6dfgeusW4B@spud>
 <CAHVXubgoi8FsfdAXVocL=ZcfGT=mA72uiq60jPVJB52ovKhdzA@mail.gmail.com> <167319074e1644868e0e5461590f7ada@EXMBX066.cuchost.com>
In-Reply-To: <167319074e1644868e0e5461590f7ada@EXMBX066.cuchost.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 7 Feb 2023 06:27:29 +0100
Message-ID: <CAHVXubiW5grsq=nDto8HdiHiRXv3H_A2GtJ8+UL12nDvZj-NOg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 5:58 AM JeeHeng Sia <jeeheng.sia@starfivetech.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Sent: Tuesday, 31 January, 2023 6:00 PM
> > To: Conor Dooley <conor@kernel.org>
> > Cc: JeeHeng Sia <jeeheng.sia@starfivetech.com>; paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-
> > riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo
> > <mason.huo@starfivetech.com>
> > Subject: Re: [PATCH v3 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> >
> > Hi,
> >
> > On Tue, Jan 31, 2023 at 12:30 AM Conor Dooley <conor@kernel.org> wrote:
> > >
> > > +CC Alex
> > >
> > > Alex, could you take a look at the page table bits here when you get a
> > > chance please?
> >
> > Yes, I'll do that soon.
> Hi Alex, do you have any comment? I shall send out the v4 soon and you can provide comment to the v4 series?

I'll do that today!

> >
> > Thanks,
> >
> > Alex
> >
> > >
