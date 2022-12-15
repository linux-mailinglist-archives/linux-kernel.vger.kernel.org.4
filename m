Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E608264D67D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiLOGjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOGje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:39:34 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FB04666F;
        Wed, 14 Dec 2022 22:39:33 -0800 (PST)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BF4NmK2019951;
        Thu, 15 Dec 2022 06:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pps0720;
 bh=bMZz3ogq7xp78XE+RPxado7j16RTnLC9xdcSvwwG144=;
 b=gOCXf/3UFNf/s7VHiU3ThM76RagyGVuKwd3BGiTild05d1GX239rWDIaZhSFah6rYdL6
 Dg8XHTDMQwAQea4r7J+Fh1mQ7DL6N3HzZYNMUYLBEw5hMPHdLrmuJkgSWXo46I5c7FpL
 a3IoPWCuZizYE5CYQnKf8OY6/P/mOyPpCTgPMqpDH56YzEGTuaenskX/nD51JLNvagNI
 2erHonQP2pmXT6zPKYPqPAsZgNVL8JsNgt6+jJ4exsQwwgXl1Tr2WPDMDwPxWmsC+bmg
 8E2NgxnmK2fq05+O1xkXCj7+OJmerRid9UoGKEXi1wvYdK1WaVk8QtA7EhALsUZLQobs nA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mfvgj0smp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 06:39:26 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 3F393807130;
        Thu, 15 Dec 2022 06:39:26 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 9680880BE0E;
        Thu, 15 Dec 2022 06:39:24 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH 0/8] crypto: kernel-doc for assembly language
Date:   Thu, 15 Dec 2022 00:38:49 -0600
Message-Id: <20221215063857.161665-1-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6LDG-wbVDkSAbm-1bHmkrSWym1RedlMG
X-Proofpoint-GUID: 6LDG-wbVDkSAbm-1bHmkrSWym1RedlMG
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_02,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150050
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the existing kernel-doc headers in the crypto subsystem,
then add support for kernel-doc headers in assembly language files
for functions called from C code.

This provides a place to document the assumptions made by the
assembly language functions about their arguments (e.g., how
they handle length values of 0, less than some value, not
multiples of some value, etc.).

Not all the assembly language files are tackled yet - just some
of the x86 files pending changes related to kernel_fpu_begin/end.

Example man page formatted output for one of them:
---
$ nroff -man /tmp/man/sha1_transform_avx2.9
sha1_transform_avx2(9)      Kernel Hacker's Manual      sha1_transform_avx2(9)



NAME
       sha1_transform_avx2  -  Calculate  SHA1 hash using the x86 AVX2 feature
       set

SYNOPSIS
       void sha1_transform_avx2 (u32 *digest , const u8 *data , int blocks );

ARGUMENTS
       digest      address of current 20-byte hash value (rdi, CTX macro)

       data        address of data (rsi, BUF macro); data size must be a mul‐
                   tiple of 64 bytes

       blocks      number of 64-byte blocks (rdx, CNT macro)

DESCRIPTION
       This function supports 64-bit CPUs.

RETURN
       none

PROTOTYPE
       asmlinkage  void  sha1_transform_avx2(u32  *digest, const u8 *data, int
       blocks)



December 2022                 sha1_transform_avx2 sha1_transform_avx2(9)



Robert Elliott (8):
  crypto: clean up kernel-doc headers
  doc: support kernel-doc for asm functions
  crypto: x86/sha - add kernel-doc comments to assembly
  crypto: x86/crc - add kernel-doc comments to assembly
  crypto: x86/sm3 - add kernel-doc comments to assembly
  crypto: x86/ghash - add kernel-doc comments to assembly
  crypto: x86/blake2s - add kernel-doc comments to assembly
  crypto: x86/chacha - add kernel-doc comments to assembly

 .../mips/cavium-octeon/crypto/octeon-crypto.c | 19 ++--
 arch/x86/crypto/blake2s-core.S                | 26 +++++
 arch/x86/crypto/chacha-avx2-x86_64.S          | 90 ++++++++++++------
 arch/x86/crypto/chacha-avx512vl-x86_64.S      | 94 ++++++++++++-------
 arch/x86/crypto/chacha-ssse3-x86_64.S         | 75 ++++++++++-----
 arch/x86/crypto/crc32-pclmul_asm.S            | 24 ++---
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S     | 29 +++---
 arch/x86/crypto/crct10dif-pcl-asm_64.S        | 24 +++--
 arch/x86/crypto/ghash-clmulni-intel_asm.S     | 27 +++++-
 arch/x86/crypto/sha1_avx2_x86_64_asm.S        | 32 +++----
 arch/x86/crypto/sha1_ni_asm.S                 | 22 +++--
 arch/x86/crypto/sha1_ssse3_asm.S              | 33 ++++---
 arch/x86/crypto/sha256-avx-asm.S              | 24 +++--
 arch/x86/crypto/sha256-avx2-asm.S             | 25 +++--
 arch/x86/crypto/sha256-ssse3-asm.S            | 26 ++---
 arch/x86/crypto/sha256_ni_asm.S               | 25 ++---
 arch/x86/crypto/sha512-avx-asm.S              | 33 +++----
 arch/x86/crypto/sha512-avx2-asm.S             | 34 +++----
 arch/x86/crypto/sha512-ssse3-asm.S            | 36 ++++---
 arch/x86/crypto/sm3-avx-asm_64.S              | 18 ++--
 crypto/asymmetric_keys/verify_pefile.c        |  2 +-
 crypto/async_tx/async_pq.c                    | 11 +--
 crypto/async_tx/async_tx.c                    |  4 +-
 crypto/crypto_engine.c                        |  2 +-
 include/crypto/acompress.h                    |  2 +-
 include/crypto/des.h                          |  4 +-
 include/crypto/if_alg.h                       | 26 ++---
 include/crypto/internal/ecc.h                 |  8 +-
 include/crypto/internal/rsa.h                 |  2 +-
 include/crypto/kdf_sp800108.h                 | 39 ++++----
 scripts/kernel-doc                            | 48 +++++++++-
 31 files changed, 545 insertions(+), 319 deletions(-)

-- 
2.38.1

