Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C316F7361B2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 04:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjFTC5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 22:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFTC5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 22:57:09 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4601AC;
        Mon, 19 Jun 2023 19:57:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 99F8A5C01ED;
        Mon, 19 Jun 2023 22:57:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 19 Jun 2023 22:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1687229825; x=1687316225; bh=9GbRm5CtvL
        ke73jGmzLqa1s16vX991t6TY9JsVkBVzQ=; b=L2Z8EDoHD1b0HgywJKMUqbYghi
        w4HOj/I3nsuQ8KI0h0O2GxCR7l4G//W7cOwYkjvuMRDmH7804KZHJlajDMSmFjHs
        g/a8at4dlV6WXwjhBatXLVqtTCXMqJKWyAMCECbgj7d8O51mbyLa5Mt1Snk8hpr1
        5NpTA4/nm4XwQw99O40jQ0bTdxnInqu97uTX+rcYaUZ2+D8vahBTMr10sWPYZXgq
        NxYUdhpB1cBDA1cta5dQ7UWMfjHomzpeTzvZkekIApVl628quWkQ9SRIA3LB8BLM
        wz235mhV9NcwQvC8wsA3I9YbIGoJ6s/7XKE7++/OfwaV3efAlHTHUMZUh/Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687229825; x=1687316225; bh=9GbRm5CtvLke7
        3jGmzLqa1s16vX991t6TY9JsVkBVzQ=; b=mT6b9Wt/th9vO+9nY9HJrhkhYuiwy
        dOEqXs54lJv1wJ/SdI2/cmiK7UXp7IbtvzVUP37+OKARidx+9pguIGKQh+xInlwJ
        ZxV5XTucqdKGwyGEXXRM3CtuAY9CX8AtlQQvCM76sBGXLCjs5rqVKXYrHBrHO2ct
        Z3lOpEPpH5rOh+pP8SQK664s7GxwflndtvRwyPZXhh29ffYGJusMXaN3VHiW7aPC
        5f1PEYRzaCNYaM9qOQsaTkRUPRPruq3vy8dPbYaIDfadj8LeXd7RVFUG2RsDWfDw
        u0Eu+k5NMdn2mtVUl4LSmZU65A86egATcePEzoTfetUJmYZGUFZDVUu1w==
X-ME-Sender: <xms:gRWRZMy83k_1lVNQnylydsu3rpwGRJop8333gbooZTJJOONYCUKrNQ>
    <xme:gRWRZATHe1vCimEDWsJpRfT07ScwWDueYoji43aD2pwlotRc6IcA1S6vzMXVmChLa
    mnfUrCo6beL24M22_s>
X-ME-Received: <xmr:gRWRZOWskQ9jdMMaIoGdbgBp5Wj9ESeh7YGbwSK8zFmL5z-PBwoyDVMJxDHt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:gRWRZKjHW8BHuCvf1TLgIAhMqH88kO2_v1qnz39FAHJNSpeEbS1v_g>
    <xmx:gRWRZOC2mFdRzFtrQxjnh7iis7fR1TezmZB7CnymAgaJ9w0pgrWT1Q>
    <xmx:gRWRZLK5udewIp7phIf2DQcx_zKHRCXZM_93ox95S2qYsZEn1Nl6kg>
    <xmx:gRWRZEAaNdL5-4H32xxfw1j0k_6hPL3Y0SqiiyVuwlHq3-vdXMjDJQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 22:57:02 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 0/8] asus-wmi: add/expose more features, fixes
Date:   Tue, 20 Jun 2023 14:56:33 +1200
Message-Id: <20230620025641.53197-1-luke@ljones.dev>
X-Mailer: git-send-email 2.40.1
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

 .../ABI/testing/sysfs-platform-asus-wmi       | 100 +++
 drivers/platform/x86/asus-wmi.c               | 685 +++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h    |  21 +-
 3 files changed, 803 insertions(+), 3 deletions(-)

-- 
2.40.1

