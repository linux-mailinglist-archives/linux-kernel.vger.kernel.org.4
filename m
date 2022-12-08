Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784E8646B9F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiLHJMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiLHJLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:11:45 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ADF1B1EA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 01:11:20 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id jn7so923287plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 01:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1wAtYZkQg8yxlvh3V2WzAs1Bk4wWoFDdDG5ii8S+ZE=;
        b=C5cAjxYYPbdbpMTbX/x0Ag4j99qppribUY9pXyVzfeJIH8LJ5bjcYCYA1I6s5Q/XNd
         mIEdB9YoIUPm3vl5498rOsHLWGfhjGNjX40VLZG1+fjS4hm717YlJh4PCSqO+iYFu4vH
         6ebXjNpFKrbrbp10EhF5eHolEa8RJXXeziZDXeDsxf8LURn/EfkzzoP38fNcPMmJmcfe
         SZ6g3BhwtG+P4RRqQt/VIR1xmRvBdJMmrytvNmThslaWrM6r257QP07J9QHH3xYIBppy
         G1o8a+i40pX2z27v0glyPITmrq+4t68igTJ2YxkYHObepdAltka8hsQGMC3fOIi6x88U
         oCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1wAtYZkQg8yxlvh3V2WzAs1Bk4wWoFDdDG5ii8S+ZE=;
        b=zfNnRKHqLbrBK2BV6IxLvu1r9GE9K7YOIuqDl9MIlxRHXMo3a1KDlRaRKEpgPdSH0A
         zX4RCUmKPn1N0G5KYfNrYClg6BKnTfoakxtrBoIv4NGsPZQabx87MtBqqRnqzLL2QHJ+
         3a45NyyZ4/WgfoZA9luNE5/cUgjSy9xGDKi0K8HtDuaPn7VbcB7gpYAUgJpLgtQgl6sq
         m+V8y08FWCtx6VigO/fxvhbNRMLS0ejHYbWz/+SNSCrp/pCPMh0ERFIES1G4CEbf6CSv
         QwX+owAR9YPVAQMPRwgKZ3WTAXYkdbEoTGbqSfKEv4L5Nbyrfr5sbOt7DSy/AWsNKSJW
         zB/w==
X-Gm-Message-State: ANoB5pm/xF3OmetUgVFiBuQjPD/w+ene6YT2aLQNAtdfgwQ1TPGCgj9y
        sWWDqfUuf6LWAkZsuuMWCyY=
X-Google-Smtp-Source: AA0mqf6nuuyIVCUeKDrvq0WJlFuBsDFD8uIYrOlkZrUcPXkNeyn7jPh4YUl5DhDRi16W6p0C0TM4Lg==
X-Received: by 2002:a17:90a:ea8f:b0:219:2e8c:d1d0 with SMTP id h15-20020a17090aea8f00b002192e8cd1d0mr55902252pjz.57.1670490679822;
        Thu, 08 Dec 2022 01:11:19 -0800 (PST)
Received: from zoo868e (1-170-0-91.dynamic-ip.hinet.net. [1.170.0.91])
        by smtp.gmail.com with ESMTPSA id a15-20020aa78e8f000000b005743cdde1a7sm14801038pfr.82.2022.12.08.01.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 01:11:19 -0800 (PST)
Date:   Thu, 8 Dec 2022 17:11:17 +0800
From:   Matt Jan <zoo868e@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 2/3] staging: vme_user: replace 'unsigned' with 'unsigned int'
Message-ID: <20221208091117.GA95220@zoo868e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the bare use of "unsigned" to the preferred "unsigned int".

Signed-off-by: Matt Jan <zoo868e@gmail.com>
---
 drivers/staging/vme_user/vme_bridge.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
index e17a8f7de165..9a127f6fefca 100644
--- a/drivers/staging/vme_user/vme_bridge.h
+++ b/drivers/staging/vme_user/vme_bridge.h
@@ -84,7 +84,7 @@ struct vme_error_handler {
 	unsigned long long end;		/* End of error window */
 	unsigned long long first_error;	/* Address of the first error */
 	u32 aspace;			/* Address space of error window*/
-	unsigned num_errors;		/* Number of errors */
+	unsigned int num_errors;		/* Number of errors */
 };
 
 struct vme_callback {
-- 
2.25.1

