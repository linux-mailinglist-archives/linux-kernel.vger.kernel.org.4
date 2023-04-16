Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0506E3BE9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 22:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDPU3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 16:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPU3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 16:29:32 -0400
Received: from st43p00im-ztfb10061701.me.com (st43p00im-ztfb10061701.me.com [17.58.63.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571A21FD4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 13:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1681676969; bh=QOcoWbCcjc4S5ZBNccicx/PEXIx3g1kNuRyf36MJ7dQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=jmZwo9Qkr9SI/MA8gviFhsfb8kCAYV2NQx2LsTm3FzvbenVDtYoKOlWaHwfiamcwz
         9DgJGVqPg3w6Sc3gmRcRxDtKTNrQPYrqrxXxZmm9xPmZPP8OssmOsMam/Mu4rhcvvh
         tpRdMctppZ9zmqO83vJFDjySg00nQyX1BBiCp5rVOX15ixrywTEJUdSz3swCJMzboe
         clUuldfLwvptns5vEZQ1WOpgFYY6WnhTLEmUXm4Z2mHXTKJLaQBW7p1NPzWXLQUtNi
         Cb1Hh1ckTosMiemwj7j4W8aRMB49wa7w4B2HmChjjAB6TyRP2sYsRwAaLpFnwjwvkC
         wQ1tHu9A0qnsQ==
Received: from localhost (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-ztfb10061701.me.com (Postfix) with ESMTPSA id 067712E0FD1;
        Sun, 16 Apr 2023 20:29:28 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     philippe.cornu@foss.st.com, arnd@arnd.de
Cc:     dri-devel@lists.freedesktop.org, patrice.chotard@foss.st.com,
        Alain Volmat <avolmat@me.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update Alain Volmat's email address for drm/sti
Date:   Sun, 16 Apr 2023 22:27:47 +0200
Message-Id: <20230416202747.62479-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1xLIxmdQxK7MZgk1QyxRp-bDz1-kadNu
X-Proofpoint-ORIG-GUID: 1xLIxmdQxK7MZgk1QyxRp-bDz1-kadNu
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2020-02-14=5F02,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=687
 suspectscore=0 clxscore=1011 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2304160194
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my email address for maintainer of the STi DRM driver.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e64787aace8..3cec7ad72389 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6952,7 +6952,7 @@ F:	Documentation/devicetree/bindings/display/rockchip/
 F:	drivers/gpu/drm/rockchip/
 
 DRM DRIVERS FOR STI
-M:	Alain Volmat <alain.volmat@foss.st.com>
+M:	Alain Volmat <avolmat@me.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-- 
2.34.1

