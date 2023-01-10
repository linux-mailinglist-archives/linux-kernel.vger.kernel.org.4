Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C2066382A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 05:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjAJE03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 23:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjAJE0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 23:26:09 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849961648A;
        Mon,  9 Jan 2023 20:26:07 -0800 (PST)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A0nD1h003597;
        Tue, 10 Jan 2023 04:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=eJWRKFD9z7plkN6elhB+a1yxixq+W/JZIKNF2DtUM2M=;
 b=H1WPde8lyAy2Xb3TUkFlxhQVz6tAFkBPj2Fy0MeyyOfEQVNVi1t/Bu6SwgRpoH2OIb+f
 F+3c6vmNMLi6NJ3dp8rNYV6Q+07xeQ6x2fq4HqeYmp2Alao6LkE+YCKgRBdH4Hbwi/Ub
 KlLy1iR++MyIXusxvsWPysec0N//WUhUc4SHwtkpRhlh6gn/TCyKwyNoS5ydSJOJ4uve
 oaWTv6NdJu7Oy1DlyxkPN/oSgO3rMFfQwKWYob+RYhGDYwJQWxW+Y0B1k1+LKgKHpWRg
 3wQHAsIrQr0tXJE1GAi2lzPQrcxgIGO3HkQtg8TWVIqyWrojlSsWvFun7U9B5pnlVPPe CA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3n0wt814kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 04:25:58 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 9BE75310C4;
        Tue, 10 Jan 2023 04:25:57 +0000 (UTC)
Received: from openbmc-dev.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id E80AF80C76A;
        Tue, 10 Jan 2023 04:25:53 +0000 (UTC)
From:   clayc@hpe.com
To:     linux-kernel@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        verdun@hpe.com, nick.hawkins@hpe.com, arnd@arndb.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux@armlinux.org.uk, olof@lixom.net
Cc:     Clay Chang <clayc@hpe.com>
Subject: [PATCH 4/5] ARM: multi_v7_defconfig: Add GXP SROM Driver
Date:   Tue, 10 Jan 2023 12:25:32 +0800
Message-Id: <20230110042533.12894-5-clayc@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230110042533.12894-1-clayc@hpe.com>
References: <20230110042533.12894-1-clayc@hpe.com>
X-Proofpoint-ORIG-GUID: NvDGkOUb1mry9b_b4wxgR0KE0AjaSFOw
X-Proofpoint-GUID: NvDGkOUb1mry9b_b4wxgR0KE0AjaSFOw
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_01,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 clxscore=1015 mlxlogscore=634 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clay Chang <clayc@hpe.com>

Add the CONFIG_HPE_GXP_SROM and CONFIG_HPE_GXP_SOCLIB.

Signed-off-by: Clay Chang <clayc@hpe.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ee184eb37adc..f50a3731b84c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1254,3 +1254,5 @@ CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
+CONFIG_HPE_GXP_SOCLIB=m
+CONFIG_HPE_GXP_SROM=m
-- 
2.17.1

