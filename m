Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354E26BA5A3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCODcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCODcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:32:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271CFB479
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:31:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k37so11675642wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678851117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3K7bYVcRRLpPV8fpY3rpueWArs0o2kU2/AdNJpK1ko=;
        b=cOEu5P/hwLHjlqVidN+tKJXVsEbyMgHEGhh8ltEDz/3VkqILP+s0v59UvSs9sK+gR6
         kxZfycgE45hMop12s442Zc33kDNccfuNFEj+2SsOAIoMJ29U3vYhHDIzFyeaN1WUSWN9
         6nkGDPoMSjnRDTbZp3z2i4l4s+bPhDwKcBBw4EBoBj9iMsESgIIi1gfOSpJpqoogFG6K
         +bsCxcgxj+UMkWikEu14reM0CcxuDgGUbQZwtFG2qrsTBnYAz9MDHjt6QFdupxkurHcb
         L4Ytg+11Tliv5D0ICoBZqznBwRFXmQVBAIhbH1QmJKp0WS1+7qZ7kJqg/AOGWxoiN9IM
         6Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678851117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3K7bYVcRRLpPV8fpY3rpueWArs0o2kU2/AdNJpK1ko=;
        b=dNFltPottvzr3RS7xtcJJ3LCmRcFrVUC9amLt0oYdwvPdHbARqqNm8AGgPk60tKHFW
         WcO6kM+qbrwK1qlpse3MzN3sg8UlFKehhIF8ipYrQHSbaGUccBVb1fWBmpXa8kQRtcBO
         ITQG3ztAxElxbBVULNYY0xk5R6sIenzjUw07bNraB1bPj44FYJzAfo62VtM5YTialgUC
         tmTqRsVO8z81M/YoqqcewrT81gc/U5d6SVPxajdzqXWtTQx4vjwpGtTXEBKnZ8x4JG26
         6QXKUFbmo6IROIH85IuWPD/QTt13J4SUIeAZ9WCaGs/c/52aiQwpisi+t+FYrkc7o5XL
         Cv0A==
X-Gm-Message-State: AO0yUKWvSlppiH3sTYFqJ+HL9IvnpOWHCjdx4wd1XecC4YXG+tWy/Aw3
        j6qBW2TU2wBYQa6Ul0XkvpTWHBsF0XuWZAyIuWNjRLEqfN8=
X-Google-Smtp-Source: AK7set/T35h/tf031R5686OL6NCAQ0FZAq/RRLVR47zXGIPZVpoQM9p2OR7kE2GLalnttfZU5prsS0VUpTa78MWPf5U=
X-Received: by 2002:a05:600c:35cd:b0:3eb:8ac:eeab with SMTP id
 r13-20020a05600c35cd00b003eb08aceeabmr4794543wmq.0.1678851117178; Tue, 14 Mar
 2023 20:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAJNi4rNSHf3N6KrBNcVXKo-wjSPmZa2xan9WPmrER8Ttir-MDA@mail.gmail.com>
 <CAJNi4rO6TiZFFKTcW3kGgha2Rc0nTsXRLyeqAyYrN3foLbExSQ@mail.gmail.com>
In-Reply-To: <CAJNi4rO6TiZFFKTcW3kGgha2Rc0nTsXRLyeqAyYrN3foLbExSQ@mail.gmail.com>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Wed, 15 Mar 2023 11:31:45 +0800
Message-ID: <CAJNi4rNyDWY5xrVr0qZADNTSjhTko=OXVUDRmvuDKWTNX-NU1w@mail.gmail.com>
Subject: Re: Question about select and poll system call
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, vlobanov@speakeasy.net,
        hch@lst.de, viro@zeniv.linux.org.uk, dipankar@in.ibm.com,
        akpm@osdl.org
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

Adding more people...

I did some homework and found that the FD_SETSIZE question seems
related with below 2 commits:
1. 4e6fd33b7560 ("enforce RLIMIT_NOFILE in poll()")
"POSIX states that poll() shall fail with EINVAL if nfds > OPEN_MAX.
In this context, POSIX is referring to sysconf(OPEN_MAX), which is the
value of current->signal->rlim[RLIMIT_NOFILE].rlim_cur in the linux
kernel...". IOW, the nfds suggested by POSIX is kind of configurable,
making sense for Linux kernel to link it with rlimit.
2. bbea9f69668a ("fdtable: Make fdarray and fdsets equal in size")
This commit uses the fdt->max_fds instead of FD_SETSIZE suggested by
POSIX, but gives no reason to do that.

Curiously I did some tests on Linux and macOS, the testing code snippet:

static int test(void)
{
    int err =3D 0;
    int nfds =3D FD_SETSIZE;
    fd_set rfds, wfds, efds;

    FD_ZERO(&rfds);
    FD_ZERO(&wfds);
    FD_ZERO(&efds);

    err =3D select(nfds + 1, &rfds, &wfds, &efds, NULL);
    if (err < 0)
        perror("select failed");
    return err;

}

The test results as:
Linux
~~~~
Blocked at select

macOS
~~~~~~
select failed: Invalid argument

Thanks!

On Tue, Mar 14, 2023 at 10:31=E2=80=AFAM richard clark
<richard.xnu.clark@gmail.com> wrote:
>
> Adding linux-arm-kernel@lists.infradead.org ... for more possible feedbac=
k:)
>
> On Tue, Mar 14, 2023 at 10:28=E2=80=AFAM richard clark
> <richard.xnu.clark@gmail.com> wrote:
> >
> > Hi, (Sorry, not find the maintainers for this subsystem, so to the lkml=
)
> >
> > There're two questions about these system calls:
> > 1. According to https://pubs.opengroup.org/onlinepubs/7908799/xsh/selec=
t.html:
> > ERRORS
> > [EINVAL]
> >       The nfds argument is less than 0 or greater than FD_SETSIZE.
> > But the current implementation in Linux like:
> >        if (nfds > FD_SETSIZE)
> >                nfds =3D FD_SETSIZE
> > What's the rationale behind this?
> >
> > 2. Can we unify the two different system calls? For example, using
> > poll(...) to implement the frontend select call(...), is there
> > something I'm missing for current implementation? The Cons and Pros,
> > etc
> >
> > Thanks,
