Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96819651F55
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiLTK5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiLTK5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:57:03 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45BE186DE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:57:01 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id r18so8063979pgr.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8k67zJlb+0og1fI70XWWV+fozLhkvG+Z+dJQ3HrHtqE=;
        b=S76Fjpo4Im91Fh+ZJaaRXNoMDOcanklJ+h89vMJ1hCTw0ElKEsVOy49V6+zO9+1sDk
         znfRGUvW01hcoI7wUQWXNP2jQ8hsds4OvlTstJ2cSiaV3tdiV95Cur3tCjucNR2+zgHT
         81GECtD2O5D7zGQ4BIkJ6psBlbFOinOhVb9qygVNHwfqju3m88enbw7Aeos84B1FLyF3
         Oz7Ug560RPP4WKuMnakDBG7vp7WpPd/onO6l++NNoD13Lq9VjLD/eX9W9WpTTN9HRsBZ
         g1yBJwPn8v2B/tyZVJFkjjcL6YuxYD9r7lLdrdXi2+i0+8SJrs+DujeNpukO4V7pzz5l
         EDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8k67zJlb+0og1fI70XWWV+fozLhkvG+Z+dJQ3HrHtqE=;
        b=1cZQPc1IYqGeyg714QqkE1KvAFPUeMTwVCnI/Vdv7S1Xu8cLpYwFgjf8oQGs3HmuMr
         YwT+45ZHTIWqYs2k9NEfLSx73SVLKJ22X5Uhkv2lbI4PnrEohzo2WOQ13kuZPTweY6Pj
         TG+nN9pLSGgbsrwfaCiqGDT+hYWdViQVK41Z4Xj+yH5NmO7j0nEs0dhwEIy7AtJtJFPJ
         639tV++zHxJQ7qyXFbuAxTVnZVHKFdtLTtDzIshVE0Wy6XAM2B6EwPcJFnCBR93TAEtZ
         cHhvmtdROhv/tELYE3zOk69opvSu/NkOpYnZVUtGTNSFNpaDhunicOa2PYCVUiF0RT0T
         cG/Q==
X-Gm-Message-State: ANoB5pkoZ3MRXsWFF/6yby9R7jtiBBW8HjVcbHM0psdHRway5oGsqsTz
        PHCGNJz2UdDAAroYLCx870s5OOQrrViACS6bsdWPfA==
X-Google-Smtp-Source: AA0mqf4SfnRWAmtLOQ27NPQzaK9OiPvPjKOga3rESBawRntpFwTC7BSFOdam4RCRPR6uChj73OCwVIssJhEljFbk6ho=
X-Received: by 2002:aa7:928f:0:b0:56d:2e71:449 with SMTP id
 j15-20020aa7928f000000b0056d2e710449mr81425859pfa.46.1671533821368; Tue, 20
 Dec 2022 02:57:01 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvz1eNS5fw1Wg5f4HqwdWPNg3EQyrGZVEOJ=OQzYzZ_YQ@mail.gmail.com>
 <1671532079.1159124-1-xuanzhuo@linux.alibaba.com> <CA+G9fYvd3SuT6ijxO8J1+zx05ZvSR8dspz7vKgSWB+c_AvkqnQ@mail.gmail.com>
 <20221220054426-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221220054426-mutt-send-email-mst@kernel.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 20 Dec 2022 11:56:50 +0100
Message-ID: <CADYN=9+CbdhP03o2TCY2K+u-OD2wT+yPpJ+oHtrSxGMnyXckAw@mail.gmail.com>
Subject: Re: next: kernel BUG at drivers/virtio/virtio.c:122!
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>,
        Angus Chen <angus.chen@jaguarmicro.com>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        virtualization@lists.linux-foundation.org, dmitry.fomichev@wdc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2022 at 11:44, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Dec 20, 2022 at 04:12:05PM +0530, Naresh Kamboju wrote:
> > On Tue, 20 Dec 2022 at 16:04, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Tue, 20 Dec 2022 14:51:54 +0530, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > > The qemu-x86_64 and qemu-arm64 boot failed with Linux next-20221220 tag.
> > > > It is always reproducible with gcc-11/ gcc-12 and clang tool chains.
> > > >
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > >
> > > > <6>[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> > > > <5>[    0.000000] Linux version 6.1.0-next-20221220 (tuxmake@tuxmake)
> > > > (Debian clang version 16.0.0
> > > > (++20221218072110+9c1b82599dac-1~exp1~20221218072217.501), Debian LLD
> > > > 16.0.0) #1 SMP PREEMPT @1671498176
> > > > <5>[    0.000000] random: crng init done
> > > > <6>[    0.000000] Machine model: linux,dummy-virt
> > > > ....
> > > > <6>[    3.571098] loop: module loaded
> > > > <6>[    3.573410] virtio_blk virtio0: 1/0/0 default/read/poll queues
> > > > <5>[    3.578816] virtio_blk virtio0: [vda] 2816420 512-byte logical
> > > > blocks (1.44 GB/1.34 GiB)
> > > > <4>[    3.581234] ------------[ cut here ]------------
> > > > <2>[    3.581595] kernel BUG at drivers/virtio/virtio.c:122!
> > > > <0>[    3.582906] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> > > > <4>[    3.583672] Modules linked in:
> > > > <4>[    3.584905] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> > > > 6.1.0-next-20221220 #1
> > > > <4>[    3.585801] Hardware name: linux,dummy-virt (DT)
> > > > <4>[    3.586591] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT
> > > > -SSBS BTYPE=--)
> > > > <4>[    3.587349] pc : virtio_check_driver_offered_feature+0x60/0x6c
> > > > <4>[    3.588613] lr : virtblk_probe+0x7cc/0x8f0

I bisected this problem down to this
patch 0562d7bf1604 ("virtio-blk: add support for zoned block devices")
see the full bisection log [1].

I built just a plain defconfig for an arm64 kernel.
I used tuxmake and tuxrun to do the bisection a commanline like this:
$ git bisect start next-20221220 next/stable \
   && git bisect run tuxmake --runtime podman \
   --target-arch arm64 --toolchain gcc-12 \
   --kconfig defconfig kernel @tuxrun-arm64

Pre-req: install tuxmake [2], tuxrun [3] and podman and store a tuxmake
result-hook in your $HOME/.config/tuxmake dir
$ mkdir -p ~/.config/tuxmake/
$ curl -sSL http://ix.io/4j6v -o ~/.config/tuxmake/tuxrun-arm64

I reverted the patch and the kernel booted fine.

Cheers,
Anders
[1] http://ix.io/4j6B
[2] https://tuxmake.org/
[3] https://tuxrun.org/
[4] http://ix.io/4j6v
