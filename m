Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F249372D747
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbjFMCM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFMCM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:12:57 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA651718;
        Mon, 12 Jun 2023 19:12:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QgBsc2QNyz4f3tP1;
        Tue, 13 Jun 2023 10:12:52 +0800 (CST)
Received: from ubuntu20.huawei.com (unknown [10.67.174.33])
        by APP1 (Coremail) with SMTP id cCh0CgBXxS+j0IdkeBHAKw--.56443S2;
        Tue, 13 Jun 2023 10:12:53 +0800 (CST)
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, gongruiqi1@huawei.com
Subject: [PATCH] pinctrl: renesas: remove checker warnings: x | !y
Date:   Tue, 13 Jun 2023 10:16:43 +0800
Message-Id: <20230613021643.3330661-1-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXxS+j0IdkeBHAKw--.56443S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1DWry5AFW5GFWDGF1ftFb_yoWkKFc_CF
        1UXrnxCr9rC3W5ury0qayfWrWvkan2q34vvwn2va43Cr9xAw12yF9YkrZ8Cwn7Wa17tF9x
        CrnFvrW0yF17AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbokYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following Sparse reports when building with C=1:

drivers/pinctrl/renesas/pinctrl-rzn1.c:187:52: warning: dubious: x | !y
drivers/pinctrl/renesas/pinctrl-rzn1.c:193:52: warning: dubious: x | !y

Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
---
 drivers/pinctrl/renesas/pinctrl-rzn1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzn1.c b/drivers/pinctrl/renesas/pinctrl-rzn1.c
index 374b9f281324..2391a316d5c5 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
@@ -184,13 +184,15 @@ static void rzn1_hw_set_lock(struct rzn1_pinctrl *ipctl, u8 lock, u8 value)
 	 * address | 1.
 	 */
 	if (lock & LOCK_LEVEL1) {
-		u32 val = ipctl->lev1_protect_phys | !(value & LOCK_LEVEL1);
+		u32 val = ipctl->lev1_protect_phys |
+			(value & LOCK_LEVEL1 ? 0 : 1);
 
 		writel(val, &ipctl->lev1->status_protect);
 	}
 
 	if (lock & LOCK_LEVEL2) {
-		u32 val = ipctl->lev2_protect_phys | !(value & LOCK_LEVEL2);
+		u32 val = ipctl->lev2_protect_phys |
+			(value & LOCK_LEVEL2 ? 0 : 1);
 
 		writel(val, &ipctl->lev2->status_protect);
 	}
-- 
2.25.1

