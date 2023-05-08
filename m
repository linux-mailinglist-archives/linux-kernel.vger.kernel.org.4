Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F506FB0F7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjEHNMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjEHNMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:12:09 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83BA1FF3;
        Mon,  8 May 2023 06:12:08 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348D1sYn003279;
        Mon, 8 May 2023 09:11:58 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3qdkt9b82y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 09:11:58 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 348DBvJn020329
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 May 2023 09:11:57 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 8 May 2023 09:11:56 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 8 May 2023 09:11:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 8 May 2023 09:11:56 -0400
Received: from IST-LT-42339.ad.analog.com ([10.158.19.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 348DBdTJ009014;
        Mon, 8 May 2023 09:11:42 -0400
From:   Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sre@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <Zeynep.Arslanbenzer@analog.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v3 0/7] Add MAX77643/MAX77654/MAX77658/MAX77659 PMIC Support
Date:   Mon, 8 May 2023 16:10:38 +0300
Message-ID: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: LkDOQoopkfvGDBVlK7Z9k9yMa5vS8X9Z
X-Proofpoint-ORIG-GUID: LkDOQoopkfvGDBVlK7Z9k9yMa5vS8X9Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_09,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=832 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305080089
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
* Remove regulator adi,max77658-regulator.yaml
* Patch 1: "mfd: max77658: Add ADI MAX77643/54/58/59 MFD Support"
  * Use MAX77643/54/58/59 instead of listing every device
  * Move max77658_pmic_setup function body to probe function
  * Remove dev from max77658_dev struct
  * Fix error explanations
  * Drop chip structure, use only id
  * Fix the wrong indentations
* Patch 2: "dt-bindings: mfd: max77658: Add ADI MAX77658"
  * Decrease the example count
* Patch 3: "power: supply: max77658: Add ADI MAX77658 Battery Support"
  * Use default values to initialize SALRT min-max thresholds
* Patch 4: "dt-bindings: power: supply: max77658: Add ADI MAX77658 Battery"
  * Fix syntax
  * Remove SALRT properties from the device tree
  * State monitored-battery as required
  * Remove reg
* PATCH 5: "power: supply: max77658: Add ADI MAX77654/58/59 Charger Support"
  * Use MAX77643/54/58/59 instead of listing every device
  * Use sysfs entries for fast-charge-timer and topoff-timer    
* Patch 6: "dt-bindings: power: supply: max77658: Add ADI MAX77654/58/59 Charger"
  * Remove fast-charge-timer and topoff-timer properties from the device tree
* PATCH 7: "regulator: max77658: Add ADI MAX77643/54/58/59 Regulator Support"
  * Use MAX77643/54/58/59 instead of listing every device
  * Use only one entry id id_table

Changes in v2:
* Add MAX77643, MAX77654, MAX77658 device support

Zeynep Arslanbenzer (7):
  regulator: max77658: Add ADI MAX77643/54/58/59 Regulator Support
  dt-bindings: power: supply: max77658: Add ADI MAX77654/58/59 Charger
  power: supply: max77658: Add ADI MAX77654/58/59 Charger Support
  dt-bindings: power: supply: max77658: Add ADI MAX77658 Battery
  power: supply: max77658: Add ADI MAX77658 Battery Support
  dt-bindings: mfd: max77658: Add ADI MAX77658
  mfd: max77658: Add ADI MAX77643/54/58/59 MFD Support

 .../devicetree/bindings/mfd/adi,max77658.yaml | 160 ++++
 .../power/supply/adi,max77658-battery.yaml    |  47 +
 .../power/supply/adi,max77658-charger.yaml    |  53 ++
 drivers/mfd/Kconfig                           |  13 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max77658.c                        | 426 +++++++++
 drivers/power/supply/Kconfig                  |  14 +
 drivers/power/supply/Makefile                 |   2 +
 drivers/power/supply/max77658-battery.c       | 633 +++++++++++++
 drivers/power/supply/max77658-charger.c       | 844 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max77658-regulator.c        | 170 ++++
 include/linux/mfd/max77658.h                  |  80 ++
 14 files changed, 2452 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77658.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/adi,max77658-battery.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml
 create mode 100644 drivers/mfd/max77658.c
 create mode 100644 drivers/power/supply/max77658-battery.c
 create mode 100644 drivers/power/supply/max77658-charger.c
 create mode 100644 drivers/regulator/max77658-regulator.c
 create mode 100644 include/linux/mfd/max77658.h

-- 
2.25.1

