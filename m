Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0DD6A61F2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjB1V6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjB1V6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:58:04 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F37011175
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:58:02 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l1so11314802pjt.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677621482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zT2Z59SyUMMx6e7nQOd4Y0e0wzjXIYNSwDsukVzhlNU=;
        b=Nsdhqqj2NAcNHj2DSBZ+kS5jRtdqO1utNXx7SAbLK0yH86JWAe9okdx3cmSTDAFyfe
         37ogiE7menuoVRArjVndBX9XVxS4xzFY39Yg7dbN4B3OES8E3feaews1w7Y0tLw8g80U
         f7gyTG+rsuiSAUXrPXu3qbYxbAxv2Q+2PLfLTi9DKnIDbgC5laxseX130GU+8SqkrggW
         g92RuJEHmtR5D1LiKyiNTL8hSWVpqKplI6qNjli28NNdAE/NYaedmX5AIUH3CzcrYB1m
         w9iYyGwlp9ECD7akzFK69VgVpSozhiR0DG64qwSlXV1VUc4E7eB9gdBHNK2WttHSJ7ah
         e6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677621482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zT2Z59SyUMMx6e7nQOd4Y0e0wzjXIYNSwDsukVzhlNU=;
        b=BSyXAe+tXKsID/xdsDZuZDl2vUqA8ptvOHycTlwflui8M7UtmPqwyMDMMHVfn5hJEO
         ySC+X/P582hiQFfydWpOvUPyuQ2tidxx1WrjavzX6oSRSqNfyAbPQN5G1VB8qxANuwJD
         DsgVxLmH0T5PDDLKeXosjGioFZlmgKUAai+BRKcbVLsXF/VNi9VAIsljhdj5DyfKjPOV
         UiKXk5R5lC6tIIClaZU55cnG5OgLj2XbaUGO+i8azFBVFjQfWrIRQL4eIe5IbwKSdCQK
         gEB+y8amNpDrNaGQS02xP/wRX1sYbVR9bsBOpdvB2fw0s89ksF7PE/pfabsyRhteBIXx
         eV5w==
X-Gm-Message-State: AO0yUKVH+npjlFxGyXWmpEIy/8epFiRJd2m6pIqydcBQ2+r0quJDnO5g
        M23839M8NZWyo9ZkbR7GuGDJ2DDmTGtJfYTlI/sbGe9dt1aFRWzp
X-Google-Smtp-Source: AK7set88qVqC//7RZJZH7Fy234rgMOzyArOoxOrL3OzXINFMZ9nkmS0e90ROYD3+FtDG7At9brmyXiMAVCz0tkqFd4g=
X-Received: by 2002:a17:90a:9c06:b0:236:736d:2581 with SMTP id
 h6-20020a17090a9c0600b00236736d2581mr1662417pjp.8.1677621482115; Tue, 28 Feb
 2023 13:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20230228174019.4004581-1-jjhiblot@traphandler.com>
 <CAGETcx-w4A3fz_DPqJG+9P6ETGAPv547DcnsO52gqTO1_vijsw@mail.gmail.com> <CAL_JsqL6qFDC5uC_0PgyM_8OVEwFq+o=gPk2=PRKBDTp9XTzOw@mail.gmail.com>
In-Reply-To: <CAL_JsqL6qFDC5uC_0PgyM_8OVEwFq+o=gPk2=PRKBDTp9XTzOw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 28 Feb 2023 13:57:25 -0800
Message-ID: <CAGETcx9DGK8Ass-f2wo=efHaGcQ8T2xzOqOP5TTrkM+537YPjA@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add missing of_node_get() in parse_interrupt()
To:     Rob Herring <robh+dt@kernel.org>
Cc:     jjhiblot@traphandler.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 1:01=E2=80=AFPM Rob Herring <robh+dt@kernel.org> wr=
ote:
>
> On Tue, Feb 28, 2023 at 1:07=E2=80=AFPM Saravana Kannan <saravanak@google=
.com> wrote:
> >
> > On Tue, Feb 28, 2023 at 9:40=E2=80=AFAM Jean-Jacques Hiblot
> > <jjhiblot@traphandler.com> wrote:
> > >
> > > From: Jean Jacques Hiblot <jjhiblot@traphandler.com>
> > >
> > > As all the other parsers do, parse_interrupt() must increase the refc=
ount
> > > of the device_node. Otherwise the refcount is decremented every time
> > > parse_interrupt() is called on this node, leading to a potential
> > > use-after-free.
> > >
> > > This is a regression introduced by commit f265f06af194 ("of: property=
:
> > > Fix fw_devlink handling of interrupts/interrupts-extended"). The reas=
on is
> > > that of_irq_parse_one() does not increase the refcount while the prev=
iously
> > > used of_irq_find_parent() does.
> >
> > Thanks for catching the issue Jean!
> >
> > This feels like a bug in of_irq_parse_one() to me. It's returning a
> > reference to a node without doing a of_node_get() on it.
> >
> > Rob, Marc, Do you agree?
>
> I think you are right. If we look at the 'interrupts-extended' path,
> it just calls of_parse_phandle_with_args() which does a get.
>
> > Jean,
> >
> > If they agree, can you please fix of_irq_parse_one() and add a
> > of_node_put() to existing callers (if they aren't already doing a
> > put()).
>
> I think it is not that simple. The correct thing for callers may also
> be to hold the ref. We wouldn't want to just blindly do a put that is
> clearly wrong just to keep current behavior.

Right, I was just giving the approximate idea. If the caller keeps
using the node pointer, they shouldn't do a put().

> But not having the put
> means we're leaking refcounts as calling the APIs originally had no
> side effect. For example, IIRC, of_irq_get() is called again on each
> deferred probe. There is no of_irq_put() because Linux IRQ numbers
> aren't (or weren't?) refcounted.

Hopefully fw_devlink will avoid a lot of these deferred probes. But if
it comes to wasting memory (leaking) vs use after free, we should for
the short term switch to leaking.

IRQ themselves can't be freed once they are registered with the IRQ
framework, but I'd think the consumers can still do a get/put on an
IRQ. So, at the least, we should be able to do some put() from the
consumer context.

> Really, I'd like to get rid of exposing of_irq_parse_one() in the first p=
lace.

I don't have enough context to comment here.

-Saravana
