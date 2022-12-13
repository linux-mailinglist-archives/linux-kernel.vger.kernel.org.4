Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B27B64ACCC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbiLMBKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiLMBKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:10:02 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4DD1BE91
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:10:01 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ja17so4275702wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FMF1WryJYAL52DrPmPV1bTKAGt8XywNx2Fj7RGuPtjc=;
        b=h+3rnHji3fnp12yIK2zcrF8VGXuUr3aJV6N+197XgdZkBVkQpaZU8A0XQ+vx3dXpqE
         RXlmugMS2HqFDHpexayjWvzCN2yYRciPqYzt7q2w75zQ5RlWI0Lja9usVcR9aJf5KTYt
         obB/bIikgDfSVL7b/JHV9emZVPCleobYzPeH2MvwZiPoWmxV+ZvWei7t3m5789iuN9FW
         Fv2n4yrf5iFoTdc3Jf+JthMoVYJLoEKHQaYeg27x+sSmeqU+mjjOHcyZ2OEEnx6+7aTF
         nGbEjKXhBW7lfXO0Vpjk4jO5uFYd+xoxNFNLE7i940y8Pczz/Ps3YS8Ebbbq5GBdIq/0
         xMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMF1WryJYAL52DrPmPV1bTKAGt8XywNx2Fj7RGuPtjc=;
        b=iw0aijhW4Wa7jhTnphkQL4QMlmrjxF17EMfiAaCOM83jGIsPIRZtbRN5p4xH7sy1PI
         8XcrqXMRCgGPrC3pH8UsCTIyhkIzauiiSF5sKXjOl2OrhoyzlNwXIllVP0N3tUphv4mB
         lvQI9MnXKNkdh0xUJ4SRd2uSWUtLqCZGyWIZ1U2A9FB6JpVHiLotQ9oxu+C1k6poiQbC
         XSaUqC81CVUtH7Jj5FDz4UKFvW8fyGDWc5QXb70FsNoTz8pDGcDwzfIx3n8n3koX3g5B
         20ejOvkET1zeCFLZC7ZSyTnHRaTnr8w5qpmE1vFeGjMVzqCWUgNDUOXdVHxqPcvZ8a38
         HxLA==
X-Gm-Message-State: ANoB5pnslz1IChY5eqidWogo5C0Lhw3QshUmMF8iYVSjKN5OguzD/AYC
        dECB1wJPVTcQ+tj6IIGH3DI9lj0nBr2dRakO/kg=
X-Google-Smtp-Source: AA0mqf7sPpV7XxtPtZppQ9vvR6hYztoOIilHXFPgdV+GPKCS1b4ZaB/7LySOcG/L4zqYZyJGYlfnZMoebg0HhnXHRGs=
X-Received: by 2002:a05:600c:5117:b0:3d0:bda:f2c with SMTP id
 o23-20020a05600c511700b003d00bda0f2cmr55619wms.117.1670893800237; Mon, 12 Dec
 2022 17:10:00 -0800 (PST)
MIME-Version: 1.0
References: <20221212061836.3620-1-richard.xnu.clark@gmail.com>
 <Y5bI9ZbjpzNFpk/8@slm.duckdns.org> <CAJhGHyA=qGtktv6BPavo5HRrDkcORqpkD3C7nhnxyFtt8WNJMg@mail.gmail.com>
 <Y5eqyErNGDD0tbF9@slm.duckdns.org>
In-Reply-To: <Y5eqyErNGDD0tbF9@slm.duckdns.org>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Tue, 13 Dec 2022 09:09:48 +0800
Message-ID: <CAJNi4rOpm=6m6Lm65QP-qLvbR19RiyJbvgJNhKfZJWLH7WHR5A@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Prevent a new work item from queueing into a
 destruction wq
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 6:27 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Dec 12, 2022 at 02:48:25PM +0800, Lai Jiangshan wrote:
> > On Mon, Dec 12, 2022 at 2:23 PM Tejun Heo <tj@kernel.org> wrote:
> > >
> > > On Mon, Dec 12, 2022 at 02:18:36PM +0800, Richard Clark wrote:
> > > > Currently the __WQ_DRAINING is used to prevent a new work item from queueing
> > > > to a draining workqueue, but this flag will be cleared before the end of a
> > > > RCU grace period. Because the workqueue instance is actually freed after
> > > > the RCU grace period, this fact results in an opening window in which a new
> > > > work item can be queued into a destorying workqueue and be scheduled
> > > > consequently, for instance, the below code snippet demos this accident:
> > >
> > > I mean, this is just use-after-free. The same scenario can happen with
> > > non-RCU frees or if there happens to be an RCU grace period inbetween. I'm
> > > not sure what's being protected here.
> >
> > I think it is a kind of debugging facility with no overhead in the
> > fast path.
> >
> > It is indeed the caller's responsibility not to do use-after-free.
> >
> > For non-RCU free, the freed workqueue's state can be arbitrary soon and
> > the caller might get a complaint. And if there are some kinds of debugging
> > facilities for freed memory, the system can notice the problem earlier.
> >
> > But now is RCU free for the workqueue, and the workqueue has nothing
> > different between before and after destroy_workqueue() unless the
> > grace period ends and the memory-allocation subsystem takes charge of
> > the memory.
>
> idk, maybe? It seems kinda out of scope. Richard, can you update the patch
> description and comment so that they clearly state that this is a debug aid
> to help spotting user errors?

Sure, will update soon

Thanks

>
> Thanks.
>
> --
> tejun
