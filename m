Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1506BCF0F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCPMNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCPMNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:13:05 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB4727D68
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:12:57 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h14so565428pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678968777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=od3DXQEgQMTx/o+FP1rR4efgPuUI3RgZhMjodxUOCMQ=;
        b=Xfp5zCpRL5o9xpgGA9KNq3E2yeSwqewj4PZEd6554Y3C7TbeDPjIIrQJAFMhmVyalI
         j67tqz5u+Dgp8sujYRnTtna1KXipEk4ArbBd7pZ+kdlmNxAolaMWy8p/wDMAH/t6ymWE
         Ab/anAOuz0+24UzigAswydw/R0dFRV99PcB5D5GlhtJp8541bL9Aj61bPK77lsChAHLN
         oOWfMFRs3w6Luc/KE1Q4oTuWUgr2uhOogpBzg4bcdHoMJ1EVdFpMgFsXvccoveNs8qnB
         Pv6xj/ovtOEyR2x2Gn8PMQrCEilwZQUZ72JLJh5uKFHwnQTF5V5vowugH7ALqnL7iXQZ
         kJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678968777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=od3DXQEgQMTx/o+FP1rR4efgPuUI3RgZhMjodxUOCMQ=;
        b=Yu5meiABpJGcfChHp4jL8zxIJmTMX7Fu06yXMaid2kn2iudth8OPK/Lle8lHRv7Ehh
         e4QHvjs0sA4rfDrrgfeediim1YjeeWpQxuNss6cqnmMG+z7rjz7JUM980Q46mMy/4fcz
         1UaKfoPLMWgjYLRRwjCW36H7J0UyaUdBkcLQHNRnwpAS2Nh/SW93aoeRqWU/hhPAg7+R
         3Tqf6ahRl8OALfCqEF++ebodOQQS8Rsv7x+rixQBZmbPqEEuMrIxcCVTPP55d6oMEfNL
         13HHPreY4ZWNLlmallculbsfpYN6UqtnJ3hjxBbS2f+n2p9wO5hfxl2BO/zwR4lQUpWF
         Zatg==
X-Gm-Message-State: AO0yUKWku2nPI9POrSHmlsm5UAAm7nuJkTUXP1EIB9EpQHdNoLBlBnXG
        zmA6XzA8jupEdKYd3UY4wwu0XZ4Bl29sm84gmPp8lg==
X-Google-Smtp-Source: AK7set9HapZmc3MGh8eI5A7bdNHbn1+PaR0ApOWI44KjvTC3p414zeAEwTFSJltAixl5NdETPdwdBPvyyWRwoa6kV3A=
X-Received: by 2002:a05:6a00:1752:b0:5eb:e0e0:d650 with SMTP id
 j18-20020a056a00175200b005ebe0e0d650mr1153939pfc.6.1678968776834; Thu, 16 Mar
 2023 05:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230302144330.274947-1-ulf.hansson@linaro.org>
 <54cee7de4ab7479db74b21e64e5f53cf@hyperstone.com> <CAPDyKFq-qToEX+qiuHirNbcuedii_f0KKuHiPAv7+tydrUTpqQ@mail.gmail.com>
 <4a2c5b752968496ca72966f80e148d47@hyperstone.com> <3effa855-1668-db9f-7d38-2c3352ea6ef1@intel.com>
 <CAPDyKFpVZaHA0jPBa=uxLSCzcUTZujUzJvh1oqar6NbBHg9wtQ@mail.gmail.com> <ed864feb-fdac-1aae-3f8b-f6e66f3e7598@intel.com>
In-Reply-To: <ed864feb-fdac-1aae-3f8b-f6e66f3e7598@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Mar 2023 13:12:20 +0100
Message-ID: <CAPDyKFp_19Y1QFh4v5abrL6va=cLdz+Ooz3xKu_pqh9rKZwqxw@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bean Huo <huobean@gmail.com>
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

On Tue, 14 Mar 2023 at 09:58, Adrian Hunter <adrian.hunter@intel.com> wrote=
:
>
> On 14/03/23 09:56, Ulf Hansson wrote:
> > On Mon, 13 Mar 2023 at 17:56, Adrian Hunter <adrian.hunter@intel.com> w=
rote:
> >>
> >> On 10/03/23 19:06, Christian L=C3=B6hle wrote:
> >>>
> >>>>>
> >>>>> I have benchmarked the FUA/Cache behavior a bit.
> >>>>> I don't have an actual filesystem benchmark that does what I wanted=
 and is easy to port to the target so I used:
> >>>>>
> >>>>> # call with
> >>>>> # for loop in {1..3}; do sudo dd if=3D/dev/urandom bs=3D1M
> >>>>> of=3D/dev/mmcblk2; done; for loop in {1..5}; do time
> >>>>> ./filesystembenchmark.sh; umount /mnt; done
> >>>>> mkfs.ext4 -F /dev/mmcblk2
> >>>>> mount /dev/mmcblk2 /mnt
> >>>>> for i in {1..3}
> >>>>> do
> >>>>> cp -r linux-6.2.2 /mnt/$i
> >>>>> done
> >>>>> for i in {1..3}
> >>>>> do
> >>>>> rm -r /mnt/$i
> >>>>> done
> >>>>> for i in {1..3}
> >>>>> do
> >>>>> cp -r linux-6.2.2 /mnt/$i
> >>>>> done
> >>>>>
> >>>>>
> >>>>> I found a couple of DUTs that I can link, I also tested one industr=
ial card.
> >>>>>
> >>>>> DUT1: blue PCB Foresee eMMC
> >>>>> https://pine64.com/product/32gb-emmc-module/
> >>>>> DUT2: green PCB SiliconGo eMMC
> >>>>> Couldn't find that one online anymore unfortunately
> >>>>> DUT3: orange hardkernel PCB 8GB
> >>>>> https://www.hardkernel.com/shop/8gb-emmc-module-c2-android/
> >>>>> DUT4: orange hardkernel PCB white dot
> >>>>> https://rlx.sk/en/odroid/3198-16gb-emmc-50-module-xu3-android-for-o=
dro
> >>>>> id-xu3.html
> >>>>> DUT5: Industrial card
> >>>>
> >>>> Thanks a lot for helping out with testing! Much appreciated!
> >>>
> >>> No problem, glad to be of help.
> >>>
> >>>>
> >>>>>
> >>>>>
> >>>>> The test issued 461 DO_REL_WR during one of the iterations for DUT5
> >>>>>
> >>>>> DUT1:
> >>>>> Cache, no FUA:
> >>>>> 13:04.49
> >>>>> 13:13.82
> >>>>> 13:30.59
> >>>>> 13:28:13
> >>>>> 13:20:64
> >>>>> FUA:
> >>>>> 13:30.32
> >>>>> 13:36.26
> >>>>> 13:10.86
> >>>>> 13:32.52
> >>>>> 13:48.59
> >>>>>
> >>>>> DUT2:
> >>>>> FUA:
> >>>>> 8:11.24
> >>>>> 7:47.73
> >>>>> 7:48.00
> >>>>> 7:48.18
> >>>>> 7:47.38
> >>>>> Cache, no FUA:
> >>>>> 8:10.30
> >>>>> 7:48.97
> >>>>> 7:48.47
> >>>>> 7:47.93
> >>>>> 7:44.18
> >>>>>
> >>>>> DUT3:
> >>>>> Cache, no FUA:
> >>>>> 7:02.82
> >>>>> 6:58.94
> >>>>> 7:03.20
> >>>>> 7:00.27
> >>>>> 7:00.88
> >>>>> FUA:
> >>>>> 7:05.43
> >>>>> 7:03.44
> >>>>> 7:04.82
> >>>>> 7:03.26
> >>>>> 7:04.74
> >>>>>
> >>>>> DUT4:
> >>>>> FUA:
> >>>>> 7:23.92
> >>>>> 7:20.15
> >>>>> 7:20.52
> >>>>> 7:19.10
> >>>>> 7:20.71
> >>>>> Cache, no FUA:
> >>>>> 7:20.23
> >>>>> 7:20.48
> >>>>> 7:19.94
> >>>>> 7:18.90
> >>>>> 7:19.88
> >>>>
> >>>> Without going into the details of the above, it seems like for DUT1,=
 DUT2, DUT3 and DUT4 there a good reasons to why we should move forward wit=
h $subject patch.
> >>>>
> >>>> Do you agree?
> >>>
> >>> That is a good question, that's why I just posted the data without fu=
rther comment from my side.
> >>> I was honestly expecting the difference to be much higher, given the =
original patch.
> >>> If this is representative for most cards, you would require quite an =
unusual workload to actually notice the difference IMO.
> >>> If there are cards where the difference is much more significant then=
 of course a quirk would be nicer.
> >>> On the other side I don't see why not and any improvement is a good o=
ne?
> >>>
> >>>>
> >>>>>
> >>>>> Cache, no FUA:
> >>>>> 7:19.36
> >>>>> 7:02.11
> >>>>> 7:01.53
> >>>>> 7:01.35
> >>>>> 7:00.37
> >>>>> Cache, no FUA CQE:
> >>>>> 7:17.55
> >>>>> 7:00.73
> >>>>> 6:59.25
> >>>>> 6:58.44
> >>>>> 6:58.60
> >>>>> FUA:
> >>>>> 7:15.10
> >>>>> 6:58.99
> >>>>> 6:58.94
> >>>>> 6:59.17
> >>>>> 6:60.00
> >>>>> FUA CQE:
> >>>>> 7:11.03
> >>>>> 6:58.04
> >>>>> 6:56.89
> >>>>> 6:56.43
> >>>>> 6:56:28
> >>>>>
> >>>>> If anyone has any comments or disagrees with the benchmark, or has =
a specific eMMC to test, let me know.
> >>>>
> >>>> If I understand correctly, for DUT5, it seems like using FUA may be =
slightly better than just cache-flushing, right?
> >>>
> >>> That is correct, I specifically tested with this card as under the as=
sumption that reliable write is without much additional cost, the DCMD woul=
d be slightly worse for performance and SYNC a bit worse.
> >>>
> >>>>
> >>>> For CQE, it seems like FUA could be slightly even better, at least f=
or DUT5.  Do you know if REQ_OP_FLUSH translates into MMC_ISSUE_DCMD or MMC=
_ISSUE_SYNC for your case? See mmc_cqe_issue_type().
> >>> It is SYNC (this is sdhci-of-arasan on rk3399, no DCMD), but even SYN=
C is not too bad here it seems, could of course be worse if the workload wa=
s less sequential.
> >>>
> >>>>
> >>>> When it comes to CQE, maybe Adrian have some additional thoughts aro=
und this? Perhaps we should keep using REQ_FUA, if we have CQE?
> >>> Sure, I'm also interested in Adrian's take on this.
> >>
> >> Testing an arbitrary system and looking only at individual I/Os,
> >> which may not be representative of any use-case, resulted in
> >> FUA always winning, see below.
> >>
> >> All values are approximate and in microseconds.
> >>
> >>                 With FUA                Without FUA
> >>
> >> With CQE        Reliable Write  350     Write   125
> >>                                         Flush   300
> >>                 Total           350             425
> >>
> >> Without CQE     Reliable Write  350     Write   125
> >>                 CMD13           100     CMD13   100
> >>                                         Flush   300
> >>                                         CMD13   100
> >>                 Total           450             625
> >>
> >> FYI the test I was doing was:
> >>
> >>   # cat test.sh
> >>         #!/bin/sh
> >>
> >>         echo "hi" > /mnt/mmc/hi.txt
> >>
> >>         sync
> >>
> >>
> >>   # perf record --no-bpf-event -e mmc:* -a -- ./test.sh
> >>   # perf script --ns --deltatime
> >>
> >>
> >> The conclusion in this case would seem to be that CQE
> >> makes the case for removing FUA less bad.
> >>
> >> Perhaps CQE is more common in newer eMMCs which in turn
> >> have better FUA implementations.
> >
> > Very interesting data - and thanks for helping out with tests!
> >
> > A few observations and thoughts from the above.
> >
> > 1)
> > A "normal" use case would probably include additional writes (regular
> > writes) and I guess that could impact the flushing behavior. Maybe the
> > flushing becomes less heavy, if the device internally/occasionally
> > needs to flush its cache anyway? Or - maybe it doesn't matter at all,
> > because the reliable writes are triggering the cache to be flushed
> > too.
>
> The sync is presumably causing an EXT4 journal commit which
> seems to use REQ_PREFLUSH and REQ_FUA. That is:
>         Flush (the journal to media)
>         Write (the commit record) (FUA)
> So it does a flush anyway.  The no-FUA case is:
>         Flush (the journal to media)
>         Write (the commit record)
>         Flush (the commit record)
>
> >
> > 2)
> > Assuming that a reliable write is triggering the internal cache to be
> > flushed too, then we need less number of commands to be sent/acked to
> > the eMMC - compared to not using FUA. This means less protocol
> > overhead when using FUA - and perhaps that's what your tests is
> > actually telling us?
>
> There is definitely less protocol overhead because the no-FUA
> case has to do an extra CMD6 (flush) and CMD13.
>
> Note also, in this case auto-CMD23 is being used, which is why
> is is not listed.
>
> Using an older system (no CQE but also auto-CMD23), resulted
> in a win for no-FUA:
>
>                 With FUA                Without FUA
>
>                 Reliable Write  1200    Write    850
>                 CMD13            100    CMD13    100
>                                         Flush    120
>                                         CMD13     65
>                 Total           1300            1135
>
>

Alright, so it seems like just checking whether the cache control
feature is available, isn't sufficient when deciding to avoid FUA.

That said, in the next version I am going to add a card quirk, which
needs to be set too, to avoid FUA. Then we can see for what cards it
should actually be set for.

What eMMC cards did you use in your tests above?

Kind regards
Uffe
