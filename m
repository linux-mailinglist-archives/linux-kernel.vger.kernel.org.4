Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F535B924F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiIOBqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiIOBqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:46:21 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDE879EEA;
        Wed, 14 Sep 2022 18:46:18 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id JAJ00012;
        Thu, 15 Sep 2022 09:46:12 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.12; Thu, 15 Sep 2022 09:46:13 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] media: vivid.rst: fix TV and S-Video Inputs section
Date:   Wed, 14 Sep 2022 21:46:09 -0400
Message-ID: <20220915014609.1559-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   2022915094612d4a18b7b809ee003b7622ffe0444f35e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove the double word 'in'.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 Documentation/admin-guide/media/vivid.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/media/vivid.rst b/Documentation/admin-guide/media/vivid.rst
index 4f680dc9661c..a5a9c062b23f 100644
--- a/Documentation/admin-guide/media/vivid.rst
+++ b/Documentation/admin-guide/media/vivid.rst
@@ -392,7 +392,7 @@ Which one is returned depends on the chosen channel, each next valid channel
 will cycle through the possible audio subchannel combinations. This allows
 you to test the various combinations by just switching channels..
 
-Finally, for these inputs the v4l2_timecode struct is filled in in the
+Finally, for these inputs the v4l2_timecode struct is filled in the
 dequeued v4l2_buffer struct.
 
 
-- 
2.27.0

