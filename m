Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2936AF8B9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCGWbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjCGWbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:31:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E349AD0F;
        Tue,  7 Mar 2023 14:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1678228228; i=rauchwolke@gmx.net;
        bh=8sqLXcNqxcRRmk4g+niiNwf4mZHOr/7LKBavN9Cew48=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=ju4aQC5sMYJ1a0N7ers/qWf9uX3xAxztpTe8FUUhrd05MtXCBLdV6IducI4EFMqPy
         yLrJIAQX5O4hE6JHg8+DvcQSnaGnFgJbXHwZhxe5XzhoAXWI73mZ4D2MqBpicIXQz0
         QiOe9Qo4u0+VpUvvvc7AsenoCZWo9CODmsyy2+o3rCQ0Hm2Z5eKltcE+e5glT1OMsz
         F6wyifAqJJkJ2gbFMC+Nl5czMwGBdzKmjWJjGZ4GW7q2M6Of87nKRewcyc4IpeuhLb
         9qP1CycBY0HDSEb5kSkgUN0mRnmI2JpdQfJLe1yPGJW28iYC/9141YnN4NNlPubB6j
         MloEXEJe2pu/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from polar.lan ([62.178.199.114]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOiHf-1pvzXX1TCB-00Q9jM; Tue, 07
 Mar 2023 23:30:28 +0100
Date:   Tue, 7 Mar 2023 23:31:23 +0100
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
Message-ID: <20230307233123.14a411ee@polar.lan>
In-Reply-To: <debc7fe9-204d-63a7-aa61-91b20a46f385@wetzel-home.de>
References: <b8efebc6-4399-d0b8-b2a0-66843314616b@leemhuis.info>
 <5a7cd098-1d83-6297-e802-ce998c8ec116@leemhuis.info>
 <6025e17e-4c29-6d36-6b9c-2fec543b21c4@wetzel-home.de>
 <debc7fe9-204d-63a7-aa61-91b20a46f385@wetzel-home.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LkPNF4z4ns/DjSgAU3BgUKYkU+YL1EAR36QX0CukRuJgLRJjy0w
 pP6w7zZsATR5bHImcdf1RqTPd3PKPRoEf9gIg7KCoBdSJMKY7qu+n3XPiRa2Tz0LG/msrLg
 y+wL8SBwZOg5XbhELrZ6Oj65h1f5x5r8BOn2OzWc3/AxDcqvIPbB9pnRdwJc+pxN31tPdli
 kZ99nN/WqFYn/6+pnavHw==
UI-OutboundReport: notjunk:1;M01:P0:6KImbf7iV0I=;dl4l/bbnMCr0qMGA7QLl/1H2Thk
 oSnFmUl6hj6ho6dTKJKUW5XGBE0nLfx6iePSzrE6ynwncjOJm7PM1Szix++E3jiXtIuZQTCUi
 1bl1xop6CN8vPUH5djdqzGGl0nw9rSGiCKZUtLlsmkoomplUJo/EkmBgvmC4ZkmdfNxtGVva0
 aowim4HMgGCw06Il4ABbrGlPzhARl9VC2Cv1WwUXXLTewmjha81lkwDiKKTAuCNbwqlXy1P9z
 /NUfcRCXHuCmXRMj4uXXyAzB7PZ1FOR6hqfvIzNGIWqQJJgmszQ9U8LjXCVGKf4OwO+OQOf8m
 R0O5o54mPvqpKp+CqX2tlQNQd789QPjMXsPXGdI/aoYB+77u5KL/ynlks63Vd/UZcepirK6nB
 NVMZESOWTy0k9mJKXLiFOHhaCGOUx14N0vA0CWY5LmkavHHhGfMtHdnK1SnQ1dMpWMBFANDIz
 3LexZBTaMA4JFWpZZVBF6RhDxuqzpvGL92SpQVwp9CLJaFxbXTxDOjEn0ue/8OTBzIKbYdudI
 KhLIzaW//mqHKmvg77kHGqpkNCY+Z8yvmMDMcUkYHIzaUgsH57rmxNR9OjhO2WQfIF6lAl/Kd
 p25z8+Kh4pGUFny0vcrt1hzmXjESBCY8yKdkeKGSC1x7qFdSgUGvr77zGuCgtVHxRJySpSywL
 QJiTOS2jeVkpzoWsX1yphkY1t4IxOw5b7KW6CVqvo9AawtyMZR7uTNTsKM4YCzZoKp2MnHVzo
 409Jsz+jEgcgm7rhtiHrS5S29mNhtMqZhy+VBRj/InQvblydV7zwCNNzSi2CGSc49N8E093LG
 y4kWpFK3+jx7PIU/v3P7DBcjxKxzOvycGm8cOPSp+zsuuXTGfFAjsRgb8CgtFvRDDyzO+MCch
 2AtqoPKLM1kYlVr7+45fT4k5+E8B6AeFpfBuRhXc/CaOlhxsKeCAM/x0JlRm0oOgBAncQBTyy
 7dhxXQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

i can't boot the binary kernel here, as the initramfs is included in my
kernel, if you send me a patch, i can apply it and test it.

Thomas

On Tue, 7 Mar 2023 21:54:31 +0100
Alexander Wetzel <alexander@wetzel-home.de> wrote:

> >>
> >
> > I just uploaded a test patch to bugzilla.
> > Please have a look if that fixes the issue.
> >
> > If not I would be interested in the output of your iTXQ status.
> > Enable CONFIG_MAC80211_DEBUGFS and run this command when the
> > connection is bad and send/share/upload to bugzilla the resulting
> > debug.out:
> >
> > k=3D1; while [ $k -lt 10 ]; do \
> > cat /sys/kernel/debug/ieee80211/phy?/netdev:*/stations/*/aqm; \
> > k=3D$(($k+1)); done >> debug.out
>
> Thomas and I continued with some debugging in
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217119
>
> But the results so far are unexpected and we decided to continue the
> debugging with the round here. Hoping someone sees something I miss.
>
> A very summary where we are:
> I can't reproduce the bug with a very similar card and kernel config
> so far. Thomas card stops the iTXQs for intervalls >30s. Mine
> operates normally.
>
> A more useful but longer summary:
>
> Thomas updated to a 6.2 kernel and reported "connection drops and
> bandwidth problems" with his rt2800usb wlan card. (6.1 is ok.) Asked
> for some more details he reported:
> "...slow bandwidth stuff works better, but the main problem/test case
> is to start a 8-16 mbit video stream, which sometimes runs for a few
> seconds and then stops or it doesn't start at all"
>
> He bisected the issue and identified my commit 4444bc2116ae ("wifi:
> mac80211: Proper mark iTXQs for resumption") as culprit.
>
> Checking the internal iTXQ status when the issue is ongoing shows,
> that TID zero is flagged as dirty and thus is not transmitting queued
> packets. Interesting line from
> /sys/kernel/debug/ieee80211/phy?/netdev:*/stations/*/aqm:
> tid ac backlog-bytes backlog-packets new-flows drops marks overlimit
> collisions tx-bytes tx-packets flags
> 0 2 619736 404 1681 0 0 0 1 4513965 3019 0xe(RUN AMPDU NO-AMSDU DIRTY)
>
> --> The "normal" iTXQ handling IEEE80211_AC_BE has queued packets and
> is flagged as DIRTY. There even is a potential race setting the DIRTY
> flag, but the fix for that is not helping.
>
> Thus Thomas applied two debug patches, to better understand why the
> DIRTY flag is not cleared.
>
> And looking at the output from those we see that the driver stops Tx
> by calling ieee80211_stop_queue(). When ieee80211_wake_queue()
> mac80211 correctly resumes TX but is getting stopped by the driver
> after a single packet again. (The start of the relevant log is
> missing, so that may be initially more).
> I assume TX is still ok at that stage. But after some singe Tx
> operations the driver stops the queues again. Here the relevant part
> of the log:
> [  179.584997] XXXX __ieee80211_wake_txqs: waking TID 0
> [  179.585022] XXXX drv_tx: TX
> [  179.585027] XXXX ieee80211_stop_queue: called
> [  179.585028] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.585030] XXXX __ieee80211_wake_txqs: TID 3 NOT dirty
> [  179.585031] XXXX __ieee80211_wake_txqs: TID 8 NOT dirty
> [  179.585033] XXXX __ieee80211_wake_txqs: TID 11 NOT dirty
> [  179.585034] XXXX __ieee80211_wake_txqs: EXIT
> [  179.585035] XXXX __ieee80211_wake_txqs: ENTRY
> [  179.585036] XXXX __ieee80211_wake_txqs: TID 1 NOT dirty
> [  179.585037] XXXX __ieee80211_wake_txqs: TID 2 NOT dirty
> [  179.585038] XXXX __ieee80211_wake_txqs: TID 9 NOT dirty
> [  179.585040] XXXX __ieee80211_wake_txqs: TID 10 NOT dirty
> [  179.585041] XXXX __ieee80211_wake_txqs: EXIT
> [  179.585047] XXXX drv_tx: TX
> [  179.585056] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.585271] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.585868] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.586120] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.586544] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.586792] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.587317] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.587591] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> [  179.588569] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> ....
> [  214.307617] XXXX ieee80211_wake_queue: called
>
>
> --> So the driver blocked TX for more than 30s. Which is a good
> explanation of what Thomas observes.
>
> But there is nothing mac80211 can do differently here. Whatever is
> the real reason for the issue, it's nothing obvious I see.
>
> Luckily I found a card using the same driver and nearly the same card:
> Thomas systems:Linux version 6.2.2-gentoo (root@foo) (gcc (Gentoo
> Hardened 12.2.1_p20230121-r1 p10) 12.2.1 20230121, GNU ld (Gentoo
> 2.39 p5) 2.39.0) #2 SMP Fri Mar  3 16:59:02 CET 2023ieee80211 phy0:
> rt2x00_set_rt: Info - RT chipset 3070, rev 0201 detected
> ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005 detected
> ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
>
> My system, using the kernel config from Thomas with only minor
> modifications (different filesystems and initramfs settings and
> enabled mac80211 debug and developer options):
> Linux version 6.2.2-gentoo (root@Perry.mordor) (gcc (Gentoo
> 12.2.1_p20230121-r1 p10) 12.2.1 20230121, GNU ld (Gentoo 2.40 p2)
> 2.40.0) #2 SMP Tue Mar  7 18:18:47 CET 2023ieee80211 phy0:
> rt2x00_set_rt: Info - RT chipset 3070, rev 0200 detected
> ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005 detected
> ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
> ieee80211 phy0: rt2x00lib_request_firmware: Info - Loading firmware
> file 'rt2870.bin'
> ieee80211 phy0: rt2x00lib_request_firmware: Info - Firmware detected
> - version: 0.36
>
> But there is one big difference on my system: I can't reproduce the
> bug so far. It's working as it should... (I did not apply the debug
> patches myself so far)
>
> I'm now planning to look a bit more into the rt2800usb driver and
> provide another debug patch for interesting looking code pieces in it.
>
> @Thomas:
> I've also uploaded you my binary kernel I'm running at the moment
> here: https://www.awhome.eu/s/5FjqMS73rtCtSBM
>
> That kernel should also be able to boot and operate your system. Can
> you try that and tell me, if that makes any difference?
>
> I'm also planning to provide some more debug patches, to figuring out
> which part of commit 4444bc2116ae ("wifi: mac80211: Proper mark iTXQs
> for resumption") fixes the issue for you. Assuming my understanding
> above is correct the patch should not really fix/break anything for
> you...With the findings above I would have expected your git bisec to
> identify commit a790cc3a4fad ("wifi: mac80211: add wake_tx_queue
> callback to drivers") as the first broken commit...
>
> Alexander

