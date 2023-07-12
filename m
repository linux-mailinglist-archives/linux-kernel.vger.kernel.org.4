Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397CC750070
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGLHvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjGLHvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:51:43 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5771998;
        Wed, 12 Jul 2023 00:51:42 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C569Ml020943;
        Wed, 12 Jul 2023 03:51:35 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3rq4q6r15n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 03:51:35 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 36C7pY52045639
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jul 2023 03:51:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 12 Jul
 2023 03:51:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Jul 2023 03:51:33 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.149])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 36C7pPt8015653;
        Wed, 12 Jul 2023 03:51:27 -0400
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH 0/1] Add new channels for adis16475
Date:   Wed, 12 Jul 2023 10:50:53 +0300
Message-ID: <20230712075054.953421-1-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: _EQRHBL6yrxsMlAQq71ranCohGRclMHh
X-Proofpoint-ORIG-GUID: _EQRHBL6yrxsMlAQq71ranCohGRclMHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=793 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120068
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add delta angle and delta velocity channels to adis16475 driver.
All supported devices offer the capabilities to read this data
by performing raw register reads.

Ramona Bolboaca (1):
  iio: imu: adis16475.c: Add delta angle and delta velocity channels

 drivers/iio/imu/adis16475.c | 88 +++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

-- 
2.25.1

