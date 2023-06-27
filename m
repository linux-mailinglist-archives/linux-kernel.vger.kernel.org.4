Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0F473F79F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjF0InF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjF0InD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:43:03 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7835B132
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:43:01 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QqysG0gWXzBJJjJ
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:42:58 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :subject:to:from:date:mime-version; s=dkim; t=1687855377; x=
        1690447378; bh=0GqXxlr5oAw8l6SW03YNzgfnjKcC5xcgvTQREDFjnRI=; b=Q
        oo1UWEAhYRKjnHmfWMypFmfKABtSaOEXAm+UuQQlqA8TQCSDqu1r9jkQAiVqHO0z
        sT1k51RkrmWf6RU2ObNxGHJyBYsiaNOfFlbZBBWpIDd1SrO0NBQBhvRt7/w5RKx3
        RRVXCGBGyZKxs4+arakgRAr56F2LsOQI6YaAdeRldMIIxU+tnWmR1gp6hBpMF82a
        wT15wps+7jYpefCC3wyvk9qmZBlO9dOyq7MNeP3lJSsPLmD2xXmsSI+SnLzL02Hk
        jmky5fbfnUCjag60IgZ9HzUzAMZ04kYDupUVN7ZV6r+XvcPPkQ6hg9sQZKj9uEM1
        Vd1Xv6w951l/ixD/yVYKQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5qhBBNH3yYlx for <linux-kernel@vger.kernel.org>;
        Tue, 27 Jun 2023 16:42:57 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QqysF5M1ZzBJBHT;
        Tue, 27 Jun 2023 16:42:57 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 27 Jun 2023 16:42:57 +0800
From:   baomingtong001@208suo.com
To:     pjones@redhat.com, konrad@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] iscsi_ibft: Remove unneeded semicolon
User-Agent: Roundcube Webmail
Message-ID: <7fe48e9768ec4b70e86b26990bac8171@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./drivers/firmware/iscsi_ibft.c:803:2-3: Unneeded semicolon

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  drivers/firmware/iscsi_ibft.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/iscsi_ibft.c 
b/drivers/firmware/iscsi_ibft.c
index 6e9788324fea..3c52fde713ce 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -800,7 +800,7 @@ static void ibft_unregister(void)
  		ibft_kobj = boot_kobj->data;
  		if (ibft_kobj->hdr && ibft_kobj->hdr->id == id_nic)
  			sysfs_remove_link(&boot_kobj->kobj, "device");
-	};
+	}
  }

  static void ibft_cleanup(void)
-- 
2.40.1

