Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70896568D4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiL0JWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiL0JWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:22:17 -0500
Received: from pv50p00im-zteg10021301.me.com (pv50p00im-zteg10021301.me.com [17.58.6.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BD5765A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zzy040330.moe;
        s=sig1; t=1672132934;
        bh=6uIkJHq/oE8tSBCo6lr9eo7/ZNZTPvJxUWQNK0GEQnM=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=XjVbddmm3RWkuWCSSaYosADIEWNp2wIg/I4PLiHhcCA7KqYy9FmYpYZcU9crgDGoY
         eawQg5U0RhA5Ivn6LPJGiHdP1wmaWh62amWZaT0wj+2kOMRLuyDkfDU1sLM8L9Yehd
         ZK9+V82ARm3kEngujndZ1h5X4FVOoajO4jhRcjYSBNT/QtrRCkWYgOhH2ImNkynyQp
         96vGaLAMIwUy1Qokp9KqwPm+WXRGqznxIYds4/NXFQy+VUjeYc1e1VoFU/vT62eg3G
         jqo/4IR6KRHEb7i2gZYleV0eLYg3hDk5EwTnuIw+1jaFXa0oeyczc/4jDeBnn7Nf3F
         wDdMM1K8Tx5qw==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id 216F750056D;
        Tue, 27 Dec 2022 09:22:06 +0000 (UTC)
From:   Jun ASAKA <JunASAKA@zzy040330.moe>
To:     masahiroy@kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jun ASAKA <JunASAKA@zzy040330.moe>
Subject: [PATCH] kbuild: add a missing line for help message
Date:   Tue, 27 Dec 2022 17:21:57 +0800
Message-Id: <20221227092157.329109-1-JunASAKA@zzy040330.moe>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -vHwCIjNLMoiID5fF55NQQGyqOjJFoaZ
X-Proofpoint-GUID: -vHwCIjNLMoiID5fF55NQQGyqOjJFoaZ
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1030 adultscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=658 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212270077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The help message line for building the source RPM package was missing.
Added it.

Signed-off-by: Jun ASAKA <JunASAKA@zzy040330.moe>
---
 scripts/Makefile.package | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 539e9f765d64..525a2820976f 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -158,6 +158,7 @@ $(perf-tar-pkgs):
 PHONY += help
 help:
 	@echo '  rpm-pkg             - Build both source and binary RPM kernel packages'
+	@echo '  srcrpm-pkg          - Build only the source kernel RPM package'
 	@echo '  binrpm-pkg          - Build only the binary kernel RPM package'
 	@echo '  deb-pkg             - Build both source and binary deb kernel packages'
 	@echo '  bindeb-pkg          - Build only the binary kernel deb package'
-- 
2.31.1

