Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8801B6F12EA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345754AbjD1H40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345676AbjD1H4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:56:19 -0400
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0DF210E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1682668556;
        bh=3/XxOwPGyLvaqFQFO3bG8JaEsc6tiajYxhKhW2i4Fm8=;
        h=From:To:Cc:Subject:Date;
        b=wRQ+wo9KyBLklvin5BgUa4eU7+tsfR/CHoujuI7r7zuhDwi+4tv75u82dWlM90SaJ
         ZvLnpcqVLs/6sgRfAIsS8kXzR4p5Dvh6twKZ6gdYgGY+QoL+DtEiQMxuI4HkV8ttym
         Ej3Foh3H5skyz2FrPLcjzQe+GRoPU6czEhyp/dPY=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id DF32E888; Fri, 28 Apr 2023 15:55:51 +0800
X-QQ-mid: xmsmtpt1682668551t298bh9bi
Message-ID: <tencent_F0318BF0724705EC156C341E11DE4040E805@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9GVejZOqymyPp5OC+cBjbPM3QxSp+D5P37BqGKCuHb3xdb9Q3/k
         clOZKlkMMl2200rWRiIftvcPhBp2owsNUrYlP6AN7XmircsJ2uE5ERCiXN3Jxu2KQgf2M48sLJZB
         GHQ+BX9cJATzHZ+FM2lIDkeG3m13Mfdj7YO1P1lVI6XJ5hGbO2QQ9CnMt4cZbnR4JudaUc8TcWua
         g2FBWXjk8XDLCwwqSTNhwjLJOYWaSTl4tT4fNMAqZMQjIZg4ocK6A/0wp77zsz/TUe574EWmSjw5
         RPHcKHw58aDCw5cLHw73J/GwTbwe7jJj0DZOzjsTdPUDS4QNGRrvvmoMCCwUtlZtwiehrAkZxqjj
         u3j0D0GwZg8I3hRvhdCowAq35OdCwNhD9NaJ9cqeYTs6rsK3yweZhC4E/mYGIRTbJsmkPpJ031ls
         jDaHMxLtkZUO4VdqZMVRFZ6ZdqW5ycvqDRYRWEffjl6HFi/cPDHoWI6Ihq873A2xq28NaEZW/l9C
         5Zygf9RRQIO+Q5K3UHYyI+K2gRG8QLozkl3Z9nIHd/twVvzN/XeXVCHGvhdqhmE15tC9zpJQS48A
         FVny7XQEoYB0iVYJ1WSAbpaeYZ59m8TRPguSzaMdi1oMNuRckZmsdYrDoSlrWx/hxbuo5P6pPe50
         9eP6iyPqzyexer9U4ou7w6zkPj+vG5mpy4GckStRVINwW4TrJTmqdBl1FZDiV9zSXvuJp5giInD8
         7EeGVlKwy2lbgzuUaQ6MJJ8FOVHQctCyM6CLm/uC8m81Ezyq1sJEyc0vTTkVtlSVy+r6bTe96Tv+
         RHO088iJb/1rM1yatfaVk3v/31FMUlWl5OXg+/vEIiY9rFP7IMyVbmfIjZeSsQRYd2rTKOw2WdWv
         jVT2463C+GklG9/950Rpb+ISSdx5JxCk7ZG2zGfjOInWhabfgJSxsldA/dHcZKfvVGDQC72gCW2E
         P1dculv7UdBONKpfsif0KbZt0i/sU5UKwfRQZEG11ECcFsSi/5llmzeQGOosJx
From:   Rong Tao <rtoax@foxmail.com>
To:     terry.bowman@amd.com
Cc:     bp@suse.de, feng.tang@intel.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, rongtao@cestc.cn, Rong Tao <rtoax@foxmail.com>
Subject: [PATCH] tools/x86/kcpuid: Add .gitignore
Date:   Fri, 28 Apr 2023 15:55:49 +0800
X-OQ-MSGID: <20230428075549.164345-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
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

Ignore kcpuid ELF file.

Signed-off-by: Rong Tao <rtoax@foxmail.com>
---
 tools/arch/x86/kcpuid/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/arch/x86/kcpuid/.gitignore

diff --git a/tools/arch/x86/kcpuid/.gitignore b/tools/arch/x86/kcpuid/.gitignore
new file mode 100644
index 000000000000..be91f895ff60
--- /dev/null
+++ b/tools/arch/x86/kcpuid/.gitignore
@@ -0,0 +1 @@
+/kcpuid
-- 
2.39.1

