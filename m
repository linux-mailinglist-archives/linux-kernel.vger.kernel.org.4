Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB136CCE74
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 02:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjC2AB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 20:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjC2AB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 20:01:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF38AF;
        Tue, 28 Mar 2023 17:01:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BDC2618E5;
        Wed, 29 Mar 2023 00:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE908C433EF;
        Wed, 29 Mar 2023 00:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680048084;
        bh=RVxXcEiibRebSGr+aKRiwje0chKKQkgOOPr8eSlVSkY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=awFjxt5m0rkRkcTeDWE3+14Tkz0Ts+OA3EknP8LyGLYSJKo7krFIZWEkt/fa7t6jW
         QxwfuThJ/kmJ4Landpwg9VLqnUnT7tGY9Y5MVxEJMQZWjYtEqwd4hutizbqCT6aXS6
         EwpOxhJfxIuhpGi99UdCv1iphl/Uml/hs3cGcz0ILoc53cwbQxalNiTwc+eOVg3Fss
         kaAdLvwMDeFOb40RvTGnw/pdg5rubsjNIF3qvm+1GwzMRqdKYpqSHOKqez44Gy7OVP
         9TZu5SU83+qbpoAxi7zBCDKNnHpJl0V4yXsQtYRb6M+qQajFKYxoMUl29Ms32Xqma8
         uBWdN0XzJ+Gpw==
Received: by mail-lf1-f49.google.com with SMTP id h11so11007489lfu.8;
        Tue, 28 Mar 2023 17:01:24 -0700 (PDT)
X-Gm-Message-State: AAQBX9ci19N+jOu5gFVsNadSuILBcG+PrLw9rM6qNu7+DGHqohK4DRHG
        X4u9ocCdGJp9bfO4/KKlxZ6O4j21M6gikWgkCos=
X-Google-Smtp-Source: AKy350b6mMLErOC4Bt39LRAAoBVZQ1UY0GpckPACTLqkHA0ji0rRxAVibRESZV5L9UB9RCqQS1oIe6imBco637i/Krw=
X-Received: by 2002:ac2:5dcd:0:b0:4e8:5bed:a051 with SMTP id
 x13-20020ac25dcd000000b004e85beda051mr5202722lfq.3.1680048082691; Tue, 28 Mar
 2023 17:01:22 -0700 (PDT)
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
 <CAH6h+hf7Y-kurBJG+pnH6WCQiaEK+Jq3KG5JOGnHJ4Uw6AbUjg@mail.gmail.com>
 <2af18cf7-05eb-f1d1-616a-2c5894d1ac43@linux.dev> <CAH6h+hc8VdpaS2q4ya_ZfqVxWFRsKVCjN-sv73SfeyGomXvjRQ@mail.gmail.com>
 <CAH6h+hcWfXNpC1Mro3zfzQc8tK142vuaOMELLJL7mg_G+o0fXw@mail.gmail.com>
In-Reply-To: <CAH6h+hcWfXNpC1Mro3zfzQc8tK142vuaOMELLJL7mg_G+o0fXw@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Mar 2023 17:01:09 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6R11y6vETeZ4vmFGmV6DRrj2gwhp1-Nm+csvtHb2nQYg@mail.gmail.com>
Message-ID: <CAPhsuW6R11y6vETeZ4vmFGmV6DRrj2gwhp1-Nm+csvtHb2nQYg@mail.gmail.com>
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle" transition
To:     Marc Smith <msmith626@gmail.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Donald Buczek <buczek@molgen.mpg.de>,
        linux-raid@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        it+raid@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 8:25=E2=80=AFAM Marc Smith <msmith626@gmail.com> wr=
ote:
>
> On Tue, Mar 14, 2023 at 10:45=E2=80=AFAM Marc Smith <msmith626@gmail.com>=
 wrote:
> >
> > On Tue, Mar 14, 2023 at 9:55=E2=80=AFAM Guoqing Jiang <guoqing.jiang@li=
nux.dev> wrote:
> > >
> > >
> > >
> > > On 3/14/23 21:25, Marc Smith wrote:
> > > > On Mon, Feb 8, 2021 at 7:49=E2=80=AFPM Guoqing Jiang
> > > > <guoqing.jiang@cloud.ionos.com> wrote:
> > > >> Hi Donald,
> > > >>
> > > >> On 2/8/21 19:41, Donald Buczek wrote:
> > > >>> Dear Guoqing,
> > > >>>
> > > >>> On 08.02.21 15:53, Guoqing Jiang wrote:
> > > >>>>
> > > >>>> On 2/8/21 12:38, Donald Buczek wrote:
> > > >>>>>> 5. maybe don't hold reconfig_mutex when try to unregister
> > > >>>>>> sync_thread, like this.
> > > >>>>>>
> > > >>>>>>           /* resync has finished, collect result */
> > > >>>>>>           mddev_unlock(mddev);
> > > >>>>>>           md_unregister_thread(&mddev->sync_thread);
> > > >>>>>>           mddev_lock(mddev);
> > > >>>>> As above: While we wait for the sync thread to terminate, would=
n't it
> > > >>>>> be a problem, if another user space operation takes the mutex?
> > > >>>> I don't think other places can be blocked while hold mutex, othe=
rwise
> > > >>>> these places can cause potential deadlock. Please try above two =
lines
> > > >>>> change. And perhaps others have better idea.
> > > >>> Yes, this works. No deadlock after >11000 seconds,
> > > >>>
> > > >>> (Time till deadlock from previous runs/seconds: 1723, 37, 434, 12=
65,
> > > >>> 3500, 1136, 109, 1892, 1060, 664, 84, 315, 12, 820 )
> > > >> Great. I will send a formal patch with your reported-by and tested=
-by.
> > > >>
> > > >> Thanks,
> > > >> Guoqing
> > > > I'm still hitting this issue with Linux 5.4.229 -- it looks like 1/=
2
> > > > of the patches that supposedly resolve this were applied to the sta=
ble
> > > > kernels, however, one was omitted due to a regression:
> > > > md: don't unregister sync_thread with reconfig_mutex held (upstream
> > > > commit 8b48ec23cc51a4e7c8dbaef5f34ebe67e1a80934)
> > > >
> > > > I don't see any follow-up on the thread from June 8th 2022 asking f=
or
> > > > this patch to be dropped from all stable kernels since it caused a
> > > > regression.
> > > >
> > > > The patch doesn't appear to be present in the current mainline kern=
el
> > > > (6.3-rc2) either. So I assume this issue is still present there, or=
 it
> > > > was resolved differently and I just can't find the commit/patch.
> > >
> > > It should be fixed by commit 9dfbdafda3b3"md: unlock mddev before rea=
p
> > > sync_thread in action_store".
> >
> > Okay, let me try applying that patch... it does not appear to be
> > present in my 5.4.229 kernel source. Thanks.
>
> Yes, applying this '9dfbdafda3b3 "md: unlock mddev before reap
> sync_thread in action_store"' patch on top of vanilla 5.4.229 source
> appears to fix the problem for me -- I can't reproduce the issue with
> the script, and it's been running for >24 hours now. (Previously I was
> able to induce the issue within a matter of minutes.)

Hi Marc,

Could you please run your reproducer on the md-tmp branch?

https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/log/?h=3Dmd-tmp

This contains a different version of the fix by Yu Kuai.

Thanks,
Song
