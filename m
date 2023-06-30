Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6677E743374
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 06:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjF3ESI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 00:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjF3ESE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 00:18:04 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895D61FE9;
        Thu, 29 Jun 2023 21:18:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3FC123200991;
        Fri, 30 Jun 2023 00:17:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 30 Jun 2023 00:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1688098678; x=1688185078; bh=BZ7oSZ7ADh
        AqExrANywARhivzR2LpwYy+ka8YnAU4tU=; b=wTiKImwwMnCqcR+Eq8CR0by2NY
        bI6YWmJRCxn7TJI0w3GG1xU/fZ9kxItzAlmTP/j/I9LTwVq5fKeBkFrJQb4f2Gqn
        9oU19ed4o5AHJYBNn1jaEv/IJpPXifC4F7WTPs7Noy32x/R2vklP+2oWwweXm59E
        y4csHhQUf39Ny1VAtnkfct33xHIR3dkS2shRd2z5wYygNYuFKw2UP2Hpb6jTXtWH
        m+yX1QhDEWoF+Fu+zIJsy9De41N75ywuwxD2dWbYVcnpj/lSr30HLx4sPowBFSbJ
        PfSA952qkoZ8Bz6dNgebnM1goAhLxG1MHCsyC47lPkVXrtXVtqrFaowoCCiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688098678; x=1688185078; bh=BZ7oSZ7ADhAqE
        xrANywARhivzR2LpwYy+ka8YnAU4tU=; b=WRQdhcNyWuJWvIheSEdlea5YyVPv8
        t+z9Lm9f5bl6oy/SvMxjE/3M+Zj1gK3uWVH83EzZeTi41tMZkrBW1ZAUNQ1siaL7
        TYbD1IhuCvv/7FhdR3FAO//THbI0bv/aUrpLxMlcQG9FqZx7pfyfOXMAJ4/CjD9i
        lXQm/eaRD+h1d3Nt5cJlJ6HXm1+l/ku744P0Y0D8ru4nFFSPFLUIrQgdvMs3ha+x
        iBqr6RSC0L5wPEU9y5v/FgzaGy23E04QWKoXBgFjvW7AH4A/knZuh6nVvqi615Aj
        flRoSftBP4l4oh92hDuv4oZMZHEqXF1e/pPde5OintQHVuYVBtOjl7q5A==
X-ME-Sender: <xms:dVeeZOp-mASquYwxk1y-MBEiwJNl4md2mOFrOrsGpWnbX3lz-Gbypg>
    <xme:dVeeZMphoiokhQPRFCQcBFfvp8C9qWm9B4f9-pWN22MrUDKFyFNDGb9VnMda9ZqUy
    sgd4Fdfn5AAeyRfMSE>
X-ME-Received: <xmr:dVeeZDN3l1Q4tStmTRGb4S5VeBJY7vdifhZFrtCcVtyPOqBi6xQFLJ-82416>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdehgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpedtheekieeggefgleekueeffeejuddvje
    evuddvhedtgeevfedtueegtedvledtjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukh
    gvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:dVeeZN7-fHsEyHi39_db5KGyfLu-xR2XjmJpz8hcXJrdwnyX0tYmbw>
    <xmx:dVeeZN68H5ZqkKwSdqbAm-Vtv8zn8wJcK4Z-kOJhH4JjrmXK6GlbVw>
    <xmx:dVeeZNh6wZAQEDyBQLWdCst2XR4lZRs4fYnvCPsMC1RQKlXaUlCXXg>
    <xmx:dleeZIby7xk8qKjl0H8OxKMBynguzzLP5Pd0A_NAByJdTKt-F51qgQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 00:17:54 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v4 0/1] asus-wmi: add support for ASUS screenpad
Date:   Fri, 30 Jun 2023 16:17:42 +1200
Message-ID: <20230630041743.911303-1-luke@ljones.dev>
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
- V4
  - Fix a null dereference that happened if the display was powered off and dev struct uninitialised yet
  - Previous: https://lore.kernel.org/all/20230620030033.55033-1-luke@ljones.dev/
- V3
  - Refactor error handling in all functions
- V2
  - Complete refactor to use as a backlight device

Luke D. Jones (1):
  platform/x86: asus-wmi: add support for ASUS screenpad

 drivers/platform/x86/asus-wmi.c            | 128 +++++++++++++++++++++
 drivers/platform/x86/asus-wmi.h            |   1 +
 include/linux/platform_data/x86/asus-wmi.h |   4 +
 3 files changed, 133 insertions(+)

-- 
2.41.0

