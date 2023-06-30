Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557CB7438C8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjF3J6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjF3J5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:57:54 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307452122;
        Fri, 30 Jun 2023 02:57:53 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f866383b25so13665161cf.2;
        Fri, 30 Jun 2023 02:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688119072; x=1690711072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WA7mtLgIygm3ucDU5ekjivQLE+ppz92A/1OX3gRjkFs=;
        b=d93NApBhSsz7hP3XpuBEREcPdvWGoKSnCnSyWKyLdoGKe04Pr+J4hsFHlYwWz7m6qm
         ba0eH+TxlQpVSTkXlGfzDEEvCWmtyAdpBdQfKD45PEhnrCJBpX+dLYj7PCv/jCjaFUBB
         gTGnFG7XooNjV0wODky1VgrwajTHb0F3y7TuJvurJqBaP8VU9H0+dRkqHj07GMFzYF7I
         HMQwPwyYMkecYMiJkmK2fumGdFaoaiZfBxGQ5PhijmWejNOXmzE+kozDOy7J1mDlGvlY
         THbJz4tPCGm75yg6klc6hem36N03dXXIRPWjcMlGr78XsVZYBizoltTU3T225GJgRLuz
         UgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688119072; x=1690711072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WA7mtLgIygm3ucDU5ekjivQLE+ppz92A/1OX3gRjkFs=;
        b=Ktr1yhbwAsr66Deu46WGaKtDq7e0n3fgLNHnEkJG7EkNMGnE8neRrvyRD9/0WE6pQu
         d2rdLiShZ2XPnw2osY3ErpvOOmtVPfkXvWh+8ZcNwMPgmtD9iMKJnyb71O/9fMbvYnkU
         CROcbaVjqtt27NHa5pjKt82FIAqZXJYRVMM+CqtLFwVFnG50hXubZi8YDB+uy0yKo4Ux
         92uNckoLSbjYs2mF9GpLI3PzBm886itEH8AbAkdJmcw1nv2a/MyFhlIULFhwPiI9mgm7
         HRC8lWNUCv94h6JAGtsr1co2azZvYQv7aACCBE6k2jBtNNLuAj9HZ+14IKdEBEd5sA+N
         0Lcg==
X-Gm-Message-State: AC+VfDweYY3FHFnsqMeAZxSNCpbEfvlG5UkG/IfPZq04jz60aSMd3W4b
        9Jp7YCXKPTPareafOIAmrunry0yqV1E8M7PsiaTAFOYpI3U=
X-Google-Smtp-Source: ACHHUZ4NHJgnBZmZeqlqlhPH+B1chiHNOZBjHF0XSWKgOVywGVOHYzZFcvARZ6ZY25Fsm4TTYmqpDo6q3Ty0O4QII50=
X-Received: by 2002:ac8:5f4f:0:b0:3ff:2179:c48d with SMTP id
 y15-20020ac85f4f000000b003ff2179c48dmr2325757qta.28.1688119072209; Fri, 30
 Jun 2023 02:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230628121811.338655-1-tz.stoyanov@gmail.com>
 <20230628084428.7bb32d65@rorschach.local.home> <CAPpZLN6dCMzHyUhjSN3+9Um+-mS2TJiDPObUeO8NxyqpQS3k=g@mail.gmail.com>
 <20230630033330.20a503fa@rorschach.local.home>
In-Reply-To: <20230630033330.20a503fa@rorschach.local.home>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Fri, 30 Jun 2023 12:57:36 +0300
Message-ID: <CAPpZLN50yfT7rZxfP6T2g3asE6b8YkAERJHt3UuJ2bh4FAjDCQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/trace: Fix cleanup logic of enable_trace_eprobe
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, dan.carpenter@linaro.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Jun 30, 2023 at 10:33=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 29 Jun 2023 17:31:24 +0300
> Tzvetomir Stoyanov <tz.stoyanov@gmail.com> wrote:
>
> > On Wed, Jun 28, 2023 at 3:44=E2=80=AFPM Steven Rostedt <rostedt@goodmis=
.org> wrote:
> > >
> > > On Wed, 28 Jun 2023 15:18:11 +0300
> > > "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com> wrote:
> >> > > --- a/kernel/trace/trace_eprobe.c
> > > > +++ b/kernel/trace/trace_eprobe.c
> > > > @@ -702,8 +702,12 @@ static int enable_trace_eprobe(struct trace_ev=
ent_call *call,
> > > >
> > > >       if (ret) {
> > > >               /* Failed to enable one of them. Roll back all */
> > > > -             if (enabled)
> > > > -                     disable_eprobe(ep, file->tr);
> > > > +             if (enabled) {
> > >
> > > If one was enabled and the second one failed, that should only happen
> > > if there's a bug in the kernel (unless the failure was due to a memor=
y
> > > problem).
> > >
> > > I wonder if we should add:
> > >
> > >                         int cnt =3D 0;
> > >
> > > > +                     list_for_each_entry(pos, trace_probe_probe_li=
st(tp), list) {
> > >
> > >                                 /*
> > >                                  * It's a bug if one failed for somet=
hing other than memory
> > >                                  * not being available but another ep=
robe succeeded.
> > >                                  */
> > >                                 WARN_ON_ONCE(cnt++ && ret !=3D -ENOME=
M);
> >
> > That makes sense, I can send v2 with it. What is the idea of this cnt
> > counter, why not just:
> >                                  WARN_ON_ONCE(ret !=3D -ENOMEM);
> > outside of the loop? If enabled is true and ret is not ENOMEM, the bug
> > is already there.
>
> Failing for something other than ENOMEM should not cause a warning by
> itself. The idea is, if one fails for something other than ENOMEM, they
> all should fail with the same error. That is, they all should succeed
> or they all should fail.
>
> Actually, the above isn't right. The counter should be in the original
> loop, and if one or more succeeds to enable, but another fails due to
> some other error, that needs to be looked at, hence the warning.
>
> Does that make sense?

Yes, it makes sense. But the original loop will break on the first
failure.  If there is an error (ret is not 0) and at least one eprobe
was enabled successfully (enabled is true),
the warning should be emitted, only if that error is not ENOMEM:
                                  WARN_ON_ONCE(ret !=3D -ENOMEM);


>
> -- Steve
>
> > >
> > >
> > > > +                             ep =3D container_of(pos, struct trace=
_eprobe, tp);
> > > > +                             disable_eprobe(ep, file->tr);
> > > > +                     }
> > > > +             }
> > > >               if (file)
> > > >                       trace_probe_remove_file(tp, file);
> > > >               else
> > >
> >
> >
>


--=20
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
