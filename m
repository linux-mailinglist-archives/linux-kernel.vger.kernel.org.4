Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C058E6FECA6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbjEKHVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237642AbjEKHVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:21:33 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB0483E4
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:20:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50b8d2eed3dso12482468a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683789646; x=1686381646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ByB4pfwmcoAKbCvDGkyQJemL9axC2eU/XREfF3lNALk=;
        b=MYqS0oLF1GjGiAFTPneIwzHZuUTsuag2OjRnQESkyULiBknONhlDNixpHGbX1xXiyJ
         /MEZDeRBCys38+oqaXLzOqEQqyuugpzj2XvUpS5cONbIXUlkEIN+OcYkoaw2AC8U7Fbd
         BGAcoqNBUOMkb1K7QhDnrknL71aWTQ9TJMsb/oI9yCnpw9X1heWNnKS3ZRj8SmB9Ot2o
         vTr7RvoYet4XLb8Mnkqqf3s7h3GbmkDGtVj62c4hWT7EcCinxEZZ3ImhEWZ9re4MH3ck
         FAAfNfg8SsJJJY4J6mjhaPWDoScBxE9kYi9ltz9J7Kitb7Mgg8IkXbTlCW2Q37MRPt5L
         yZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683789646; x=1686381646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByB4pfwmcoAKbCvDGkyQJemL9axC2eU/XREfF3lNALk=;
        b=hklxGo62QcgfvUqq+ndLlxQHFk2nzZ3CetmHJsvDwxKsHKcRO1/b+j4sMXsMsZKi+/
         pm+aivgz2J6b1hUX4c8mWD7joPEp34lkX8lNqlCXhgH17DCsASz26TTBs/XzVFWZ9FPN
         hOHBkE02e00CoEERGx1CJ7U/hbdv95lSrIAzTWb/4+YJM1SGkp9yN9T2Wf9LlofBXYCa
         l1iinvV84XfSFajfAFfnmIbvwaO14pL3prkjZ0h3tZ0WlubcUUCeH0AW+JXLuCjnYwTn
         TWMTL379dNhivwQYTBh46e5orb3TGcBFg57Jd8Cmnqa2EOyTXuNOhcl0fA40s4p71F1E
         KGlg==
X-Gm-Message-State: AC+VfDwxVyWW70kYTaIas0TSuX576AvdR/bSF/D8WNlcjBr5X3pstJV5
        wqTOaVt/htYubgOc4R3ri6HBy2n3yHYGJCzDLK6xB90CH6xM0sII8Fk=
X-Google-Smtp-Source: ACHHUZ6BAv/T98/M2HPFY6Q8i2xZ59HY9UnMHKa3Ka6CGEmwap4G3Ygt1wXfKGKplb7aN8YKa87wXp2WIoWCg2CfLsk=
X-Received: by 2002:a17:907:6e9e:b0:931:ad32:79ed with SMTP id
 sh30-20020a1709076e9e00b00931ad3279edmr22168618ejc.12.1683789645988; Thu, 11
 May 2023 00:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230505173012.881083-1-etienne.carriere@linaro.org>
 <CAFA6WYMGw5Dh09BfZwmYtdWQOLGvft4DPuQt4mUByk55vQwjJg@mail.gmail.com>
 <CAN5uoS9QZCRiN=USbSNm1vz34vg_9+msT0NP9B3mCAx9evesYQ@mail.gmail.com> <CAFA6WYPL9MadOp1DYcMWcjD34wnwD+bRVtBmHS+hR=976HsopA@mail.gmail.com>
In-Reply-To: <CAFA6WYPL9MadOp1DYcMWcjD34wnwD+bRVtBmHS+hR=976HsopA@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 11 May 2023 09:20:35 +0200
Message-ID: <CAN5uoS_0pF=-9=gznYUOU9oWPKz8HkRb=6gTAumMv=Vey8qb0g@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] tee: optee: system call property
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 at 08:03, Sumit Garg <sumit.garg@linaro.org> wrote:
> (snip)
> > > >
> > > >  int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> > > > @@ -408,12 +412,15 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> > > >         struct optee_msg_arg *msg_arg;
> > > >         struct optee_session *sess;
> > > >         struct tee_shm *shm;
> > > > +       bool system_thread;
> > > >         u_int offs;
> > > >         int rc;
> > > >
> > > >         /* Check that the session is valid */
> > > >         mutex_lock(&ctxdata->mutex);
> > > >         sess = find_session(ctxdata, arg->session);
> > > > +       if (sess)
> > >
> > > This check is redundant if we move the assignment below...
> >
> > Here we change the sesssion attribute while the mutex is locked, in
> > case some equivalent call with that session is issued.
> > Below we return to caller once mutex is unlocked.
> > I think it is the safer behavior. What do you think?
>
> Aren't we only reading session attribute in order to capture value in
> a local variable: system_thread? I don't think that it would require a
> mutex.

optee_system_session() sets session::use_sys_thread with mutex locked
hence I think we should get the attribute with the mutex locked.
See "[PATCH v6 3/4] tee: optee: support tracking system threads".

Etienne

>
> -Sumit
>
> >
> > Best regards,
> > Etienne
> >
> > >
> > > > +               system_thread = sess->use_sys_thread;
> > > >         mutex_unlock(&ctxdata->mutex);
> > > >         if (!sess)
> > > >                 return -EINVAL;
> > >
> > > ...here as:
> > >            system_thread = sess->use_sys_thread;
> > > (snip)
