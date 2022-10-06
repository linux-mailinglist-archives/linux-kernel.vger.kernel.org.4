Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446345F6E36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiJFT2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJFT2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:28:43 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37809E6AD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:28:41 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id g2-20020a4ac4c2000000b0047f703cbe86so2085878ooq.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QylbASj8mHMoZsensOf73cgYUPu6ciE5d8nOL8LnqTw=;
        b=GVveOlL1VjgEAGjoHyLhI8srzUiM+TTa6AisI33mOwo29FUxPFH3pUyhV7rqYAbR2a
         O1xyWQ6JDA7r9Ql4bfGTVWs84D1mkmsOzlrmGHnm3ct0NUm1bXfxPj6R2BFNKYvnHGW8
         wfb3nY4hnMxN3Av6FeWdMUDs1qAv3Tyy1Q6n4TCQeFrnbliWL/P4KAtIiZRu4srskDxv
         tJoxWpyirqYAhUWoL3FRfQdDddBGWzZup+QMtVtxJnWUdwBUOopRaRBhy+UZB6rWJql+
         lAH4T7wgVKW0/9mMR3ZKUHp/fKfDgx4Z8oEKyizhyiiqdUxL+/rrcI0wemV5+13VD3lh
         AxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QylbASj8mHMoZsensOf73cgYUPu6ciE5d8nOL8LnqTw=;
        b=WBxa25PmGeZ9oZY6pSz4k7pLbCq/F154+uIHJPw2mbcNU6q264KFc8N97ctCEbRx/S
         aMGo81rJCqRSlGolBSMIyvwTyvfc3hda6qxRSEUXGBXsVKfwN8zadjf2ErpQQ5XPbA/f
         my66761pUQiPVALsZuJNcNRuw3dx5+4fP08TLopYc02VEF2D6nZdtEA1hgD/I6GoGRuv
         1u1G+2pvtdpnUNnZb3ZuPB+na91gCOHtd3275Qx/+Qqk2omW5MrmmPnDns4m9mvORavX
         5/LWzM2iAunTN1qwOfTv2zDPJJiSoI0yc5adW5yI1tk+q7ccXz1kOato5UZdB2iS4zcp
         xGGQ==
X-Gm-Message-State: ACrzQf1JqrmcE3BXRE20ufPbyKs3HB12GQJ9kS1mGIpxG+Nvrhzsxf59
        kS9QWGJ61fGd76ebKggaJmwJd+rParitNuIxsc4=
X-Google-Smtp-Source: AMsMyM40pemucAMFt3x2dRzM1fcF+9+BTps0a0I4ERP0s9acIagU6U36M5B5fb0R3kh6xLHbX/596A/Fd8ZmTSFD944=
X-Received: by 2002:a9d:6215:0:b0:660:f41e:513a with SMTP id
 g21-20020a9d6215000000b00660f41e513amr619627otj.123.1665084520085; Thu, 06
 Oct 2022 12:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
 <CAHk-=whUp5Ufur6Bmv=H-rDDTNJJ-KVqOKkL+5FmR01jp0dbcA@mail.gmail.com>
In-Reply-To: <CAHk-=whUp5Ufur6Bmv=H-rDDTNJJ-KVqOKkL+5FmR01jp0dbcA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 6 Oct 2022 15:28:28 -0400
Message-ID: <CADnq5_Of-8ZyBxee0fZ=0x-eV-2NX_+e9sd-9nmuHdLugSHp2g@mail.gmail.com>
Subject: Re: [git pull] drm for 6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
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

On Thu, Oct 6, 2022 at 2:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Oct 4, 2022 at 8:42 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > Lots of stuff all over, some new AMD IP support and gang
> > submit support [..]
>
> Hmm.
>
> I have now had my main desktop lock up twice after pulling this.
> Nothing in the dmesg after a reboot, and nothing in particular that
> seems to trigger it, so I have a hard time even guessing what's up,
> but the drm changes are the primary suspect.
>
> I will try to see if I can get any information out of the machine, but
> with the symptom being just a dead machine ...
>
> This is the same (old) Radeon device:
>
>    49:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X/590] (rev e7)
>
> with dual 4k monitors, running on my good old Threadripper setup.
>
> Again, there's no explicit reason to blame the drm pull, except that
> it started after that merge (that machine ran the kernel with the
> networking pull for a day with no problems, and while there were other
> pull requests in between them, they seem to be fairly unrelated to the
> hardware I have).
>
> But the lockup is so sporadic (twice in the last day) that I really
> can't bisect it, so I'm afraid I have very very little info.
>
> Any suggestions?

Maybe you are seeing this which is an issue with GPU TLB flushes which
is kind of sporadic:
https://gitlab.freedesktop.org/drm/amd/-/issues/2113
Are you seeing any GPU page faults in your kernel log?

Alex
