Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988D85B8346
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiINIwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiINIwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:52:07 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A435F9A7;
        Wed, 14 Sep 2022 01:52:06 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E87YFK005790;
        Wed, 14 Sep 2022 08:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=OO19sj1nrjuLI9FfnQwrBekSePzYL8wn1rlle6iX61Q=;
 b=kzb02ax1B4TNqqAiJtHQL+4IK0Itiv25SOdthaWsCFs+c9/IrlCa2DxGM2tkVHY0cpbr
 s1eTy46ZjMDmxr1ECh03SXP2mHIsZ2lf5G9k5hNiIx413zjOec9zy23Q4CWXQ1IqloHR
 tCVBUVhX0nyJ25A71BV8fPvMSCqmBslejk4PkJbEKUdiBz7NHko+fRV2YIqLA2YuE8TL
 73h7/Sj2Bsf0kbycAKsxsJqoZyH6UaQQDiU9qf6cC6jS8wFuimpHB1nqekmPi6GJMqTP
 7Rb9KYnTXaVL8nQHzEwafyTic4rkbi5FNmtDue8DkGlGv0wqsjwbtgElFnOvT6x6U/qS 7A== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3jk55vuqnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 08:51:57 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 6CBDAD24E;
        Wed, 14 Sep 2022 08:51:56 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id A83D180171D;
        Wed, 14 Sep 2022 08:51:55 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        lukas.bulwahn@gmail.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH 1/2] crypto/arm64: Kconfig - fix SHA1 symbol name
Date:   Wed, 14 Sep 2022 03:51:20 -0500
Message-Id: <20220914085121.1808274-1-elliott@hpe.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FooX2_pGw5FWt_ovaxVDh3SSCELlTBLQ
X-Proofpoint-ORIG-GUID: FooX2_pGw5FWt_ovaxVDh3SSCELlTBLQ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_03,2022-09-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=873 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140043
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the arm64 Kconfig file, revert an incorrect change of
the symbol name CRYPTO_SHA1_ARM64_CE to CRYPTO_SHA1_ARM64.

Fixes: 3f342a23257d ("crypto: Kconfig - simplify hash entries")
Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/arm64/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 7ba9bcb6d409..8bd80508a710 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -36,7 +36,7 @@ config CRYPTO_POLY1305_NEON
 	  Architecture: arm64 using:
 	  - NEON (Advanced SIMD) extensions
 
-config CRYPTO_SHA1_ARM64
+config CRYPTO_SHA1_ARM64_CE
 	tristate "Hash functions: SHA-1 (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
-- 
2.37.2

