Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7103A6C426F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCVF5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCVF5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:57:17 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423345328D;
        Tue, 21 Mar 2023 22:57:16 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M2BD7E006353;
        Wed, 22 Mar 2023 01:57:04 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pfmey1w96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 01:57:04 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 32M5v3SQ053821
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Mar 2023 01:57:03 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 Mar 2023 01:57:02 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 Mar 2023 01:57:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 22 Mar 2023 01:57:01 -0400
Received: from IST-LT-42339.ad.analog.com (IST-LT-42339.ad.analog.com [10.117.192.221] (may be forged))
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 32M5ueXF016875;
        Wed, 22 Mar 2023 01:56:44 -0400
From:   Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sre@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <Zeynep.Arslanbenzer@analog.com>, <Nurettin.Bolucu@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v2 0/8] Add MAX77643/MAX77654/MAX77658/MAX77659 PMIC Support
Date:   Wed, 22 Mar 2023 08:56:20 +0300
Message-ID: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 31ycXc5gBcF6M-k59U7RFnO9BjV2CFtA
X-Proofpoint-ORIG-GUID: 31ycXc5gBcF6M-k59U7RFnO9BjV2CFtA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=743 phishscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303220042
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
* Add MAX77643 MAX77654 MAX77658 support

Zeynep Arslanbenzer (8):
  dt-bindings: regulator: max77658: Add ADI MAX77643/54/58/59 Regulator
  regulator: max77658: Add ADI MAX77643/54/58/59 Regulator Support
  dt-bindings: power: supply: max77658: Add ADI MAX77654/58/59 Charger
  power: supply: max77658: Add ADI MAX77654/58/59 Charger Support
  dt-bindings: power: supply: max77658: Add ADI MAX77658 Battery
  power: supply: max77658: Add ADI MAX77658 Battery Support
  dt-bindings: mfd: max77658: Add ADI MAX77658
  mfd: max77658: Add ADI MAX77643/54/58/59 MFD Support

 .../devicetree/bindings/mfd/adi,max77658.yaml | 199 +++++
 .../power/supply/adi,max77658-battery.yaml    |  58 ++
 .../power/supply/adi,max77658-charger.yaml    |  65 ++
 .../regulator/adi,max77658-regulator.yaml     |  32 +
 drivers/mfd/Kconfig                           |  15 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max77658.c                        | 448 +++++++++++
 drivers/power/supply/Kconfig                  |  14 +
 drivers/power/supply/Makefile                 |   2 +
 drivers/power/supply/max77658-battery.c       | 646 +++++++++++++++
 drivers/power/supply/max77658-charger.c       | 745 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max77658-regulator.c        | 171 ++++
 include/linux/mfd/max77658.h                  |  88 +++
 15 files changed, 2493 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77658.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/adi,max77658-battery.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77658-regulator.yaml
 create mode 100644 drivers/mfd/max77658.c
 create mode 100644 drivers/power/supply/max77658-battery.c
 create mode 100644 drivers/power/supply/max77658-charger.c
 create mode 100644 drivers/regulator/max77658-regulator.c
 create mode 100644 include/linux/mfd/max77658.h

-- 
2.25.1

