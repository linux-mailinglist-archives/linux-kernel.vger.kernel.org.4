Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4391474345A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjF3FgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF3FgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:36:04 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C546410F8;
        Thu, 29 Jun 2023 22:36:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 590893200987;
        Fri, 30 Jun 2023 01:36:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 30 Jun 2023 01:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1688103360; x=1688189760; bh=MYM7zcS68e
        tgcFaROVR2fVfdgFG8CJYtLYbZNZStSYw=; b=kVoxg5IE+bVDjQxJRo2gA3KmBY
        O1Gr+TOEjCWAcagetji6lPFPodsYVRadAxkBk4zjPzIZEolWDH/jisqyuJpfZ1F0
        0nJa47jSurjcs4Yd3ZT9z/TQAD5UaCRBf8exaAKC3GNX2QIFRGq3eHkTYkswGEHp
        SvD2vHtFWmIiiY49vVcuemwo/Bkz1fI1Jt1RW835wGBooarN+nXGVxSeaGPqGCMA
        gA/smpg2SeugeeO78q5TGmps9cxBheNUrbxcslmjg0Qm192Ng1thY8VSXyCa4JSI
        CiuqnaU3fomQaM2w64ijnqpSjMY79NySXDP0o5kRjDwvIfK7ZQffqD3YNJsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688103360; x=1688189760; bh=MYM7zcS68etgc
        FaROVR2fVfdgFG8CJYtLYbZNZStSYw=; b=MuoYYEgkZKG+jnZu6nsXiC0OW6oxc
        Nm0hdF/XIuK5rSqD0hnvRTIu3NJwb3A+fAEhlPd5fGT2Kh8Uq+3nrTTI58O7+Mns
        9eJ2g1iXxLd9dHUdheDX9Pnoi03zqbrY4cVScUVrIFM44XZtEKPREKPXrq0A/jz7
        Qoixv2jHtD7h+5b70evRKa/aukbLPlNmZD26bAFocB1EuHrlb8BxSEsHcEmf7fyi
        1j+eOXyVy4Sp2lH7lhscbdp3Dfcoi59LN1DetUYG7WdS/qoRkXLGAJCP/r2aMLi8
        p3lMoMdHiayKZ32SSWJpYGwKJwsppYl8PU2f7vv7FIOFmr5VIFcTf4Elw==
X-ME-Sender: <xms:wGmeZNvhlLl5A9J3hP0X4hIQDzRoGsSkYgTEJtbbTjts60uRFnFUgA>
    <xme:wGmeZGcIKS9SVvOwUlKdlVk8nyzHAOM2bKLQ4m0LRWG-FhnCikyni8w0KO-BlQoWB
    3lDWUFlY0B66wOYJ8U>
X-ME-Received: <xmr:wGmeZAx2WfqxnIdP5xCYpnVY0jGRBHy_M5-o_l0YF4nr9xvh6Mo2CeE-aBUC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdehgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:wGmeZEN3GXiS_-6Z_o_aR6vJqqQrSZHyAeilvCLgniFkOztDnK8oKg>
    <xmx:wGmeZN-9BUyJgr5FJGzypMdV293q5ZiTEK1OgHWYKOhU04bIZV6zQQ>
    <xmx:wGmeZEXOgnO5vSPLk0QY1VF_5jZnJg2RlGXTH3uYv8bHdX0bFFErfQ>
    <xmx:wGmeZGN6kayqlQQMhStZrmH4PCuacUWScscDZKDAeih4-vrPK9OlHQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 01:35:57 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/8] platform/x86: asus-wmi:
Date:   Fri, 30 Jun 2023 17:35:44 +1200
Message-ID: <20230630053552.976579-1-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds or exposes more features that are available in the ROG
laptop series.

- expose dGPU and CPU tunables for ROG
  - These are things like GPU boost, CPU Pl1 and PL2, package power limits
- support setting mini-LED mode
  - Some newer laptops have a screen that can toggle between regular style
    backlight and using mini-LED backlight
- add WMI method to show if egpu connected
  - This WMI method can be monitored/queried to see if it is possible to begin
    the change-over to eGPU
- support middle fan custom curves
  - Some newer laptops have a center/middle fan which blows across the CPU and GPU
- add support for showing middle fan RPM
- add support for showing charger mode (AC, USB-C, both plugged)
- add additional checks to GPU switching code
  - These try to prevent a sceanrio such as the user disabling the dGPU while it
    is driving the internal panel via MUX, resulting in no output at all.
    There are no checks in the ACPI code for this, but on some newer models ASUS
    did finally add a switch in the BIOS menu. It is best to try and prevent this
    at the kernel level rather than userland level.

All patches pass ./scripts/checkpatch.pl

Changelog:
- v2-0008-platform-x86-asus-wmi-expose-dGPU-and-CPU-tunable.patch
	- Rename the WMI defs to match what ASUS supplied as names
	- Remove EDC and TDC exposure (unsafe)
	- Slight change to formatting
	- Add better notes to documentation
		

Luke D. Jones (8):
  platform/x86: asus-wmi: add support for showing charger mode
  platform/x86: asus-wmi: add support for showing middle fan RPM
  platform/x86: asus-wmi: support middle fan custom curves
  platform/x86: asus-wmi: add WMI method to show if egpu connected
  platform/x86: asus-wmi: don't allow eGPU switching if eGPU not
    connected
  platform/x86: asus-wmi: add safety checks to gpu switching
  platform/x86: asus-wmi: support setting mini-LED mode
  platform/x86: asus-wmi: expose dGPU and CPU tunables for ROG

 .../ABI/testing/sysfs-platform-asus-wmi       |  86 +++
 drivers/platform/x86/asus-wmi.c               | 605 +++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h    |  19 +-
 3 files changed, 707 insertions(+), 3 deletions(-)

-- 
2.41.0

