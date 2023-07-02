Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E694E744E91
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 18:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGBQUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 12:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjGBQUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 12:20:37 -0400
Received: from qs51p00im-qukt01080102.me.com (qs51p00im-qukt01080102.me.com [17.57.155.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4135E60
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1688314835; bh=qpy3QnsNYV/6i+Z+E/7oVPqLATRtztnFxJi7PACiimo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=dCwTwT8rwm0z7+pxWPyNsJVDJpkzUWLfCFjQptH+nYNQUYvowrtI4Yb9Pvq2oexAp
         WAwR/YKICXrC3B02ML5S0/eUO1GigaDBYLBMs/W7GYQCsshDZj/vf4DALz+0q0j/9K
         dBDHT1ONCv1c1xU1LCbKAqnHL/NRRR5f4fxJXJp0R19H12561Hnt/IA2qXt5zpexG0
         o9fODmW1Cngm/AvCkyBItr7Qo77NxXh9Bc/7brbzwAgVtwaTDD00ZS8cF2yDCANsgF
         9ao4OkOtf5n+eIZ4IQvF5E+ym3a+/kE7mi51UA9zscrarI1oro10O5FPEyKpM950Ny
         dEbd9mGXdQqGA==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01080102.me.com (Postfix) with ESMTPSA id 0B3BF1CC011A;
        Sun,  2 Jul 2023 16:20:34 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     avolmat@me.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: st: correct serial alias in stih418-b2264.dts
Date:   Sun,  2 Jul 2023 16:19:33 +0000
Message-Id: <20230702161936.134429-2-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230702161936.134429-1-avolmat@me.com>
References: <20230702161936.134429-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3qWlRv3hkttOG_FJeOtgvo5utsrLyM1i
X-Proofpoint-ORIG-GUID: 3qWlRv3hkttOG_FJeOtgvo5utsrLyM1i
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F03:2022-01-11=5F01,2022-01-12=5F03,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 clxscore=1015 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=884 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2307020155
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aliases should only contain lowercase, digits or - hence
correct the alias for the serial from ttyAS0 into serial0
as already done for the other boards.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/st/stih418-b2264.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stih418-b2264.dts b/arch/arm/boot/dts/st/stih418-b2264.dts
index fc32a03073b6..f496ca28850d 100644
--- a/arch/arm/boot/dts/st/stih418-b2264.dts
+++ b/arch/arm/boot/dts/st/stih418-b2264.dts
@@ -69,7 +69,7 @@ opp04 {
 	};
 
 	aliases {
-		ttyAS0 = &sbc_serial0;
+		serial0 = &sbc_serial0;
 		ethernet0 = &ethernet0;
 	};
 
-- 
2.34.1

