Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E761265AE08
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjABIVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjABIUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:20:38 -0500
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F5E25FD;
        Mon,  2 Jan 2023 00:20:34 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.109.143.204])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 8739F23F543;
        Mon,  2 Jan 2023 08:10:33 +0000 (UTC)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 2 Jan
 2023 09:10:32 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <lee.jones@linaro.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <johan+linaro@kernel.org>, <marijn.suijten@somainline.org>,
        <andy.shevchenko@gmail.com>, <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [PATCH v7 0/6] Add a multicolor LED driver for groups of monochromatic LEDs
Date:   Mon, 2 Jan 2023 09:10:15 +0100
Message-ID: <20230102081021.138648-1-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 10482409609861020123
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrjedugdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffoggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefhkeelgffhlefhtefhgeektdevvdfgkeeltdehgeeujeeutdehkeeuhffftdenucfkphepuddvjedrtddrtddruddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhgvvgdrjhhonhgvsheslhhinhgrrhhordhorhhgpdhprghvvghlsehutgifrdgtiidprhhosghhodgutheskhgvrhhnvghlrdhorhhgpdhsvhgvnhdrshgthhifvghrmhgvrhesughishhruhhpthhivhgvqdhtvggthhhnohhlohhgihgvshdrtghomhdpkhhriiihshiithhofhdrkhhoiihlohifshhkihdoughtsehlihhnrghrohdrohhrghdpjhhohhgrnhdolhhinhgrrhhosehkvghrnhgvlhdrohhrghdpmhgrrhhijhhnrdhsuhhijhhtvghnsehsohhmrghinh
 hlihhnvgdrohhrghdprghnugihrdhshhgvvhgthhgvnhhkohesghhmrghilhdrtghomhdpjhgrtggvkhdrrghnrghsiigvfihskhhisehgmhgrihhlrdgtohhmpdhlihhnuhigqdhlvggushesvhhgvghrrdhkvghrnhgvlhdrohhrghdpuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhofedttdegpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Some HW design implement multicolor LEDs with several monochromatic LEDs.
Grouping the monochromatic LEDs allows to configure them in sync and use
the triggers.
The PWM multicolor LED driver implements such grouping but only for
PWM-based LEDs. As this feature is also desirable for the other types of
LEDs, this series implements it for any kind of LED device.

changes v6->v7:
 - in led_mcg_probe() increment the counter at the end of the loop for
   clarity.

changes v5->v6:
 - restore sysfs access to the leds when the device is removed

changes v4->v5:
 - Use "depends on COMPILE_TEST || OF" in Kconfig to indicate that OF
   is a functional requirement, not just a requirement for the
   compilation.
 - in led_mcg_probe() check if devm_of_led_get_optional() returns an
   error before testing for the end of the list.
 - use sysfs_emit() instead of sprintf() in color_show().
 - some grammar fixes in the comments and the commit logs.

changes v2->v3, only minor changes:
 - rephrased the Kconfig descritpion
 - make the sysfs interface of underlying LEDs read-only only if the probe
   is successful.
 - sanitize the header files
 - removed the useless call to dev_set_drvdata()
 - use dev_fwnode() to get the fwnode to the device.

changes v1->v2:
 - Followed Rob Herrings's suggestion to make the dt binding much simpler.
 - Added a patch to store the color property of a LED in its class
   structure (struct led_classdev).


Jean-Jacques Hiblot (6):
  devres: provide devm_krealloc_array()
  leds: class: simplify the implementation of devm_of_led_get()
  leds: provide devm_of_led_get_optional()
  leds: class: store the color index in struct led_classdev
  dt-bindings: leds: Add binding for a multicolor group of LEDs
  leds: Add a multicolor LED driver to group monochromatic LEDs

 Documentation/ABI/testing/sysfs-class-led     |   9 +
 .../bindings/leds/leds-group-multicolor.yaml  |  64 +++++++
 drivers/leds/led-class.c                      |  65 +++++--
 drivers/leds/rgb/Kconfig                      |  10 ++
 drivers/leds/rgb/Makefile                     |   1 +
 drivers/leds/rgb/leds-group-multicolor.c      | 166 ++++++++++++++++++
 include/linux/device.h                        |  13 ++
 include/linux/leds.h                          |   3 +
 8 files changed, 317 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
 create mode 100644 drivers/leds/rgb/leds-group-multicolor.c

-- 
2.25.1

