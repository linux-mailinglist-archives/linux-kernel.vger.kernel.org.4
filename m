Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACB163A7F3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiK1MIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiK1MGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:06:31 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154551D641
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:02:21 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NLPGh0lXrz4y0tv;
        Mon, 28 Nov 2022 20:02:20 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2ASC2CIk076108;
        Mon, 28 Nov 2022 20:02:13 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 28 Nov 2022 20:02:15 +0800 (CST)
Date:   Mon, 28 Nov 2022 20:02:15 +0800 (CST)
X-Zmail-TransId: 2afa6384a347ffffffffc94097cc
X-Mailer: Zmail v1.0
Message-ID: <202211282002156712454@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <rostedt@goodmis.org>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhang.songyi@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHRyYWNpbmc6IG1vdmUgZnJvbSBzdHJsY3B5IHdpdGggdW51c2VkIHJldHZhbCB0byBzdHJzY3B5?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2ASC2CIk076108
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 6384A34C.001 by FangMail milter!
X-FangMail-Envelope: 1669636940/4NLPGh0lXrz4y0tv/6384A34C.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6384A34C.001/4NLPGh0lXrz4y0tv
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

Follow the advice of the below link and prefer 'strscpy' in this
subsystem. That's now the recommended way to copy NUL terminated
strings. Conversion is 1:1 because the return value is not used.

Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 kernel/trace/trace_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 3bfaf560ecc4..a43be36c489e 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2813,7 +2813,7 @@ static __init int setup_trace_triggers(char *str)
        char *buf;
        int i;

-       strlcpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
+       strscpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
        ring_buffer_expanded = true;
        disable_tracing_selftest("running event triggers");

--
2.15.2
