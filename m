Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F78643D57
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiLFGxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbiLFGxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:53:02 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BB6C765
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 22:53:00 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id c140so17417052ybf.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 22:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nf/VegHe9+DqsAeyPteKwkpo+sm1WkuqI0IKT/1miE=;
        b=cYPDJXaDoeFowhUH4pRW6EN1R1ExMdSekmsCVfiJDlNC4/QXiNUQ9RYeysubclPBKu
         uSHg0e2noHIScncTRwd81FjDH1Y95yeuZEiHmcXT07Snk3pqnWC7uaHVbLgcbEbZNs5e
         SKOZixmdHzs2JvVmiqrl+lRCWQcm9XvQOvVTcfsRQOv9QCYRkr8rflXuhlB0OhdQXvUF
         3o8Udjlmx68Kn01WEWO3sAfUMLVU0IJm+YBx/F5ygCr/xkdLtpCAedrVDfJ35rj6OZn/
         LfDGjnMad/ni4Bb4m2WcguVHd3lYfdYjodrg8o4HwpFdEBhdOSviz5yshQPP9i7D5yd/
         RIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nf/VegHe9+DqsAeyPteKwkpo+sm1WkuqI0IKT/1miE=;
        b=k1Y4ryG6/WNwoiBpIbxf2oXpzTdoTpFxdblSG0dr9pA37BIWwYcEN9FzWcefnsQmyI
         4vfz+pzSyrL1OqS844xl8h7vciPXNt0n7hArYh1B0vrPYaWKSCPQFfF2oXZo/d4XPZTF
         vQcfy6/5mizbkX14aNect/l40cfoWb77mKTqnI6ywKHnhgUJj4mxBYafj0e1FzgkbKyA
         7luWlR3IjzzVzYI9DgkEA3Cb6wkzePxDxZ/dbk9MSNNyzosrOTQfV99umb9Uere8cRim
         78kPcTj5Rj54CVa/KG+m+h4O3JnF6ZuRAFEYCUvSj9yZdY5knBD36D0IlrqxZtcV2VrP
         DvIA==
X-Gm-Message-State: ANoB5pnRZugktwzsVF04eIil4t7Gs/X0TObYJl7MTzvGuNg5tMza0TnI
        ybwLIqj+Pw0i0UHhzraoonyWWK8OuK0TTp5K83w=
X-Google-Smtp-Source: AA0mqf6/NcEko6QjWT03tHSJ8MnBO2pFwcpGQpe+t5dgnqukYWx9FopEzIf67r5owPn8EjVKGLAm0H7eHm0TualXIx0=
X-Received: by 2002:a25:c0d7:0:b0:6f4:fad9:731a with SMTP id
 c206-20020a25c0d7000000b006f4fad9731amr41616099ybf.400.1670309579517; Mon, 05
 Dec 2022 22:52:59 -0800 (PST)
MIME-Version: 1.0
References: <20221111073154.784261-1-avagin@google.com> <202211181438.7D252CDC10@keescook>
 <CANaxB-zB_DuUrKuhDFAFVZVGphoVk=2PzF20-nJwJkx-xnbSfQ@mail.gmail.com>
In-Reply-To: <CANaxB-zB_DuUrKuhDFAFVZVGphoVk=2PzF20-nJwJkx-xnbSfQ@mail.gmail.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Mon, 5 Dec 2022 22:52:48 -0800
Message-ID: <CANaxB-x=QMiTMf6-RCy1Vs8gyU=idqeK419y=BMpfeQ1oHL4XA@mail.gmail.com>
Subject: Re: [PATCH 0/5 v3] seccomp: add the synchronous mode for seccomp_unotify
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Andrei Vagin <avagin@google.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kees Cook <keescook@chromium.org>
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

On Mon, Nov 21, 2022 at 11:52 PM Andrei Vagin <avagin@gmail.com> wrote:
>
> On Fri, Nov 18, 2022 at 2:38 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Nov 10, 2022 at 11:31:49PM -0800, Andrei Vagin wrote:
> > > From: Andrei Vagin <avagin@gmail.com>
> > >
> > > seccomp_unotify allows more privileged processes do actions on behalf
> > > of less privileged processes.
> > >
> > > In many cases, the workflow is fully synchronous. It means a target
> > > process triggers a system call and passes controls to a supervisor
> > > process that handles the system call and returns controls back to the
> > > target process. In this context, "synchronous" means that only one
> > > process is running and another one is waiting.
> > >
> > > The new WF_CURRENT_CPU flag advises the scheduler to move the wakee t=
o
> > > the current CPU. For such synchronous workflows, it makes context
> > > switches a few times faster.
> > >
> > > Right now, each interaction takes 12=E7=9B=9C. With this patch, it ta=
kes about
> > > 3=E7=9B=9C.
> > >
> > > v2: clean up the first patch and add the test.
> > > v3: update commit messages and a few fixes suggested by Kees Cook.
> >
> > Thanks for the update! If I can get Acks from the sched folks, I think
> > this looks good to take.
>
> Peter, Ingo, could you take a look at this series?

Friendly ping

>
> Thanks,
> Andrei
