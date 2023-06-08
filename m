Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD4C7286AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjFHR4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjFHR4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:56:30 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC181FDC;
        Thu,  8 Jun 2023 10:56:28 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358GmvNa008710;
        Thu, 8 Jun 2023 13:56:08 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r2a9dy8yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 13:56:08 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 358Hu7RG064309
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Jun 2023 13:56:07 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 Jun 2023 13:56:06 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 Jun 2023 13:56:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 Jun 2023 13:56:05 -0400
Received: from kimedia-VirtualBox.ad.analog.com (KPALLER2-L02.ad.analog.com [10.116.242.24])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 358HtlOv003718;
        Thu, 8 Jun 2023 13:55:50 -0400
From:   Kim Seer Paller <kimseer.paller@analog.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <Michael.Hennerich@analog.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <kimseer.paller@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/2] Add max14001 support
Date:   Fri, 9 Jun 2023 01:55:15 +0800
Message-ID: <20230608175517.40217-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: bxT6LeuPbOsZ-uftTHLjHMIxmKe_2Bbi
X-Proofpoint-ORIG-GUID: bxT6LeuPbOsZ-uftTHLjHMIxmKe_2Bbi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_13,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxlogscore=997
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080157
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Attached link is the app note I used as reference for programming the max14001,
which I found to provide a much easier approach. You can find it here:
https://www.analog.com/media/en/technical-documentation/user-guides/guide-to-programming-the-max14001max14002-isolated-adcs--maxim-integrated.pdf

The code has been tested and is working fine with the max14001pmb and
max14001evsys boards on the Raspberry Pi 4.

Changes in v3:

max14001:
 * Replaced __cacheline_aligned with __aligned(IIO_DMA_MINALIGN).
 * Removed redundant assignment of the tx variable in the max14001_write()
 and max14001_read() functions.
 * Assigned struct device *dev with &spi->dev to improve code readability.
 * Utilized a non-regmap approach and ensure a consistent use of interface
 throughout the driver code. I attempted to use the regmap API but faced
 difficulties in implementing it due to the timing diagram requirements.
 Specifically, the need to change the chip select between transfers, which, as
 far as I know, is not applicable with regmap. While I am open to thorough
 guidance and suggestions on utilizing the regmap API, for now, I have chosen
 to stick with the non-regmap approach.

bindings:
 * Utilized the default register values, which led to the omission of some
 properties in v2. I plan to include and switch to generic values the excluded
 properties in v1 in future support.
 * Dropped the status property.
 * Moved the allOf property after the required property for better alignment.

Best Regards,
Kim Seer Paller

Kim Seer Paller (2):
  dt-bindings:iio:adc: add max14001
  iio: adc: max14001: New driver

 .../bindings/iio/adc/adi,max14001.yaml        |  54 +++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max14001.c                    | 337 ++++++++++++++++++
 5 files changed, 410 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
 create mode 100644 drivers/iio/adc/max14001.c


base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
-- 
2.34.1

