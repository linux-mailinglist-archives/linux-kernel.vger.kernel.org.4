Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A45E6C6FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjCWSHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCWSHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:07:38 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7A2EC78
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:07:37 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-544f7c176easo264201917b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679594856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D74n7gh2e+yraGRRHuwIsY16XgTeKkTUvC50d4zORpo=;
        b=eYFC2WMp4wycqzmZ+KFoGjc33WDvdgzLq2458qsW7p9MfDn+RZahgcn1K1ZqfAuTi4
         3QGsVqv8NsLPTskBqBB43v2v6JJWajEIJCL6YkBTs9xC+1LQQY1YjGUmRwkd3psPYK8P
         zhHP9tWS+5YStH3s8k2YjeZkouNHhcZX8QARBE0Wg/oFIx5S6IDjwrYC7r13L6qDPrYr
         Q51EyOdYVtFmhxM/8AksLjgrSslIbrHR3ph7NmcwZOfbjD/cdGW3ZsMNGSguNB6RwSgM
         vXL2vcm5PS/obhyjvUNcPGRiu3MuKfvYju7QC48MFj+1n3ZZtXZ5I5SKntegBVYhDbyY
         qqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679594856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D74n7gh2e+yraGRRHuwIsY16XgTeKkTUvC50d4zORpo=;
        b=SkY8vauMBfJI3qcDpSXlQw/agjVh28+hP8dx2azoxguBtdvBouZv9jd31GNBLNlNZc
         3NvCJ2xIOaulf7RerhNYBv/BGTu/eCKZTCSFcRwtovpxiX6fHIKYv3+G2Es5uy4/icMR
         xwuxvNGqKj73vN4b4aocgGxrJeXVRzpGuQ6TG4ZLLAnvEYmFoQgs2pM8nTZlY0IAI3/D
         fIbU4CR17OJl5IbYI2KSyGaEZHosGKiK6qqbKYHeZZALCynMMlmZtdocH27n+wTdRlf4
         1IOQfhR2hLqHrnhBQTGw96QHRMNkwsd+vPmEkVKu99kdFx3kqZCsmxnGe0xSFsCxNDcT
         6d9w==
X-Gm-Message-State: AAQBX9fc8w33LqzCY3ntyRgerlxx6mOf3m/Z5+MKoBVV0Q8FLdacRUeD
        xqo9nmSXXv5iZ6+QqDqLnysuYKSObeSrPAFA33L4KQ==
X-Google-Smtp-Source: AKy350Z3rfj1sZgDPPKwtizx5xtZ1y5MNFjZi81s4k5EzTEK7PjU0Q8aPkkYh0TYZwedcyG/BVlor44vR0mmaXWilH4=
X-Received: by 2002:a81:ad57:0:b0:545:64d7:5086 with SMTP id
 l23-20020a81ad57000000b0054564d75086mr2380325ywk.1.1679594856179; Thu, 23 Mar
 2023 11:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230323103350.40569-1-cerasuolodomenico@gmail.com>
 <20230323103350.40569-4-cerasuolodomenico@gmail.com> <CAJuCfpFh0iL0cE8V3dh-HkDx3-20Kyo+ZAt0vnqvOzA33HwnFg@mail.gmail.com>
 <20230323174459.GH739026@cmpxchg.org>
In-Reply-To: <20230323174459.GH739026@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 23 Mar 2023 11:07:25 -0700
Message-ID: <CAJuCfpFxzYKRkLg2m_T5ee+y-XLyYM6OKPKPXSi3rN4Lrr194Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sched/psi: allow unprivileged polling of N*2s period
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        brauner@kernel.org, chris@chrisdown.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 10:45=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Thu, Mar 23, 2023 at 09:55:11AM -0700, Suren Baghdasaryan wrote:
> > On Thu, Mar 23, 2023 at 3:34=E2=80=AFAM Domenico Cerasuolo
> > > @@ -1254,16 +1262,19 @@ int psi_show(struct seq_file *m, struct psi_g=
roup *group, enum psi_res res)
> > >  }
> > >
> > >  struct psi_trigger *psi_trigger_create(struct psi_group *group,
> > > -                       char *buf, enum psi_res res)
> > > +                       char *buf, enum psi_res res, struct file *fil=
e)
> > >  {
> > >         struct psi_trigger *t;
> > >         enum psi_states state;
> > >         u32 threshold_us;
> > > +       bool privileged;
> > >         u32 window_us;
> > >
> > >         if (static_branch_likely(&psi_disabled))
> > >                 return ERR_PTR(-EOPNOTSUPP);
> > >
> > > +       privileged =3D cap_raised(file->f_cred->cap_effective, CAP_SY=
S_RESOURCE);
> >
> > I missed one detail here. We are moving the cap check from open() to
> > write(). That might break potential users which open the file from a
> > process with that cap and then pass that FD to an unprivileged process
> > to create the trigger by writing to that file. I'm not aware of any
> > use of such a pattern but it is possible there are such users.
> > With this change such users would have to delegate trigger creation to
> > the privileged process too and the received FD would be used only for
> > polling. IMHO that's a safer pattern because triggers are created by
> > the privileged process.
>
> Oh, it's checking file->f_cred, which is set up at open(). So if the
> opener is privileged, the write can be delegated to an unprivileged
> process.
>
> But I agree that this is subtle and could use a comment.
>
> This was a usecase specifically requested by Christian, actually.

Ah, great!
