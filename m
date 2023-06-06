Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4986723515
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 04:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjFFCMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 22:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjFFCL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 22:11:59 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1691F7;
        Mon,  5 Jun 2023 19:11:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QZv9k4WYTz4f3pBY;
        Tue,  6 Jun 2023 10:11:54 +0800 (CST)
Received: from ubuntu1804.huawei.com (unknown [10.67.174.102])
        by APP3 (Coremail) with SMTP id _Ch0CgDHrQvolX5kx5PMKA--.45351S2;
        Tue, 06 Jun 2023 10:11:53 +0800 (CST)
From:   Ruiqi Gong <gongruiqi@huaweicloud.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: [PATCH RESEND] bpf: cleanup unused function declaration
Date:   Tue,  6 Jun 2023 10:10:47 +0800
Message-Id: <20230606021047.170667-1-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _Ch0CgDHrQvolX5kx5PMKA--.45351S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1xJw1xKr43Xw45AF18Zrb_yoWDAFgEv3
        4Fvr1xGr4rWrWxAw1jqF92qrn09w18JryfuF95WrZ3A3Z8Aw4Fkw1xC3srX3s7W3WDXFZx
        Kan7X3W3Jr1agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All usage and the definition of `bpf_prog_free_linfo()` has been removed
in commit e16301fbe183 ("bpf: Simplify freeing logic in linfo and
jited_linfo"). Clean up its declaration in the header file.

Signed-off-by: Ruiqi Gong <gongruiqi@huaweicloud.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/all/20230602030842.279262-1-gongruiqi@huaweicloud.com/
---

Resend: formatted from bpf-next/master.

 include/linux/filter.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index bbce89937..f69114083 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -874,7 +874,6 @@ void bpf_prog_free(struct bpf_prog *fp);
 
 bool bpf_opcode_in_insntable(u8 code);
 
-void bpf_prog_free_linfo(struct bpf_prog *prog);
 void bpf_prog_fill_jited_linfo(struct bpf_prog *prog,
 			       const u32 *insn_to_jit_off);
 int bpf_prog_alloc_jited_linfo(struct bpf_prog *prog);
-- 
2.17.1

