Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6739656969
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 11:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiL0KYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 05:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiL0KYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 05:24:01 -0500
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1551225CB;
        Tue, 27 Dec 2022 02:23:59 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.108.4.193])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 8ABB5147C1BE7;
        Tue, 27 Dec 2022 11:07:05 +0100 (CET)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 27 Dec
 2022 11:07:04 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <johan+linaro@kernel.org>, <marijn.suijten@somainline.org>,
        <bjorn.andersson@linaro.org>, <andy.shevchenko@gmail.com>,
        <jacek.anaszewski@gmail.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [RESEND PATCH v6 0/6] Add a multicolor LED driver for groups of monochromatic LEDs
Date:   Tue, 27 Dec 2022 11:06:53 +0100
Message-ID: <20221227100659.157071-1-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG3EX1.emp2.local (172.16.2.21) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 14107807311632546267
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedriedtgdduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfgtihesthekredtredttdenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepjeeuhfeklefghfelhfethfegkedtvedvgfekledtheegueejuedtheekuefhffdtnecukfhppeduvdejrddtrddtrddupdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdpphgrvhgvlhesuhgtfidrtgiipdhrohgshhdoughtsehkvghrnhgvlhdrohhrghdpshhvvghnrdhstghhfigvrhhmvghrseguihhsrhhuphhtihhvvgdqthgvtghhnhholhhoghhivghsrdgtohhmpdhkrhiihihsiihtohhfrdhkohiilhhofihskhhiodgutheslhhinhgrrhhordhorhhgpdhjohhhrghnodhlihhnrghroheskhgvrhhnvghlrdhorhhgpdhmrghrihhjnhdrshhuihhjthgvnhesshhomhgrihhnlhhinhgvrdhorh
 hgpdgsjhhorhhnrdgrnhguvghrshhsohhnsehlihhnrghrohdrohhrghdprghnugihrdhshhgvvhgthhgvnhhkohesghhmrghilhdrtghomhdpjhgrtggvkhdrrghnrghsiigvfihskhhisehgmhgrihhlrdgtohhmpdhlihhnuhigqdhlvggushesvhhgvghrrdhkvghrnhgvlhdrohhrghdpuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhohedvkedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Resending the v6 of the series.

I updated the date and kernel version in Documentation/ABI/testing/sysfs-class-led
to Dec 2022 and version 6.2.

Thanks,

JJ


Some HW design implement multicolor LEDs with several monochromatic LEDs.
Grouping the monochromatic LEDs allows to configure them in sync and use
the triggers.
The PWM multicolor LED driver implements such grouping but only for
PWM-based LEDs. As this feature is also desirable for the other types of
LEDs, this series implements it for any kind of LED device.

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
 drivers/leds/rgb/leds-group-multicolor.c      | 168 ++++++++++++++++++
 include/linux/device.h                        |  13 ++
 include/linux/leds.h                          |   3 +
 8 files changed, 319 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
 create mode 100644 drivers/leds/rgb/leds-group-multicolor.c

-- 
2.25.1

