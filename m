Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DAD6902F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjBIJMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjBIJMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:12:19 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644695EF9A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:12:09 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p26so4281178ejx.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 01:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mw+sObl4QVdmQB1+Lg1EKzfK/QxstkGP3t9tYzhrTKI=;
        b=uHgrKI252GITxQkAl/nzJRkD6aYwplkBjdkKuEUM7t2pXbcUi0HbCLYXpxx2f+oE+g
         I1HSIUNHXJFmbGFFKs4vOCK9w36AblYU19AXMLQ1sq69Nc3KP8odJGUudvElq1geTHSK
         v68D6MiMe27F+mEHiBNADhgnIIZPFPTIZLFR5liYgiBjHAV7aph87A2V0dOzLDSHmf06
         qbF+A0E8H5b0/rdchRz9bNcHVuqLAbcS9KCqj0E0MUv0EnSUMFgLEoRKnZt3/XC0serg
         5WV3FIQ271HycRslbKgCY3YiHDozQZfwYGHn23/6a9rAIkouB1jk2JurKDrSTO7Q1RC0
         W3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mw+sObl4QVdmQB1+Lg1EKzfK/QxstkGP3t9tYzhrTKI=;
        b=RBzRbk844XA7bz/qnAIkXY8M6UsJEpin+kB/vhkzdo4r//rekUzPJpfKN4sHv07rb4
         2eGPx+OESc9kl0ShWkyZiQgIa9VaW4czqYB5YjIoLc6c05TH900lvi95MuAgTwmoTt0v
         SWzxvwBmrD6geNQWT6dpYC2KR4wlp1JeKK6wB2lmsmHFKmJeyh/XmvS+fKDZGyhYCN0Q
         H9kdNYwy7sVrXWKq8nq0F4k7dLrCzAvWBEZ8BcxaADtocme8/Nw9rclK85yVl71sydO2
         vMs+aRls6ihRssharsWVghN76i5Ki1wrmBjYSkSpXKzxlfTCvSUDt8BxDHexMZXVDIov
         iDGg==
X-Gm-Message-State: AO0yUKV/zLdat6htRE4LpDocZ8plMZ9ft6brsJDxE40M3fJy0ECXg2kW
        zdC1+q0b9apP/J7lewy+QuSZ2GwpTO3eV4+a/wqIq9UFCzmJZcO/
X-Google-Smtp-Source: AK7set9fGvfMqSyg9k7cIHMdjxqemjyWCoN6Sf1g5ilcBJPBUwtwxPsHNa4CJYThs3XkXCHawl0vQdHAXqJzSuP7pY0=
X-Received: by 2002:a17:906:f90e:b0:88b:a2de:ed92 with SMTP id
 lc14-20020a170906f90e00b0088ba2deed92mr2315377ejb.193.1675933927828; Thu, 09
 Feb 2023 01:12:07 -0800 (PST)
MIME-Version: 1.0
References: <20230130094157.1082712-1-etienne.carriere@linaro.org>
 <CAFA6WYPxzB45pgWkkh++jRaY-d0eHWnrjzu+Z9059PjK5=M-mQ@mail.gmail.com>
 <CAHUa44G3jCqyiXtdZAAEw=8WPC+m5fD8tqsPfGc3MkV3JjRDCA@mail.gmail.com>
 <CAFA6WYN7i+7riJGPH4BEUFK77-kAx4J89Tn3=oX=g6rFUFtDkQ@mail.gmail.com>
 <CAHUa44G1yQtgF1eAUJVA+wtctKHfqYFBhs0PBnpoN-gD8_x8eg@mail.gmail.com>
 <CAN5uoS_M4uMWkf=Q8XFLCrNSvyUdjLgCPixqonKv3mRwRTr-nQ@mail.gmail.com>
 <Y+SdRrwSq/a9OgGr@jade> <CAN5uoS-7Mk6Cy9T9978-5hRUK55UOcCXPFe7Kv8ZUvkJZPi6pw@mail.gmail.com>
In-Reply-To: <CAN5uoS-7Mk6Cy9T9978-5hRUK55UOcCXPFe7Kv8ZUvkJZPi6pw@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 9 Feb 2023 10:11:56 +0100
Message-ID: <CAN5uoS_voYQLqSaz5xAWhrdQENXn2MyNgd9kLXV1FuN8M7KaJg@mail.gmail.com>
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

On Thu, 9 Feb 2023 at 09:11, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Hi Jens,
>
>
> On Thu, 9 Feb 2023 at 08:14, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Hi Etienne,
> >
> > On Wed, Feb 08, 2023 at 06:09:17PM +0100, Etienne Carriere wrote:
> > > Hello Sumit, Jens,
> > >
> > [snip]
> > > > > > > >
> > > > > > > >         if  (rpc_arg && tee_shm_is_dynamic(shm)) {
> > > > > > > > -               param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
> > > > > > > > +               if (ctx->sys_service &&
> > > > > > > > +                   (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SYSTEM_THREAD))
> > > > > > > > +                       param.a0 = OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG;
> > > > > > > > +               else
> > > > > > > > +                       param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
> > > > > > >
> > > > > > > This system thread flag should also be applicable to platforms without
> > > > > > > registered arguments support. IOW, we need similar equivalents for
> > > > > > > OPTEE_SMC_FUNCID_CALL_WITH_ARG and OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG
> > > > > > > too. So I would rather suggest that we add following flag to all 3
> > > > > > > call types:
> > > > > > >
> > > > > > > #define OPTEE_SMC_CALL_SYSTEM_THREAD_FLAG    0x8000
> > > > > >
> > > > > > The main reason platforms don't support registered arguments is that
> > > > > > they haven't been updated since this was introduced. So if a platform
> > > > > > needs system threads it could update to use registered arguments too.
> > > > >
> > > > > Are we hinting at deprecating reserved shared memory support? If yes,
> > > > > wouldn't it be better to be explicit about it with a boot time warning
> > > > > message about its deprecation?
> > > > >
> > > > > Otherwise it will be difficult to debug for the end user to find out
> > > > > why system thread support isn't activated.
> > > > >
> > > > > > The Linux kernel already supports registered arguments. An advantage
> > > > > > with the current approach is that the ABI is easier to implement
> > > > > > since we have distinct SMC IDs for each function.
> > > > >
> > > > > I see your point but my initial thought was that we don't end up
> > > > > making that list too large that it becomes cumbersome to maintain,
> > > > > involving all the combinatorial.
> > > >
> > > > You have a point. Etienne, do you think we could give it a try at
> > > > https://github.com/OP-TEE/optee_os/pull/5789 to better see how this
> > > > would play out?
> > > >
> > >
> > > Indeed I miss that...
> > > With the patch proposed here, indeed if OP-TEE does not support
> > > dynamic shared memory then Linux will never use the provisioned TEE
> > > thread. This is weird as in such a case OP-TEE provisions resources
> > > that will never be used, which is the exact opposite goal of this
> > > feature. Verified on our qemu-arm setup.
> > >
> > > For simplicity, I think this system invocation should require OP-TEE
> > > supports dyn shm.
> >
> > It's not obvious to me that this will easier to implement and maintain.
> > Looking at the code in optee_os it looks like using a flag bit as
> > proposed by Sumit would be quite easy to handle.
>
> OP-TEE could auto disable thread provis when dyn shm is disabled, right.

By the way, from OP-TEE OS, we have config switches for dyn-shm and
system context provisioning.
The latter could depend on the former so it's clear at build time when
TEE can embed the capability.

Br,
etienne

> Will it be sufficient? We will still face cases where an OP-TEE
> provisions thread but Linux kernel is not aware (older vanilla kernel
> used with a recent OP-TEE OS). Not much platforms are really affected
> I guess but those executing with pager in small RAMs where a 4kB
> thread context costs.
>
> (snip)
