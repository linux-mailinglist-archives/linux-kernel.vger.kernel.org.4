Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD297226EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjFENJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjFENJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:09:00 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F690F2;
        Mon,  5 Jun 2023 06:08:58 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355D3KS0025575;
        Mon, 5 Jun 2023 09:08:37 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r02e4a3ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 09:08:37 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 355D8ZLi022855
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Jun 2023 09:08:35 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 5 Jun 2023
 09:08:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 5 Jun 2023 09:08:34 -0400
Received: from kimedia-VirtualBox.ad.analog.com (KPALLER2-L02.ad.analog.com [10.116.242.24])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 355D8IfT010470;
        Mon, 5 Jun 2023 09:08:22 -0400
From:   Kim Seer Paller <kimseer.paller@analog.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>,
        <krzysztof.kozlowski@linaro.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kimseer.paller@analog.com>
Subject: [PATCH v2 0/2] Add max14001 support
Date:   Mon, 5 Jun 2023 21:07:53 +0800
Message-ID: <20230605130755.92642-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: qZS9KUlB8OxIS9RiXnRq9vEYXAeKiAat
X-Proofpoint-GUID: qZS9KUlB8OxIS9RiXnRq9vEYXAeKiAat
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=917
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050114
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It took more time than I expected, but I have followed up on this and now
I'm presenting the patch for your review.

Modified the code based on the implementation of this application note
as a reference:
https://www.analog.com/media/en/technical-documentation/user-guides/guide-to-programming-the-max14001max14002-isolated-adcs--maxim-integrated.pdf
For now, I'm figuring out how to implement daisy chain for future support.

Changes in v2:

 max14001:
  - Replaced verification register definitions with macro.
  - Removed local definition of IIO_DMA_MINALIGN.
  - Changed driver to big endian format and reverse data prior to outputting
  it to the device as per the app note.
  - Utilized default register values instead of zero to clear memory validation
  fault.
  - Converted driver to use custom regmap for register access.
  - Modified scaled value calculation and changed to IIO_VAL_FRACTIONAL_LOG2.
  - Removed offset attribute.
  - Added comments for clarity in write transactions.
  - Misc changes(blank lines...).

 Bindings:
  - Removed unneccessary device tree propertied and updated bindings.

The code was tested using max14001pmb and max14001evsys boards with
raspberry pi 4.

Kim Seer Paller (2):
  dt-bindings:iio:adc: add max14001
  iio: adc: max14001: New driver

 .../bindings/iio/adc/adi,max14001.yaml        |  55 +++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max14001.c                    | 333 ++++++++++++++++++
 5 files changed, 407 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
 create mode 100644 drivers/iio/adc/max14001.c


base-commit: 44149752e9987a9eac5ad78e6d3a20934b5e018d
-- 
2.34.1

