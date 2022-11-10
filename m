Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81C0624656
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiKJPvg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Nov 2022 10:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiKJPvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:51:32 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5F42981B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:51:29 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6166C3C28C2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 15:51:28 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id EA4FB3C28BB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 15:51:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668095487; a=rsa-sha256;
        cv=none;
        b=D+sjt1vUjN+wCAzbMUTLwh9dcM8FDIZtUdL4fBIQkpfrunSfyqWi0je+j240mNs3/WQFD9
        CWzTue8Ie5ge+NtUPxovgrQr6q1ivHQDU/Je+m5nFmrI0c6YC4tJvhMzBISH8js0hfOMZS
        3+COxOpwBpKWj5g2bfxH46cEWaIhlE9mrL67txIzXrOdqN3oYS0eg2gsuBvJyxZD/umAb5
        CjsaQ+i02ihWWm+anAvNvkR2/n82PT2P8xxL6erA6/fsKGQ4R/pWk6OF3VJtvOgSf6pqNX
        GsHBnyxtQbtfQFlpqk9ugewfHrFuYGI0cClatG2JIKLeg802vYrK6djC5Y6r7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668095487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2qhiPoENMAsMlFMExCVk79Dvj953WH4RIcCmmxQAorE=;
        b=EBvz8lOa/oopTZ2G/RvAbH7qZMQC0xhIymP7m+pZCTs9D/Nkqc85V1a1iCwglf6sr4T4gq
        14voWnx6GVBfm5mc4918OHrgI+UorX+M9GKB9OyS5v8fXgAkkNiOzoSYnQIJbUxQbLliuV
        FEum8/ADSKMVSxDUeEz2jy7GER25i0iAzEeOers/4dg1jqSAED9Tm8LS3nj/p9jbBP426X
        ENq07sQsj7kx8IsXPUU6IAcN1I5GXcfNXMvWUPfWTJP5Zz2D6xr1VJ679ADUOefC7hp97y
        rNRt7qzYjFKjToDbzd7oO2nabQY6mcZ0fUckpljL9GSUmPcnEgCAH2M2RYKRjA==
ARC-Authentication-Results: i=1;
        rspamd-7f9bbcf788-bggqn;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Attack-Fearful: 2d5eb5c264473c67_1668095487486_3270916758
X-MC-Loop-Signature: 1668095487486:3896382440
X-MC-Ingress-Time: 1668095487486
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.97.48.72 (trex/6.7.1);
        Thu, 10 Nov 2022 15:51:27 +0000
Received: from ppp-46-244-242-174.dynamic.mnet-online.de ([46.244.242.174]:36804 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1ot9pr-00064j-3c
        for linux-kernel@vger.kernel.org;
        Thu, 10 Nov 2022 15:51:25 +0000
Message-ID: <137702a8b3abf9cd7083acd05156bdf970b0a41d.camel@scientia.org>
Subject: non-functional suspend/resume on Fujitsu Lifebook U7512 (and more)
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-kernel@vger.kernel.org
Date:   Thu, 10 Nov 2022 16:51:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        HAS_X_OUTGOING_SPAM_STAT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey.


I got a new Fujitsu Lifebook U7512, which has an Intel i7-1270P and
runs with Debian unstable (kernel 6.0.7).

There are a number of problems, where I don't know where exactly to
report.

1) Suspend to RAM is probably broken
   First, there was the problem discussed here:
    https://gitlab.freedesktop.org/drm/intel/-/issues/7402
   respectively in own my earlier report:
    https://gitlab.freedesktop.org/drm/intel/-/issues/7378
   But for that here are patches (see first link) which I've
   tested and they fix that problem.

   However, as I've already mentioned here:
    https://gitlab.freedesktop.org/drm/intel/-/issues/7402#note_1632185
   there's more broken with suspend, which I guess is unrelated to
   i915:

   With and without the fix for the above issue, when I send the system
   to suspend to RAM, while there is some bigger CPU activity (and one
   can noticeably hear the fan), the fan stays on even when suspended.
   When the fan ran very fast when suspending, it seems to slow down,
   but then ever really stops completely.

   With previous Lifebooks, the suspend was completed, when the screen
   turned off, and the power button LED started blinking, which is also
   what happens above.
   However, because of the fan issue and the following, I'm not even
   sure, whether it's really fully suspended at all.

   In earlier device, the resume was initiated when pressing the power
   button (or opening the lid).
   However, no pressing the power button has no effect at all (even
   pressing it several times) - but pressing any keyboard key, causes
   it to resume (which works correctly with the patches to i915).


   Any ideas what to do? Or is this some firmware issue, where the
   kernel cannot really fix anything?



2) While booting, kernel log gives a number of errors/warnings, where
   I'm not sure whether anything should be done/reported, or if that's
   just "normal":

   pmd_set_huge: Cannot satisfy [mem 0xc0000000-0xc0200000] with a huge-page mapping due to MTRR override.

   pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid
   pci 0000:00:07.1: DPC: RP PIO log size 0 is invalid

   pnp 00:03: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]

   hpet_acpi_add: no address or irqs in _CRS

   i2c i2c-17: Systems with more than 4 memory slots not supported yet, not instantiating SPD

   thermal thermal_zone4: failed to read out thermal zone (-61)



3) That one I saw only once (much later, not during boot), but sounded
   a bit more concerning:
   Scheduler frequency invariance went wobbly, disabling!



If anyone could help/tell whether the ones from (2) and (3) are
"interesting" and should be reported somewhere (and where?) that would
be appreciated.
I personally don't see any other big malfunctioning than that from (1),
so I would rather ignore (2) and (3) from my side.



Thanks a lot,
Chris.
