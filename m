Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798665FBACF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJKS4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJKS42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:56:28 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577BC7DF51;
        Tue, 11 Oct 2022 11:56:26 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BHIPkW006181;
        Tue, 11 Oct 2022 18:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=YpWs8mo9IaR2bHU46VUy4drcw7S0/CT/ZY7oZR3/e7Q=;
 b=Baf7FjeH6BoVVBAHqIYTUSgdvpmgpcVD0qB2YokZf6fPdCBbMDNk5nHxUYD/bkrGcSRU
 bdgsSVv2QLy5YzvYBgiOUJCT8AbtJ4ioHxgW3cx2xADmDXac7GuTc8uJ634DmhwUb9KV
 vewHiQjB85WpMgr8XrfaPbMqy1Jz6ghofsVyM60hnDL3eKlZ7GdImJSrYeIko154RM6P
 +5pegoAauOoaPCxJQXkRLacg5NcgzDMW2wMBQv8DZmqOLuw0qPeqwJVbEa6kUwlIfyyz
 ox2zQ8k3z44KlGForbn0c4aCbrpgp8fO0YrbUjuudrwa5KQldNeIWgsRbXWmAV17D653 aA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3k5crx8s45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 18:56:03 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id A814EB2;
        Tue, 11 Oct 2022 18:56:02 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 47772808C39;
        Tue, 11 Oct 2022 18:56:02 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 5/5] MAINTAINERS: Add HPE SOC Drivers
Date:   Tue, 11 Oct 2022 13:55:25 -0500
Message-Id: <20221011185525.94210-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011185525.94210-1-nick.hawkins@hpe.com>
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: Ug0QAypPg7DRInl5t9n3GuFupI7PfR3A
X-Proofpoint-GUID: Ug0QAypPg7DRInl5t9n3GuFupI7PfR3A
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxlogscore=882 priorityscore=1501 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110110
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Add the HPE GXP SOC Include files, yaml files, and driver files.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56ff555ed5a4..17e8eeaa8178 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2178,14 +2178,17 @@ M:	Jean-Marie Verdun <verdun@hpe.com>
 M:	Nick Hawkins <nick.hawkins@hpe.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
+F:	Documentation/devicetree/bindings/soc/hpe/hpe,gxp-plreg.yaml
 F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
 F:	arch/arm/boot/dts/hpe-bmc*
 F:	arch/arm/boot/dts/hpe-gxp*
 F:	arch/arm/mach-hpe/
 F:	drivers/clocksource/timer-gxp.c
+F:	drivers/soc/hpe/*
 F:	drivers/spi/spi-gxp.c
 F:	drivers/watchdog/gxp-wdt.c
+F:	include/linux/soc/hpe/*
 
 ARM/IGEP MACHINE SUPPORT
 M:	Enric Balletbo i Serra <eballetbo@gmail.com>
-- 
2.17.1

