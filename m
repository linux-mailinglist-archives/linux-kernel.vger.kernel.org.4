Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C54740454
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjF0UKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjF0UKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:10:11 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880B926BC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:09:56 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-47193e20887so1774319e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687896595; x=1690488595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Utdr5WS5Dt1V8YNxQC325Hn+zaAMwRrEoQmcOclolZI=;
        b=RSwOPf8TqhHWqPvRvrK9VgmrCRph+6lxOR33UodUhRsjm3OJ6k7LRgb81/9koeq23I
         luLCdNl1DD9CodpSJOdT+UlbbPxweEKiczSGE8XfGfcebgmXS0GFDDyMfyEbjIGBN2zX
         k/VI72ZASyes1e4MZw/yt7RDKI0lAexKiL3hWBTrQ/FvkHnfbK1IgS2+jUjT3a8KqNJ8
         hWs7sFqA/+GtjzKdZSdv9xDQd9mNaANYP0SLOvXY0GW/uIo0m03zp4vmN9+sWlM91Swx
         kEiZOFPKTEf1iPvGUQbs5CyNMh2xRYBaHGDU4J7vF4HvGANfWNa2DvJaJ8Ju7VKoh6W9
         7HHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687896595; x=1690488595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Utdr5WS5Dt1V8YNxQC325Hn+zaAMwRrEoQmcOclolZI=;
        b=CZAHgJPl1xjibHy09OGg4NzX7pWjSOW53LnJZn/raxR7N9+Upo4iE3SVxM0ecc2qRv
         gS+T3AGstLZzDARSQrPwrKwND9o2x12lLneY6kuxB5ePIvD9BLkdmA6xyNPLhsSwa+Om
         MoYoBvRS4Kxce/1ySvfJyu7ipp87ARC4wINFwTdfN5AVpodbA4KKBWjHTgTrca0vRVuZ
         vA9ZSYEa1ZLeKcPndW239UshLgAZWChsYO1rr+BH6RmOCCrZmAPuV6FQZq0gfh/taAQ6
         /raNsEZsfDOT77PfCjC+upGn7tM5/2lPEfvO6qkvin0F3Ay4pLbeKQASqx1TzT3UPLq+
         arkA==
X-Gm-Message-State: AC+VfDyVkpyXurKrt674gNEfVTF6KjMTgZEEYGWKojBOUIjVuY5+vCMi
        PI5SEnh69uIwT3kL2INZ9T7/jNrjmQyJ/b9ke9eiMA==
X-Google-Smtp-Source: ACHHUZ61EwG4kf1d2mySo1wmyS8ZaF/ypIupw+0kiuX3vtzDaesyppfEG9Ng/QNscsBQLyer/8wL0paz76ro4KFLBh0=
X-Received: by 2002:a1f:d103:0:b0:471:5cb5:11f8 with SMTP id
 i3-20020a1fd103000000b004715cb511f8mr14606111vkg.15.1687896595343; Tue, 27
 Jun 2023 13:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230626201713.1204982-1-surenb@google.com> <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
 <20230627-kanon-hievt-bfdb583ddaa6@brauner> <CAJuCfpECKqYiekDK6Zw58w10n1T4Q3R+2nymfHX2ZGfQVDC3VQ@mail.gmail.com>
 <20230627-ausgaben-brauhaus-a33e292558d8@brauner> <ZJstlHU4Y3ZtiWJe@slm.duckdns.org>
In-Reply-To: <ZJstlHU4Y3ZtiWJe@slm.duckdns.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Jun 2023 13:09:44 -0700
Message-ID: <CAJuCfpFUrPGVSnZ9+CmMz31GjRNN+tNf6nUmiCgx0Cs5ygD64A@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
To:     Tejun Heo <tj@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, gregkh@linuxfoundation.org,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 11:42=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Christian.
>
> On Tue, Jun 27, 2023 at 07:30:26PM +0200, Christian Brauner wrote:
> ...
> > ->release() was added in
> >
> >     commit 0e67db2f9fe91937e798e3d7d22c50a8438187e1
> >     kernfs: add kernfs_ops->open/release() callbacks
> >
> >     Add ->open/release() methods to kernfs_ops.  ->open() is called whe=
n
> >     the file is opened and ->release() when the file is either released=
 or
> >     severed.  These callbacks can be used, for example, to manage
> >     persistent caching objects over multiple seq_file iterations.
> >
> >     Signed-off-by: Tejun Heo <tj@kernel.org>
> >     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >     Acked-by: Acked-by: Zefan Li <lizefan@huawei.com>
> >
> > which mentions "either releases or severed" which imho already points t=
o
> > separate methods.
>
> This is because kernfs has revoking operation which doesn't exist for oth=
er
> filesystems. Other filesystem implemenations can't just say "I'm done. By=
e!"
> and go away. Even if the underlying filesystem has completely failed, the
> code still has to remain attached and keep aborting operations.
>
> However, kernfs serves as the midlayer to a lot of device drivers and oth=
er
> internal subsystems and it'd be really inconvenient for each of them to h=
ave
> to implement "I want to go away but I gotta wait out this user who's hold=
ing
> onto my tuning knob file". So, kernfs exposes a revoke or severing semant=
ics
> something that's exposing interface through kernfs wants to stop doing so=
.
>
> If you look at it from file operation implementation POV, this seems exac=
tly
> like ->release. All open files are shutdown and there won't be any future
> operations. After all, revoke is forced closing of all fd's. So, for most
> users, treating severing just like ->release is the right thing to do.
>
> The PSI file which caused this is a special case because it attaches
> something to its kernfs file which outlives the severing operation bypass=
ing
> kernfs infra. A more complete way to fix this would be supporting the
> required behavior from kernfs side, so that the PSI file operates on kern=
fs
> interface which knows the severing event and detaches properly. That said=
,
> currently, this is very much an one-off.
>
> Suren, if you're interested, it might make sense to pipe poll through ker=
nfs
> properly so that it has its kernfs operation and kernfs can sever it. Tha=
t
> said, as this is a fix for something which is currently causing crashes,
> it'd be better to merge this simpler fix first no matter what.

I'm happy to implement the right fix if you go into more details.
AFAIKT kernfs_ops already has poll() operation, we are hooking
cgroup_file_poll() to it and using kernfs_generic_poll(). I thought
this is the right way to pipe poll through kernfs but if that's
incorrect, please let me know. I'm happy to fix that.
Thanks,
Suren.

>
> Thanks.

>
> --
> tejun
