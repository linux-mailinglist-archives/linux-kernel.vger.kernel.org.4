Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E12690960
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjBIM5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBIM5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:57:09 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841B12BEF0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:57:07 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ud5so6079390ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 04:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ktdDslcvWKj2LkZK7T9I4RYoDooeQBCWJEtHRO61dgQ=;
        b=YOXfC+GiK/9TPFqoWK5ZxF5T62rURwovnuPa2z7Kn7cdxwQdsDrJNbCPrMqXcizRqg
         49nqG1FNfipRdXJn4XZVlrMdCDxj1jaI/16QwA/pHhf6FG3C0QHIekljmNblqRPSryNm
         pDtwFQqIG5bqIgJ+jbj8C5V9XJrwGfZnF34T3qDxn01FdGGmuWu+W5FhAzLWiCxRjOCf
         LmTEg8LQPc5ZLcc/95npaQrDuV0E/fEV6/O2Pv9GztUajepiNh0NxztcyVwfWHLys89h
         vruBmurHymumzwCDbNUN280RGQRpS1OsB7sj5N50LiWVJE5bMMf0kBkjI6jQ30DktRZ4
         Qipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktdDslcvWKj2LkZK7T9I4RYoDooeQBCWJEtHRO61dgQ=;
        b=sqBzo0eZ7MkV2ZJfi/Wf9/gwDNtItdA79gdwAzvQgAEqs/4RLGKH8o0Ziw355hzYBB
         uQnI4l4nLoAJEjtyE+YM0MR0XZq5b12ycOP+zapMvk8gSd/B/rMwnPGRQS7Rb6sLSZL+
         jgCox1P06n/n5351l38RYhzjENZrtSB5mCCtkaMhrY9w9u6rBPfywnZ7DyPYi6NRtI6k
         QWb+5qdnPEiX31Ls52sQhXdlE/lX2+j9RoR8bGuLmkp8TyrvvYMXxSdHUwnYMBeh4r/A
         cpjGXnHKRRNUf+/n1I1yF8uGpZjhAV4Tu2ure5UE6KMKVll/OuEnCxb3p3Px0mXeroUW
         kgNA==
X-Gm-Message-State: AO0yUKVrEEVSfQektl5GU0+fQUW7YZS5na2STy1J+3Sgk+5Kxtk0bu4P
        4rr8nlDkU+M7QRUQLwVpfPFb72A+JyCo+xsoz5tmHw==
X-Google-Smtp-Source: AK7set/7AzGhauxDb655geiSBxMuStpM++DIX7DNbp5TTlEYidI+DouqWIiP948oaaKQG7Clc7yZmShEnh8xiIvWsfM=
X-Received: by 2002:a17:907:10c3:b0:8ae:b14b:4b9e with SMTP id
 rv3-20020a17090710c300b008aeb14b4b9emr476139ejb.9.1675947425558; Thu, 09 Feb
 2023 04:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20230130094157.1082712-1-etienne.carriere@linaro.org>
 <CAFA6WYPxzB45pgWkkh++jRaY-d0eHWnrjzu+Z9059PjK5=M-mQ@mail.gmail.com>
 <CAHUa44G3jCqyiXtdZAAEw=8WPC+m5fD8tqsPfGc3MkV3JjRDCA@mail.gmail.com>
 <CAFA6WYN7i+7riJGPH4BEUFK77-kAx4J89Tn3=oX=g6rFUFtDkQ@mail.gmail.com>
 <CAHUa44G1yQtgF1eAUJVA+wtctKHfqYFBhs0PBnpoN-gD8_x8eg@mail.gmail.com>
 <CAN5uoS_M4uMWkf=Q8XFLCrNSvyUdjLgCPixqonKv3mRwRTr-nQ@mail.gmail.com>
 <Y+SdRrwSq/a9OgGr@jade> <CAN5uoS-7Mk6Cy9T9978-5hRUK55UOcCXPFe7Kv8ZUvkJZPi6pw@mail.gmail.com>
 <Y+S6qbgtAViopMPd@jade>
In-Reply-To: <Y+S6qbgtAViopMPd@jade>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 9 Feb 2023 13:56:54 +0100
Message-ID: <CAN5uoS-Qo3gn-JChY1v-kOpYrjSyuL44e1hH_16i6KA+Kx=4UQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tee: system invocation
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 at 10:19, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> On Thu, Feb 09, 2023 at 09:11:53AM +0100, Etienne Carriere wrote:
> > Hi Jens,
> >
> >
> > On Thu, 9 Feb 2023 at 08:14, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > Hi Etienne,
> > >
> > > On Wed, Feb 08, 2023 at 06:09:17PM +0100, Etienne Carriere wrote:
> > > > Hello Sumit, Jens,
> > > >
> > > [snip]
> > > > > > > > >
> > > > > > > > >         if  (rpc_arg && tee_shm_is_dynamic(shm)) {
> > > > > > > > > -               param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
> > > > > > > > > +               if (ctx->sys_service &&
> > > > > > > > > +                   (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SYSTEM_THREAD))
> > > > > > > > > +                       param.a0 = OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG;
> > > > > > > > > +               else
> > > > > > > > > +                       param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
> > > > > > > >
> > > > > > > > This system thread flag should also be applicable to platforms without
> > > > > > > > registered arguments support. IOW, we need similar equivalents for
> > > > > > > > OPTEE_SMC_FUNCID_CALL_WITH_ARG and OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG
> > > > > > > > too. So I would rather suggest that we add following flag to all 3
> > > > > > > > call types:
> > > > > > > >
> > > > > > > > #define OPTEE_SMC_CALL_SYSTEM_THREAD_FLAG    0x8000
> > > > > > >
> > > > > > > The main reason platforms don't support registered arguments is that
> > > > > > > they haven't been updated since this was introduced. So if a platform
> > > > > > > needs system threads it could update to use registered arguments too.
> > > > > >
> > > > > > Are we hinting at deprecating reserved shared memory support? If yes,
> > > > > > wouldn't it be better to be explicit about it with a boot time warning
> > > > > > message about its deprecation?
> > > > > >
> > > > > > Otherwise it will be difficult to debug for the end user to find out
> > > > > > why system thread support isn't activated.
> > > > > >
> > > > > > > The Linux kernel already supports registered arguments. An advantage
> > > > > > > with the current approach is that the ABI is easier to implement
> > > > > > > since we have distinct SMC IDs for each function.
> > > > > >
> > > > > > I see your point but my initial thought was that we don't end up
> > > > > > making that list too large that it becomes cumbersome to maintain,
> > > > > > involving all the combinatorial.
> > > > >
> > > > > You have a point. Etienne, do you think we could give it a try at
> > > > > https://github.com/OP-TEE/optee_os/pull/5789 to better see how this
> > > > > would play out?
> > > > >
> > > >
> > > > Indeed I miss that...
> > > > With the patch proposed here, indeed if OP-TEE does not support
> > > > dynamic shared memory then Linux will never use the provisioned TEE
> > > > thread. This is weird as in such a case OP-TEE provisions resources
> > > > that will never be used, which is the exact opposite goal of this
> > > > feature. Verified on our qemu-arm setup.
> > > >
> > > > For simplicity, I think this system invocation should require OP-TEE
> > > > supports dyn shm.
> > >
> > > It's not obvious to me that this will easier to implement and maintain.
> > > Looking at the code in optee_os it looks like using a flag bit as
> > > proposed by Sumit would be quite easy to handle.
> >
> > OP-TEE could auto disable thread provis when dyn shm is disabled, right.
> > Will it be sufficient? We will still face cases where an OP-TEE
> > provisions thread but Linux kernel is not aware (older vanilla kernel
> > used with a recent OP-TEE OS). Not much platforms are really affected
> > I guess but those executing with pager in small RAMs where a 4kB
> > thread context costs.
>
> When you add exceptions you make it more complicated. Now we must
> remember to always use dyn shm if we are to succeed in configuring with
> system threads. What if both dyn shm and static shm is configured in
> OP-TEE, but the kernel only uses static shm?
>
> > > > If OP-TEE could know when Linux does not support TEE system
> > > > invocation, then OP-TEE could let any invocation use these provisioned
> > > > resources so that they are not wasted.
> > > > I think a good way would be Linux to expose if it supports this
> > > > capability, during capabilities exchange.
> > > > Would you agree with this approach?
> > >
> > > No, I'm not so keen on adding that side effect to
> > > OPTEE_SMC_EXCHANGE_CAPABILITIES.
> >
> > It is a capability REE would exchanges with TEE.
> > What kind of side effects do you fear?
>
> I was hoping to keep it stateless. One thing less to keep track of when
> handing over from a boot stage to the kernel.

Or from a kernel VM unload/reload.

>
> > > The way you're describing the problem it sounds like it's a normal world
> > > problem to know how many system threads are needed. How about adding a
> > > fast call where normal world can request how many system threads should
> > > be reserved?  If none are requested, none will be reserved.
> >
> > Well, could be. With caps exchange, we have an SMC funcID to REE to
> > say to TEE: "reserved the default configured number of sys thread". I
> > think it is simpler.
>
> Until you realize the that the default number of system threads doesn't
> match what you need.

Ok, I see your point. Indeed, Linux drivers requiring system context
could issue a fastcall SMC to request dynamic provisioning of TEE
context resources, and release their request upon driver unload. I
agree it would better scale in the long term. I'll propose something
in a v2.

>
> >
> > With REE calling TEE to provision thread, we would need another call
> > to release the reservation. Whe caps exchange, we have a single SMC to
> > reconfig the negotiated caps.
>
> A single SMC with growing complexity in its arguments.

:)  fair.

>
> Cheers,
> Jens
