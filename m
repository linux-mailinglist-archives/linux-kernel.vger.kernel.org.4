Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924FE744E8F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 18:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjGBQUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 12:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjGBQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 12:20:34 -0400
Received: from qs51p00im-qukt01080502.me.com (qs51p00im-qukt01080502.me.com [17.57.155.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2E4E61
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1688314833; bh=Iv3m4GfwEiIJ+1q3qPvMChkBe3FPQBoOmUBhBQvkpxU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=YuGeDnwlgnpLn4qDY1LacevolK8WKLaIvV2cThhRABpnNrSBkOc3b2Tx0rnT/a4OG
         aTcYWEAUTw9GAtW7Wa+RyUgPO/SjyhTmX+9gQx7x6pb4q/D1+iqH2ltSBjyZrJ/tO7
         rtwpmg4abdICFbZYI8LJ81YJRyfZEdCXgIL7ZVTRvflMJ/1J2Q7dmZXZE4mGgfywga
         99aUHMvgmR61dGrKZp6X7EA6ZY7LQvUo3qSXNzBaMe8iS3rvuTNWEYl3AXow4UMhzD
         GbF7EFvq31NgPQ75dekqAltD0B/FU6qz4gOvGR0qdbIB+3ytdLWuT8JYCNtMC0xfv8
         2wkngiQm/z4ig==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01080502.me.com (Postfix) with ESMTPSA id 2E6194E40129;
        Sun,  2 Jul 2023 16:20:32 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     avolmat@me.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ARM: dts: st: dts fixes in stih418-b2264.dts
Date:   Sun,  2 Jul 2023 16:19:32 +0000
Message-Id: <20230702161936.134429-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uvpmp6rULJM-6ybVzzoAcro1J_HI7UxA
X-Proofpoint-ORIG-GUID: uvpmp6rULJM-6ybVzzoAcro1J_HI7UxA
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=510 clxscore=1011 phishscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2307020155
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correction of two dts warnings and led state in stih418-b2264.dts

Alain Volmat (3):
  ARM: dts: st: correct serial alias in stih418-b2264.dts
  ARM: dts: st: move leds out of soc in stih418-b2264.dts
  ARM: dts: st: correct led level in stih418-b2264.dts

 arch/arm/boot/dts/st/stih418-b2264.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.34.1

