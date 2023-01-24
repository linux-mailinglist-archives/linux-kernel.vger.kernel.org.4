Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4328967A3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjAXU3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjAXU3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:29:47 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546613C24
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:29:46 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OIgoHA014372;
        Tue, 24 Jan 2023 20:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=lcsUXjs+Zhj7MnFufKjt8MNtTDZRqUAJ9cxWr0Mzbw0=;
 b=XIHcHTHomIzDTJ/NvHZu9VW8q7ftA4ny+ffZaYzoSeCBx+lRzQKQS0G5KyBjQadRfx5F
 5zM5R9efHsOExblk4aE19CVnwGhSRokYr0BP6UlxgXcjp++4eGrc8YZGAjrcQoPKqsDh
 VLbhhglaAuj5ahUkqAP3wrNXAe4P7mODZSXZkTU6JRLBtY9ZyhtkBWAZorrLBTOzCT26
 BY9Pjro5e+6hJD7fNzU2TdE+KzVWH3z3+iWV9MoZi1CtVzZczXd11+QrPHYc9UA+tgQ8
 gE4LD+mVBKpXSvLSs8q4TvpJMXZN4cbyhhmZsTyUTFLF0jQeO7Ap8MoKym7RYGlGC97V Eg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3namuh8yty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 20:29:31 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 9109E310EC;
        Tue, 24 Jan 2023 20:29:30 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 4F92680A0DD;
        Tue, 24 Jan 2023 20:29:30 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
        id CFD7A30088170; Tue, 24 Jan 2023 14:29:29 -0600 (CST)
From:   Justin Ernst <justin.ernst@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>
Subject: [PATCH] Update HPE Superdome Flex Maintainers
Date:   Tue, 24 Jan 2023 14:29:14 -0600
Message-Id: <20230124202914.3180834-1-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3okbXWyhXf6QZI6TSo2G9AenNdUQkDAg
X-Proofpoint-GUID: 3okbXWyhXf6QZI6TSo2G9AenNdUQkDAg
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_15,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240188
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Travis has retired. His expertise will be sorely missed.
Replace Mike's entry under UV HPE SUPERDOME FLEX.

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 123216b76534..212228134df4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22636,7 +22636,7 @@ F:	arch/x86/platform
 
 X86 PLATFORM UV HPE SUPERDOME FLEX
 M:	Steve Wahl <steve.wahl@hpe.com>
-R:	Mike Travis <mike.travis@hpe.com>
+R:	Justin Ernst <justin.ernst@hpe.com>
 R:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
 R:	Russ Anderson <russ.anderson@hpe.com>
 S:	Supported
-- 
2.34.1

