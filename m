Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C600463E195
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiK3UNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiK3UNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:13:05 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34E88E586;
        Wed, 30 Nov 2022 12:10:58 -0800 (PST)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUJaisI008479;
        Wed, 30 Nov 2022 20:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=BaP+vpJm0HGIoKSVbIN0D8aRlNrjQWzLOwUMMVNXGpo=;
 b=ooBgCvkqTRSw4mXD68nTmPAZagGaN551l3clQz7/ruCo8XlB3uLoReq3MME3rVYuesy7
 W/iAvig/2720oxgDnTKDpZE5BPugo97Khlbv3uCiDBqsOLm5qg40SUKDy3vmV1C9os1r
 vkSF1TXqHWQI1hLvb1UQ3L6BjkXqUKXcY2/WIyNXOp0uZD/wgMyTxCGAd+f1z82DR/np
 oWnOYmebermvkd0QQKumZP/ptJ6zGeLkAgYcPi0oAbVAhUYofuxcwL9SVtVEKLFwVGJ5
 +lnORd/TiFQsJu6BZpNxn+CjSo/slMJ/Vd1/9Nl8x5OqsloklayxXYhH00NiRD5P3tE7 qA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3m69p3t7st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 20:10:18 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 180018066E1;
        Wed, 30 Nov 2022 20:10:18 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 7960480A272;
        Wed, 30 Nov 2022 20:10:17 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        nick.hawkins@hpe.com, corbet@lwn.net, linux@armlinux.org.uk,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/6] ABI: sysfs-class-hwmon: add a description for fanY_fault
Date:   Wed, 30 Nov 2022 14:08:42 -0600
Message-Id: <20221130200846.4226-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221130200846.4226-1-nick.hawkins@hpe.com>
References: <20221130200846.4226-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: EKiVIJINkiv8tWxQ7kxH0P2gqJASCj-y
X-Proofpoint-ORIG-GUID: EKiVIJINkiv8tWxQ7kxH0P2gqJASCj-y
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211300142
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Document existing fanY_fault attribute.

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

