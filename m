Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E11C73F74E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjF0Ice (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjF0Ibh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:31:37 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BE726A4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:30:21 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QqyZG5KfTzBJBJN
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:29:58 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :subject:to:from:date:mime-version; s=dkim; t=1687854598; x=
        1690446599; bh=rY8FrVJSi19RgbCUiiSwhe+wareQggKiD1cqjZX3ejs=; b=U
        cSsWTLfQeymVyJyNCqgX+lb1njxOleAUQnLkW0NMACCSF+p+eIV7ufmdVOGoVipb
        Kro6sAcHTG/kXhn6ufOPlZ+djJOYKgnikjHcpkSrx6ytXNULb8DN/f4HTTpy6BeO
        H5NT6KXptSzIspm+HfrSxQ7+WrMQur3hBphHYzqC+m4H//98ZIQTCFm+lvJRd4Si
        Hl/0Spl1lYJyl+dnSzNkxWtfiLAuDIE0CcnLlEvOX/QEHAwogsmVcoMttjfEItaG
        dAqC17xl5mBPykelnKKfIml2eRv6KUZBOsDdhyLL3/IOancGam0fgDo9th9/6zJe
        ewme+kaJpve4MMOcD7nZA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Pk5EOfxtWsfl for <linux-kernel@vger.kernel.org>;
        Tue, 27 Jun 2023 16:29:58 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QqyZG2L09zBJBHT;
        Tue, 27 Jun 2023 16:29:58 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 27 Jun 2023 16:29:58 +0800
From:   baomingtong001@208suo.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ipr: Remove unneeded semicolon
User-Agent: Roundcube Webmail
Message-ID: <9d16962fccbd962abd25d0063f97df47@208suo.com>
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

./drivers/scsi/ipr.h:1916:2-3: Unneeded semicolon

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  drivers/scsi/ipr.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ipr.h b/drivers/scsi/ipr.h
index c77d6ca1a210..583bbf9a7a93 100644
--- a/drivers/scsi/ipr.h
+++ b/drivers/scsi/ipr.h
@@ -1913,7 +1913,7 @@ static inline int ipr_sdt_is_fmt2(u32 sdt_word)
  	case IPR_SDT_FMT2_BAR5_SEL:
  	case IPR_SDT_FMT2_EXP_ROM_SEL:
  		return 1;
-	};
+	}

  	return 0;
  }
-- 
2.40.1

