Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6E3628EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbiKOA7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiKOA65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:58:57 -0500
X-Greylist: delayed 667 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Nov 2022 16:58:56 PST
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767FE63A5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:58:55 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NB79B3NSRz8QrkZ;
        Tue, 15 Nov 2022 08:58:54 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2AF0woFW074233;
        Tue, 15 Nov 2022 08:58:50 +0800 (+08)
        (envelope-from guo.ziliang@zte.com.cn)
Received: from mapi (xaxapp03[null])
        by mapi (Zmail) with MAPI id mid32;
        Tue, 15 Nov 2022 08:58:51 +0800 (CST)
Date:   Tue, 15 Nov 2022 08:58:51 +0800 (CST)
X-Zmail-TransId: 2afb6372e44bffffffff940df1c2
X-Mailer: Zmail v1.0
Message-ID: <202211150858513761518@zte.com.cn>
Mime-Version: 1.0
From:   <guo.ziliang@zte.com.cn>
To:     <pbonzini@redhat.com>
Cc:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIEtWTTogcmVwbGFjZSBERUZJTkVfU0lNUExFX0FUVFJJQlVURSB3aXRoIERFRklORV9ERUJVR0ZTX0FUVFJJQlVURQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AF0woFW074233
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 6372E44E.000 by FangMail milter!
X-FangMail-Envelope: 1668473934/4NB79B3NSRz8QrkZ/6372E44E.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<guo.ziliang@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6372E44E.000/4NB79B3NSRz8QrkZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: guo ziliang <guo.ziliang@zte.com.cn>
Fix the following coccicheck warning:
/virt/kvm/kvm_main.c: 3849: 0-23: WARNING: vcpu_get_pid_fops
should be defined with DEFINE_DEBUGFS_ATTRIBUTE

Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>
---
virt/kvm/kvm_main.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2719e10..6e58aec 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3846,7 +3846,7 @@ static int vcpu_get_pid(void *data, u64 *val)
return 0;
}

-DEFINE_SIMPLE_ATTRIBUTE(vcpu_get_pid_fops, vcpu_get_pid, NULL, "%llu\n");
++DEFINE_DEBUGFS_ATTRIBUTE(vcpu_get_pid_fops, vcpu_get_pid, NULL, "%llu\n");

static void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
{
--
1.8.3.1
