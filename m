Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FE46FED09
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbjEKHjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237409AbjEKHjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:39:43 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B601F10EB
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:39:40 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-44fdac26696so2618547e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683790780; x=1686382780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JPIfdZXpQclo2XOVCzhBUsw2JR/pG+gLtlBy53C+n8M=;
        b=MmDiIH1cRCp5UdGpVzWlYl8NC2m8NByJ7QAYLF+3G33PcKcr36fIxB/q7Xy9tlxqXM
         3U07Ytioo2gK4N7F4soZe3UeUarAlweUjoRskLpalbaH1dprd7s0T4b6nH+KJPdB6KLK
         3qb4/sfLbDPPMJ/LQwrbOhc7MZ0iRaOzyzw0tdt9yWEjB0pSYSiiXRIx61Lzvn44jEfK
         YHFsjcclhjbRlIdOuF62ak2MH45nawvlDWoBY8AwOOSGPmdRCtur18eJTaYBEyy4L5yZ
         LHSAoKYJ9AVHil/RHpJgQM9hSoRdyOzjGWv2lBcy1bALNFrlqnjKekvHZJn27KoXn9T1
         xP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683790780; x=1686382780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPIfdZXpQclo2XOVCzhBUsw2JR/pG+gLtlBy53C+n8M=;
        b=SirqxOtCIOgI9CGNAVGjQX6hVKS6VHkpv5pZCiTf9tD2ZPXt5Rm6k3uO8Lj1buPCLa
         jspy9yOOUvtbAXS8ISbtFWXWoylXou9l94M+uCb/gS4qEnwA6KMWN63DeuwzAvovH3v9
         b7iyW2FGpSxkjItBIqI3pKEeOTKGGRQr8dKwwJLKbfCbfpUlFN0x5n68lA8jfmQziRuh
         vK69yc1FgzVJ039usM/7onpxpP/C5/cGfA55EDxB8jmTNSEu3vHMwgVZWgpx7F1o+/M8
         e2TbQZ4LDL3pJlJaqkVOP7SSz7kvAV17Hh44Sh87KXT7kOGgWtaRCio7n0QEdV1OlwZs
         utdQ==
X-Gm-Message-State: AC+VfDzP2UTZ3xk1nibiDHwBbja6PwAJD8afsyCsmcd/T5+YCTEuwg2P
        Rij4QyLKmNdCCMXVkjg0iwEXPe9Cpzp5xPgOAr4V0Q==
X-Google-Smtp-Source: ACHHUZ5mO4TUw+8huugyRdeOBEQkw2CkR0y6yhHL3jbqqG8NKIq7PZrbNSEe+bqShRtnctkT/jAsFlG/55WhAKfO+go=
X-Received: by 2002:a1f:60d8:0:b0:43f:b31b:f1d1 with SMTP id
 u207-20020a1f60d8000000b0043fb31bf1d1mr6077121vkb.13.1683790779805; Thu, 11
 May 2023 00:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230505173012.881083-1-etienne.carriere@linaro.org>
 <CAFA6WYMGw5Dh09BfZwmYtdWQOLGvft4DPuQt4mUByk55vQwjJg@mail.gmail.com>
 <CAN5uoS9QZCRiN=USbSNm1vz34vg_9+msT0NP9B3mCAx9evesYQ@mail.gmail.com>
 <CAFA6WYPL9MadOp1DYcMWcjD34wnwD+bRVtBmHS+hR=976HsopA@mail.gmail.com> <CAN5uoS_0pF=-9=gznYUOU9oWPKz8HkRb=6gTAumMv=Vey8qb0g@mail.gmail.com>
In-Reply-To: <CAN5uoS_0pF=-9=gznYUOU9oWPKz8HkRb=6gTAumMv=Vey8qb0g@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 11 May 2023 13:09:28 +0530
Message-ID: <CAFA6WYNf0xk0QVKyJvRKx1cisLtbjkG_FTDQ47Q_FPAAu3WFHg@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] tee: optee: system call property
To:     Etienne Carriere <etienne.carriere@linaro.org>
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

On Thu, 11 May 2023 at 12:50, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> On Thu, 11 May 2023 at 08:03, Sumit Garg <sumit.garg@linaro.org> wrote:
> > (snip)
> > > > >
> > > > >  int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> > > > > @@ -408,12 +412,15 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> > > > >         struct optee_msg_arg *msg_arg;
> > > > >         struct optee_session *sess;
> > > > >         struct tee_shm *shm;
> > > > > +       bool system_thread;
> > > > >         u_int offs;
> > > > >         int rc;
> > > > >
> > > > >         /* Check that the session is valid */
> > > > >         mutex_lock(&ctxdata->mutex);
> > > > >         sess = find_session(ctxdata, arg->session);
> > > > > +       if (sess)
> > > >
> > > > This check is redundant if we move the assignment below...
> > >
> > > Here we change the sesssion attribute while the mutex is locked, in
> > > case some equivalent call with that session is issued.
> > > Below we return to caller once mutex is unlocked.
> > > I think it is the safer behavior. What do you think?
> >
> > Aren't we only reading session attribute in order to capture value in
> > a local variable: system_thread? I don't think that it would require a
> > mutex.
>
> optee_system_session() sets session::use_sys_thread with mutex locked
> hence I think we should get the attribute with the mutex locked.
> See "[PATCH v6 3/4] tee: optee: support tracking system threads".
>

Okay I see your point. Although I don't see a practical race between
optee_invoke_func() vs optee_system_session(), you never know what
complex kernel TEE client use-case comes up. So I can live with it
being protected by a mutex.

-Sumit

> Etienne
>
> >
> > -Sumit
> >
> > >
> > > Best regards,
> > > Etienne
> > >
> > > >
> > > > > +               system_thread = sess->use_sys_thread;
> > > > >         mutex_unlock(&ctxdata->mutex);
> > > > >         if (!sess)
> > > > >                 return -EINVAL;
> > > >
> > > > ...here as:
> > > >            system_thread = sess->use_sys_thread;
> > > > (snip)
