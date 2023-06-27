Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6D473F78E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjF0IkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjF0Ijo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:39:44 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4122826AB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:39:40 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QqynN75dfzBJBJT
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:39:36 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :subject:to:from:date:mime-version; s=dkim; t=1687855176; x=
        1690447177; bh=XOfdzcztldaOEUijUhJfqXO6nZpNRZo74etOZmm2dac=; b=K
        /k64J3lwdNcFpaCZivttIKy/IuEwgUE1OslL2jEoD7J8D+zZc0tytw9jAn71eJmH
        XMUXf5ekNg595zMFT9DVt8q+ngIQ/dBCwv+3i0vvBhPh1IN2X9fWOTG3cg2AZC9F
        DDLfTT8r545LAWrgRjy0mkpnei+63cL4nqFSQ+/KW8d4N0MXa6nbC1MCj1owyzpD
        kelhFfjSN2OwDI1ixITMFfVf0j6n0PPwdekoK0DlaIeJqBBha3wp6lNls5fO+ZrE
        pNxwoLbQxwXUeQ18vRIa1eytNU1NpsIVDo3DKa3LDBKxN3+liPZqj4GdzLsj0F+X
        zZJItSx1twKUEQYzgApEg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qf5gQTF5O3jn for <linux-kernel@vger.kernel.org>;
        Tue, 27 Jun 2023 16:39:36 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QqynN4GPQzBJBHT;
        Tue, 27 Jun 2023 16:39:36 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 27 Jun 2023 16:39:36 +0800
From:   baomingtong001@208suo.com
To:     david.e.box@linux.intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tools/arch/x86: intel_sdsi: intel_sdsi: Remove unneeded
 semicolon
User-Agent: Roundcube Webmail
Message-ID: <3de99ba427d71d6ff1f943e86a977ffb@208suo.com>
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

./tools/arch/x86/intel_sdsi/intel_sdsi.c:508:2-3: Unneeded semicolon

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  tools/arch/x86/intel_sdsi/intel_sdsi.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c 
b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 2cd92761f171..890c9a84f800 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -505,7 +505,7 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
  				lbc->num_bundles, STATE_MAX_NUM_IN_BUNDLE);

  		offset += blob_size;
-	};
+	}

  	return 0;
  }
-- 
2.40.1

