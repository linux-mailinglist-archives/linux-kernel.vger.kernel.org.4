Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E706EB9AD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 16:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDVOgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 10:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVOgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 10:36:01 -0400
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8EC10E4;
        Sat, 22 Apr 2023 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1682174157;
        bh=rV+obqBV2YKvr1MLCeqn9cEsCuGUCv/eN8ByCFyFd0o=;
        h=From:To:Cc:Subject:Date;
        b=cfipC+FMoS4I0CbQVjfyqkeELQI0ILoPQFJgH6Tui2WJ487VR7r4XZf7VJ25dAIgD
         5aprOXElaQfofA19ELIoWq3jjPmVtrjicr/BNUNTlogjyq4bmJ89uPBXinuMz+lNSC
         nSSEe5Btahqb/1SPcU/VWoD6TytPONgdmJWF3oXo=
Received: from rtoax.. ([111.199.190.121])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 8F7278F5; Sat, 22 Apr 2023 22:35:55 +0800
X-QQ-mid: xmsmtpt1682174155tp1m27fmo
Message-ID: <tencent_3E0341A1C9AC8FCB7915E7D791D117445707@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQw2r08/0nNmetDOkmWKFwsM6519DB8bTZ3b478RMp2L/YWkTkcA7
         SdN9+kuyCMmR+hdxq99LYQIBh8G3SBJPVAkbG+Xo/BMV/mTpf5fKZ1RLkqjH3gBI4CHT4pI25j7N
         pBpZnn+4TDkM2O+hPpukG2ZcunHYVRuit4bvMVkm3vplfNUX1TS6HJP5VBKghowY5JrlKpWoZnnO
         cytYJrkn90M1Jh2ZAc6p33JhMS96Qc/p7PLgnD6fNY13RdX9rCRZzFDVKUwvRmJ+wjftrFrqbDbQ
         Cdpj2ySLYb2xesJUtC2EySF2NTgobscnTwOdWr0jukv1xAXUXHcAQ38bZdeG7KlLDcJ2cCazUoT8
         /poCy/7FCZcN7Ul2JHUPPA7G0w9IanT3jT5MX4+18pfyn06IY3ViuSHXE/0PnSTC1wHsV2dwjj5Z
         XiUsRGedjVTqkJVCytKAIbkEjRr5XB2sw7gvG8m0Krn1lm5jfvTN6FP7CEg2/qdXn7ZX2HDDZ/wC
         cHrdFxydsRo966SF7DS+ycWTyouJqCaxRGCnDBlFUUeQCHzWozlHp/+PMxBDsm8pcF+5PdxblHDG
         oV6z3C/AywEeBIoXT9TFoLvUPDx6u4fAuej5an7YD1kDScF7WGzm4Dw29IUnBf/IFeqR5DaGT/BN
         dOKHrDvlhntBi9KZkxFdSFxCYsHX0F/1gNohrksKR1YOQMCGYNKEBwIIaBJRl8URP6SCkcxllcwp
         KPch8DM4UBpfhjYw2cKJkDO6HIXDdq+RHF12s4z+7XLNgzkWcLwwsWSvmlK05juOxSHHO2QoQ/g/
         /cHYoBXkT9mKNRXNCm+xVSpd4LqwKki/dHgFmRF5ZXQf1u09jgt//YLA7HpWRabOoV+cr7rWWF5D
         tM3Aahq5hLTWDZNWGPBBEfwFS1JhiUQjNaVimC4zNbqjsH0bznTZsR6hrTXiZwfA4JaLxxWxcY6P
         csCSlYtWqtubXCkcjS0G3XKyfjzCrOUtntci0+ayChesTmlubRvgacsw2NUWOv191R3DP1TBMtu5
         X6M9OKJA==
From:   Rong Tao <rtoax@foxmail.com>
To:     william.gray@linaro.org
Cc:     Rong Tao <rongtao@cestc.cn>,
        linux-kernel@vger.kernel.org (open list),
        linux-iio@vger.kernel.org (open list:COUNTER SUBSYSTEM)
Subject: [PATCH v2] tools/counter: Add .gitignore
Date:   Sat, 22 Apr 2023 22:35:53 +0800
X-OQ-MSGID: <20230422143554.61364-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Ignore counter_example and include/linux/counter.h.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v2: Ignore /include/linux/counter.h, instead of /include directory
v1: https://lore.kernel.org/lkml/tencent_1625E21562D40C91CEE047E82E2BFC524305@qq.com/
---
 tools/counter/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/counter/.gitignore

diff --git a/tools/counter/.gitignore b/tools/counter/.gitignore
new file mode 100644
index 000000000000..9fd290d4bf43
--- /dev/null
+++ b/tools/counter/.gitignore
@@ -0,0 +1,2 @@
+/counter_example
+/include/linux/counter.h
-- 
2.40.0

