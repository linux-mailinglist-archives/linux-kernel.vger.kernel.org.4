Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143197147CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjE2KRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjE2KR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:17:29 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B747B5
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:17:27 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-437e4f09268so1700598137.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685355446; x=1687947446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+eJAGxWuNUIuVdQXR76skZ0f3FejWcmcpyIG+4gmoE=;
        b=d+JtPt+wPhonwADhMUpEfM2aGSMwq8eu3H9VFMSPE6nHkZS7XQQibxNj77M7alCg1K
         AfQpSiyJqVNYeSOAGHDN3Yt8laHgmjaa4r6ZIQDqcnCr85Lc+sV4NrYG51KjS4aI4mtT
         mrcT2EzEsO4vu+fuBaw8vThuJiouoQjanUAC2wPi6V4JoBiW09PMV67eH8oOYwJxYRka
         oPqBAzBH+nPiNn5EiNbfQGyvCpH5H26IOeEUjPfuMQB6oiUgme+6NjEOR6mxbQAIIAWI
         hWnOqjjEgwaNlsHIFNO9lPpDOUZZdVc5LOGPYdSWnUATj01ZqGDaksis5jossVKk/zWp
         FVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685355446; x=1687947446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+eJAGxWuNUIuVdQXR76skZ0f3FejWcmcpyIG+4gmoE=;
        b=ks/jw0M1k3XWO+nDRwW9tL4Wa+U6usFT821MrO54C49WLjLqxJkKOVliHx+RiBmVCJ
         +37+lvXJBwX/LqY8+D2fkDNRnPPsgQs+weOBvt7K4cTaekmTe71LU+xzuac+gdA5s3HY
         TRiy/5EWSD/KQXiYfRwmEosxrPlSa7bbO0iEvAKfAI9A6vMvV67TMdQWDzVO0BbHMHlA
         MHWVrovUj4CdBCzcB57c2KE27QFQ5aJg+CFg4wsd5MLA640Tq0VcPlkhMtxkEInsZRmy
         v1gClUEyymIf23f5UkiWIYHRxlNVGrGqIzgLYONgoij9/wzrTBoikppmrloM47YobuZ4
         UrLQ==
X-Gm-Message-State: AC+VfDyJP1QYsIheTCwFjMTYbNSvrBQAZkZpitBEiI1h9Ba08/mBE3wq
        0ev9nUBzGN6LUgopsr099wYK7ewcYwf2WOtfQZLqOsZmhWHIxhOP6zk=
X-Google-Smtp-Source: ACHHUZ5iWwhNOGPTY/KVmj4cq7yD8SnWBPLbxXRI2I2InvQwpm6oRwG7L9/FPUaN7M25xnOp8M0RmLaGiSNKqPn0l8Y=
X-Received: by 2002:a67:fb48:0:b0:439:4284:3f74 with SMTP id
 e8-20020a67fb48000000b0043942843f74mr3282257vsr.16.1685355446555; Mon, 29 May
 2023 03:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230517143311.585080-1-sumit.garg@linaro.org>
 <CAN5uoS9h6OmO-SZWmBdRUkT+ih9QK+mTo8Kvmn3ePQ4NrKriBw@mail.gmail.com>
 <CAFA6WYPCOqsyedjP-ffAQiyX3manDV+oE3akFpeuRZukro_dRg@mail.gmail.com>
 <PAXPR10MB468715EB2B1DFE080F380266FD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
 <CAHUa44FDs-cukERVwev88i855Y-ZaAkLUt=bVxah=GdW+JKVLQ@mail.gmail.com>
 <PAXPR10MB46872AD9A798A1B7DAF4721DFD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
 <CAFA6WYOFaSHHRhNbeuwjLMtCRhGt4edMyeSD1841E3xzS-ETag@mail.gmail.com> <CAHUa44FCEs6dBG_WJApJkDKKUY+rS+EJM1s_ouCDazbb7vURxg@mail.gmail.com>
In-Reply-To: <CAHUa44FCEs6dBG_WJApJkDKKUY+rS+EJM1s_ouCDazbb7vURxg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 29 May 2023 15:47:15 +0530
Message-ID: <CAFA6WYMm43GRGFvWv-5dLiRzfeZyFbDMZewoE0ZU93Wsk6EFpQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] tee: optee: support tracking system threads
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Etienne CARRIERE <etienne.carriere@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 at 15:10, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Mon, May 29, 2023 at 9:11=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Fri, 26 May 2023 at 01:05, Etienne CARRIERE <etienne.carriere@st.com=
> wrote:
> > >
> > >
> > > > De: Jens Wiklander <jens.wiklander@linaro.org>
> > > > Envoy=C3=A9 : jeudi 25 mai 2023 17:20
> > > >
> > > > Hi,
> > > >
> > > > On Thu, May 25, 2023 at 1:48=E2=80=AFPM Etienne CARRIERE
> > > > <etienne.carriere@st.com> wrote:>
> > > > >
> > > > > >
> > > > > > De : Sumit Garg <sumit.garg@linaro.org>
> > > > > > Envoy=C3=A9 : mercredi 24 mai 2023 09:31
> > > > > > > On Tue, 23 May 2023 at 12:41, Etienne Carriere
> > > > > > <etienne.carriere@linaro.org> wrote:
> > > > > > > Hello Sumit,
> > > > > > >
> > > > > > >
> > > > > > > On Wed, 17 May 2023 at 16:33, Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > > > > > > >
> > > > > > > > From: Etienne Carriere <etienne.carriere@linaro.org>
> > > > > > > >
> > > > > > > > Adds support in the OP-TEE driver to keep track of reserved=
 system
> > > > > > > > threads. The optee_cq_*() functions are updated to handle t=
his if
> > > > > > > > enabled. The SMC ABI part of the driver enables this tracki=
ng, but the
> > > > > > > > FF-A ABI part does not.
> > > > > > > >
> > > > > > > > The logic allows atleast 1 OP-TEE thread can be reserved to=
 TEE system
> > > > > > > > sessions. For sake of simplicity, initialization of call qu=
eue
> > > > > > > > management is factorized into new helper function optee_cq_=
init().
> > > > > > > >
> > > > > > > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.or=
g>
> > > > > > > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Disclaimer: Compile tested only
> > > > > > > >
> > > > > > > > Hi Etienne,
> > > > > > > >
> > > > > > > > Overall the idea we agreed upon was okay but the implementa=
tion looked
> > > > > > > > complex to me. So I thought it would be harder to explain t=
hat via
> > > > > > > > review and I decided myself to give a try at simplification=
. I would
> > > > > > > > like you to test it if this still addresses the SCMI deadlo=
ck problem or
> > > > > > > > not. Also, feel free to include this in your patchset if al=
l goes fine
> > > > > > > > wrt testing.
> > > > > > >
> > > > > > > With these changes, there is no more a specific waiting list =
for TEE
> > > > > > > system threads hence when a waiting queue can complete, we'll=
 pick any
> > > > > > > TEE thread, not a TEE system thread first..
> > > > > >
> > > > > > I had thought about this but I can't see any value in having a
> > > > > > separate wait queue for system threads. Here we only need to pr=
ovide
> > > > > > an extra privileged thread for system sessions (kernel clients)=
 such
> > > > > > that user-space doesn't contend for that thread. This prevents =
kernel
> > > > > > client's starvation or deadlock like in the SCMI case.
> > > > > >
> > > > > > > Also, as stated in a below answer, these change unconditional=
ly
> > > > > > > reserve a TEE thread for TEE system calls even if no TEE clie=
nt
> > > > > > > reserved such.
> > > > > >
> > > > > > I don't think we should make thread reservations based on the p=
resence
> > > > > > of TEE clients. You never know how much user-space or kernel TE=
E
> > > > > > clients you are dealing with. And reserving a single privileged=
 thread
> > > > > > unconditionally for system sessions shouldn't be much of a burd=
en for
> > > > > > memory constrained devices too.
> > > > > >
> > > > > > Also, this way we would enable every kernel TEE client to lever=
age
> > > > > > system sessions as it's very likely they wouldn't like to compe=
te with
> > > > > > user-space for thread availability. Two other kernel TEE client=
s that
> > > > > > are on top of my head are HWRNG and Trusted Keys which can bene=
fit
> > > > > > from this feature.
> > > > >
> > > > > Trusted Keys is an interesting use case. When OP-TEE accesses Tru=
sted Keys,
> > > > > it may need to access the eMMC/RPMB using the Linux OS tee-suppli=
cant
> > > > >  whichj may repuire an eMMC clock or voltage regulator to be enab=
led.
> > > > > If that clock or regulator is under an SCMI control, then we need=
 2
> > > > > reserved TEE thread: one for invoking the Trusted Key TA and
> > > > > another for the SCMI request to reach the TEE will the Trusted Ke=
y
> > > > > TA invocation still consumes a thread.
> >
> > Trusked keys TA doesn't need access to secure storage (eMMC/RPMB). It
> > only requires a RNG and access to a key derived from HUK.
>
> Because it's always compiled as an early TA so no rollback protection is =
used?
>

Yeah it has to be compiled as an early TA to support Trusted Keys
use-cases. BTW, we don't have enumeration support for REE-FS TAs at
the moment.

> >
> > > > >
> > > > Why would the Trusted Keys session need a system thread? To me, it
> > > > seems that the session could use the normal client priority.
> >
> > The system thread priority as per my patch is nothing but an extra
> > thread available in the thread pool for kernel clients as compared to
> > user-space clients.
> >
> > Trusted keys use-case was really motivated by: "every kernel TEE
> > client would like to avoid competing with user-space for thread
> > availability". However, HWRNG has a real case that user-space
> > shouldn't starve kernel RNG thread for OP-TEE thread availability.
> >
> > System thread can be useful for trusted keys in case the disk
> > encryption key is backed by a trusted key.
>
> With well-behaving TAs every TEE client will get its thread in due time.

We should try to keep distinction among user-space clients vs kernel
clients rather than keeping them in the same bucket. The kernel
clients are more privileged than user-space ones. This is similar
hardening as we have done with respect to session login method (REE
kernel login).

>
> The system thread feature was originally intended as a way of avoiding
> a deadlock.

That's true but doing so can also benefit other (mutual independent)
kernel clients as well.

> So far we have otherwise assigned threads on a first-come
> first-served basis. If we now also need a way of giving priority to
> kernel clients for less critical reasons we may need to take a step
> back and redesign because reserving a thread for each kernel client
> doesn't scale.

No, please have a relook at this patch. We have *only* reserved a
single thread for all the allowed (sess->use_sys_thread =3D true) kernel
clients to compete for. And user-space has access to all the other
threads on a first-come first-served basis except the one thread
reserved for kernel clients.

-Sumit

>
> Thanks,
> Jens
