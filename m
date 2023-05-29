Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4E9714B25
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjE2Nyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjE2Ny0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:54:26 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902DE19A
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:53:29 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4301281573aso848584137.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685368381; x=1687960381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwO9i+agZkv18kweshb+/0AmPusVt4GuXihgOlnD2CU=;
        b=E/DVxXp859puptpG7p2OZcu4leTHF1f2Ju7vOjHTFdrIRWW/ws+H+oBbFahWIqUV2K
         A5uEdQhagWaS1HoksukjsG/R/EUNcvfXa38qCNujdkLbh1QbGtL4yYx/6rRaz5BEHoI1
         CU6ESDgeaqsdHwYZVVyPk/OStcl5kS+LiobdsKv1D9DFdy2FKjO8/95nzef2owuNf/0t
         TO3OlJPWP+jOh0RJHJ8ZXIChM/HiJI1MKalwTlwL1T2Z4vcHFNK/1htT1/7HuXzrkLxH
         fxezDRsfL4s5juOJIa9LiwPYQCvrR+5F8wcLJBzYzGBDM0/OCZRGWyc4tU4VNVSnDht1
         WPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368381; x=1687960381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwO9i+agZkv18kweshb+/0AmPusVt4GuXihgOlnD2CU=;
        b=JVZXJfcEklxKGDGKuJC3pDAO78PCKN4iqfpb1uni3jQhIHZSLrGyyMUL5Dq5qLs+1v
         39Uun2TQj4tNBh677LnBGT7T3npq+t0qUjA3/sVKaobH2cQc7YrRdJNWlD4sArTfrzuo
         cRoV0+zfIJPFM7/IJBdxUp6V47uHVWvVnJw6o7Bf78N+1LvYo9ZuucyB2q3+vnwNtydK
         CPRxbr8cFbpaAi3tdHoe/kMoK6jG51SZ+rSoXksAbldDAzui06TmmiIorrlGnsJOPeV+
         dHedb5GsHoqpX0P2uPRIES1o+XhZbAC0CMMdb2akitmloCX+If7mdCsobAF9u1lmyEkC
         wZmQ==
X-Gm-Message-State: AC+VfDzHlBBqVt1NktUDYgdj/ZyH9gsm0dXlsSLlQsCL4CPY93XWXN5W
        U2yynhlrY2eSyAcT+yS8XshuwBlODwlaeI1OYuJJKA==
X-Google-Smtp-Source: ACHHUZ7quc3YIzPoBoJ6C6Xt7li9h+C60yFzJvs4iD8dS39wkFFPMhg1RcH2uXmaeJ+xEtXnsqAYJDTAOt5poDQkB/o=
X-Received: by 2002:a67:de15:0:b0:439:62bd:ee81 with SMTP id
 q21-20020a67de15000000b0043962bdee81mr3361148vsk.1.1685368380736; Mon, 29 May
 2023 06:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230517143311.585080-1-sumit.garg@linaro.org>
 <CAN5uoS9h6OmO-SZWmBdRUkT+ih9QK+mTo8Kvmn3ePQ4NrKriBw@mail.gmail.com>
 <CAFA6WYPCOqsyedjP-ffAQiyX3manDV+oE3akFpeuRZukro_dRg@mail.gmail.com>
 <PAXPR10MB468715EB2B1DFE080F380266FD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
 <CAHUa44FDs-cukERVwev88i855Y-ZaAkLUt=bVxah=GdW+JKVLQ@mail.gmail.com>
 <PAXPR10MB46872AD9A798A1B7DAF4721DFD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
 <CAFA6WYOFaSHHRhNbeuwjLMtCRhGt4edMyeSD1841E3xzS-ETag@mail.gmail.com>
 <CAHUa44FCEs6dBG_WJApJkDKKUY+rS+EJM1s_ouCDazbb7vURxg@mail.gmail.com>
 <CAFA6WYMm43GRGFvWv-5dLiRzfeZyFbDMZewoE0ZU93Wsk6EFpQ@mail.gmail.com> <CAHUa44HBQatvnJ5Nkm=uWmnXX7xx_svjDt5d+fV6sosKAxppSg@mail.gmail.com>
In-Reply-To: <CAHUa44HBQatvnJ5Nkm=uWmnXX7xx_svjDt5d+fV6sosKAxppSg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 29 May 2023 19:22:49 +0530
Message-ID: <CAFA6WYOhoR1DhbRbw0qGm2-4AL5Ba1BM+Ck3v3TUPsWNwED_Yw@mail.gmail.com>
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

On Mon, 29 May 2023 at 17:53, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Mon, May 29, 2023 at 12:17=E2=80=AFPM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> >
> > On Mon, 29 May 2023 at 15:10, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > On Mon, May 29, 2023 at 9:11=E2=80=AFAM Sumit Garg <sumit.garg@linaro=
.org> wrote:
> > > >
> > > > On Fri, 26 May 2023 at 01:05, Etienne CARRIERE <etienne.carriere@st=
.com> wrote:
> > > > >
> > > > >
> > > > > > De: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > Envoy=C3=A9 : jeudi 25 mai 2023 17:20
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Thu, May 25, 2023 at 1:48=E2=80=AFPM Etienne CARRIERE
> > > > > > <etienne.carriere@st.com> wrote:>
> > > > > > >
> > > > > > > >
> > > > > > > > De : Sumit Garg <sumit.garg@linaro.org>
> > > > > > > > Envoy=C3=A9 : mercredi 24 mai 2023 09:31
> > > > > > > > > On Tue, 23 May 2023 at 12:41, Etienne Carriere
> > > > > > > > <etienne.carriere@linaro.org> wrote:
> > > > > > > > > Hello Sumit,
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > On Wed, 17 May 2023 at 16:33, Sumit Garg <sumit.garg@lina=
ro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > From: Etienne Carriere <etienne.carriere@linaro.org>
> > > > > > > > > >
> > > > > > > > > > Adds support in the OP-TEE driver to keep track of rese=
rved system
> > > > > > > > > > threads. The optee_cq_*() functions are updated to hand=
le this if
> > > > > > > > > > enabled. The SMC ABI part of the driver enables this tr=
acking, but the
> > > > > > > > > > FF-A ABI part does not.
> > > > > > > > > >
> > > > > > > > > > The logic allows atleast 1 OP-TEE thread can be reserve=
d to TEE system
> > > > > > > > > > sessions. For sake of simplicity, initialization of cal=
l queue
> > > > > > > > > > management is factorized into new helper function optee=
_cq_init().
> > > > > > > > > >
> > > > > > > > > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.=
org>
> > > > > > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.or=
g>
> > > > > > > > > > Signed-off-by: Etienne Carriere <etienne.carriere@linar=
o.org>
> > > > > > > > > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > Disclaimer: Compile tested only
> > > > > > > > > >
> > > > > > > > > > Hi Etienne,
> > > > > > > > > >
> > > > > > > > > > Overall the idea we agreed upon was okay but the implem=
entation looked
> > > > > > > > > > complex to me. So I thought it would be harder to expla=
in that via
> > > > > > > > > > review and I decided myself to give a try at simplifica=
tion. I would
> > > > > > > > > > like you to test it if this still addresses the SCMI de=
adlock problem or
> > > > > > > > > > not. Also, feel free to include this in your patchset i=
f all goes fine
> > > > > > > > > > wrt testing.
> > > > > > > > >
> > > > > > > > > With these changes, there is no more a specific waiting l=
ist for TEE
> > > > > > > > > system threads hence when a waiting queue can complete, w=
e'll pick any
> > > > > > > > > TEE thread, not a TEE system thread first..
> > > > > > > >
> > > > > > > > I had thought about this but I can't see any value in havin=
g a
> > > > > > > > separate wait queue for system threads. Here we only need t=
o provide
> > > > > > > > an extra privileged thread for system sessions (kernel clie=
nts) such
> > > > > > > > that user-space doesn't contend for that thread. This preve=
nts kernel
> > > > > > > > client's starvation or deadlock like in the SCMI case.
> > > > > > > >
> > > > > > > > > Also, as stated in a below answer, these change unconditi=
onally
> > > > > > > > > reserve a TEE thread for TEE system calls even if no TEE =
client
> > > > > > > > > reserved such.
> > > > > > > >
> > > > > > > > I don't think we should make thread reservations based on t=
he presence
> > > > > > > > of TEE clients. You never know how much user-space or kerne=
l TEE
> > > > > > > > clients you are dealing with. And reserving a single privil=
eged thread
> > > > > > > > unconditionally for system sessions shouldn't be much of a =
burden for
> > > > > > > > memory constrained devices too.
> > > > > > > >
> > > > > > > > Also, this way we would enable every kernel TEE client to l=
everage
> > > > > > > > system sessions as it's very likely they wouldn't like to c=
ompete with
> > > > > > > > user-space for thread availability. Two other kernel TEE cl=
ients that
> > > > > > > > are on top of my head are HWRNG and Trusted Keys which can =
benefit
> > > > > > > > from this feature.
> > > > > > >
> > > > > > > Trusted Keys is an interesting use case. When OP-TEE accesses=
 Trusted Keys,
> > > > > > > it may need to access the eMMC/RPMB using the Linux OS tee-su=
pplicant
> > > > > > >  whichj may repuire an eMMC clock or voltage regulator to be =
enabled.
> > > > > > > If that clock or regulator is under an SCMI control, then we =
need 2
> > > > > > > reserved TEE thread: one for invoking the Trusted Key TA and
> > > > > > > another for the SCMI request to reach the TEE will the Truste=
d Key
> > > > > > > TA invocation still consumes a thread.
> > > >
> > > > Trusked keys TA doesn't need access to secure storage (eMMC/RPMB). =
It
> > > > only requires a RNG and access to a key derived from HUK.
> > >
> > > Because it's always compiled as an early TA so no rollback protection=
 is used?
> > >
> >
> > Yeah it has to be compiled as an early TA to support Trusted Keys
> > use-cases. BTW, we don't have enumeration support for REE-FS TAs at
> > the moment.
> >
> > > >
> > > > > > >
> > > > > > Why would the Trusted Keys session need a system thread? To me,=
 it
> > > > > > seems that the session could use the normal client priority.
> > > >
> > > > The system thread priority as per my patch is nothing but an extra
> > > > thread available in the thread pool for kernel clients as compared =
to
> > > > user-space clients.
> > > >
> > > > Trusted keys use-case was really motivated by: "every kernel TEE
> > > > client would like to avoid competing with user-space for thread
> > > > availability". However, HWRNG has a real case that user-space
> > > > shouldn't starve kernel RNG thread for OP-TEE thread availability.
> > > >
> > > > System thread can be useful for trusted keys in case the disk
> > > > encryption key is backed by a trusted key.
> > >
> > > With well-behaving TAs every TEE client will get its thread in due ti=
me.
> >
> > We should try to keep distinction among user-space clients vs kernel
> > clients rather than keeping them in the same bucket. The kernel
> > clients are more privileged than user-space ones. This is similar
> > hardening as we have done with respect to session login method (REE
> > kernel login).
> >
> > >
> > > The system thread feature was originally intended as a way of avoidin=
g
> > > a deadlock.
> >
> > That's true but doing so can also benefit other (mutual independent)
> > kernel clients as well.
> >
> > > So far we have otherwise assigned threads on a first-come
> > > first-served basis. If we now also need a way of giving priority to
> > > kernel clients for less critical reasons we may need to take a step
> > > back and redesign because reserving a thread for each kernel client
> > > doesn't scale.
> >
> > No, please have a relook at this patch. We have *only* reserved a
> > single thread for all the allowed (sess->use_sys_thread =3D true) kerne=
l
> > clients to compete for. And user-space has access to all the other
> > threads on a first-come first-served basis except the one thread
> > reserved for kernel clients.
>
> Thanks, got it now. User space clients may or may not be able to
> starve kernel clients enough to matter. However, if all kernel clients
> only will be guaranteed one thread then we're still stuck with the
> deadlock problem for SCMI. We can't guarantee that none of the kernel
> clients will indirectly access eMMC/RPMB.

I think we should be able to address this via disallowing system
sessions for kernel clients whose devices are probed via
PTA_CMD_GET_DEVICES_SUPP. But I can't find a sane way to enforce this
via code but can be taken care of during review as well.

-Sumit

>
> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > >
> > > Thanks,
> > > Jens
