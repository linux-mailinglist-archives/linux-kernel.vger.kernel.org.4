Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9967C641CDD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 13:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiLDMTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 07:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiLDMTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 07:19:14 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7873C13F71;
        Sun,  4 Dec 2022 04:19:12 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Axz+s_kIxjMRYDAA--.7155S3;
        Sun, 04 Dec 2022 20:19:11 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxbuA8kIxjkmMlAA--.26442S3;
        Sun, 04 Dec 2022 20:19:10 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Documentation/features-refresh.sh: Only sed the beginning "arch" of ARCH_DIR
Date:   Sun,  4 Dec 2022 20:18:46 +0800
Message-Id: <1670156327-9631-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1670156327-9631-1-git-send-email-yangtiezhu@loongson.cn>
References: <1670156327-9631-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8DxbuA8kIxjkmMlAA--.26442S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoWrtw1xZF4UJFyrKF1DWr1Utrb_yoWkCwbEka
        9xtF1UtrWUJr1I9ry5JF4YkFy2v34F9a1ruwn3JF4Fyw1I9a9xGFZFkrW5Za4UZr45Cr1r
        CFZ7XrW7Ar12qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        17kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
        W8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should only sed the beginning "arch" of ARCH_DIR in features-refresh.sh,
otherwise loongarch is recognized as loong, that is not what we want.

Fixes: be99f610a110 ("Documentation/features: Add script that refreshes the arch support status files in place")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 Documentation/features/scripts/features-refresh.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/scripts/features-refresh.sh b/Documentation/features/scripts/features-refresh.sh
index 9e72d38..c228812 100755
--- a/Documentation/features/scripts/features-refresh.sh
+++ b/Documentation/features/scripts/features-refresh.sh
@@ -60,7 +60,7 @@ for F_FILE in Documentation/features/*/*/arch-support.txt; do
 	echo "    |         arch |status|" >> $T_FILE
 	echo "    -----------------------" >> $T_FILE
 	for ARCH_DIR in arch/*/; do
-		ARCH=$(echo $ARCH_DIR | sed -e 's/arch//g' | sed -e 's/\///g')
+		ARCH=$(echo $ARCH_DIR | sed -e 's/^arch//g' | sed -e 's/\///g')
 		K_FILES=$(find $ARCH_DIR -name "Kconfig*")
 		K_GREP=$(grep "$K" $K_FILES)
 		#
-- 
2.1.0

