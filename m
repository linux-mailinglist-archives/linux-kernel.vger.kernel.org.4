Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ACA604AB2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiJSPJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiJSPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:09:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68AB4DB70
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:01:07 -0700 (PDT)
X-QQ-mid: bizesmtp67t1666183971tap1fkn8
Received: from localhost.localdomain ( [182.148.15.91])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Oct 2022 20:52:49 +0800 (CST)
X-QQ-SSF: 01000000008000E0J000B00A0000000
X-QQ-FEAT: +oIWmpEafD/3ErJpHslt5YkZvLkPzxVd2l9JB2lduXxgKsmxNqMFG5Zb0z0oH
        PH6tqzlWdl4eCgPtb1GK/eaOF7L0DFkrC4RVPleUe3VF0TNWwiAJXKNLC4tbGLVgypjhlOz
        FTAgURKBcuBpU04fLIkFaPeuteVsIXWUzfDlMinONart/OyNxjTWP0vyhJm+N2jjBirC1Te
        kyL0C/rDKCxMevQf+5iA+Q+5Q5ZpnKn5K/M6Z++VpAlPdAlNVsLMV84D8j11SmNyaJ51uxS
        0hETpdL1SOpcIZu0ZQa+YP4Kv7RwpMoW0Jq4tfxXXey9dmXBTXnD3w6Y2p/1nsNmZB1kPZl
        D3xKAoT4GqYeEaqnJErqr0gWDidshFPvAcsHDEt2fm9NMCW12VAcBhlBDX0T18CPU9/PFSm
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] platform/chrome: fix repeated words in comments
Date:   Wed, 19 Oct 2022 20:52:43 +0800
Message-Id: <20221019125243.49098-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'from'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/platform/chrome/cros_ec_rpmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
index 39d3b50a7c09..a62b87086bad 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -20,7 +20,7 @@
 #define HOST_EVENT_MARK		2
 
 /**
- * struct cros_ec_rpmsg_response - rpmsg message format from from EC.
+ * struct cros_ec_rpmsg_response - rpmsg message format from EC.
  *
  * @type:	The type of message, should be either HOST_COMMAND_MARK or
  *		HOST_EVENT_MARK, representing that the message is a response to
-- 
2.36.1

