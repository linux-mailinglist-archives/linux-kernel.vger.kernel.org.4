Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79D66714C2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjARHQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjARHQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:16:14 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8D77A51B;
        Tue, 17 Jan 2023 22:39:42 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I4rh1S024646;
        Wed, 18 Jan 2023 01:39:17 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3n6048mc4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 01:39:17 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 30I6dFkH050794
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jan 2023 01:39:15 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 18 Jan 2023 01:39:14 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 18 Jan 2023 01:39:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 18 Jan 2023 01:39:12 -0500
Received: from okan.localdomain ([10.158.40.55])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 30I6ccUr005042;
        Wed, 18 Jan 2023 01:38:41 -0500
From:   Okan Sahin <okan.sahin@analog.com>
To:     <okan.sahin@analog.com>
CC:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Caleb Connolly" <caleb.connolly@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH v3 0/5]  Add MAX77541/MAX77540 PMIC Support
Date:   Wed, 18 Jan 2023 09:38:07 +0300
Message-ID: <20230118063822.14521-1-okan.sahin@analog.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 8dAlMa-Jf9SkRa18AD1Af-xwQOk-rPSS
X-Proofpoint-ORIG-GUID: 8dAlMa-Jf9SkRa18AD1Af-xwQOk-rPSS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_01,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 phishscore=0 clxscore=1015 spamscore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301180057
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFD, regulator and ADC driver and related bindings for MAX77540/MAX77541.
The patches are requeired to be applied in sequence.

Changes in v3:
* Patch 1: "drivers: mfd: Add ADI MAX77541/MAX77540 PMIC Support"
  * Change struct name from max77541_dev to max77541
  * Adjust max-line-length lower than 80
* Patch 2: "dt-bindings: mfd: Add ADI MAX77541/MAX77540"
  * Remove adc object as we do not need
  * Remove adc node from example
* Patch 3: "drivers: regulator: Add ADI MAX77541/MAX77540 Regulator Support"
  * Change node name from "BUCK#_id" to "buck#_id" in regulator desc
* Patch 4: "dt-bindings: regulator: Add ADI MAX77541/MAX77540 Regulator"
  * Change node name from "BUCK" to "buck" in regulators
* Patch 5: "drivers: iio: adc: Add ADI MAX77541 ADC Support"
  * Convert voltage values from V to mV for scaling.
  * Convert temperature values from C to miliC for scale and offset
  * Do not set offset bit in info_mask_separate for voltage that does not need offset
  * Remove unnecessary dev_get_drvdata() instead of it use dev_get_regmap to have regmap.
  * Assing hard coded name for adc dev name

Changes in v2:
* Patch 1: "drivers: mfd: Add MAX77541/MAX77540 PMIC Support"
  * Drop "this patch adds" from commit message.
  * Drop redundant blank lines.
  * Drop module version
  * Use definition for parameter of devm_mfd_add_devices(.., -1,..)
  * Use desc in chip_info to adding desc for different devices.
  * Add missing headers and forward declarations.
  * Drop unused elements from max77541_dev struct
  * Add chip_info into max77541_dev struct to identify different devices.
* Patch 2: "dt-bindings: mfd: adi,max77541.yaml Add MAX77541 bindings"
  * Drop "this patch adds" from commit message.
  * Fix $ref path
  * Drop adc part under allOf
  * Keep only one example (more complex one)
  * Fix make dt_binding_check errors.(trailing space, No newline)
* Patch 3: "drivers: regulator: Add MAX77541 Regulator Support"
  * Drop "this patch adds" from commit message.
  * Add trailing comma for required structs.
  * Fix wrong indentation.
  * Drop redundant blank lines.
  * Drop max77541_regulator_dev struct.
  * Use "regulator_desc *desc" for both regulator
    regarding to "max77541->id"
* Patch 4: "dt-bindings: regulator: max77541-regulator.yaml Add MAX77541
            Regulator bindings"
  * Drop "this patch adds" from commit message.
  * Chance filename (matching compatible), so adi,max77541-regulator.yaml
  * Fix make dt_binding_check errors.(trailing space, No newline)
* Patch 5: "drivers: iio: adc: Add MAX77541 ADC Support"
  * Drop "this patch adds" from commit message.
  * Drop redundant blank lines.
  * Fix wrong include path.
  * Use switch instead of if-else for range setting in max77541_adc_scale
  * Move max77541_adc_range enum from max77541.h to here.
  * Use definition from units.h
  * Drop unused elements from max77541_adc_iio struct
  * Drop the .data from platform_device_id

Okan Sahin (5):
  drivers: mfd: Add ADI MAX77541/MAX77540 PMIC Support
  dt-bindings: mfd: Add ADI MAX77541/MAX77540
  drivers: regulator: Add ADI MAX77541/MAX77540 Regulator Support
  dt-bindings: regulator: Add ADI MAX77541/MAX77540 Regulator
  drivers: iio: adc: Add ADI MAX77541 ADC Support

 .../devicetree/bindings/mfd/adi,max77541.yaml |  87 ++++++
 .../regulator/adi,max77541-regulator.yaml     |  44 +++
 MAINTAINERS                                   |  11 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max77541-adc.c                | 200 ++++++++++++++
 drivers/mfd/Kconfig                           |  13 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max77541.c                        | 250 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max77541-regulator.c        | 160 +++++++++++
 include/linux/mfd/max77541.h                  | 108 ++++++++
 13 files changed, 896 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77541.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77541-regulator.yaml
 create mode 100644 drivers/iio/adc/max77541-adc.c
 create mode 100644 drivers/mfd/max77541.c
 create mode 100644 drivers/regulator/max77541-regulator.c
 create mode 100644 include/linux/mfd/max77541.h

-- 
2.30.2

