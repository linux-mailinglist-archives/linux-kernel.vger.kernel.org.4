Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A35646059
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiLGRhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiLGRhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:37:38 -0500
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.145.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7BB10EC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:37:34 -0800 (PST)
Received: from atl1wswcm04.websitewelcome.com (unknown [50.6.129.165])
        by atl4wswob04.websitewelcome.com (Postfix) with ESMTP id 2F7E0658C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 17:37:34 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id 2yMNpfFwW2cIM2yMPpwkWj; Wed, 07 Dec 2022 17:37:34 +0000
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mwspufoNVqOPT3V7QZ/EvePKFxM8hL1WYxqRiN1KeK8=; b=nP1Y4kSqyAgvLPZLnvtruWLbQH
        rFk3r+e7bQz4PcbjtAsRvHpR6K8VTziG3KKLaY1K92OKxDD/gOdNucusj+LXZUeDISHTxNr8h/pee
        f/eMry9o0WtVL8LmnikmOJTi/p9avSmA564XWj5TXtJ1C8s6NRENkYw4CU+xiVKX+THoTe7iMxjas
        O3bDwtTtgTnDVvZIU5zXLvZGrAilf+mLEOHg4bNFu4XLI2V4f2oPI8owgX7avQjs9LmKTfmEQZKgR
        vKXaEKJDxkDWv9LIbT8VALIT2aV9cevG2S4A9bBBjKreSW2t1oKl0f/E/qGgVwJfpMkemGUJ25F6O
        rP+8hKIQ==;
Received: from [106.222.117.249] (port=8172 helo=discovery..)
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <saravanan@linumiz.com>)
        id 1p2yMM-0025qb-Bn;
        Wed, 07 Dec 2022 17:37:30 +0000
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marten.lindahl@axis.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saravanan Sekar <saravanan@linumiz.com>
Subject: [PATCH v3 0/4] Add support for mpq7932 PMIC IC
Date:   Wed,  7 Dec 2022 18:37:12 +0100
Message-Id: <20221207173716.123223-1-saravanan@linumiz.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 106.222.117.249
X-Source-L: No
X-Exim-ID: 1p2yMM-0025qb-Bn
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (discovery..) [106.222.117.249]:8172
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 1
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJFpQhgrpg2iCFK1lVdbbQB7FFL0P3KfiG8fvJPENt2Ml1tWYUO6jGPk0faTLHIMshj604NIPiWFyAZu9de6Ul9ZUAOt+zVmnjB5Vt1uWITjQmC+QnJg
 UOrfkquhMf1hzKpeYecQXMNN809ihf9540CJUfLMPRdHJOmdySTbVhWb+AuLfdOM5EiFVGxiJzCJhRrH2wW0KXbcPS/VbpOHzE0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes in v3:
  - bindings moved from pmbus to regulator directory
  - added second configuraion option SENSORS_MPQ7932_REGULATOR which enables regulator functionality
  - fixed review comments on driver

changes in v2:
  - add new patch to include min_uV in PMBUS_REGULATOR_STEP
  - fix review comments mpq7932 driver, bindings document and Maintiners file

Saravanan Sekar (4):
  hwmon: pm_bus: core: Add min_uV in pmbus regulator helper macro
  dt-bindings: regulator: Add mps,mpq7932 power-management IC
  hwmon: (pmbus/mpq7932) Add a support for mpq7932 Power Management IC
  MAINTAINERS: Update the entry for MPQ7932 PMIC driver

 .../bindings/regulator/mps,mpq7932.yaml       |  68 ++++++++
 MAINTAINERS                                   |   1 +
 drivers/hwmon/pmbus/Kconfig                   |  16 ++
 drivers/hwmon/pmbus/Makefile                  |   1 +
 drivers/hwmon/pmbus/ltc2978.c                 |  16 +-
 drivers/hwmon/pmbus/mpq7932.c                 | 157 ++++++++++++++++++
 drivers/hwmon/pmbus/pmbus.h                   |   5 +-
 7 files changed, 254 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7932.yaml
 create mode 100644 drivers/hwmon/pmbus/mpq7932.c

-- 
2.34.1

