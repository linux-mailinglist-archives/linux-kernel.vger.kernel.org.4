Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86B769258E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjBJSnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjBJSnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:43:31 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B2A2CFCB;
        Fri, 10 Feb 2023 10:43:30 -0800 (PST)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AHHwZS019599;
        Fri, 10 Feb 2023 18:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=Ko1FXTOhHPhLV3x2B7D3oxEHYnv+h9p7DX8hhx/aTD0=;
 b=c/AqEBRdQSw5D+KKIf6YwAwmYIc2VNuQTFGVwH9xPoFqxIt+jLllW2Iht9iOeTbNM/s+
 Ny9HrpCV3SrZru8AcEm9JHlESW/WTCokMrcbvvMMnyb8XfNUYS1KB1kqfjzcFiyLWRiU
 OsKp55MbjOMJDXULLeVaR59cS3rQH4TR8WpzqvBRvlHytA32UqExUVYwYoT111ii0URM
 eEUISLsF6XBphqKDQtmui+wV/MsB61swtLjWhAVcsaDwKZ/ay/7JUxAEIFdy0aqaFd12
 SjZGEa79/+eMFaXMcGGlEgJ6Ar2sZ+Zl+TOiIOUh3V8zDywexjts8cR7wZaM41CT/1of Gw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3nnt6s8m4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 18:43:13 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 19A44805E5C;
        Fri, 10 Feb 2023 18:43:13 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 8B75980025B;
        Fri, 10 Feb 2023 18:43:12 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     linux@roeck-us.net, corbet@lwn.net
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 1/2] Documentation/watchdog/hpwdt: Fix Reference
Date:   Fri, 10 Feb 2023 11:42:46 -0700
Message-Id: <20230210184247.221134-2-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210184247.221134-1-jerry.hoemann@hpe.com>
References: <20230210184247.221134-1-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CGjdMwoYOQRkW2nf22N5nNRFdrvGBNgY
X-Proofpoint-ORIG-GUID: CGjdMwoYOQRkW2nf22N5nNRFdrvGBNgY
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_13,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=767 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100157
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPMI documentation moved to Documentation/driver-api/ipmi.rst.
Update reference to reflect new location.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 Documentation/watchdog/hpwdt.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/watchdog/hpwdt.rst b/Documentation/watchdog/hpwdt.rst
index c824cd7f6e32..c972fc2a3d0b 100644
--- a/Documentation/watchdog/hpwdt.rst
+++ b/Documentation/watchdog/hpwdt.rst
@@ -48,7 +48,7 @@ Last reviewed: 08/20/2018
  NOTE:
        More information about watchdog drivers in general, including the ioctl
        interface to /dev/watchdog can be found in
-       Documentation/watchdog/watchdog-api.rst and Documentation/IPMI.txt.
+       Documentation/watchdog/watchdog-api.rst and Documentation/driver-api/ipmi.rst
 
  Due to limitations in the iLO hardware, the NMI pretimeout if enabled,
  can only be set to 9 seconds.  Attempts to set pretimeout to other
-- 
2.39.1

