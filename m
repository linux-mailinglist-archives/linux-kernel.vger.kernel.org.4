Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26990621065
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiKHMYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiKHMX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:23:59 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D0B12AA4;
        Tue,  8 Nov 2022 04:23:58 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A8Ap0sS019015;
        Tue, 8 Nov 2022 07:23:22 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kq8ec5hw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 07:23:22 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2A8CNLhI043204
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Nov 2022 07:23:21 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 8 Nov 2022 07:23:20 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 8 Nov 2022 07:23:20 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 8 Nov 2022 07:23:20 -0500
Received: from IST-LT-39247.ad.analog.com (IST-LT-39247.ad.analog.com [10.25.16.20])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2A8CN2OP018748;
        Tue, 8 Nov 2022 07:23:05 -0500
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/2] drivers: rtc: add max313xx series rtc driver
Date:   Tue, 8 Nov 2022 15:22:52 +0300
Message-ID: <20221108122254.1185-1-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: qNk4NK24LLq4NVsPcZ3dvwtmKtfGRHc9
X-Proofpoint-ORIG-GUID: qNk4NK24LLq4NVsPcZ3dvwtmKtfGRHc9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=481
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080071
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Sending v3 to fix a warning reported by kernel test robot.
Also added reviewed-by tag for Krzysztof since dt-bindings patch
has not been modified.

Best regards,
Ibrahim

changelog:
since v3:
  - add "break" to fix warning: unannotated fall-through 
    Reported-by: kernel test robot <lkp@intel.com>

since v2:
  - dtbinding: update title and description
  - dtbinding: remove last example
  - drop watchdog support
  - support reading 12Hr format instead of forcing 24hr at probe time
  - use "tm_year % 100" instead of range check
  - refactor max313xx_init for readability


Ibrahim Tilki (2):
  drivers: rtc: add max313xx series rtc driver
  dt-bindings: rtc: add max313xx RTCs

 .../devicetree/bindings/rtc/adi,max313xx.yaml |  151 +++
 drivers/rtc/Kconfig                           |   11 +
 drivers/rtc/Makefile                          |    1 +
 drivers/rtc/rtc-max313xx.c                    | 1070 +++++++++++++++++
 4 files changed, 1233 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
 create mode 100644 drivers/rtc/rtc-max313xx.c

-- 
2.25.1

