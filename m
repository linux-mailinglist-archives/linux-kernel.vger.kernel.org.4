Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533015B8347
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiINIwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiINIwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:52:07 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815895F99C;
        Wed, 14 Sep 2022 01:52:06 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E87Y40005765;
        Wed, 14 Sep 2022 08:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=u+/SFtI5p8K0lNeVYWMyM98e41leFnaV0WpGTye5n64=;
 b=V5ePB/cfaWfRnnNBqS1IUnYIX8YkucaEvBWpIEVRAis8/K1YqD4BolcaBifMkwPY0Od5
 nEMI6tYgDKv8vCkxywNSV9owq9LruUyDyH9ck/9vIMnyxnGyi7wK1RkuxhItWJTzvpFv
 VzeL9ia09cw/O3JJpc8pIo5+WCE5weBz+wqaI0UVmSbDFg0CP8pGnRNS4JnaE9kc/ZPZ
 Vnc03xadtbUpYeQAVsmKR1wefD6dvBkrwp35U07ewTGR4xL1DCsw1t2rd9+KdrKInkcY
 CntNo3gYoTFQwKruXvVfGYXKnrO8r6J2uS5HNsheeV77s5FybEJgLNEUp/AkdruC1Xyd Aw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3jk55vuqp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 08:52:00 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 26FFAD25E;
        Wed, 14 Sep 2022 08:51:59 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id BE1558080C8;
        Wed, 14 Sep 2022 08:51:58 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        lukas.bulwahn@gmail.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH 2/2] crypto: Kconfig - remove CRYPTO_BLAKE2S symbol
Date:   Wed, 14 Sep 2022 03:51:21 -0500
Message-Id: <20220914085121.1808274-2-elliott@hpe.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914085121.1808274-1-elliott@hpe.com>
References: <20220914085121.1808274-1-elliott@hpe.com>
X-Proofpoint-GUID: oImM5O_cLGpMkBEvrI3rrcwtbBCfBKIc
X-Proofpoint-ORIG-GUID: oImM5O_cLGpMkBEvrI3rrcwtbBCfBKIc
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_03,2022-09-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
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

Revert an incorrect change that reintroduced the CRYPTO_BLAKE2S
symbol that was removed by commit 2d16803c562e ("crypto: blake2s -
remove shash module").

Fixes: 3f342a23257d ("crypto: Kconfig - simplify hash entries")
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/Kconfig | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index e93da749f31b..8346e591d8df 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -916,27 +916,6 @@ config CRYPTO_BLAKE2B
 
 	  See https://blake2.net for further information.
 
- config CRYPTO_BLAKE2S
-	tristate "BLAKE2s"
-        select CRYPTO_LIB_BLAKE2S_GENERIC
-        select CRYPTO_HASH
-        help
-	  BLAKE2s cryptographic hash function (RFC 7693)
-
-	  BLAKE2s is optimized for 8 to 32-bit platforms and can produce
-	  digests of any size between 1 and 32 bytes. The keyed hash is
-	  also implemented.
-
-	  This module provides the following algorithms:
-          - blake2s-128
-          - blake2s-160
-          - blake2s-224
-          - blake2s-256
-
-	  Used by Wireguard.
-
-          See https://blake2.net for further information.
-
 config CRYPTO_CMAC
 	tristate "CMAC (Cipher-based MAC)"
 	select CRYPTO_HASH
-- 
2.37.2

