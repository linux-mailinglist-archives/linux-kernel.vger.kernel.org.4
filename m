Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FC76C4CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjCVOEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjCVOEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:04:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530BB1F5F6;
        Wed, 22 Mar 2023 07:04:12 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCCYpF036849;
        Wed, 22 Mar 2023 14:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=G2VDcMPZylaZW24+nLg4SfkUNuDp0ugu4HX8Reayq9g=;
 b=BH/rrfooFiMNg8MHH4/5cR+2/2sPYrHmdrr5jxqUmOxAEDwZ9FeLod/ik8sMhyN2EKiK
 AQWXc+81xhYW/sRdpJNR1xCQXp3tIDNnLq/74FTq59w8I7dCQkYRCPkOe8du2UOMZmg4
 TsmWwk5MAyUe4OKk3GXGVlBEcC4WpyRhfh6bNsBHqOdgOd35WnrBu2Qy0OUHieS0IKvP
 lTjZLOuP7++kqAm6mLrH3YbpIZ5W5lwiqsJEzvyM4qQkEtI7Dl32aHLoHUNqU7wx3pwJ
 7ucnJOFIV4Mcz5KRnj2up4lXBpPaICn5nKq7/KC/R8kBsuBBkXasxhkBrAfeomcfbZYs 6w== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pfx528c0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 14:03:57 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32MDmE09012015;
        Wed, 22 Mar 2023 14:03:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3pd4x70m8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 14:03:56 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ME3t8t14811896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 14:03:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A1B95805D;
        Wed, 22 Mar 2023 14:03:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10A905805A;
        Wed, 22 Mar 2023 14:03:54 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.129.242])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Mar 2023 14:03:53 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v3 2/4] dt-bindings: trivial-devices: Add Atmel AT30TSE004A serial eeprom
Date:   Wed, 22 Mar 2023 09:03:46 -0500
Message-Id: <20230322140348.569397-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230322140348.569397-1-eajames@linux.ibm.com>
References: <20230322140348.569397-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Eg0c6fKpZDdm_AZXCn3bx8UifTJ4XU19
X-Proofpoint-ORIG-GUID: Eg0c6fKpZDdm_AZXCn3bx8UifTJ4XU19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_11,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220103
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AT30TSE004A EEPROM is compatible with the JEDEC EE1004 standard.
Document it as a trivial I2C device.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v2:
 - Use full model name
 - Fix commit name

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 6f482a254a1d..9ce6308466c5 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -47,6 +47,8 @@ properties:
           - ams,iaq-core
             # i2c serial eeprom (24cxx)
           - at,24c08
+            # i2c serial eeprom (EE1004 standard)
+          - atmel,at30tse004a
             # i2c trusted platform module (TPM)
           - atmel,at97sc3204t
             # ATSHA204 - i2c h/w symmetric crypto module
-- 
2.31.1

