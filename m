Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5392563A910
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiK1NNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiK1NMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:12:50 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF9A1C434
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:12:48 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NLQqy579zz4y0vD;
        Mon, 28 Nov 2022 21:12:46 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2ASDCcQW007677;
        Mon, 28 Nov 2022 21:12:38 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 28 Nov 2022 21:12:42 +0800 (CST)
Date:   Mon, 28 Nov 2022 21:12:42 +0800 (CST)
X-Zmail-TransId: 2afa6384b3ca79d8d251
X-Mailer: Zmail v1.0
Message-ID: <202211282112423253537@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <david.e.box@linux.intel.com>
Cc:     <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHRvb2xzL2FyY2gveDg2OiBpbnRlbF9zZHNpOiBSZW1vdmUgdW5uZWVkZWQgc2VtaWNvbG9u?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2ASDCcQW007677
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 6384B3CE.000 by FangMail milter!
X-FangMail-Envelope: 1669641166/4NLQqy579zz4y0vD/6384B3CE.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6384B3CE.000/4NLQqy579zz4y0vD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

coccinelle told:
/tools/arch/x86/intel_sdsi/intel_sdsi.c:508:2-3: Unneeded semicolon

Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 tools/arch/x86/intel_sdsi/intel_sdsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 2cd92761f171..890c9a84f800 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -505,7 +505,7 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
                                lbc->num_bundles, STATE_MAX_NUM_IN_BUNDLE);

                offset += blob_size;
-       };
+       }

        return 0;
 }
--
2.15.2
