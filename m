Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F151E6DF284
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjDLLFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDLLFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:05:42 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B56165B0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:05:41 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54ee17a659bso213011507b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681297540; x=1683889540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r1UJnL+g1sgvldq85JC2yBYX8dKaLXOu2Roxifi7aBE=;
        b=h3OqGmMYVvak/nl8v8VOgkyGOpX2n38WNl4qIOam2PnpkJuYp1q2g+uExhahBlNHwK
         480TKh3xhS+DX4L8fwxAAOoFmf8vZ0CK15nmXfhCSrKXfcY4Ttii/gIbCkUFlHOrp1bg
         qf9lN8rXq6TEEqZ/82PZHnyZ+TZD+P0u9cQ0xMbKYwFy7oyhg2tW0G4qt9DBAIfbNpOu
         2Gf5xiemcKv7WWCH1DTPyWvs5xfZ382WkR/Pw7+PjQGFaDJFxnlOA4dRVrDGp889fLWV
         RzrsRBz9FX/tQAtTzFBKi87ZUVf0ShzbeFxlVWYfK+qQ7A2AZXWOlgxLg1qnwLhN9HAk
         3HkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681297540; x=1683889540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1UJnL+g1sgvldq85JC2yBYX8dKaLXOu2Roxifi7aBE=;
        b=k/i7/eTvxZPEzqAHRkFnv7r0xkUASM7So5XGO8SXC/dA5OlrBm5C4jcv8L3HOt0naJ
         lzIQECTlip/d7VX5V6K+23uic9OjeshNaO08c+Bu14Q8K1YeV+c1wmWNnMetuQ9lm9Qm
         jCXxAlAeIexpFcFOmpyDGFyyKCUCdsHSz1X6cL0PygRLsxiNw8nUUEezS2v40irUY1d2
         a4dxaXtF6OlV2W61q+8RqvgAHtXDUoo6Z3DJq4po/0azrmJBP49fLIjpClgre2Eq+Z52
         /bLjJZ4Q2LqvWjWZ/Csb92esVIgjQjzqtVnfFLGItGVRG0hXBNxklrUqOxmW8VVieXtY
         m8EQ==
X-Gm-Message-State: AAQBX9e5E+WJp+0js/K0SxdMzx26ugIo+fG5koD8s508+N6rydcvsB7G
        U71eZDRJNSNkLqslPr3Jexdbh/2m3AoMRY/Ji/23pg==
X-Google-Smtp-Source: AKy350a0gNDPfxZRX0VNCJg343uWMNNcrtPBnCXkkM+eWuW1HdvOcJesB015WcdgLsCEPqEoOxvMQeaDJxPDlaWc2SU=
X-Received: by 2002:a81:b184:0:b0:545:f7cc:f30 with SMTP id
 p126-20020a81b184000000b00545f7cc0f30mr7972164ywh.0.1681297540207; Wed, 12
 Apr 2023 04:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230329202148.71107-1-dennis@kernel.org> <ZCTOMVjW+pnZVGsQ@snowbird>
 <CAPDyKFrcdJuyA9B-JDReacT2z1ircDoY4oTXZQ8AVFk6UEFYsw@mail.gmail.com>
 <ZCclEE6Qw3on7/eO@snowbird> <CAPDyKFqc33gUYXpY==jbNrOiba2_xUYLs-bv0RTYYU5d8T0VBA@mail.gmail.com>
 <ZC/TL2/gLre0B4xH@snowbird>
In-Reply-To: <ZC/TL2/gLre0B4xH@snowbird>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Apr 2023 13:05:04 +0200
Message-ID: <CAPDyKFoq==uxyenQu2ZwLHqMGSK=8ZxdzwU5mm2MPTeLXj0xgg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023 at 10:24, Dennis Zhou <dennis@kernel.org> wrote:
>
> On Mon, Apr 03, 2023 at 11:50:41AM +0200, Ulf Hansson wrote:
> > On Fri, 31 Mar 2023 at 20:23, Dennis Zhou <dennis@kernel.org> wrote:
> > >
> > > Hi Ulf,
> > >
> > > On Fri, Mar 31, 2023 at 02:43:10PM +0200, Ulf Hansson wrote:
> > > > On Thu, 30 Mar 2023 at 01:48, Dennis Zhou <dennis@kernel.org> wrote:
> > > > >
> > > > > When using dm-verity with a data partition on an emmc device, dm-verity
> > > > > races with the discovery of attached emmc devices. This is because mmc's
> > > > > probing code sets up the host data structure then a work item is
> > > > > scheduled to do discovery afterwards. To prevent this race on init,
> > > > > let's inline the first call to detection, __mm_scan(), and let
> > > > > subsequent detect calls be handled via the workqueue.
> > > >
> > > > In principle, I don't mind the changes in $subject patch, as long as
> > > > it doesn't hurt the overall initialization/boot time. Especially, we
> > > > may have more than one mmc-slot being used, so this needs to be well
> > > > tested.
> > > >
> > >
> > > I unfortunately don't have a device with multiple mmcs available. Is
> > > this something you could help me with?
> >
> > Yes, I can help to test. Allow me a few days to see what I can do.
> >
> > Note that, just having one eMMC and one SD card should work too. It
> > doesn't have to be multiple eMMCs.
> >
> > >
> > > > Although, more importantly, I fail to understand how this is going to
> > > > solve the race condition. Any I/O request to an eMMC or SD requires
> > > > the mmc block device driver to be up and running too, which is getting
> > > > probed from a separate module/driver that's not part of mmc_rescan().
> > >
> > > I believe the call chain is something like this:
> > >
> > > __mmc_rescan()
> > >     mmc_rescan_try_freq()
> > >         mmc_attach_mmc()
> > >             mmc_add_card()
> > >                 device_add()
> > >                     bus_probe_device()
> > >                         mmc_blk_probe()
> > >
> > > The initial calling of this is the host probe. So effectively if there
> > > is a card attached, we're inlining the device_add() call for the card
> > > attached rather than waiting for the workqueue item to kick off.
> > >
> > > dm is a part of late_initcall() while mmc is a module_init(), when built
> > > in becoming a device_initcall(). So this solves a race via the initcall
> > > chain. In the current state, device_initcall() finishes and we move onto
> > > the late_initcall() phase. But now, dm is racing with the workqueue to
> > > init the attached emmc device.
> >
> > You certainly have a point!
> >
> > This should work when the mmc blk module is built-in. Even if that
> > doesn't solve the entire problem, it should be a step in the right
> > direction.
> >
> > I will give it some more thinking and run some tests at my side, then
> > I will get back to you again.
> >
>
> Hi Ulf, is there an update on testing with this patch?

Sorry, it's a busy period for me and I expect it to remain like that
for another couple of weeks.

I will try to squeeze in some time for this, but no promises. Sorry.

[...]

Kind regards
Uffe
