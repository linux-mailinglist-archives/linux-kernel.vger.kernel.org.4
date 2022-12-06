Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453FF644192
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 11:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbiLFKvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 05:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbiLFKu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 05:50:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE05A1F630
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 02:50:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AB1361501
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 10:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6780C433C1;
        Tue,  6 Dec 2022 10:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670323848;
        bh=idwSFerOmfYTDTa+HtATh8uMUYRUYxADXIpo+amvaIA=;
        h=From:To:Cc:Subject:Date:From;
        b=Z47jOEwIzybJflloXu11hjP8mW6r0CDFkL7oK4iR5o0rbZKkJn9M85m9wdQEnqNL5
         QBKWB8R1JAlGq2r0oUhYZD1L08kdqcZokNd5ZmgsWfP8PL34Et86SHXDHvPBEXd8vv
         c3ousHwjv7pP6xZWr/e8gKLFk4vdomnk6ERhVo0j+vQK/SS5+OgaSIZLUuQsLyKlhB
         jcspMVzmYHdrmOI/tW5HdKtky9n0LpyIownHtfo+WYyN0NBIXdq/a+jKRVkmXXyPrw
         +RTFPOpraPiPML5ZhncxPfxFP7dq4exPkIEMMZErwwxh6clNv+plImiPFS5V7HdeU9
         X8UxS4TZ104BQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] MAINTAINERS: Move MFD from a Supported to Maintaied state
Date:   Tue,  6 Dec 2022 10:50:38 +0000
Message-Id: <20221206105038.124613-1-lee@kernel.org>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one is funding MFD maintenance.

  S: *Status*, one of the following:
     Supported:   Someone is actually paid to look after this.
     Maintained:  Someone actually looks after it.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6591462661d6c..fcdb2ac6ca6dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14251,7 +14251,7 @@ F:	drivers/media/i2c/mt9v111.c
 
 MULTIFUNCTION DEVICES (MFD)
 M:	Lee Jones <lee@kernel.org>
-S:	Supported
+S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
 F:	Documentation/devicetree/bindings/mfd/
 F:	drivers/mfd/
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

