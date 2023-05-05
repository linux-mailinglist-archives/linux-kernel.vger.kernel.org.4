Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583766F7BDB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjEEEah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEEae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:30:34 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF80B7DB3;
        Thu,  4 May 2023 21:30:32 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 99C6F5C032F;
        Fri,  5 May 2023 00:30:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 05 May 2023 00:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1683261029; x=1683347429; bh=XES4iXxvck
        kCMX5/y3MP9xkYumxYm3xAmwtlzCAmBro=; b=S5HnNHChOgIJ0q5uWly47dNQNA
        D1bnvTQWYP3znhOYUFwDZJtStavdgiJMHNKLa5QQFiDm7bj+4PGgvcxrt3QjT4ia
        /7i1PhjpdlIaITlLB8mrtb9QmiBAbLYuZ8vR2Axe3vWF+jxUN/Dx1qt3PEpGaRa3
        P9UJgKtNPdKVwEh/m8we3F/nu6Nxn+1gyd0c34qwHlW3DhirQHN7h559VcT0NbvZ
        UJ+lKn7moKQhjlFshJ7qS4W+P5t9LD4P2CC4Mf24reEJmDsVq72rtWYJZ83ykGwm
        e/e4ld0+wDI/6u5YiazLWPtu19aEB3IY0GB1LPCCUN7D6hBq/Z78ad1sCycA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683261029; x=1683347429; bh=XES4iXxvckkCM
        X5/y3MP9xkYumxYm3xAmwtlzCAmBro=; b=Lpe0zno/SYKOnMq13tCD/3rUzJS1C
        3rVFwgrO1mPSQzQLQnrFmb8UFDY0rIpS3FFmg6jS1NiPPbN4iY0qiGqOyra/itGx
        7fyt2voWoy2ccXQEU/uFw4Q/6AXAgJNgmarqnaPvvgllPHEAj7j+0IImT0sKmC0o
        W/63oHwxmgYBStWgiZ/N3YhBtiMsdbPeOvXZ64B57NyJBBeuXx24FO6B9D5QYSa3
        SfQjJpHqumJl0NXEgsejlyNU1wqSCJ4NcN1L62dgaf4SKJ/S/KbKSUNFoKBla5X4
        6rbOQv71JBKnIHh00RQstDGnr+Lxyr4I5p1koGSpPrN79+kZRN/3cLZjA==
X-ME-Sender: <xms:ZYZUZN-BaOSDxc5rU9CQZUBbjcgvi_KSXxheXFt3fPTTGSubesOslA>
    <xme:ZYZUZBvCt4iWjp5v4MzYunx479NQgRVG9oEWOZ7XYlgSZ9oXlqQW6j8sSWi9Z-SOn
    7i2oe07TuNuC9yPf_U>
X-ME-Received: <xmr:ZYZUZLA_5qB0aUpCA823v9TMDLGsqO_-GxhPgXS6iuRX6YobjgzW9h8Pi0Vv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefuddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:ZYZUZBeqZPoKJ12nfK3kQSv2bI5VFmVC-zS8Iz3xMaehdMwcHPjCsQ>
    <xmx:ZYZUZCPaJAlYJU65kVtWex1w5iN6Yys9O1t_IAZAdppeh-DF2Z29vg>
    <xmx:ZYZUZDnv1vO-haIzcvAv-qcD3q8CI6zivOuO7t5e4AiAsgu7d9fWEg>
    <xmx:ZYZUZOAcBvRpkC0fR6bnDFQYAL-VDSbhehFBgEYfa3C4nkCW72hZQg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 00:30:24 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net,
        hdegoede@redhat.com, corentin.chary@gmail.com,
        markgross@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/1] platform/x86: asus-wmi: add support for ASUS screenpad
Date:   Fri,  5 May 2023 16:30:12 +1200
Message-Id: <20230505043013.2622603-1-luke@ljones.dev>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for the screenpad(-plus) found on a few ASUS laptops that have a main 16:9 or 16:10 screen and a shorter screen below the main but above the keyboard.
The support consists of:
- On off control
- Setting brightness from 0-255

There are some small quirks with this device when considering only the raw WMI methods:
1. The Off method can only switch the device off
2. Changing the brightness turns the device back on
3. To turn the device back on the brightness must be > 1
4. When the device is off the brightness can't be changed (so it is stored by the driver if device is off).
5. Booting with a value of 0 brightness (retained by bios) means the bios will set a value of > 0, < 15 which is far too dim and was unexpected by testers. The compromise was to set the brightness to 60 which is a usable brightness if the module init brightness was under 15.
6. When the device is off it is "unplugged"

All of the above points are addressed within the patch to create a good user experience and keep within user expectations.

Changelog:
- V2
  - Complete refactor to use as a backlight device

Luke D. Jones (1):
  platform/x86: asus-wmi: add support for ASUS screenpad

 .../ABI/testing/sysfs-platform-asus-wmi       |   2 +-
 drivers/platform/x86/asus-wmi.c               | 132 ++++++++++++++++++
 drivers/platform/x86/asus-wmi.h               |   1 +
 include/linux/platform_data/x86/asus-wmi.h    |   4 +
 4 files changed, 138 insertions(+), 1 deletion(-)

-- 
2.40.0

