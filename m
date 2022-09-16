Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193CE5BAF01
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiIPOMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiIPOMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:12:02 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE783B07F5;
        Fri, 16 Sep 2022 07:12:00 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GDvDpD020005;
        Fri, 16 Sep 2022 10:11:58 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jm8x5pbar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 10:11:58 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 28GEBuC8057771
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Sep 2022 10:11:57 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 Sep 2022 10:11:56 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 Sep 2022 10:11:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 Sep 2022 10:11:55 -0400
Received: from debian.ad.analog.com ([10.48.65.127])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 28GEBfsk020264;
        Fri, 16 Sep 2022 10:11:49 -0400
From:   Ciprian Regus <ciprian.regus@analog.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ciprian Regus <ciprian.regus@analog.com>
Subject: [PATCH 1/5] Remove duplicate matching entry
Date:   Fri, 16 Sep 2022 17:09:18 +0300
Message-ID: <20220916140922.2506248-2-ciprian.regus@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220916140922.2506248-1-ciprian.regus@analog.com>
References: <20220916140922.2506248-1-ciprian.regus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: d4W8jZTq-kdJBuJ0UMENTp1Wjmn8Mi78
X-Proofpoint-ORIG-GUID: d4W8jZTq-kdJBuJ0UMENTp1Wjmn8Mi78
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_08,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209160105
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the specific entry for ad5758, since
Documentation/devicetree/bindings/iio/*/adi,* already matches
the path.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
 changes in v3:
  - reordered as the first patch in the series.
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d7f64dc0efe..ed31866e4c4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1327,7 +1327,6 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
 F:	Documentation/devicetree/bindings/iio/*/adi,*
-F:	Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
 F:	drivers/iio/*/ad*
 F:	drivers/iio/adc/ltc249*
 F:	drivers/iio/amplifiers/hmc425a.c
-- 
2.30.2

