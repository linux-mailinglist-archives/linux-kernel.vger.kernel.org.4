Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A96763E8F0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLAErL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLAErG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:47:06 -0500
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.152.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E835E98945
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 20:47:05 -0800 (PST)
Received: from atl1wswcm03.websitewelcome.com (unknown [50.6.129.164])
        by atl3wswob01.websitewelcome.com (Postfix) with ESMTP id 73A19316CC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:47:05 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id 0bTSpLUWgPUI80bTUp4UyS; Thu, 01 Dec 2022 04:47:05 +0000
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lt9ssPxraP7AVqIsyBoSkJvYwNULAALvMmqCxZgrk6g=; b=ov+DaIALsAqMIdNaVmoS0uPcOc
        DG4aWsV83JDARy8Lw0RcquU8bPpQ3JcBQRe8UVVSAvvVLBX6i1fiLBAU9/+Csqmtfp6Vv5UA3HdZV
        ul3uovvv0zmQ75tax5A/K3HGs8xZqRyA7arQJN/78eohykOkRCb2hkC9dSzl8A327Unt1zTfuhNCV
        Kxi1y2Uj61S6wBQcJ9rUtbVB5cRI+fTB57lVllGb6kqQCJUWSr2g8JglcwxiXHidYxi70lOIAJacr
        TDrxA7+Pq0wVY+l5UmEv7cPSyGH3RnPj116qJe+G2BkzjcVf4nFJ6vZEwdQXJ0/7Gr9ePRq4R8NcA
        3lc2s2GQ==;
Received: from [223.187.112.123] (port=34121 helo=discovery..)
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <saravanan@linumiz.com>)
        id 1p0bTR-003t5m-Jo;
        Thu, 01 Dec 2022 04:47:01 +0000
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marten.lindahl@axis.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saravanan Sekar <saravanan@linumiz.com>
Subject: [PATCH v2 4/4] MAINTAINERS: Update the entry for MPQ7932 PMIC driver
Date:   Thu,  1 Dec 2022 05:46:43 +0100
Message-Id: <20221201044643.1150870-5-saravanan@linumiz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221201044643.1150870-1-saravanan@linumiz.com>
References: <20221201044643.1150870-1-saravanan@linumiz.com>
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
X-Exim-ID: 1p0bTR-003t5m-Jo
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (discovery..) [223.187.112.123]:34121
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 38
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLdBeXa540jMSR4cOUfqOd6w4Q3J41GSuY4Gddy9+UN6+xY3wkKCONu8AnBzgBYM/QxdkRiIQ+aVLoLO9ljjW8nnjySzceLOTAKsV8AQefKNp785rYdC
 KuzLAlt4UPU0o50pEwYa2VkhzuZJKBH4mxWsZzkO0K9WMk0XvLOcPrwEsSEPUQPrMNryEYzATV6ZnMryyFS5n+zwaIdEzqsJ+GI=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the MAINTAINERS file to include the path for the MPQ7932 and
MPQ7932 devicetree bindings documentation.

Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 379945f82a64..8e0dbf4c6cf3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13924,8 +13924,10 @@ F:	scripts/module*
 MONOLITHIC POWER SYSTEM PMIC DRIVER
 M:	Saravanan Sekar <sravanhome@gmail.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/pmbus/mps,mpq7932.yaml
 F:	Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 F:	Documentation/devicetree/bindings/regulator/mps,mp*.yaml
+F:	drivers/hwmon/pmbus/mpq7932.c
 F:	drivers/iio/adc/mp2629_adc.c
 F:	drivers/mfd/mp2629.c
 F:	drivers/power/supply/mp2629_charger.c
-- 
2.34.1

