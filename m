Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA6363C33E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiK2O6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbiK2O6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:58:05 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962D9B5C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:58:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s5so20083043edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r75p1eFMXKQ8J7TYZaKWyn27SqsBD3/AsLI3zva19UI=;
        b=I5ZwJXEwMTDiKm/D6EG/P+e+ITsPwWbKmHcm2TS+XfEPlGsREoWspExg1BF9Q7H2wv
         s+l1CwZ+6a8zYY8DDlvmRuzkRBqq8AM9t6BQCZqRzv5UBAmCkvfBGEMXYoYVrNYrYOFp
         EG4+6lakHZUQaXMKIEnZiCE6iSF5F8D9MNwW5gWl9FQzKkFcBOAeKKNcKrru8zSlIrm/
         ecQQTPmNfUhnEg8qVnJGskgXAQckrV2TQsHY2Frw/Zn+qp89mcQ6JP3e/5VkcKOgdAlm
         jwGEjUUkggLzAggFrP2QDJoFIa04xXUwBKO7F4s1YZCCvZ0euE7e0BU215KkTgFGHHn+
         j1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r75p1eFMXKQ8J7TYZaKWyn27SqsBD3/AsLI3zva19UI=;
        b=ATS6mkYf+w5bya3PRRhHWdtDZemxQe/JjRTUnHI31CjZCkYrZHsb2n4cdTzb4SMbQ3
         zh5N4uy+Hg7S7fIpXwsyK6Elvqu/+j2QaXybbQ1OP4kiBeuCWKoRt9bUmDpW6wwJ/RyL
         Loi6XSgk9jIDzgSpPVVHIiTDroWXfjV1Cner61DHOMZvj+kuFw0uHR64B8h1pQ/mGr60
         CKd95jIJG4sG9iupTjsGSjB2ScBc0DU4MbJqassE6EbSql3YJnsEz9KfTVhCApUCAaJZ
         Dy/PO9+QeW3y3+DDehQ7Cvo00A5xMOIqqR0xLqY2yEA/h+Zk5jINLiJyfobUqPLABKog
         lx0Q==
X-Gm-Message-State: ANoB5pn5RyxLkp9WoAs+cbvrRh8g+kBd8z6btMFhzzlbxgghvS0si2yT
        pqsTadJF3w0FoBTHXKstmsgub4OFA/Q/cTHygqNjzw==
X-Google-Smtp-Source: AA0mqf5Y/+vzKZPDu0HIiqgRDNP3PDGrpQuTbvEMCglEx8rTPkVQ8nFpFwOr8RBm33gQIypJ1AtzoZQ6VRgAC9IXGOM=
X-Received: by 2002:aa7:d555:0:b0:464:6485:419b with SMTP id
 u21-20020aa7d555000000b004646485419bmr38297553edr.382.1669733881867; Tue, 29
 Nov 2022 06:58:01 -0800 (PST)
MIME-Version: 1.0
References: <20221111095313.2010815-1-sumit.garg@linaro.org>
 <20221111143800.k7xje6g23ujefnye@bogus> <CAFA6WYMdNjbMRZxt3iicmKOhQa3ax7_HYtqmNN9bmpndqT8e9A@mail.gmail.com>
 <20221114102650.qwkaxtnstujaiu6u@bogus> <CAN5uoS8SArNmaxwhJ=tRCPD8ue1D8VvQyLacDDS2sunfg4gLbw@mail.gmail.com>
 <b0bc03f9f2a5afbe3a77b81648a765348073cc36.camel@axis.com> <Y30LXW5Elcur5mlI@e120937-lin>
 <0b24b15bfee6d97d23caf0225d264c14e0ed48f1.camel@axis.com> <Y4X35fXiPHQ5b0cG@e120937-lin>
In-Reply-To: <Y4X35fXiPHQ5b0cG@e120937-lin>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Tue, 29 Nov 2022 15:57:50 +0100
Message-ID: <CAN5uoS8pFOLqZ3Jd7rHCisUcJvVkfWQqnOE=DUGyC3EURGLsFg@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: Resolve dependency with TEE subsystem
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     =?UTF-8?Q?Ludvig_P=C3=A4rsson?= <Ludvig.Parsson@axis.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian, Ludvig,

For info, I've tested your patches Cristian on my setup.
they did the job for probing optee transport at module initcall level.

br,
etienne

On Tue, 29 Nov 2022 at 13:15, Cristian Marussi <cristian.marussi@arm.com> w=
rote:
>
> On Tue, Nov 29, 2022 at 10:49:10AM +0000, Ludvig P=C3=A4rsson wrote:
> > On Tue, 2022-11-22 at 17:48 +0000, Cristian Marussi wrote:
> > > On Mon, Nov 14, 2022 at 01:47:25PM +0000, Ludvig P=C3=A4rsson wrote:
> > > > On Mon, 2022-11-14 at 12:29 +0100, Etienne Carriere wrote:
> > > > > Hello all,
> > > > >
> > >
> > > Hi Ludvig,
> > >
> > > following up on the issues raised by this thread and a few proposals
> > > that
> > > were flying around (online and offline), in the past days I took the
> > > chance
> > > to have a go at a substantial rework of the init/probe sequences in
> > > the SCMI
> > > core to address the issue you faced with SCMI TEE transport while
> > > trying to
> > > untangle a bit the SCMI core startup sequences (... while also
> > > possibly not
> > > breaking it all :P...)
> > >
> > > In a nutshell, building on an idea from an offline chat with Etienne
> > > ad
> > > Sudeep, now the SCMI bus initialization is split on its own and
> > > initialized at
> > > subsys_initcall level, while the SCMI core stack, including the the
> > > SCMI TEE
> > > transport layer, is moved at module_init layer together with the SCMI
> > > driver users.
> > >
> > > This *should* theoretically solve your issue ... (and it seems like
> > > all the
> > > rest it's still working :P) ... so I was wondering if you can give a
> > > go
> > > at the following pachset on your setup:
> > >
> > > https://gitlab.arm.com/linux-arm/linux-cm/-/commits/scmi_rework_stack=
_init_draft/
> > >
> > > ... note that this is just a draft at the moment, which has undergone
> > > a
> > > reasonable amount of testing on mailbox/virtio transports only in
> > > both a
> > > SCMI builtin and/or modules scenario, but is no where ready for
> > > review.
> > >
> > > The top three patches are really what you need BUT these are probably
> > > tightly bound to that bunch of early fixes you can see in the
> > > branch...so in other words better if you pick the whole branch for
> > > testing :D
> > >
> > > Once you've confirmed me that this solves your issues I'll start the
> > > final cleanup for posting in the next cycle.
> > >
> > > Thanks,
> > > Cristian
> >
> > Hi Cristian,
>
> Hi,
>
> >
> > I tried my best to get the patchset to work somehow on my version of
> > the kernel, and it seems to be working great. I played around with some
> > things, for example changing order of some drivers that were on the
> > same init levels, and it still worked. Only tested with voltage domain
> > protocol and optee transport.
> >
> > Thanks for your great work!
> >
>
> Great, thanks for testing it.
> I'll post shortly a cleaned up series aiming at the next release cycle.
>
> Thanks,
> Cristian
