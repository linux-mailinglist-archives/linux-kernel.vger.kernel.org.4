Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025E471F9B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 07:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjFBFmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 01:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjFBFmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 01:42:18 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED9B1A1;
        Thu,  1 Jun 2023 22:42:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QXX2C6thPz4f3mVg;
        Fri,  2 Jun 2023 13:42:11 +0800 (CST)
Received: from ubuntu20.huawei.com (unknown [10.67.174.33])
        by APP4 (Coremail) with SMTP id gCh0CgBHsLMkgXlkIMb+Kg--.35696S2;
        Fri, 02 Jun 2023 13:42:13 +0800 (CST)
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
To:     Serge Hallyn <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: [PATCH] capability: erase checker warnings about struct __user_cap_data_struct
Date:   Fri,  2 Jun 2023 13:45:27 +0800
Message-Id: <20230602054527.290696-1-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBHsLMkgXlkIMb+Kg--.35696S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trW7Cr4UKrWkJFW3Jr43ZFb_yoW8CF1rpF
        18Gw4fGFZ7Ar4xCw4kCa12yr1FqrWDJFy7tFy7Gw1Fyr4Fk3W8WF1jka40yF1Fvrs7KrW3
        X392grWF934DC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently Sparse warns the following when compiling kernel/capability.c:

kernel/capability.c:191:35: warning: incorrect type in argument 2 (different address spaces)
kernel/capability.c:191:35:    expected void const *from
kernel/capability.c:191:35:    got struct __user_cap_data_struct [noderef] __user *
kernel/capability.c:168:14: warning: dereference of noderef expression
...... (multiple noderef warnings on different locations)
kernel/capability.c:244:29: warning: incorrect type in argument 1 (different address spaces)
kernel/capability.c:244:29:    expected void *to
kernel/capability.c:244:29:    got struct __user_cap_data_struct [noderef] __user ( * )[2]
kernel/capability.c:247:42: warning: dereference of noderef expression
...... (multiple noderef warnings on different locations)

It seems that defining `struct __user_cap_data_struct` together with
`cap_user_data_t` make Sparse believe that the struct is `noderef` as
well. Separate their definitions to clarify their respective attributes.

Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
---
 include/uapi/linux/capability.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 3d61a0ae055d..5bb906098697 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -41,11 +41,12 @@ typedef struct __user_cap_header_struct {
 	int pid;
 } __user *cap_user_header_t;
 
-typedef struct __user_cap_data_struct {
+struct __user_cap_data_struct {
         __u32 effective;
         __u32 permitted;
         __u32 inheritable;
-} __user *cap_user_data_t;
+};
+typedef struct __user_cap_data_struct __user *cap_user_data_t;
 
 
 #define VFS_CAP_REVISION_MASK	0xFF000000
-- 
2.25.1

