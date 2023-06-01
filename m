Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D3D71F77B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjFBBEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFBBEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:04:38 -0400
X-Greylist: delayed 21002 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Jun 2023 18:04:36 PDT
Received: from 12.mo550.mail-out.ovh.net (12.mo550.mail-out.ovh.net [87.98.162.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC769E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:04:36 -0700 (PDT)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.109.146.106])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id B41F323AF9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 19:05:22 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-v64b8 (unknown [10.110.115.101])
        by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0858F1FDB4;
        Thu,  1 Jun 2023 19:05:21 +0000 (UTC)
Received: from etezian.org ([37.59.142.98])
        by ghost-submission-6684bf9d7b-v64b8 with ESMTPSA
        id isruOfHreGRUAwAA/zevJg
        (envelope-from <andi@etezian.org>); Thu, 01 Jun 2023 19:05:21 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-98R002f027b0f7-cedf-4ad2-95e8-e13eec2dbd88,
                    AA272FFB3D993AA473C4810146CC99B0E2A08255) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 178.238.172.216
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Wolfram Sang <wsa@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add myself as I2C host drivers maintainer
Date:   Thu,  1 Jun 2023 21:04:27 +0200
Message-Id: <20230601190427.21388-1-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17001651546801769179
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpedtgfevudejhffgleekffekvedukeehveeijefhleektdeiheelueffvdeufeejffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupddujeekrddvfeekrddujedvrddvudeipdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegrnhguihesvghtvgiiihgrnhdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehhedtpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will help Wolfram out with the i2c controllers patches.

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 74aeae10a1516..668f83d514a25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9732,6 +9732,7 @@ F:	include/uapi/linux/i2c-*.h
 F:	include/uapi/linux/i2c.h
 
 I2C SUBSYSTEM HOST DRIVERS
+M:	Andi Shyti <andi.shyti@kernel.org>
 L:	linux-i2c@vger.kernel.org
 S:	Odd Fixes
 W:	https://i2c.wiki.kernel.org/
-- 
2.40.1

