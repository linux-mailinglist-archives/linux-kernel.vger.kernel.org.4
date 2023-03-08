Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B06A6B0714
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjCHM2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjCHM23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:28:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7087EA04;
        Wed,  8 Mar 2023 04:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1678278489; i=rauchwolke@gmx.net;
        bh=YHBJ/zT79zZoD5FMDYi0UTexe+zeVqnVco2rYHevudI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=eBXmLsngid+zkFxFUzoW6syeisVHqu0haC5etJNJp1QFsLgomrrG56tnUUQXZTI4G
         ZQ3VCgj4wawYfRe2re0esCYKvS4foxuYak8ECA45IvNH0TG2fk1M4uRULXQlOaavfS
         hYT4rnGvdq/Is8Pf+EQFyDaF0mkerT9ZsgH0nvz5mgwh1uHjW0Ogq7zgLfK/sgJYyw
         AvsiLtyVdNP+r15Yd/vBuU+Tb+HUoVTSBHJJhX4wmbZUXzwjTcFlc1h5t6g7iUaHXU
         GmtdaL2uJIVwrMNRTzJzm1dn0E8S//k8eXu0YOw+QILY7miiOysPN6se/pmtd7pvZW
         hR+IoH5RAnpGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from polar.lan ([62.178.199.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZkpR-1q6Tmg14xb-00Wne6; Wed, 08
 Mar 2023 13:28:09 +0100
Date:   Wed, 8 Mar 2023 13:29:06 +0100
From:   Thomas Mann <rauchwolke@gmx.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [Regression] rt2800usb - Wifi performance issues and connection
 drops
Message-ID: <20230308132906.708aee5c@polar.lan>
In-Reply-To: <20230308112650.3c72d6f2@polar.lan>
References: <b8efebc6-4399-d0b8-b2a0-66843314616b@leemhuis.info>
        <5a7cd098-1d83-6297-e802-ce998c8ec116@leemhuis.info>
        <6025e17e-4c29-6d36-6b9c-2fec543b21c4@wetzel-home.de>
        <debc7fe9-204d-63a7-aa61-91b20a46f385@wetzel-home.de>
        <20230307233123.14a411ee@polar.lan>
        <4171c994-6b02-95d1-30c7-8f6f72af7893@wetzel-home.de>
        <20230308112650.3c72d6f2@polar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kDpWL0F2tBpkhrNUdoYwmLaLA/fl7xV0o7oqSEOJaXRNReyo/e6
 hjewELljvnnoHm921OEfTLiUKVXJT+LmU2ySoiY4acdr7L44+GboiUTJ1vAM+PnnsRoYITu
 GPVvkdBSxhGHT2QFCaNBVbCZIPT8c3pMGuwvpW60wOmVJMC3tQ5noJTAYIMzMDUC772IRcV
 uGF6OktCGLXewFNOHkPjw==
UI-OutboundReport: notjunk:1;M01:P0:CbY57Ac+Cpo=;Y9PuH+tNjO9nXmF0t3RvDC5QHZ8
 tBNYEyU+FYfn61EN90Pz1mGbZzhPQItjKZy6+4m98gPwMixR3Uv8WpMMePAf6Ni6lEDymVDKF
 aCJTl2FpZ+Ouao7JA03V9d/hUUkrgNF0phakRDs61alUaHaQnM+5arIgy32N7OU9+oO4RjnD+
 Ey/TORiF+CM3vqJASB4CEktCOGC5VOTopjAcgC1axAk4mOkhE9zn+uFKDuDCFpbhvkwu6ydhi
 575N/4o/kSSisW/1TvQliy7vT/sYwWXw7Wqfat8FPcUfa4RyvoYpQhnneSOEAToaLZ6Gge1Br
 ZZaYAJq84MKrJhjd1kjw6U9dp6pbbbW9v/f7cmxBi4NxsaCqyXGXD2ArNme1ECJw5KuHc263D
 EFEdy4I5ne9IG46kYWC79VcRYOPYAgb/IbTjbs4k4rVcpCamHy8yap6BqEZ94XSPbwRZlbf5e
 B6JsPXA7vXQOf3KLlfk4giELKrJduGxHiWCIwQwEfdcv9l7egFuEMS0MLJx/T9lhFgMv9ib1w
 gOx/FvqhTxuxqK1MfGT2Mln/xBayet6nqREo4pbGRKpzRaTbVAqi1dcwJ9MolU7Bq5pZ4nVS8
 80ee1jUhiYRNMojf43xzzwnOg3KJTnhdJh3UPxRWV+uqGqv9256OEWv6u8zuwvNNrqcv9yxwQ
 rokPce7UH3eSD7CNIWSP/MaOzqfYlnPMHKu6NuecjBaIaeDkwj6qV5vuWil/MH1XWIQgi6CDG
 SI1E3+BtnkN5EAuhkxBVQKIfWPHrBLFbXYAU5S2kr+HKEkYGeRdjT5ZeSbixl7IiQgUSwDfDF
 TLo/ht25CKvSxo5pofitE9192eBGlwURRSQXl1XbUXFL7DYcd8WhdeCM8InXnirliQ9BknDNk
 1pdcEQrGRtW3YERtZwMA8V8NtvF2GnokZpYZJ/PYm9SpcR7SubNR/TOEIs8Lw4UlosgEpXgpB
 nceepo0SsbQKky6scSV+/eCYIKo=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2023 11:26:50 +0100
Thomas Mann <rauchwolke@gmx.net> wrote:

> On Wed, 8 Mar 2023 08:13:32 +0100
> Alexander Wetzel <alexander@wetzel-home.de> wrote:
>
> > On 07.03.23 23:31, Thomas Mann wrote:
> > > Hi Alexander,
> >
> > Since I suspect we'll exchange quite some mails here:
> > Top posting is being frowned on the mailing lists on copy.
> > Details here: https://www.infradead.org/~dwmw2/email.html
> >
> > I've moved your post to the correct position and replied there.
> >
> > >
> > >>>>
> > >>>
> > >>> I just uploaded a test patch to bugzilla.
> > >>> Please have a look if that fixes the issue.
> > >>>
> > >>> If not I would be interested in the output of your iTXQ status.
> > >>> Enable CONFIG_MAC80211_DEBUGFS and run this command when the
> > >>> connection is bad and send/share/upload to bugzilla the
> > >>> resulting debug.out:
> > >>>
> > >>> k=3D1; while [ $k -lt 10 ]; do \
> > >>> cat /sys/kernel/debug/ieee80211/phy?/netdev:*/stations/*/aqm; \
> > >>> k=3D$(($k+1)); done >> debug.out
> > >>
> > >> Thomas and I continued with some debugging in
> > >> https://bugzilla.kernel.org/show_bug.cgi?id=3D217119
> > >>
> > >> But the results so far are unexpected and we decided to continue
> > >> the debugging with the round here. Hoping someone sees something
> > >> I miss.
> > >>
> > >> A very summary where we are:
> > >> I can't reproduce the bug with a very similar card and kernel
> > >> config so far. Thomas card stops the iTXQs for intervalls >30s.
> > >> Mine operates normally.
> > >>
> > >> A more useful but longer summary:
> > >>
> > >> Thomas updated to a 6.2 kernel and reported "connection drops and
> > >> bandwidth problems" with his rt2800usb wlan card. (6.1 is ok.)
> > >> Asked for some more details he reported:
> > >> "...slow bandwidth stuff works better, but the main problem/test
> > >> case is to start a 8-16 mbit video stream, which sometimes runs
> > >> for a few seconds and then stops or it doesn't start at all"
> > >>
> > >> He bisected the issue and identified my commit 4444bc2116ae
> > >> ("wifi: mac80211: Proper mark iTXQs for resumption") as culprit.
> > >>
> > >> Checking the internal iTXQ status when the issue is ongoing
> > >> shows, that TID zero is flagged as dirty and thus is not
> > >> transmitting queued packets. Interesting line from
> > >> /sys/kernel/debug/ieee80211/phy?/netdev:*/stations/*/aqm:
> > >> tid ac backlog-bytes backlog-packets new-flows drops marks
> > >> overlimit collisions tx-bytes tx-packets flags
> > >> 0 2 619736 404 1681 0 0 0 1 4513965 3019 0xe(RUN AMPDU NO-AMSDU
> > >> DIRTY)
> > >> --> The "normal" iTXQ handling IEEE80211_AC_BE has queued
> > >> packets and is flagged as DIRTY. There even is a potential race
> > >> setting the DIRTY flag, but the fix for that is not helping.
> > >>
> > >> Thus Thomas applied two debug patches, to better understand why
> > >> the DIRTY flag is not cleared.
> > >>
> > >> And looking at the output from those we see that the driver stops
> > >> Tx by calling ieee80211_stop_queue(). When ieee80211_wake_queue()
> > >> mac80211 correctly resumes TX but is getting stopped by the
> > >> driver after a single packet again. (The start of the relevant
> > >> log is missing, so that may be initially more).
> > >> I assume TX is still ok at that stage. But after some singe Tx
> > >> operations the driver stops the queues again. Here the relevant
> > >> part of the log:
> > >> [  179.584997] XXXX __ieee80211_wake_txqs: waking TID 0
> > >> [  179.585022] XXXX drv_tx: TX
> > >> [  179.585027] XXXX ieee80211_stop_queue: called
> > >> [  179.585028] XXXX ieee80211_tx_dequeue: mark TID 0 dirty.
> > >> Reason: 1 [  179.585030] XXXX __ieee80211_wake_txqs: TID 3 NOT
> > >> dirty [  179.585031] XXXX __ieee80211_wake_txqs: TID 8 NOT dirty
> > >> [  179.585033] XXXX __ieee80211_wake_txqs: TID 11 NOT dirty
> > >> [  179.585034] XXXX __ieee80211_wake_txqs: EXIT
> > >> [  179.585035] XXXX __ieee80211_wake_txqs: ENTRY
> > >> [  179.585036] XXXX __ieee80211_wake_txqs: TID 1 NOT dirty
> > >> [  179.585037] XXXX __ieee80211_wake_txqs: TID 2 NOT dirty
> > >> [  179.585038] XXXX __ieee80211_wake_txqs: TID 9 NOT dirty
> > >> [  179.585040] XXXX __ieee80211_wake_txqs: TID 10 NOT dirty
> > >> [  179.585041] XXXX __ieee80211_wake_txqs: EXIT
> > >> [  179.585047] XXXX drv_tx: TX
> > >> [  179.585056] XXXX ieee80211_tx_dequeue: mark TID 0 dirty.
> > >> Reason: 1 [  179.585271] XXXX ieee80211_tx_dequeue: mark TID 0
> > >> dirty. Reason: 1 [  179.585868] XXXX ieee80211_tx_dequeue: mark
> > >> TID 0 dirty. Reason: 1 [  179.586120] XXXX ieee80211_tx_dequeue:
> > >> mark TID 0 dirty. Reason: 1 [  179.586544] XXXX
> > >> ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1 [  179.586792]
> > >> XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1 [
> > >> 179.587317] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason:
> > >> 1 [  179.587591] XXXX ieee80211_tx_dequeue: mark TID 0 dirty.
> > >> Reason: 1 [  179.588569] XXXX ieee80211_tx_dequeue: mark TID 0
> > >> dirty. Reason: 1 .... [  214.307617] XXXX ieee80211_wake_queue:
> > >> called
> > >>
> > >>
> > >> --> So the driver blocked TX for more than 30s. Which is a good
> > >> explanation of what Thomas observes.
> > >>
> > >> But there is nothing mac80211 can do differently here. Whatever
> > >> is the real reason for the issue, it's nothing obvious I see.
> > >>
> > >> Luckily I found a card using the same driver and nearly the same
> > >> card: Thomas systems:Linux version 6.2.2-gentoo (root@foo) (gcc
> > >> (Gentoo Hardened 12.2.1_p20230121-r1 p10) 12.2.1 20230121, GNU ld
> > >> (Gentoo 2.39 p5) 2.39.0) #2 SMP Fri Mar  3 16:59:02 CET
> > >> 2023ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3070, rev
> > >> 0201 detected ieee80211 phy0: rt2x00_set_rf: Info - RF chipset
> > >> 0005 detected ieee80211 phy0: Selected rate control algorithm
> > >> 'minstrel_ht'
> > >>
> > >> My system, using the kernel config from Thomas with only minor
> > >> modifications (different filesystems and initramfs settings and
> > >> enabled mac80211 debug and developer options):
> > >> Linux version 6.2.2-gentoo (root@Perry.mordor) (gcc (Gentoo
> > >> 12.2.1_p20230121-r1 p10) 12.2.1 20230121, GNU ld (Gentoo 2.40 p2)
> > >> 2.40.0) #2 SMP Tue Mar  7 18:18:47 CET 2023ieee80211 phy0:
> > >> rt2x00_set_rt: Info - RT chipset 3070, rev 0200 detected
> > >> ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005 detected
> > >> ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
> > >> ieee80211 phy0: rt2x00lib_request_firmware: Info - Loading
> > >> firmware file 'rt2870.bin'
> > >> ieee80211 phy0: rt2x00lib_request_firmware: Info - Firmware
> > >> detected
> > >> - version: 0.36
> > >>
> > >> But there is one big difference on my system: I can't reproduce
> > >> the bug so far. It's working as it should... (I did not apply
> > >> the debug patches myself so far)
> > >>
> > >> I'm now planning to look a bit more into the rt2800usb driver and
> > >> provide another debug patch for interesting looking code pieces
> > >> in it.
> > >>
> > >> @Thomas:
> > >> I've also uploaded you my binary kernel I'm running at the moment
> > >> here: https://www.awhome.eu/s/5FjqMS73rtCtSBM
> > >>
> > >> That kernel should also be able to boot and operate your system.
> > >> Can you try that and tell me, if that makes any difference?
> >
> >  >
> >  > i can't boot the binary kernel here, as the initramfs is included
> >  > in my kernel, if you send me a patch, i can apply it and test
> >  > it.
> >
> > That was an unpatched kernel. Idea was to verify that it's not a
> > compiler issue. (You seem to be using a hardened Gentoo profile.)
> >
> > Can you share your initrd, so I can include it? (Mail it to me
> > directly, upload it to bug in buguilla or send a link to some cloud
> > storage.)
> >
> I can't share this config, as it's a production system, and i'm not
> allowed to run abitrary binary code on the system. As 6.1.x works
> without a problem, i don't think it's a compiler problem. I will try
> to get a none hardened compiler and recompile the kernel.

I compiled the kernel now with a none hardened tools/compiler
(gcc (Gentoo 12.2.1_p20230121-r1 p10) 12.2.1 20230121) and the kernel
still has the same bug/behaviour.

>
> >
> >
> > >>
> > >> I'm also planning to provide some more debug patches, to figuring
> > >> out which part of commit 4444bc2116ae ("wifi: mac80211: Proper
> > >> mark iTXQs for resumption") fixes the issue for you. Assuming my
> > >> understanding above is correct the patch should not really
> > >> fix/break anything for you...With the findings above I would have
> > >> expected your git bisec to identify commit a790cc3a4fad ("wifi:
> > >> mac80211: add wake_tx_queue callback to drivers") as the first
> > >> broken commit...
> > >>
> > >> Alexander
> > >
> >
>

