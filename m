Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DB5714733
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjE2JlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjE2Jkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:40:51 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D4DD2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:40:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6077660c6so19401635e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685353226; x=1687945226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFbbd8vL2/0xpMiz4YHG2+mx1F2OjhCF3O93KZ3LWCA=;
        b=iVNG6Df4rmQejpEZn+Mx68vZiXf+V8jwtkmoIP8EmnW25fKyKs3FYbxjWlHPqLsc/r
         DT+uIRlf5KziejMk0PETlT0DOMleXSiq+8IhvpAL4G4CJHTvIpfxuJnrKruNmNTvF51e
         0j7a6IRklJ6dNICOT1FrE/CMC5piTJG3TE133xjoB+oFsLn3SOmitBoMkzBcZ+kuihlY
         CTaq0VQ4qxDlKW1brE9Rc4iCzdoMrA94z6++F9B01SMu1xzvri/dQ6+x2X4oLfQ5fk2K
         zLbBfQWmuRbKTL7Qk4pnQMAFdkERY/v0vEsLwXLKYvA4ZXAa9m+Mc9zpSCYMmVMMcv+6
         bHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685353226; x=1687945226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFbbd8vL2/0xpMiz4YHG2+mx1F2OjhCF3O93KZ3LWCA=;
        b=UBHZaieyLG7Tw4y0nVWsaVIyLS7Qjn4qxe5sb1lu/0xPL8LKpcQ7q45Jb7NaIzyd5r
         XmVzGS9fb0gyrlNl2k03XoquucaD/mfy+oiz3ihxnqsJeO1h/sPCKcNufe4Ds03mVJ+x
         UB2sbhhALpL0YyoQHp6updvvOCJqDZaGuQJuVeICF3aoLwi6O6EYBFz2duAP6s79TOY3
         m6uUB4Qv4oNLYCoY79HUHGL3HYCFPJjAa4y3bfAFK6Js0s53wHVyhHDC/8p1dQvcmq6v
         vxKy9XNP8Cl6BCR0gZVaTSUXS72shT1xjb5CWV2Q7RMz732aaNuKKo8gby6JQXx2h/c0
         ukbw==
X-Gm-Message-State: AC+VfDzjvvo60zWK8f6yq3HRmKaB92gvLMTE1JBRlbcMEd7vUIre4KXo
        cUd5CcKWW3UiZPg74C42uH4pLbouF01oDkWi0bIB/rF/alvEfV/A
X-Google-Smtp-Source: ACHHUZ68LSb/Ha/Yby5CUZ8cJly9H7akmNwT3RF9nukhkZQ9sryZpXeQOCWKNxnzUZw8vRhcVtD/89q/VXbz5lmIWzY=
X-Received: by 2002:a05:600c:22d7:b0:3f6:938:1001 with SMTP id
 23-20020a05600c22d700b003f609381001mr10026004wmg.8.1685353225907; Mon, 29 May
 2023 02:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230517143311.585080-1-sumit.garg@linaro.org>
 <CAN5uoS9h6OmO-SZWmBdRUkT+ih9QK+mTo8Kvmn3ePQ4NrKriBw@mail.gmail.com>
 <CAFA6WYPCOqsyedjP-ffAQiyX3manDV+oE3akFpeuRZukro_dRg@mail.gmail.com>
 <PAXPR10MB468715EB2B1DFE080F380266FD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
 <CAHUa44FDs-cukERVwev88i855Y-ZaAkLUt=bVxah=GdW+JKVLQ@mail.gmail.com>
 <PAXPR10MB46872AD9A798A1B7DAF4721DFD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
 <CAFA6WYOFaSHHRhNbeuwjLMtCRhGt4edMyeSD1841E3xzS-ETag@mail.gmail.com>
In-Reply-To: <CAFA6WYOFaSHHRhNbeuwjLMtCRhGt4edMyeSD1841E3xzS-ETag@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 29 May 2023 11:40:15 +0200
Message-ID: <CAHUa44FCEs6dBG_WJApJkDKKUY+rS+EJM1s_ouCDazbb7vURxg@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] tee: optee: support tracking system threads
To:     Sumit Garg <sumit.garg@linaro.org>
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

On Mon, May 29, 2023 at 9:11=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Fri, 26 May 2023 at 01:05, Etienne CARRIERE <etienne.carriere@st.com> =
wrote:
> >
> >
> > > De: Jens Wiklander <jens.wiklander@linaro.org>
> > > Envoy=C3=A9 : jeudi 25 mai 2023 17:20
> > >
> > > Hi,
> > >
> > > On Thu, May 25, 2023 at 1:48=E2=80=AFPM Etienne CARRIERE
> > > <etienne.carriere@st.com> wrote:>
> > > >
> > > > >
> > > > > De : Sumit Garg <sumit.garg@linaro.org>
> > > > > Envoy=C3=A9 : mercredi 24 mai 2023 09:31
> > > > > > On Tue, 23 May 2023 at 12:41, Etienne Carriere
> > > > > <etienne.carriere@linaro.org> wrote:
> > > > > > Hello Sumit,
> > > > > >
> > > > > >
> > > > > > On Wed, 17 May 2023 at 16:33, Sumit Garg <sumit.garg@linaro.org=
> wrote:
> > > > > > >
> > > > > > > From: Etienne Carriere <etienne.carriere@linaro.org>
> > > > > > >
> > > > > > > Adds support in the OP-TEE driver to keep track of reserved s=
ystem
> > > > > > > threads. The optee_cq_*() functions are updated to handle thi=
s if
> > > > > > > enabled. The SMC ABI part of the driver enables this tracking=
, but the
> > > > > > > FF-A ABI part does not.
> > > > > > >
> > > > > > > The logic allows atleast 1 OP-TEE thread can be reserved to T=
EE system
> > > > > > > sessions. For sake of simplicity, initialization of call queu=
e
> > > > > > > management is factorized into new helper function optee_cq_in=
it().
> > > > > > >
> > > > > > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > > > > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Disclaimer: Compile tested only
> > > > > > >
> > > > > > > Hi Etienne,
> > > > > > >
> > > > > > > Overall the idea we agreed upon was okay but the implementati=
on looked
> > > > > > > complex to me. So I thought it would be harder to explain tha=
t via
> > > > > > > review and I decided myself to give a try at simplification. =
I would
> > > > > > > like you to test it if this still addresses the SCMI deadlock=
 problem or
> > > > > > > not. Also, feel free to include this in your patchset if all =
goes fine
> > > > > > > wrt testing.
> > > > > >
> > > > > > With these changes, there is no more a specific waiting list fo=
r TEE
> > > > > > system threads hence when a waiting queue can complete, we'll p=
ick any
> > > > > > TEE thread, not a TEE system thread first..
> > > > >
> > > > > I had thought about this but I can't see any value in having a
> > > > > separate wait queue for system threads. Here we only need to prov=
ide
> > > > > an extra privileged thread for system sessions (kernel clients) s=
uch
> > > > > that user-space doesn't contend for that thread. This prevents ke=
rnel
> > > > > client's starvation or deadlock like in the SCMI case.
> > > > >
> > > > > > Also, as stated in a below answer, these change unconditionally
> > > > > > reserve a TEE thread for TEE system calls even if no TEE client
> > > > > > reserved such.
> > > > >
> > > > > I don't think we should make thread reservations based on the pre=
sence
> > > > > of TEE clients. You never know how much user-space or kernel TEE
> > > > > clients you are dealing with. And reserving a single privileged t=
hread
> > > > > unconditionally for system sessions shouldn't be much of a burden=
 for
> > > > > memory constrained devices too.
> > > > >
> > > > > Also, this way we would enable every kernel TEE client to leverag=
e
> > > > > system sessions as it's very likely they wouldn't like to compete=
 with
> > > > > user-space for thread availability. Two other kernel TEE clients =
that
> > > > > are on top of my head are HWRNG and Trusted Keys which can benefi=
t
> > > > > from this feature.
> > > >
> > > > Trusted Keys is an interesting use case. When OP-TEE accesses Trust=
ed Keys,
> > > > it may need to access the eMMC/RPMB using the Linux OS tee-supplica=
nt
> > > >  whichj may repuire an eMMC clock or voltage regulator to be enable=
d.
> > > > If that clock or regulator is under an SCMI control, then we need 2
> > > > reserved TEE thread: one for invoking the Trusted Key TA and
> > > > another for the SCMI request to reach the TEE will the Trusted Key
> > > > TA invocation still consumes a thread.
>
> Trusked keys TA doesn't need access to secure storage (eMMC/RPMB). It
> only requires a RNG and access to a key derived from HUK.

Because it's always compiled as an early TA so no rollback protection is us=
ed?

>
> > > >
> > > Why would the Trusted Keys session need a system thread? To me, it
> > > seems that the session could use the normal client priority.
>
> The system thread priority as per my patch is nothing but an extra
> thread available in the thread pool for kernel clients as compared to
> user-space clients.
>
> Trusted keys use-case was really motivated by: "every kernel TEE
> client would like to avoid competing with user-space for thread
> availability". However, HWRNG has a real case that user-space
> shouldn't starve kernel RNG thread for OP-TEE thread availability.
>
> System thread can be useful for trusted keys in case the disk
> encryption key is backed by a trusted key.

With well-behaving TAs every TEE client will get its thread in due time.

The system thread feature was originally intended as a way of avoiding
a deadlock. So far we have otherwise assigned threads on a first-come
first-served basis. If we now also need a way of giving priority to
kernel clients for less critical reasons we may need to take a step
back and redesign because reserving a thread for each kernel client
doesn't scale.

Thanks,
Jens
