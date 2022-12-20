Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0185652167
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiLTNY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiLTNYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:24:20 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E601812A85;
        Tue, 20 Dec 2022 05:24:18 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKBTI6o000448;
        Tue, 20 Dec 2022 08:24:09 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3mh8gbh9bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 08:24:09 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2BKDO7tG053410
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Dec 2022 08:24:07 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 20 Dec 2022 08:24:07 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 20 Dec 2022 08:24:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 20 Dec 2022 08:24:06 -0500
Received: from IST-LT-42339.ad.analog.com (IST-LT-42339.ad.analog.com [10.117.192.221])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2BKDNoP2010583;
        Tue, 20 Dec 2022 08:23:53 -0500
From:   Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sre@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <Zeynep.Arslanbenzer@analog.com>, <Nurettin.Bolucu@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH 0/6] drivers: mfd: Add MAX77659 MFD and related device drivers
Date:   Tue, 20 Dec 2022 16:22:44 +0300
Message-ID: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: DPnePs4ZUNXLWrXsnfbdmBGFB6xzn2wy
X-Proofpoint-GUID: DPnePs4ZUNXLWrXsnfbdmBGFB6xzn2wy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_05,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=665 clxscore=1011
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212200110
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds mfd, regulator and charger driver and related bindings.The patches 
are required to be applied in sequence.

Zeynep Arslanbenzer (6):
  drivers: mfd: add MAX77659 PMIC support
  dt-bindings: mfd: add MAX77659 binding
  drivers: power: supply: add MAX77659 charger support
  dt-bindings: power: supply: add MAX77659 charger binding
  drivers: regulator: add MAX77659 regulator support
  dt-bindings: regulator: add MAX77659 regulator binding

 .../devicetree/bindings/mfd/adi,max77659.yaml |  70 +++
 .../power/supply/adi,max77659-charger.yaml    |  42 ++
 .../regulator/adi,max77659-regulator.yaml     |  31 +
 MAINTAINERS                                   |  13 +
 drivers/mfd/Kconfig                           |  14 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max77659.c                        | 188 ++++++
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max77659-charger.c       | 547 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max77659-regulator.c        |  98 ++++
 include/linux/mfd/max77659.h                  |  60 ++
 14 files changed, 1081 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77659.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/adi,max77659-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77659-regulator.yaml
 create mode 100644 drivers/mfd/max77659.c
 create mode 100644 drivers/power/supply/max77659-charger.c
 create mode 100644 drivers/regulator/max77659-regulator.c
 create mode 100644 include/linux/mfd/max77659.h

-- 
2.25.1

