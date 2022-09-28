Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0995EE4A8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiI1Sy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiI1Syx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:54:53 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0552FFE6;
        Wed, 28 Sep 2022 11:54:50 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id i12so3775932qvs.2;
        Wed, 28 Sep 2022 11:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9819DIn5cz+DhTm0obBSo3ryJjp2/XGyvfjqokkY82w=;
        b=jeYmgn29b77/vVeyCTHdY6ntxpWPNknjR/wUWFc8YbRfkIG/PB39U9lKSXftn/B80b
         OkjZA9Xlbc48xv0u+51wKzk5HALU0KW4GWkBhBfyZYaWl+A5lAePMYzrn3Wl/aDolZry
         Oum2O3pMEe2sCUQ6uckNxiIwVJJghAR1FL/ujfj00ydZkMa4FkYH46yTBCOM9Mhk2tML
         mogmWRaqW5FcSJMehb/9e6SIk6hVnSB7NK9cLRD63plOwjzaIEpJV3fCQkLmCLLGQEM+
         W2XAekM13ZuZboIMcwP5C7ugiPHuBqag+lS6hR1RyC/GLi05aC2lX2vPETZrV7XPc91y
         mcsg==
X-Gm-Message-State: ACrzQf3CXWfZSKUtiZ036gS2Vsv+CbVB9N/taJ2o2LlDtecJNE8JLoQp
        AlNWJH6M6V9coX/mGyi405HPDyImw3kodkvqR4Q=
X-Google-Smtp-Source: AMsMyM5WCwldeJpfldUvSKKJnSka4+LWf8/LXSQcfG2XP7MWG0Rjl0WKbeGo6U1xTJ0W7yvseYzvdiQNTVz8pgAPh4o=
X-Received: by 2002:a0c:f3cb:0:b0:4af:a435:2c1b with SMTP id
 f11-20020a0cf3cb000000b004afa4352c1bmr318835qvm.130.1664391289840; Wed, 28
 Sep 2022 11:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220915164411.2496380-1-kajetan.puchalski@arm.com> <YzRBLiHByw5xPaU3@e126311.manchester.arm.com>
In-Reply-To: <YzRBLiHByw5xPaU3@e126311.manchester.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Sep 2022 20:54:38 +0200
Message-ID: <CAJZ5v0g8=mqiBC9LwQYOw15UZujaV8XoWoor8z=H+nG_aFc_3g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] cpuidle: teo: Introduce optional util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 28, 2022 at 2:42 PM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> Hi Rafael,
>
> Just a gentle ping here. Could you please take a look at this
> discussion?

I have seen it, but I haven't thought it through yet.

Overall, this is quite subtle and requires quite a bit of consideration IMV.

> I'd like to address some comments I received, especially on the subject
> of making it reduce the state by one as opposed to going all the way to
> 0 to account for different hardware and how we can accomodate different
> architectures in the implementation of that mechanism.

I need to think more about that.

> Before I send a v2 it'd be great to know your opinions on this and
> whether I should still send it as a TEO patch or fork it into a separate
> governor and make the changes there as both Doug and I seem to prefer.

Well, it is not a super-large patch against TEO, so I'm not sure if
adding a new governor just for this one bit is a good idea.

I surely don't like the #ifdeffery there, so if it can be made part of
the default TEO behavior, it will be much more appealing to me.

Thanks!

> On Thu, Sep 15, 2022 at 05:44:10PM +0100, Kajetan Puchalski wrote:
> > At the very least this approach seems promising so I wanted to discuss it in RFC form first.
> > Thank you for taking your time to read this!
> >
> > [1] https://github.com/mrkajetanp/lisa-notebooks/blob/a2361a5b647629bfbfc676b942c8e6498fb9bd03/idle_util_aware.pdf
> >
> > Kajetan Puchalski (1):
> >   cpuidle: teo: Introduce optional util-awareness
> >
> >  drivers/cpuidle/Kconfig         | 12 +++++
> >  drivers/cpuidle/governors/teo.c | 86 +++++++++++++++++++++++++++++++++
> >  2 files changed, 98 insertions(+)
> >
> > --
> > 2.37.1
> >
