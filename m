Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7106901E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBIIML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBIIMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:12:07 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EB937F39
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:12:06 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id p26so3863053ejx.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 00:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YcPAR4HeWB1OAvkoNiLImbOAwUNrxdCFwqAhHNPIayw=;
        b=PxlA717PstDzBxHBMp1VQKzh0OjZxFOtmWyNWGfAvDLC3YHWA+tIwGHN6qxP5wpOD9
         BcuKOgZXdep9OfNnL/wXCDHrnvIdK6dVEl/DhTvOyJE0wLTWfWF2EpaYu1kD9L/d2SSk
         XweEzEdsabez97Dtp8t7r7kflUEXfkVytRSZZnGUIuIt+GHt0FQI8PxCocVk1px00n9j
         qmGYXtxui7jxxsi7ph3w+mYoYVQX+uyIoZo9T02JFVYBLDa+bUocC+6T9IQfCQc+s4+C
         ee0uSERd77/cvTNDkB8F48qcneQmdfA4RACnso7XxnYTJj9P9Xd6MS8QqjP0wz4fCMj/
         bt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcPAR4HeWB1OAvkoNiLImbOAwUNrxdCFwqAhHNPIayw=;
        b=vPBjJONiZ0hmY9ZkvUGOCTsJqFkOJNABeaD/sCDMmKWaOEvfGZFk0wcvCnTwa0CIP/
         6HOOHGHverq9aM4oVSxCs5YBPsu+dLkMdJPXSZ0ns5n9GBWHUW4AJ9KFTd+TOr/EvN7T
         gmxczDL3tNgLB/H3vFLhQ1l1RAGLFtalckhcMaHKqcuhOIw8mF4yQRw0/Hq4y9QFVH0U
         ORUWorFmJvXyIBZeXP2k21SbzryoTVkfvD9eV0iPeALSt4M+3/OquHf939kI/J8hLjCc
         iRC7cDGGdbdgiIsDdbDB/wGGG+47pPvib8fBX5VAdbq8OyhufWyDVg6GWT/NlQZ5gkA0
         NVVA==
X-Gm-Message-State: AO0yUKUUKWrNnRZPh4TxhP+hPr+TGsd7Eu+2z4DgO7gCBNIw1PwM6LpE
        ZbvXGUoy57FEg2GTh0TVp0NabE3h6ssNddkYSWg+ig==
X-Google-Smtp-Source: AK7set/w4DF9lGdtDEFm0Urz4C2EhN/UINQy5w9889VZgOd53UqIqdmRnAI4goLCFsKJYdZpw451sH9IyHV0dPcjVk4=
X-Received: by 2002:a17:906:f90e:b0:88b:a2de:ed92 with SMTP id
 lc14-20020a170906f90e00b0088ba2deed92mr2282229ejb.193.1675930324685; Thu, 09
 Feb 2023 00:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20230130094157.1082712-1-etienne.carriere@linaro.org>
 <CAFA6WYPxzB45pgWkkh++jRaY-d0eHWnrjzu+Z9059PjK5=M-mQ@mail.gmail.com>
 <CAHUa44G3jCqyiXtdZAAEw=8WPC+m5fD8tqsPfGc3MkV3JjRDCA@mail.gmail.com>
 <CAFA6WYN7i+7riJGPH4BEUFK77-kAx4J89Tn3=oX=g6rFUFtDkQ@mail.gmail.com>
 <CAHUa44G1yQtgF1eAUJVA+wtctKHfqYFBhs0PBnpoN-gD8_x8eg@mail.gmail.com>
 <CAN5uoS_M4uMWkf=Q8XFLCrNSvyUdjLgCPixqonKv3mRwRTr-nQ@mail.gmail.com> <Y+SdRrwSq/a9OgGr@jade>
In-Reply-To: <Y+SdRrwSq/a9OgGr@jade>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 9 Feb 2023 09:11:53 +0100
Message-ID: <CAN5uoS-7Mk6Cy9T9978-5hRUK55UOcCXPFe7Kv8ZUvkJZPi6pw@mail.gmail.com>
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

Hi Jens,


On Thu, 9 Feb 2023 at 08:14, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi Etienne,
>
> On Wed, Feb 08, 2023 at 06:09:17PM +0100, Etienne Carriere wrote:
> > Hello Sumit, Jens,
> >
> [snip]
> > > > > > >
> > > > > > >         if  (rpc_arg && tee_shm_is_dynamic(shm)) {
> > > > > > > -               param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
> > > > > > > +               if (ctx->sys_service &&
> > > > > > > +                   (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SYSTEM_THREAD))
> > > > > > > +                       param.a0 = OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG;
> > > > > > > +               else
> > > > > > > +                       param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
> > > > > >
> > > > > > This system thread flag should also be applicable to platforms without
> > > > > > registered arguments support. IOW, we need similar equivalents for
> > > > > > OPTEE_SMC_FUNCID_CALL_WITH_ARG and OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG
> > > > > > too. So I would rather suggest that we add following flag to all 3
> > > > > > call types:
> > > > > >
> > > > > > #define OPTEE_SMC_CALL_SYSTEM_THREAD_FLAG    0x8000
> > > > >
> > > > > The main reason platforms don't support registered arguments is that
> > > > > they haven't been updated since this was introduced. So if a platform
> > > > > needs system threads it could update to use registered arguments too.
> > > >
> > > > Are we hinting at deprecating reserved shared memory support? If yes,
> > > > wouldn't it be better to be explicit about it with a boot time warning
> > > > message about its deprecation?
> > > >
> > > > Otherwise it will be difficult to debug for the end user to find out
> > > > why system thread support isn't activated.
> > > >
> > > > > The Linux kernel already supports registered arguments. An advantage
> > > > > with the current approach is that the ABI is easier to implement
> > > > > since we have distinct SMC IDs for each function.
> > > >
> > > > I see your point but my initial thought was that we don't end up
> > > > making that list too large that it becomes cumbersome to maintain,
> > > > involving all the combinatorial.
> > >
> > > You have a point. Etienne, do you think we could give it a try at
> > > https://github.com/OP-TEE/optee_os/pull/5789 to better see how this
> > > would play out?
> > >
> >
> > Indeed I miss that...
> > With the patch proposed here, indeed if OP-TEE does not support
> > dynamic shared memory then Linux will never use the provisioned TEE
> > thread. This is weird as in such a case OP-TEE provisions resources
> > that will never be used, which is the exact opposite goal of this
> > feature. Verified on our qemu-arm setup.
> >
> > For simplicity, I think this system invocation should require OP-TEE
> > supports dyn shm.
>
> It's not obvious to me that this will easier to implement and maintain.
> Looking at the code in optee_os it looks like using a flag bit as
> proposed by Sumit would be quite easy to handle.

OP-TEE could auto disable thread provis when dyn shm is disabled, right.
Will it be sufficient? We will still face cases where an OP-TEE
provisions thread but Linux kernel is not aware (older vanilla kernel
used with a recent OP-TEE OS). Not much platforms are really affected
I guess but those executing with pager in small RAMs where a 4kB
thread context costs.


>
> >
> > If OP-TEE could know when Linux does not support TEE system
> > invocation, then OP-TEE could let any invocation use these provisioned
> > resources so that they are not wasted.
> > I think a good way would be Linux to expose if it supports this
> > capability, during capabilities exchange.
> > Would you agree with this approach?
>
> No, I'm not so keen on adding that side effect to
> OPTEE_SMC_EXCHANGE_CAPABILITIES.

It is a capability REE would exchanges with TEE.
What kind of side effects do you fear?

>
> The way you're describing the problem it sounds like it's a normal world
> problem to know how many system threads are needed. How about adding a
> fast call where normal world can request how many system threads should
> be reserved?  If none are requested, none will be reserved.

Well, could be. With caps exchange, we have an SMC funcID to REE to
say to TEE: "reserved the default configured number of sys thread". I
think it is simpler.

With REE calling TEE to provision thread, we would need another call
to release the reservation. Whe caps exchange, we have a single SMC to
reconfig the negotiated caps.

>
> Cheers,
> Jens
