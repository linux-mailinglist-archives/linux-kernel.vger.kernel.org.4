Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CB5EC1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiI0Lp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiI0Lp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:45:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28C82B625;
        Tue, 27 Sep 2022 04:45:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id u69so9189537pgd.2;
        Tue, 27 Sep 2022 04:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date;
        bh=uDOSqBZttnZv7P8HqZ8HwCRjONKPJ/QjDGFAByRBk1U=;
        b=AhsmJYB7vUwD9hZbhrCt5aKSpdDXmbhi/cFdz4w53f7B9pDA+aWfVC0YNBKnkzgQgN
         Y9g2/CUvucAlI1Oi7sxk9PGgJASvbBrcE77xLAp7aizn/yE7gFgsKP8uzwJVmirYdD1m
         cSom14nCDEq4dyUu8yqTvHGQ5+5kDfx12wt3E8tY7gbq6JSGGpNricFxp4H5EroQVp1n
         oD3vnt20CQqTQPaqqV90tEtFPKIgAwvLwBn+/cy1I8ZOJLAWkS/EkGhaQkJkrJoI1mzH
         gAS8O/istinclXcRWhQXomPfbshfyPfJp2QoOef66xnYDRpp/mMj7ibOkJFi2ln9TgGF
         sFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uDOSqBZttnZv7P8HqZ8HwCRjONKPJ/QjDGFAByRBk1U=;
        b=vgGlT4HBcDjZP7MfsekuD/lZEIglNbGgu6heMKxXZKnsiDhERkiuEM7+JUnY3I2ItM
         iLl5eXZoXkjDkWgXiIgdlUYSnGxHO25Z1rGI3noJ+IpKC8iiQ2389ElegaCQEwD7lMk7
         ow0TZ7YqpKdvym7945NMEwNWzhWsasNhUw29qNyeRz3sqpEJfTJd/iCQOWqQKbkyMJ/V
         1Ry2sC/52AdCXsTceVG/XsHFpLRvjRtX+uhlJfB9h+SAWBL7RSedMymomWA3CjoWCoyi
         7D8GXQ9dK8vuN6tPkqaCnuOTV07YvWpIxEQfChVqeQfNKtHH6Ng9+zuQQiqxz9sb7YTS
         YIvQ==
X-Gm-Message-State: ACrzQf0Fso60CIuSg/31ZUOoxlV+V59jbLGKkQE+Khaox+NNgzzV2eZd
        jtrwkCBRodZCcT1jJCqqM30=
X-Google-Smtp-Source: AMsMyM4biyHOCvyZbMp0yHoN0xIAZYO1CLD1sBXnTujiyM7jdoD6yUh7tJ/NNE1wHq1sO87xZ017Hw==
X-Received: by 2002:a62:17d1:0:b0:54d:87d5:249e with SMTP id 200-20020a6217d1000000b0054d87d5249emr28803450pfx.14.1664279122155;
        Tue, 27 Sep 2022 04:45:22 -0700 (PDT)
Received: from hcl-ThinkPad-T495 ([2409:4072:2e86:dcf8:cdbd:fcea:ad98:effa])
        by smtp.gmail.com with ESMTPSA id p6-20020a622906000000b00535d3caa66fsm1476441pfp.197.2022.09.27.04.45.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Sep 2022 04:45:21 -0700 (PDT)
Date:   Tue, 27 Sep 2022 17:15:15 +0530
From:   Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH v6] ARM: dts: aspeed: Yosemite V2: Enable OCP debug card
Message-ID: <20220927114515.GA22344@hcl-ThinkPad-T495>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added IPMB-13 channel for Debug Card communication.
which improves the readability of the machine and makes
it easier to debug the server and it will display some
pieces of information about the server like "system info",
"Critical sensors" and "critical sel".

Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
---
v6:
 -Fix the commit format

v5:
 -Updated commit message

v4:
 -Resolved syntax error

v3:
 -Updated the title and commit

v2:
 -Updated the title

v1:
 - Initial draft
---
---
 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
index 8864e9c312a8..84236df522dc 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -215,6 +215,17 @@
 	};
 };
 
+&i2c13 {
+	status = "okay";
+	// Debug Card
+	multi-master;
+	ipmb13@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
 &pwm_tacho {
 	status = "okay";
 	//FSC
-- 
2.17.1

