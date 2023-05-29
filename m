Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25740714544
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjE2HLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjE2HLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:11:30 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F6CA3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:11:28 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-786efb5ffa8so514155241.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685344288; x=1687936288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VIPgBItugg4n8+/DVI4i5wWvIxKuIY8gx2aSmo5OI8=;
        b=NhuDMIV4CzkB5TZoj+zpREJy0Jjp228iNsIC5t71Pobq9pYknAqGcLpT+RkjzCVHCS
         GG5e71NgiZ3M4hIzVL9eobgCFFQDG5q0w9CezCCo8oalRtvECpyfw5jo7yvlNbwZGcgL
         piox/dUCtcrqXrWdZ3PVFkwP/hBe/lJUbwdN592qQ60GAwakB1SVbn70VEx1/E5rC9sM
         iRACk1NqvErcnlHZA8E7ycF6W2mr9U+0WWARqhdmOXTGQ96+8f8ehQXqxkUFHNF0kOIY
         HCYnq5GR4T8xrAtNEWmgVQKfL72EkUQXaR2/D/H1YnanCyfz5tNLuaK09WESOglluZh7
         Uy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685344288; x=1687936288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VIPgBItugg4n8+/DVI4i5wWvIxKuIY8gx2aSmo5OI8=;
        b=Q06CAyayPwCGD73TAt6ActkIbJJzjIs9wPytNIpSJJbqVjDQ9J7grTL01vJxfSxA6x
         HwvDqyirsI2vx0H/sQ6XVUXKpdHjagIWGBpo15VMXyOQQQLUhCpAQQiKaxL1lhCEXK7J
         E37s44g4deOmNuAahpFc+tlDON9cD5XH2UP50FanpQs2uGKMO7cUW4+OtPCuMs19CJKL
         5jTA5E4RoYLkg9rnB40F1Skgf5YRRMEp1jN1BS0GmNtrfAVcFGEznVHJWC0Ru7vuO1TC
         N9fllX09QqSx80IuDj+4KgRpivtfT56/9z9XFBJymDsxLzIQ7mT2fJXR6hqw9W/Pb9XK
         SYYA==
X-Gm-Message-State: AC+VfDzYakisYfo5TO2DlHc1QhO7h0XL9rp32IcYuzgqDJBTaucr0uzu
        pJvwLmmBhbuhPvLLAdhIK8I0tUezPteSDvPIF8o5zw==
X-Google-Smtp-Source: ACHHUZ6UVA0h7xXFQG5gOcgMwDOEFrKiHeXNI98sDyTpHEyrpriq468L8JGu702BpaRvVreB3ffW11mcxFXFm6weGRQ=
X-Received: by 2002:a67:eb88:0:b0:439:e3f:9d6 with SMTP id e8-20020a67eb88000000b004390e3f09d6mr2481461vso.17.1685344288029;
 Mon, 29 May 2023 00:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230517143311.585080-1-sumit.garg@linaro.org>
 <CAN5uoS9h6OmO-SZWmBdRUkT+ih9QK+mTo8Kvmn3ePQ4NrKriBw@mail.gmail.com>
 <CAFA6WYPCOqsyedjP-ffAQiyX3manDV+oE3akFpeuRZukro_dRg@mail.gmail.com>
 <PAXPR10MB468715EB2B1DFE080F380266FD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
 <CAHUa44FDs-cukERVwev88i855Y-ZaAkLUt=bVxah=GdW+JKVLQ@mail.gmail.com> <PAXPR10MB46872AD9A798A1B7DAF4721DFD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <PAXPR10MB46872AD9A798A1B7DAF4721DFD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 29 May 2023 12:41:17 +0530
Message-ID: <CAFA6WYOFaSHHRhNbeuwjLMtCRhGt4edMyeSD1841E3xzS-ETag@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] tee: optee: support tracking system threads
To:     Etienne CARRIERE <etienne.carriere@st.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Fri, 26 May 2023 at 01:05, Etienne CARRIERE <etienne.carriere@st.com> wr=
ote:
>
>
> > De: Jens Wiklander <jens.wiklander@linaro.org>
> > Envoy=C3=A9 : jeudi 25 mai 2023 17:20
> >
> > Hi,
> >
> > On Thu, May 25, 2023 at 1:48=E2=80=AFPM Etienne CARRIERE
> > <etienne.carriere@st.com> wrote:>
> > >
> > > >
> > > > De : Sumit Garg <sumit.garg@linaro.org>
> > > > Envoy=C3=A9 : mercredi 24 mai 2023 09:31
> > > > > On Tue, 23 May 2023 at 12:41, Etienne Carriere
> > > > <etienne.carriere@linaro.org> wrote:
> > > > > Hello Sumit,
> > > > >
> > > > >
> > > > > On Wed, 17 May 2023 at 16:33, Sumit Garg <sumit.garg@linaro.org> =
wrote:
> > > > > >
> > > > > > From: Etienne Carriere <etienne.carriere@linaro.org>
> > > > > >
> > > > > > Adds support in the OP-TEE driver to keep track of reserved sys=
tem
> > > > > > threads. The optee_cq_*() functions are updated to handle this =
if
> > > > > > enabled. The SMC ABI part of the driver enables this tracking, =
but the
> > > > > > FF-A ABI part does not.
> > > > > >
> > > > > > The logic allows atleast 1 OP-TEE thread can be reserved to TEE=
 system
> > > > > > sessions. For sake of simplicity, initialization of call queue
> > > > > > management is factorized into new helper function optee_cq_init=
().
> > > > > >
> > > > > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > > > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > ---
> > > > > >
> > > > > > Disclaimer: Compile tested only
> > > > > >
> > > > > > Hi Etienne,
> > > > > >
> > > > > > Overall the idea we agreed upon was okay but the implementation=
 looked
> > > > > > complex to me. So I thought it would be harder to explain that =
via
> > > > > > review and I decided myself to give a try at simplification. I =
would
> > > > > > like you to test it if this still addresses the SCMI deadlock p=
roblem or
> > > > > > not. Also, feel free to include this in your patchset if all go=
es fine
> > > > > > wrt testing.
> > > > >
> > > > > With these changes, there is no more a specific waiting list for =
TEE
> > > > > system threads hence when a waiting queue can complete, we'll pic=
k any
> > > > > TEE thread, not a TEE system thread first..
> > > >
> > > > I had thought about this but I can't see any value in having a
> > > > separate wait queue for system threads. Here we only need to provid=
e
> > > > an extra privileged thread for system sessions (kernel clients) suc=
h
> > > > that user-space doesn't contend for that thread. This prevents kern=
el
> > > > client's starvation or deadlock like in the SCMI case.
> > > >
> > > > > Also, as stated in a below answer, these change unconditionally
> > > > > reserve a TEE thread for TEE system calls even if no TEE client
> > > > > reserved such.
> > > >
> > > > I don't think we should make thread reservations based on the prese=
nce
> > > > of TEE clients. You never know how much user-space or kernel TEE
> > > > clients you are dealing with. And reserving a single privileged thr=
ead
> > > > unconditionally for system sessions shouldn't be much of a burden f=
or
> > > > memory constrained devices too.
> > > >
> > > > Also, this way we would enable every kernel TEE client to leverage
> > > > system sessions as it's very likely they wouldn't like to compete w=
ith
> > > > user-space for thread availability. Two other kernel TEE clients th=
at
> > > > are on top of my head are HWRNG and Trusted Keys which can benefit
> > > > from this feature.
> > >
> > > Trusted Keys is an interesting use case. When OP-TEE accesses Trusted=
 Keys,
> > > it may need to access the eMMC/RPMB using the Linux OS tee-supplicant
> > >  whichj may repuire an eMMC clock or voltage regulator to be enabled.
> > > If that clock or regulator is under an SCMI control, then we need 2
> > > reserved TEE thread: one for invoking the Trusted Key TA and
> > > another for the SCMI request to reach the TEE will the Trusted Key
> > > TA invocation still consumes a thread.

Trusked keys TA doesn't need access to secure storage (eMMC/RPMB). It
only requires a RNG and access to a key derived from HUK.

> > >
> > Why would the Trusted Keys session need a system thread? To me, it
> > seems that the session could use the normal client priority.

The system thread priority as per my patch is nothing but an extra
thread available in the thread pool for kernel clients as compared to
user-space clients.

Trusted keys use-case was really motivated by: "every kernel TEE
client would like to avoid competing with user-space for thread
availability". However, HWRNG has a real case that user-space
shouldn't starve kernel RNG thread for OP-TEE thread availability.

System thread can be useful for trusted keys in case the disk
encryption key is backed by a trusted key.

-Sumit
