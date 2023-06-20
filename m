Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1368F7361DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjFTDBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjFTDB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:01:26 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EC91995;
        Mon, 19 Jun 2023 20:00:56 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A3A8B5C00C5;
        Mon, 19 Jun 2023 23:00:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 19 Jun 2023 23:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1687230055; x=1687316455; bh=WIMSQ26wsM
        Ddg38DEAukRd9TdGdHyLx8UuCr2w4i4vQ=; b=s9AONZSg7gSD/doKtqXky6xTei
        SYWUyE6T6JezynPinG+IL41CM4s5yg8g6hAKFuwJA7Zbhg6O6+/+Qu3JM4cDftCc
        85GZ90I5IZCPgm7sIH8Ai60FavTl0x/+A4W99Dt4FrWODN24SavoeQdH7x86/PfC
        SleVzhX2Y9+MQBZn5N/j+j3DWXVqGAa313btxUgRSKNaMuxcsn/jF1ppbXe+BKVx
        tEzgoNVMny7DLxNA9ynTJjlcQnYAHvVuBUBM9PKlxODvJ1mjAFUWUGjLuaymOjAZ
        1+/h5MVcCPy4uDu1+k1Y3/gQifv2icaTgNohp97N3n4MiTSe/rYi2WOLM3+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687230055; x=1687316455; bh=WIMSQ26wsMDdg
        38DEAukRd9TdGdHyLx8UuCr2w4i4vQ=; b=eeMmppisYTnmQwYD7oOnUCFpy5CSF
        1VVqMUTW+mzmeGLB1e1kHAGFMLekD/TOHgDLO7dEnZyPf4Y83Ww52/ULRXxsVf42
        44esKZ0KEs2uJBMCBQqtgjDjNVw80s4t1ZfE8ggKpRan0RcMDlLeY9uP3lrYTz2K
        K8Y7YcumSOT8yOE7rJJZn7q0cWPuQJdiCoq6oK2AdlNhbuhYyWDT66k0rDiHBYoW
        74x9wzJ8xZaqmn/r5zUpx/LnwRrMSGDjSdpZ1wfgO9zn5TySCD5iAK+J1lSe8eCA
        t9htPQYtWQcT5MS5AmqeRlL18Fp96gBdoBxq93vXRIrQ5wExjAxyPhOwg==
X-ME-Sender: <xms:ZxaRZIsC_R24s3om4GAz28u5hm9B6oLABSCq-e-WSgeo-VThCIbtew>
    <xme:ZxaRZFcTHT9NOE2S5IoP2cUx2j529lyho9uVLJgbNPkvGdGsy28xaKZa-dpsWv_uM
    Q69HCdxWdxTyw1Pleg>
X-ME-Received: <xmr:ZxaRZDy-VTxTXgAbOQWJUsz1z5J_3sFJz2Tx3tHX3eRfPcq0AVkhgnypsEaZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:ZxaRZLNTn2VnWXFUrsgMEUWyxoIq6aDLuhbxe1fWAbNOADOLgO2EnA>
    <xmx:ZxaRZI85UQkrJrqNQfYb1geG7GVh400MJVRIbtVVu2UqRPf6H3ewoA>
    <xmx:ZxaRZDWYBoQUgLuePXFXQQw8-AOL6i2lbfObqa4izI1kXLR038y3pw>
    <xmx:ZxaRZFMhXpYmeqv7qBcLuVLG17GVm2qE9TA9aDvl7gfRkrtrrHfWcg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 23:00:52 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 0/1] asus-wmi: add support for ASUS screenpad
Date:   Tue, 20 Jun 2023 15:00:32 +1200
Message-Id: <20230620030033.55033-1-luke@ljones.dev>
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
- V3
  - Refactor error handling in all functions
- V2
  - Complete refactor to use as a backlight device

Luke D. Jones (1):
  platform/x86: asus-wmi: add support for ASUS screenpad

 drivers/platform/x86/asus-wmi.c            | 129 +++++++++++++++++++++
 drivers/platform/x86/asus-wmi.h            |   1 +
 include/linux/platform_data/x86/asus-wmi.h |   4 +
 3 files changed, 134 insertions(+)

-- 
2.40.1

