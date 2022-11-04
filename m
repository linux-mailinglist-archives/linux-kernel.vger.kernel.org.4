Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A61F61A13D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiKDTjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKDTix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:38:53 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CDB1100;
        Fri,  4 Nov 2022 12:38:44 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4FPDUB030697;
        Fri, 4 Nov 2022 19:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=8DLWvIgKifK3/WDHlcQAG4K3kstQiRCex2ZOGVAHO2s=;
 b=m3d4WveadfN2vlZ3fAjw0k+NpCagyGfyQDKse6gH+DijkmxrsO53AkI/p2TB9dkSg7hO
 Fwru55btttFY/1vx5u/0JO7+2ZZ/FuIQrmCFXvl3/0X9pumkfF5CtwRiiNjMjRgjaZC1
 3IIGgAoHTvMixoJSSnjLo4XkT63K3qX2g+9peFfHsYojerBSGfWApcVWttk1rmEAzKbk
 QVs9Wi1dy2FRGBwgtoQuqYMs6xuGn5Hp96KrS1cKXVVOj8B7uVDneqMmFUku/06Wr3dn
 c3DbC7YNh0AtUdTf5wrgKRoxp4JYV22ncfQudChAseQto1FqGpPgmBAXE0Qm+QmWg3dk yg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kn5bqsurp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 19:38:11 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 9AEEC8040F3;
        Fri,  4 Nov 2022 19:38:10 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id BAC7080353C;
        Fri,  4 Nov 2022 19:38:09 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        nick.hawkins@hpe.com, corbet@lwn.net, linux@armlinux.org.uk,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 2/6] ABI: sysfs-class-hwmon: add a description for fanY_fault
Date:   Fri,  4 Nov 2022 14:36:53 -0500
Message-Id: <20221104193657.105130-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104193657.105130-1-nick.hawkins@hpe.com>
References: <20221104193657.105130-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: _blGskLwhQylhmyFRrg7o-YVQoHSEv8V
X-Proofpoint-GUID: _blGskLwhQylhmyFRrg7o-YVQoHSEv8V
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040122
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The fans are capable of reporting a fault to the CPLD controller which
then reports it to the GXP SoC via PLREGS. This patch enables hwmon to
be able to report these failures up to the HOST OS.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 Documentation/ABI/testing/sysfs-class-hwmon | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
index 7271781a23b2..638f4c6d4ec7 100644
--- a/Documentation/ABI/testing/sysfs-class-hwmon
+++ b/Documentation/ABI/testing/sysfs-class-hwmon
@@ -276,6 +276,15 @@ Description:
 
 		RW
 
+What:		/sys/class/hwmon/hwmonX/fanY_fault
+Description:
+		Reports if a fan has reported failure.
+
+		- 1: Failed
+		- 0: Ok
+
+		RO
+
 What:		/sys/class/hwmon/hwmonX/pwmY
 Description:
 		Pulse width modulation fan control.
-- 
2.17.1

