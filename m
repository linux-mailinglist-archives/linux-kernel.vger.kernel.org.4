Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A14163E8F2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiLAErW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiLAErF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:47:05 -0500
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.152.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118FD98945
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 20:46:59 -0800 (PST)
Received: from atl1wswcm03.websitewelcome.com (unknown [50.6.129.164])
        by atl3wswob01.websitewelcome.com (Postfix) with ESMTP id 1CBED313F3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:46:59 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id 0bTMpLUSEPUI80bTOp4Uup; Thu, 01 Dec 2022 04:46:59 +0000
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GtPPFXFKQWd88ykrxWYieq1xl8IAIXPVRnRMrWifEHw=; b=jIS8Vx0IZ5Oj+DDtDjUARUagVx
        on7EYtsn+jblWiE5hoRVndcBm3RqRL1qh0PupN5Y7dqXbBYqK64/8FYMVu9nMuQNhWB7z0xX1Wd1x
        D042vPqJnc7kyetjRElv/cLvWb40mKvUg9aVVTOVXRrUlSUk0mBfYIS++fJYH1XW7jNoWRBhkhJWy
        DVTVu2x4DFYMyAZW9HChEC0BnsiOoXf/NnO/JRiA9MdGN8aedmGKErpLQrAvyG8PqX4YxxZzlRzpn
        oAlja/85/JYYiPOHM6WXP5ZzgE0IWVi4Q1vCchuZd082u3+iXYtR2l0NPnnt5h1KGimHYIYIBauR/
        juUNodWA==;
Received: from [223.187.112.123] (port=34121 helo=discovery..)
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <saravanan@linumiz.com>)
        id 1p0bTL-003t5m-6z;
        Thu, 01 Dec 2022 04:46:55 +0000
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marten.lindahl@axis.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saravanan Sekar <saravanan@linumiz.com>
Subject: [PATCH v2 0/4] Add support for mpq7932 PMIC IC
Date:   Thu,  1 Dec 2022 05:46:39 +0100
Message-Id: <20221201044643.1150870-1-saravanan@linumiz.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 223.187.112.123
X-Source-L: No
X-Exim-ID: 1p0bTL-003t5m-6z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (discovery..) [223.187.112.123]:34121
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 6
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHoKgiRkiN1bu7HJa8q93PZxEORCKRXa+MfrSCyOCtKrrlwRHps5dR/mSGkcTf3ILEeWa00j/zOgzlqZ+7VPBOx4bA5w6S69kNShoMmOViDDR/wHSky5
 C3Nut9iLbN1aUYzfQxW4FdNnJyIV/bk3nMR78STObcHoHYy9IlbFdWNgSHT3XpR20Q3dffJN6l7B/RPoEm1IDA2n/i2OOTWza2U=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes in v2:
  - add new patch to include min_uV in PMBUS_REGULATOR_STEP
  - fix review comments mpq7932 driver, bindings document and Maintiners file

Saravanan Sekar (4):
  hwmon: pm_bus: core: Add min_uV in pmbus regulator helper macro
  dt-bindings: hwmon/pmbus: Add mps,mpq7932 power-management IC
  hwmon: (pmbus/mpq7932) Add a support for mpq7932 Power Management IC
  MAINTAINERS: Update the entry for MPQ7932 PMIC driver

 .../bindings/hwmon/pmbus/mps,mpq7932.yaml     |  63 ++++++++
 MAINTAINERS                                   |   2 +
 drivers/hwmon/pmbus/Kconfig                   |  10 ++
 drivers/hwmon/pmbus/Makefile                  |   1 +
 drivers/hwmon/pmbus/ltc2978.c                 |  16 +-
 drivers/hwmon/pmbus/mpq7932.c                 | 144 ++++++++++++++++++
 drivers/hwmon/pmbus/pmbus.h                   |   5 +-
 7 files changed, 231 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/mps,mpq7932.yaml
 create mode 100644 drivers/hwmon/pmbus/mpq7932.c

-- 
2.34.1

