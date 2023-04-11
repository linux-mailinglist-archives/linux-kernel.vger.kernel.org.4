Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8336DE524
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDKT5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDKT5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:57:08 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2EE3A87
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:57:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D079C3200931
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 15:57:04 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Tue, 11 Apr 2023 15:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681243024; x=1681329424; bh=RR
        ssdUhLPGTqNipCHTW6mJP22s4LNYxJ0UUvYMMlsu0=; b=dzhqaRiH9JhOQYqIND
        OMQKMIdsw/5wlCDwbVte5jbHPR1hYKmzrdgs+HqP23b4UyYaN9qw4gE3qX9SqE6i
        Aqx7zZ2oKZueUQXiBDTx6DHwIpAz5enEoGgG8FPVy7NkowtcJQNuIhrueAfr7S8X
        VBXj3NV7xGyBNGaPU6dzlY2c9TsVXHfE4z5iA2QseX9RFeLihSQkV5ra/YRIcgHH
        VJ02NIcNHmy6r8hr06NlEpcpQx1fxeUWDnKYDphW+se+xIePl3NzsEc3WBaCJKwq
        sYLn3d8Fg/GKCErck2YTtPbTxT4aX3ly5uw/GFVtaGHRAmGEPj7WrXUryJ99UyY2
        C1gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681243024; x=1681329424; bh=RRssdUhLPGTqNipCHTW6mJP22s4LNYxJ0UU
        vYMMlsu0=; b=AQO4+IrjmIxYVeR1wgGEE6+maqk9uLWIODLDbbjP9kF4TPOp8mR
        0KlGsdGRNzcmC5n4W6ZB4T8Hjy7EGt5FOQ5uFl25f8KmwwV0EpHXWASRL+kGaWaq
        Yzg1d15glFUIPXMN0+J95+43hS/auWjyF5DU6s5VsoYIzsD0jXZ+8KUq/m53INDJ
        1iDot5L4KKodDlCznE9XAIUsow60qCyG6EMBnws0bBk1TMhjKynK0GxqCORXzVUD
        fOgiNMrCOoeaggsX0K04Z94PZ+YzIg+qQSnKt3J7LNmcPPwdxPcxELMXbFID6ot1
        ZDME77iMRX92CEJUQ9gf+s8cdZcAcVPW10w==
X-ME-Sender: <xms:kLs1ZN1-mhDKxltbcuviMh5OW_SVp2BP-nPZ4p6t5bNw1snZURNdmg>
    <xme:kLs1ZEGudMH5JYlQefDY-sXoBMxyk1VCk7sxLa0cj-VFC7jx_mSk1BgJVn0xUTknG
    zyP5R8_lGe1s3YBwJ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtre
    dtreertdenucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidfuceotghhrhhishestgho
    lhhorhhrvghmvgguihgvshdrtghomheqnecuggftrfgrthhtvghrnhepieefkedvveelte
    efhfdvffdtfeelleetfeekhedvieefveeijeeutedtvdefjeffnecuffhomhgrihhnpegv
    nhgrsghlvggurdgtrghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheptghhrhhishestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:kLs1ZN7viCxLryjgCwex8x0twgVfLv3aQs7LlhYHqBMzLPdET43J4g>
    <xmx:kLs1ZK0BW-eUZMtc4Pl8_dcQk7mR46p0G0uHDAPZncIVHdwD44jZ9w>
    <xmx:kLs1ZAHpABPm50xEuBKESoqtLVqHZPXEDLCf1xTBeWQbjFQS22h-yQ>
    <xmx:kLs1ZEQI9z3Ybv1jsXRp9I7b0-H4a5-RQKXrh5DMWYBpfwVSyenDZQ>
Feedback-ID: i07814636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 459F51700089; Tue, 11 Apr 2023 15:57:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <725fcda1-ef6a-4f3f-9c25-246fafb6e7f4@app.fastmail.com>
Date:   Tue, 11 Apr 2023 15:54:35 -0400
From:   "Chris Murphy" <chris@colorremedies.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: exposing full preemption in sysfs
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there a future when changing preemption mode at runtime will be exposed in sysfs outside of debugfs?

Currently debugfs is subject to kernel lockdown (at least on Fedora) whenever UEFI Secure Boot is enabled.

# cat /sys/kernel/debug/sched/preempt 
[68690.741678] Lockdown: cat: debugfs access is restricted; see man kernel_lockdown.7

So it's not possible to enable full preemption at runtime. Also, adding another kernel parameter isn't popular (takes up limited space, isn't user facing or very friendly to modify bootloader configuration to enable or disable it).

I think it's preferred to see it available in syfs  proper, and then something like a systemd unit can modify the value during boot, and users can enable or disable that unit like they do any other kind of service.

Thoughts?


--
Chris Murphy
