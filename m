Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC63A6B2C09
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjCIR3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjCIR3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:29:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB79F865F;
        Thu,  9 Mar 2023 09:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1678382929; i=rauchwolke@gmx.net;
        bh=dlL+3A1UYz1+fThWQ2l99HatP3e25Gq4TXFvFA/dRPA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=auQ5TRv0LFGFbQGBubEx83uSg1r/IwedgyR9nSqTcoB1tWs5rfPzbUbrQ14CYiMMF
         7qPhdIavCGOTxa0ShLH0T1A/Pu7TYtxKdAKt/53fPX9f/ja1ueymH5YcULFU744h/S
         k+ZelaHAq8FvY6bofVZp7ALKx8/7OpWmAQGnpIqF5ETj8uSEeRKNju1c+gGkPEV7Ky
         ITcU0XJ2q325FbbQNm16AgB6lhWjKi3vidw/oCWh4rqZvnNgRb6V53+VBw11QR/BFQ
         3c62QnQs/uyn0v98ddzADKgUoOsHw1FiUuL/2jROVXYQyINKWxCMc9PDVTqvgJB4ze
         IY8JnteaxU7Eg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from polar.lan ([62.178.199.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDnI-1phVcM3LCA-00CiQt; Thu, 09
 Mar 2023 18:28:49 +0100
Date:   Thu, 9 Mar 2023 18:29:45 +0100
From:   Thomas Mann <rauchwolke@gmx.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>
Cc:     sgruszka@redhat.com,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [Regression] rt2800usb - Wifi performance issues and connection
 drops
Message-ID: <20230309182945.65f1a8fb@polar.lan>
In-Reply-To: <7300e0c0-d28e-6b3d-86c9-038cbbe47c65@wetzel-home.de>
References: <b8efebc6-4399-d0b8-b2a0-66843314616b@leemhuis.info>
        <5a7cd098-1d83-6297-e802-ce998c8ec116@leemhuis.info>
        <6025e17e-4c29-6d36-6b9c-2fec543b21c4@wetzel-home.de>
        <debc7fe9-204d-63a7-aa61-91b20a46f385@wetzel-home.de>
        <7300e0c0-d28e-6b3d-86c9-038cbbe47c65@wetzel-home.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hpuKMMTpRQBo8f9Epk15a9SoTIZkXFuw8Imc6Kub4BTg6iBLmtR
 FtoRdGzlhihZsDPn1l7WE/ViHwVSVMBQXWMpowOt8FSiBFGoS17rGYCW+nppL6dS4XriA9e
 EAxSue+fnd0R1YOmWOdV1tQw032Y07Gxu6gwRIloZgdspinibtmQrzHnUIJo/XzFW0R1Fq1
 a89/u8aSol+pX9v3/XD0Q==
UI-OutboundReport: notjunk:1;M01:P0:04ucapddsl4=;p9kOm0mndHLgfOd1eRklzndbtW2
 EoQcU9hioiEon/qxvxwdbN4UwFR2nDooby7ZjN4Ed4VRolUNMro1ylOxuQHkxZYv5y2LVD5C+
 nS1XXNUZ+c9Z+4DdjgvOp15GqzwGy5z8kNHOElhAax9VkaKQKQl1g7ayRXLSGSNsvFG6MpAXX
 jFpDg+bPfonXAI9CQugcI+i2to2W2nhK20RSM3sK8y3CxmpJtYn4GJfcfXYORvXN3squl0q3x
 +vHL+GlQNXAcqLn44TkChjuufISpoM3Ko9ZepmY1ZEnsXWxPoBpRlAM25cumkO4eF1JwxFqWF
 A+/Ds50aeecKv8LrJtmzosfsFlfkCrKYwa+LdjPukTtowzIke+CWBnbyiWzaq1QzaPeEQIxpz
 NRbOUuFOUpMEu2u0FQwpulBE+Cd16FzPQKJqKEDzcfkVOaFj6UcUzHhukYWYRzXWGg6kuYsbk
 jK7s13wJkBMYso/plnv3fQ39SmqHJKGLkzWLZJW54yOCGA6S+uH0k5K21IoQ3DvoSQNcoQnPg
 H4iGjtXGfDKh6NG/bxhAm6yheXGgDKvNdrDfRuxoti9VL/Irb2r5qyo9RLGym1b0UPj4nxYLC
 fAqg0pLHeubNdNrV2iNRkb+Ud6J0a8HykR7v5HtIHfBTW879U+RCpIDKhRQgiYKZ8EKejxHhA
 ZbwLL8IvcWqNxe62NKEbc+tkFXnMtNF0x4Itp+CoZ0xH2wBYO0SP88xnODnkq0bN0an8WBh3s
 L2VQM0qTjA5Go9t8x0mrfYzAvnP46HPYh/K7SaeOZWMbQvilW0zobfatLX1c1r+KPEjvh+Xnw
 0lbmnyE9M9qyv14UBcchRfw+5WP8YI0VrAZP44+YW4u7HE+XxKFinga0yCqsyMLSsZK1vHeMa
 4aoBKqT0lhkbKXxpeKfQ3jeWoanQiATn4edKCVFm5FUIoYBxuI0tn9Jrn/+7MqvsWUKP5THHL
 vJtRRa2ssF1oib2UC/OMMU97oUw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 18:00:04 +0100
Alexander Wetzel <alexander@wetzel-home.de> wrote:

> On 07.03.23 21:54, Alexander Wetzel wrote:
> >>> =20
> >>
> >> I just uploaded a test patch to bugzilla.
> >> Please have a look if that fixes the issue.
> >>
> >> If not I would be interested in the output of your iTXQ status.
> >> Enable CONFIG_MAC80211_DEBUGFS and run this command when the=20
> >> connection is bad and send/share/upload to bugzilla the resulting=20
> >> debug.out:
> >>
> >> k=3D1; while [ $k -lt 10 ]; do \
> >> cat /sys/kernel/debug/ieee80211/phy?/netdev:*/stations/*/aqm; \
> >> k=3D$(($k+1)); done >> debug.out =20
> >=20
> > Thomas and I continued with some debugging in
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D217119
> >=20
> > But the results so far are unexpected and we decided to continue
> > the debugging with the round here. Hoping someone sees something I
> > miss.
> >=20
> > A very summary where we are:
> > I can't reproduce the bug with a very similar card and kernel
> > config so far. Thomas card stops the iTXQs for intervalls >30s.
> > Mine operates normally.
> >=20
> > A more useful but longer summary:
> >=20
> > Thomas updated to a 6.2 kernel and reported "connection drops and=20
> > bandwidth problems" with his rt2800usb wlan card. (6.1 is ok.)
> > Asked for some more details he reported:
> > "...slow bandwidth stuff works better, but the main problem/test
> > case is to start a 8-16 mbit video stream, which sometimes runs for
> > a few seconds and then stops or it doesn't start at all"
> >=20
> > He bisected the issue and identified my commit 4444bc2116ae ("wifi:=20
> > mac80211: Proper mark iTXQs for resumption") as culprit.
> >=20
> > Checking the internal iTXQ status when the issue is ongoing shows,
> > that TID zero is flagged as dirty and thus is not transmitting
> > queued packets. Interesting line from=20
> > /sys/kernel/debug/ieee80211/phy?/netdev:*/stations/*/aqm:
> > tid ac backlog-bytes backlog-packets new-flows drops marks
> > overlimit collisions tx-bytes tx-packets flags
> > 0 2 619736 404 1681 0 0 0 1 4513965 3019 0xe(RUN AMPDU NO-AMSDU
> > DIRTY)=20
> > --> The "normal" iTXQ handling IEEE80211_AC_BE has queued packets
> > and is flagged as DIRTY. There even is a potential race setting the
> > DIRTY flag, but the fix for that is not helping.
> >=20
> > Thus Thomas applied two debug patches, to better understand why the=20
> > DIRTY flag is not cleared.
> >=20
> > And looking at the output from those we see that the driver stops
> > Tx by calling ieee80211_stop_queue(). When ieee80211_wake_queue()
> > mac80211 correctly resumes TX but is getting stopped by the driver
> > after a single packet again. (The start of the relevant log is
> > missing, so that may be initially more).
> > I assume TX is still ok at that stage. But after some singe Tx=20
> > operations the driver stops the queues again. Here the relevant
> > part of the log:
> > [=C2=A0 179.584997] XXXX __ieee80211_wake_txqs: waking TID 0
> > [=C2=A0 179.585022] XXXX drv_tx: TX
> > [=C2=A0 179.585027] XXXX ieee80211_stop_queue: called
> > [=C2=A0 179.585028] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason:
> > 1 [=C2=A0 179.585030] XXXX __ieee80211_wake_txqs: TID 3 NOT dirty
> > [=C2=A0 179.585031] XXXX __ieee80211_wake_txqs: TID 8 NOT dirty
> > [=C2=A0 179.585033] XXXX __ieee80211_wake_txqs: TID 11 NOT dirty
> > [=C2=A0 179.585034] XXXX __ieee80211_wake_txqs: EXIT
> > [=C2=A0 179.585035] XXXX __ieee80211_wake_txqs: ENTRY
> > [=C2=A0 179.585036] XXXX __ieee80211_wake_txqs: TID 1 NOT dirty
> > [=C2=A0 179.585037] XXXX __ieee80211_wake_txqs: TID 2 NOT dirty
> > [=C2=A0 179.585038] XXXX __ieee80211_wake_txqs: TID 9 NOT dirty
> > [=C2=A0 179.585040] XXXX __ieee80211_wake_txqs: TID 10 NOT dirty
> > [=C2=A0 179.585041] XXXX __ieee80211_wake_txqs: EXIT
> > [=C2=A0 179.585047] XXXX drv_tx: TX
> > [=C2=A0 179.585056] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason:
> > 1 [=C2=A0 179.585271] XXXX ieee80211_tx_dequeue: mark TID 0 dirty.
> > Reason: 1 [=C2=A0 179.585868] XXXX ieee80211_tx_dequeue: mark TID 0
> > dirty. Reason: 1 [=C2=A0 179.586120] XXXX ieee80211_tx_dequeue: mark TID
> > 0 dirty. Reason: 1 [=C2=A0 179.586544] XXXX ieee80211_tx_dequeue: mark
> > TID 0 dirty. Reason: 1 [=C2=A0 179.586792] XXXX ieee80211_tx_dequeue:
> > mark TID 0 dirty. Reason: 1 [=C2=A0 179.587317] XXXX
> > ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1 [=C2=A0 179.587591]
> > XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1 [
> > 179.588569] XXXX ieee80211_tx_dequeue: mark TID 0 dirty. Reason: 1
> > .... [=C2=A0 214.307617] XXXX ieee80211_wake_queue: called
> >=20
> >  =20
> > --> So the driver blocked TX for more than 30s. Which is a good  =20
> > explanation of what Thomas observes.
> >=20
> > But there is nothing mac80211 can do differently here. Whatever is
> > the real reason for the issue, it's nothing obvious I see. =20
>=20
> Best shot I have so far is a driver bug/issue now exposed by the
> changed traffic pattern from mac80211. And while digging into the
> rt2800usb driver I found a watchdog introduced here:
> https://lore.kernel.org/20190615100100.29800-1-sgruszka@redhat.com
>=20
>  From mac80211 debugging it looks like it may just be that: A random=20
> hang of the driver/card.
>=20
> For sure rt2800usb tells mac80211 to stop TXing and needs ages (>30s
> in known sample) to unblock the queue. And this watchdog is disabled
> by default.
>=20
> Now I'm clearly wondering, if the changed traffic pattern due to the=20
> mac80211 patch is just triggering the random hangs...
>=20
> I've also uploaded more test patches to bugzilla.
>=20
> @Thomas
> Can you also try with this watchdog enabled? It must be enabled for=20
> rt2800lib. Since you have compiled in the driver the following boot=20
> parameter should enable it:
>   rt2800lib.watchdog=3D1

i responded on the bugtracker. Enabling the watchdog doesn't solve the
problem.

>=20
> @Stanislaw
> Can you maybe also have a look at the issue and how that looks
> compared to the known random hangs you introduced the watchdog for?
>=20
> >=20
> > Luckily I found a card using the same driver and nearly the same
> > card: Thomas systems:Linux version 6.2.2-gentoo (root@foo) (gcc
> > (Gentoo Hardened 12.2.1_p20230121-r1 p10) 12.2.1 20230121, GNU ld
> > (Gentoo 2.39 p5) 2.39.0) #2 SMP Fri Mar=C2=A0 3 16:59:02 CET
> > 2023ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3070, rev 0201
> > detected ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005
> > detected ieee80211 phy0: Selected rate control algorithm
> > 'minstrel_ht'
> >=20
> > My system, using the kernel config from Thomas with only minor=20
> > modifications (different filesystems and initramfs settings and
> > enabled mac80211 debug and developer options):
> > Linux version 6.2.2-gentoo (root@Perry.mordor) (gcc (Gentoo=20
> > 12.2.1_p20230121-r1 p10) 12.2.1 20230121, GNU ld (Gentoo 2.40 p2)=20
> > 2.40.0) #2 SMP Tue Mar=C2=A0 7 18:18:47 CET 2023ieee80211 phy0:=20
> > rt2x00_set_rt: Info - RT chipset 3070, rev 0200 detected
> > ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005 detected
> > ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
> > ieee80211 phy0: rt2x00lib_request_firmware: Info - Loading firmware
> > file 'rt2870.bin'
> > ieee80211 phy0: rt2x00lib_request_firmware: Info - Firmware
> > detected - version: 0.36
> >=20
> > But there is one big difference on my system: I can't reproduce the
> > bug so far. It's working as it should... (I did not apply the debug
> > patches myself so far)
> >=20
> > I'm now planning to look a bit more into the rt2800usb driver and=20
> > provide another debug patch for interesting looking code pieces in
> > it.
> >=20
> > @Thomas:
> > I've also uploaded you my binary kernel I'm running at the moment
> > here: https://www.awhome.eu/s/5FjqMS73rtCtSBM
> >=20
> > That kernel should also be able to boot and operate your system.
> > Can you try that and tell me, if that makes any difference?
> >=20
> > I'm also planning to provide some more debug patches, to figuring
> > out which part of commit 4444bc2116ae ("wifi: mac80211: Proper mark
> > iTXQs for resumption") fixes the issue for you. Assuming my
> > understanding above is correct the patch should not really
> > fix/break anything for you...With the findings above I would have
> > expected your git bisec to identify commit a790cc3a4fad ("wifi:
> > mac80211: add wake_tx_queue callback to drivers") as the first
> > broken commit...
> >=20
> > Alexander =20
>=20

