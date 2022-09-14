Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C255B5B85A4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiINJx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiINJwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:52:37 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE4172FC8;
        Wed, 14 Sep 2022 02:52:15 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bh13so13845745pgb.4;
        Wed, 14 Sep 2022 02:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date;
        bh=7bbRGJ2JS/s/WCHseBjrCcrVfObmPjMEWiCrZVOXNHA=;
        b=ad0SES9QMv9oQTBQOhrORY0IQflgogJWDILvrSosXQZe3EzZVoPzAZ6axkmeVCj7wn
         LDtO8rlV+mVCYaG2DZDSBny5c6ESei9KEwMl7cT2co0qaU5nCKSVdph/EY0A3x8H0h8z
         hUZqtkaMZy+oWxbXfwY3UzhiqX/1R6TwWBzNOOkNcJcxte1lpLdgrQW10UtuyB9D1d/s
         QbNoGgP0Gbm9g4xqQPioM4TevBIdM3AgaPNd4xTKhnrZrYkiykIA/u//l4CJgNM7MqS8
         l1jdmAQKPXh+CLWlsTX9TqogW3dIVEty5nyFVUdCuHPiqa1AiFjQ/GMHIPmt1o/JglJe
         PXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7bbRGJ2JS/s/WCHseBjrCcrVfObmPjMEWiCrZVOXNHA=;
        b=Uvg428TwUujHWHQwzkrytSPka3h6biV9Kc+ML3bY64Lq3d6MkKlMi0yQzNtrd3OuAC
         A2KIrwWe+WhcwVGxr4zlRAFckUS2sXO2ucKGkYywy/KqDvXIpvcnu+ZYXia25MbIMqHR
         GAalSG//0h3BUmwpWpL8QLYrrG45tOBAa4U58ckmdF20gCq+zgILuDJcXFg3UdYJ21Rb
         wHmiXRxESYHWJaad35SdfdZMBLUrd+AGPsDx7zF+qPeSavM28OEL57ezXFQgx9tOw0mQ
         5RBSmZzH0o0f1+zuzrGL6rRDMR6hQ2b7GI9RYAfkX9d5vOmaUyvbqnqwrFoPaznQIqDW
         3ODQ==
X-Gm-Message-State: ACgBeo2bF7Xm9gK5dc9pEjSe7JRZHNqtybXS6mqBu/Tyym/+yzW0s4jT
        j4KQOqS9BhKOsoc6tiDzVMU=
X-Google-Smtp-Source: AA6agR4Dq2DOK4PqqkuhxpraN39JXWKIhFvyaN51qATXjuLEw7vwHMJaJBSoOp+UY3I06hA/M5O+Pw==
X-Received: by 2002:a05:6a00:2789:b0:548:1278:3e2a with SMTP id bd9-20020a056a00278900b0054812783e2amr1351055pfb.24.1663149134378;
        Wed, 14 Sep 2022 02:52:14 -0700 (PDT)
Received: from hcl-ThinkPad-T495 ([2401:4900:1ce2:dc94:48c4:2ac5:ccad:657d])
        by smtp.gmail.com with ESMTPSA id w63-20020a626242000000b0053dec787698sm9947437pfb.175.2022.09.14.02.52.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Sep 2022 02:52:13 -0700 (PDT)
Date:   Wed, 14 Sep 2022 15:22:07 +0530
From:   Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH v3] ARM: dts: aspeed: yosemit V2: Enable OCP debug card
Message-ID: <20220914095207.GA24690@hcl-ThinkPad-T495>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added IPMB-13 channel for Debug Card communication.
which improve the readability of the machine and makes
easier to debug the server.  and it will display the some
informations about the server like "system info",
"Critical sensors" and "critical sel".

---
--- v3- 2- Updated the title and commit
---

---
--- v2- Updated the title
---

---
--- v1- Initial draft
---

Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
index 8864e9c312a8..df29072b3d1b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -215,6 +215,17 @@
 	};
 };
 
+&i2c13 {
+	status = "okay";
+	// Debug Card
+	multi-master;
+	ipmb13 at 10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+};
+};
+
 &pwm_tacho {
 	status = "okay";
 	//FSC
-- 
2.17.1

