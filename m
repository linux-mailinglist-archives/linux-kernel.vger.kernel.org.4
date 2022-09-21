Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A965BF68D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiIUGnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIUGnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:43:16 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ABD796B5;
        Tue, 20 Sep 2022 23:43:15 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t70so4992790pgc.5;
        Tue, 20 Sep 2022 23:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date;
        bh=4OoemoqY03kwE/AES+O6nYI9GibmetWZKgTywgqbXVk=;
        b=Cdlu9ugblpLjxtMTv8T1E0QgdC92dLmJ9eALZY+V+j70X7VvVQ0h59gr7+k976fRmM
         t5HMxJbhR5kxqW9SYL0EQQrQjBMOuM/wFvm9WmQ5H0NSrGKQJNZY889998ILbRcdnR5U
         SsMqJAB8JPaE23G7J7uHcOeruUH5JdOzZQuRG+o2vgmPVJUJ4v1KvXLasPdtZVDlNPtE
         wjfGhEKc43K7nZajqD6AsyrLLxm3tw5XZBK5em/qj4e0zJLYPoZka2vVWlSut2UWO2mR
         RNHkBHmzwNJt+4nm2QM5SdFmDz2PGUesIE2f5NahLaDQr/NMSFkyc+JqV9q6feZlHup+
         qYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4OoemoqY03kwE/AES+O6nYI9GibmetWZKgTywgqbXVk=;
        b=2eVD94VD0E/8CbLVN/rBTSTFOsQyBMmXJ87ImHYPQJokr8z4/OIAbdqs/4j6C+Ia4e
         iN5T24RSl6fH4sRwSO3TIB6RZSfXGGPjh+iUOY+pJ0qAjT+9mS1F1OdhnxDSwnAPV605
         JrbjbyNnAUFC/TdEqC1T458UPP2HwFrGDNIRl0Yzc00hqIwlZ1s6TLusdzleJIV5PqcG
         grrEhRm8frLRmShdkv5dD9K3EPBjgyj/2xE7MJrYx4WZBUKbsrMM/caY150lhIzVN6um
         gM+uS5PmvqkXsUswSOKoCnia410GUj/h/JAXAvwD3ne7enYq5zGEq43XQFNG/ON+R+Sz
         f1ig==
X-Gm-Message-State: ACrzQf3t8oGGr+c34dXGGEP3Bdi7QlV8lx8FAVfstZGENMHPEMagQKJ8
        k1kgmxzeNweDjhYk3es64hk=
X-Google-Smtp-Source: AMsMyM5GoiNadp9pZlmdf85gfN7sInYz4kz0i/l9s9SSP9mUaVvqWWPpOlwENy6IRXcjPmMG8qpYhQ==
X-Received: by 2002:a63:8a4a:0:b0:438:6a17:f0bb with SMTP id y71-20020a638a4a000000b004386a17f0bbmr22722052pgd.267.1663742595348;
        Tue, 20 Sep 2022 23:43:15 -0700 (PDT)
Received: from hcl-ThinkPad-T495 ([2401:4900:1ce2:b8f9:48c4:2ac5:ccad:657d])
        by smtp.gmail.com with ESMTPSA id jg11-20020a17090326cb00b001769ee307d8sm1117799plb.59.2022.09.20.23.43.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Sep 2022 23:43:14 -0700 (PDT)
Date:   Wed, 21 Sep 2022 12:13:09 +0530
From:   Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v4] ARM: dts: aspeed: yosemit V2: Enable OCP debug card
Message-ID: <20220921064309.GA18932@hcl-ThinkPad-T495>
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
which improve the readability of the machine and makes
easier to debug the server.  and it will display the some
informations about the server like "system info",
"Critical sensors" and "critical sel".

---
--- v4- Resolved syntax error
--- v3- Updated the title and commit
--- v2- Updated the title
--- v1- Initial draft
---

Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
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

