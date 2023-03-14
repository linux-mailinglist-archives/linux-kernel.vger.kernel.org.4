Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7EA6B983F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCNOqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjCNOpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:45:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9082912BD7;
        Tue, 14 Mar 2023 07:45:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so15364082pjg.4;
        Tue, 14 Mar 2023 07:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678805153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSSadNKXJg8AXXiBQj4WQgn1L+5ZUNSyJt0ncpFtZQY=;
        b=NyO6s63MmEGYwPOGiqLqw4zGHtRJOyZOLkHo8t+nCQ46HCNq/gaWTQ8k48kYUmAxsl
         jGt/H/xgubnN1voz82x2j+cq1O/Hr/eVSs3V7IzqqFJ1+1+vwFZFJHYKpo1MO6NrcPxm
         G/aXNBSSGGDv9z3+238TJk4M/wWcqugL58EyGD+9hxaRzAqrAJYuOBmKehSBSXKp+W9I
         ZHysFryUK6cQgWGtPbxnx0f5qudxe14e3qVVMWcP+hw/R8U+dVqh8dqyfTPhvXJYrlM0
         TXNDlWsVOGNtSWe9fsrLxhz+0FEjHa9HK1qSr16pfnK1IsTH0KsUak50uYYKp8KFZWFe
         uutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678805153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSSadNKXJg8AXXiBQj4WQgn1L+5ZUNSyJt0ncpFtZQY=;
        b=EIjNcYrUWjhtdlpYPUfXBORFyQWQTAOfaQVuCrlhyFx88nFIrq51tmhQfysXYOfOOn
         9aRxxWc3WXOt3b42MHBfiohDi9Irh5NTHnigRHcYXa5+RWstb8FKvkoescDvi5a/J6Qd
         5ff508HOSJzvDR8Jd6Hhxvfytn1Ur1FpkaE0sEdNC0VbTWLGa2AUOaiQhcZZVy3nARnu
         lUy9FS2MzOa+sS5usjPL+xxHtk/DHBp0r2EqquKAwB9rwtPdO+9MW955FMyWOIDanbiB
         Yx9f3k83LX5G8bvIz5rV58+9MlWbQ89KQhdbAQCN8dWCKDvmzs628z3yPvjW2J3YisDf
         lphA==
X-Gm-Message-State: AO0yUKX32s+QpcmtADbBx38e9QRT8WZju1nGpq8v0OcjyeP/3u2pkFQz
        v9ehcjD6kGkZEXJe7ivsQ7KSXz0PqneU88njM6jhCbtDBM4=
X-Google-Smtp-Source: AK7set9wkGGBUJaE/goA/CaijxqDnuNbjscO4aRuIiF4nkMN73XP6haouh3zXaT1sIEajJyHXWHbLchUjvS23lytnrA=
X-Received: by 2002:a17:90a:1d0c:b0:233:eccf:ea10 with SMTP id
 c12-20020a17090a1d0c00b00233eccfea10mr13852274pjd.1.1678805152924; Tue, 14
 Mar 2023 07:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <aa9567fd-38e1-7b9c-b3e1-dc2fdc055da5@molgen.mpg.de>
 <55e30408-ac63-965f-769f-18be5fd5885c@molgen.mpg.de> <d95aa962-9750-c27c-639a-2362bdb32f41@cloud.ionos.com>
 <30576384-682c-c021-ff16-bebed8251365@molgen.mpg.de> <cdc0b03c-db53-35bc-2f75-93bbca0363b5@molgen.mpg.de>
 <bc342de0-98d2-1733-39cd-cc1999777ff3@molgen.mpg.de> <c3390ab0-d038-f1c3-5544-67ae9c8408b1@cloud.ionos.com>
 <a27c5a64-62bf-592c-e547-1e8e904e3c97@molgen.mpg.de> <6c7008df-942e-13b1-2e70-a058e96ab0e9@cloud.ionos.com>
 <12f09162-c92f-8fbb-8382-cba6188bfb29@molgen.mpg.de> <6757d55d-ada8-9b7e-b7fd-2071fe905466@cloud.ionos.com>
 <93d8d623-8aec-ad91-490c-a414c4926fb2@molgen.mpg.de> <0bb7c8d8-6b96-ce70-c5ee-ba414de10561@cloud.ionos.com>
 <e271e183-20e9-8ca2-83eb-225d4d7ab5db@molgen.mpg.de> <1cdfceb6-f39b-70e1-3018-ea14dbe257d9@cloud.ionos.com>
 <7733de01-d1b0-e56f-db6a-137a752f7236@molgen.mpg.de> <d92922af-f411-fc53-219f-154de855cd13@cloud.ionos.com>
 <CAH6h+hf7Y-kurBJG+pnH6WCQiaEK+Jq3KG5JOGnHJ4Uw6AbUjg@mail.gmail.com> <2af18cf7-05eb-f1d1-616a-2c5894d1ac43@linux.dev>
In-Reply-To: <2af18cf7-05eb-f1d1-616a-2c5894d1ac43@linux.dev>
From:   Marc Smith <msmith626@gmail.com>
Date:   Tue, 14 Mar 2023 10:45:41 -0400
Message-ID: <CAH6h+hc8VdpaS2q4ya_ZfqVxWFRsKVCjN-sv73SfeyGomXvjRQ@mail.gmail.com>
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle" transition
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Donald Buczek <buczek@molgen.mpg.de>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        it+raid@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 9:55=E2=80=AFAM Guoqing Jiang <guoqing.jiang@linux.=
dev> wrote:
>
>
>
> On 3/14/23 21:25, Marc Smith wrote:
> > On Mon, Feb 8, 2021 at 7:49=E2=80=AFPM Guoqing Jiang
> > <guoqing.jiang@cloud.ionos.com> wrote:
> >> Hi Donald,
> >>
> >> On 2/8/21 19:41, Donald Buczek wrote:
> >>> Dear Guoqing,
> >>>
> >>> On 08.02.21 15:53, Guoqing Jiang wrote:
> >>>>
> >>>> On 2/8/21 12:38, Donald Buczek wrote:
> >>>>>> 5. maybe don't hold reconfig_mutex when try to unregister
> >>>>>> sync_thread, like this.
> >>>>>>
> >>>>>>           /* resync has finished, collect result */
> >>>>>>           mddev_unlock(mddev);
> >>>>>>           md_unregister_thread(&mddev->sync_thread);
> >>>>>>           mddev_lock(mddev);
> >>>>> As above: While we wait for the sync thread to terminate, wouldn't =
it
> >>>>> be a problem, if another user space operation takes the mutex?
> >>>> I don't think other places can be blocked while hold mutex, otherwis=
e
> >>>> these places can cause potential deadlock. Please try above two line=
s
> >>>> change. And perhaps others have better idea.
> >>> Yes, this works. No deadlock after >11000 seconds,
> >>>
> >>> (Time till deadlock from previous runs/seconds: 1723, 37, 434, 1265,
> >>> 3500, 1136, 109, 1892, 1060, 664, 84, 315, 12, 820 )
> >> Great. I will send a formal patch with your reported-by and tested-by.
> >>
> >> Thanks,
> >> Guoqing
> > I'm still hitting this issue with Linux 5.4.229 -- it looks like 1/2
> > of the patches that supposedly resolve this were applied to the stable
> > kernels, however, one was omitted due to a regression:
> > md: don't unregister sync_thread with reconfig_mutex held (upstream
> > commit 8b48ec23cc51a4e7c8dbaef5f34ebe67e1a80934)
> >
> > I don't see any follow-up on the thread from June 8th 2022 asking for
> > this patch to be dropped from all stable kernels since it caused a
> > regression.
> >
> > The patch doesn't appear to be present in the current mainline kernel
> > (6.3-rc2) either. So I assume this issue is still present there, or it
> > was resolved differently and I just can't find the commit/patch.
>
> It should be fixed by commit 9dfbdafda3b3"md: unlock mddev before reap
> sync_thread in action_store".

Okay, let me try applying that patch... it does not appear to be
present in my 5.4.229 kernel source. Thanks.

--Marc


>
> Thanks,
> Guoqing
