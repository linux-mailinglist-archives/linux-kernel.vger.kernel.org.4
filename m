Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B146C1A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCTPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjCTPtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:49:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094C938675;
        Mon, 20 Mar 2023 08:40:56 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KElOu4022673;
        Mon, 20 Mar 2023 15:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qXNU6GMq4xhEXGx0X15CPuyNFyp3Isf4pgE7G9kQBCQ=;
 b=mHYyNeTGWxvu0u9LilOC3dD16LBj0y60/riShAcyZYFkQNHnwHC02+FZ18w37JyZ3lBr
 9iF7TN+89ZBS85euH89LreL5Y0t0reV2dZ2/wfGKw82depEqI82YzzBwA0lY5/Bbqxcg
 Rje44PmlmzatSYkunf1aOkaMIVJSA4CbogaxYPb/NFL4IK5A0RtuuzSwqUV0ErHrPj8I
 cP5MyOb8Ohx57VmC+20OJ7UMcMYamqe6Mw2+8T5Hw2qD1DEpWmFRb/olNpkJCmswLl9g
 TOe0gomTbDNt46hF+hb5DLzMj89lZZw9RSILIow+tqQ7IEqNCW5sLn+bZph/803Ejizw tg== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pdqf355bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 15:40:34 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32KDbpIc027997;
        Mon, 20 Mar 2023 15:40:33 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3pd4x6nkac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 15:40:33 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32KFeVST54329732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 15:40:31 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DA3E58064;
        Mon, 20 Mar 2023 15:40:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D0FB58061;
        Mon, 20 Mar 2023 15:40:31 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 20 Mar 2023 15:40:31 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 24C0874A47F; Mon, 20 Mar 2023 10:40:31 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v2 4/5] docs: hwmon: Add documenttaion for acbel-crps PSU
Date:   Mon, 20 Mar 2023 10:40:18 -0500
Message-Id: <20230320154019.1943770-5-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230320154019.1943770-1-lakshmiy@us.ibm.com>
References: <20230320154019.1943770-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LsKpcXlcHaylTea-mSQoecAqMoAS7Mu3
X-Proofpoint-ORIG-GUID: LsKpcXlcHaylTea-mSQoecAqMoAS7Mu3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_10,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=951 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation changes for acbel-crps psu

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
 Documentation/hwmon/acbel-crps.rst | 81 ++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/hwmon/acbel-crps.rst

diff --git a/Documentation/hwmon/acbel-crps.rst b/Documentation/hwmon/acbel-crps.rst
new file mode 100644
index 000000000000..89a43fb88c8c
--- /dev/null
+++ b/Documentation/hwmon/acbel-crps.rst
@@ -0,0 +1,81 @@
+Kernel driver acbel-crps
+=======================
+
+Supported chips:
+
+  * ACBEL Common Redundant Power Supply.
+  Supported models: FSG032-00xG
+
+Author: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
+
+Description
+-----------
+
+This driver supports ACBEL Common Redundant Power Supply. This driver
+is a client to the core PMBus driver.
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
+details.
+
+Sysfs entries
+-------------
+
+The following attributes are supported:
+
+======================= ======================================================
+curr1_crit          Critical maximum current.
+curr1_crit_alarm    Input current critical alarm.
+curr1_input         Measured output current.
+curr1_label         "iin"
+curr1_max           Maximum input current.
+curr1_max_alarm     Maximum input current high alarm.
+curr1_rated_max     Maximum rated input current.
+curr2_crit          Critical maximum current.
+curr2_crit_alarm    Output current critical alarm.
+curr2_input         Measured output current.
+curr2_label         "iout1"
+curr2_max           Maximum output current.
+curr2_max_alarm     Output current high alarm.
+curr2_rated_max     Maximum rated output current.
+
+
+fan1_alarm          Fan 1 warning.
+fan1_fault	    Fan 1 fault.
+fan1_input	    Fan 1 speed in RPM.
+fan1_target         Set fan speed reference.
+
+in1_alarm           Input voltage under-voltage alarm.
+in1_input           Measured input voltage.
+in1_label           "vin"
+in1_rated_max       Maximum rated input voltage.
+in1_rated_min       Minimum rated input voltage.
+in2_crit            Critical maximum output voltage.
+in2_crit_alarm      Output voltage critical high alarm.
+in2_input           Measured output voltage.
+in2_label           "vout1"
+in2_lcrit           Critical minimum output voltage.
+in2_lcrit_alarm     Output voltage critical low alarm.
+in2_rated_max       Maximum rated output voltage.
+in2_rated_min       Minimum rated output voltage.
+
+power1_alarm        Input fault or alarm.
+power1_input        Measured input power.
+power1_label        "pin"
+power1_max          Input power limit.
+power1_rated_max    Maximum rated input power.
+power2_crit         Critical output power limit.
+power2_crit_alarm   Output power crit alarm limit exceeded.
+power2_input        Measured output power.
+power2_label        "pout"
+power2_max          Output power limit.
+power2_max_alarm    Output power high alarm.
+power2_rated_max    Maximum rated output power.
+
+temp[1-3]_input     Measured temperature.
+temp[1-2]_max       Maximum temperature.
+temp[1-3]_rated_max Temperature high alarm.
+======================= ======================================================
-- 
2.37.2

