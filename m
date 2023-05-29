Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0377149CA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjE2NB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjE2NBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:01:40 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BC4CD;
        Mon, 29 May 2023 06:01:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QVFz15Fg2z4f3nwW;
        Mon, 29 May 2023 21:01:33 +0800 (CST)
Received: from ubuntu1804.huawei.com (unknown [10.67.174.58])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbAuonRkVCbnKQ--.22101S4;
        Mon, 29 May 2023 21:01:35 +0800 (CST)
From:   Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: cleanup exit_sel_fs() declaration
Date:   Mon, 29 May 2023 21:00:18 +0800
Message-Id: <20230529130018.89391-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: gCh0CgAHvbAuonRkVCbnKQ--.22101S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZryxKF4UWF1fZw1DuFyDJrb_yoWfCwbE93
        Z7Cr4kZr48ZF4Fyw1YyFn7ZF90g34xZ348W3WFqFyDXwn3ArW5G3W7JFyxJw4UGryjyrnF
        gF17Cas7Ww1DXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbokYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

exit_sel_fs() has been removed since commit f22f9aaf6c3d ("selinux:
remove the runtime disable functionality").

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/selinux/include/security.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 8746fafeb778..815838ba7f2a 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -384,7 +384,6 @@ struct selinux_kernel_status {
 extern void selinux_status_update_setenforce(int enforcing);
 extern void selinux_status_update_policyload(int seqno);
 extern void selinux_complete_init(void);
-extern void exit_sel_fs(void);
 extern struct path selinux_null;
 extern void selnl_notify_setenforce(int val);
 extern void selnl_notify_policyload(u32 seqno);
-- 
2.17.1

