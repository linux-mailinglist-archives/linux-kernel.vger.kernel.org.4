Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619CA723F74
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbjFFK3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbjFFK3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:29:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1592B10D5;
        Tue,  6 Jun 2023 03:29:19 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-65311774e52so2134393b3a.3;
        Tue, 06 Jun 2023 03:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686047358; x=1688639358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPi6mt9b6IhqfWd9nmqdtaf0Jq+4wtP+GPmYJM6tMKw=;
        b=PFiBxxRvvJsoQEsQ8EHPNXx4lO6/WVtL8qTTDyM578yKHlNpteJOZgSSzqyWQCW0SK
         Gbpd6VIJ1OLhb/Ah21u7HgqlV+7awZrGuUbNwf3yDB7F9cgQyov9KBLPkTZbKzdQdlHA
         z3V6jKpcNKE9zJW2gdKB1Teu0ODRokixzTBy9Qg7LiPMb6GPDjCH2Fx3mlROGyDkYkgE
         1KiyweuGIbxpRBYezH9Q0q+5bxJCtwrwgPZQ4PySFP7DPaUMA+3lwK6NKPsx4Ido/d3b
         jbSXl60FzPl98Jrw1dFMVdDFg6/3j47ISGNcrzJWvneszBoFb0qNFBc48jO2nxDGtEZf
         RTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686047358; x=1688639358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPi6mt9b6IhqfWd9nmqdtaf0Jq+4wtP+GPmYJM6tMKw=;
        b=Ukpjc+2+mAsgFg3slPaJ4+G8FiISpUL79Tl3sq/oTsnFstrsqfKQYN9m+ZlXHvxur7
         MgjyehiFrXyo64+26UN8X7TbV5oo7OruRaXD71by3ZSo7DcxKMXPJyAT1g6cv9iRVtZg
         URhkvl9+4HcJgWfIhbTTQ5cCKZNxZTYhsnqpVxNKmqfforJoxDNxuVwLjed0CjtqIjiE
         +ltyRXwnThTKHw5p8fgsb9Ur0B6bb6kHdITqfm2YMc9t4OxOaYMZaMCXVAgNwDDJgN0L
         kVcgI1XnQMTUSuW1xujQSwOGXPFLeYYHq79gcPDEEKIX/t8CUzGTYOoP0iBAHSmIhiDT
         p8pQ==
X-Gm-Message-State: AC+VfDxhSyZHRngZ2+J21eZ/Q5mQNlGU9iTI+LXMBcIb/wkFP+MHBRo8
        2aBB/KOh7OCtl5orqXIP7I+c9cv0c84lrA==
X-Google-Smtp-Source: ACHHUZ4WBIE/LNDUMa0qzLKQVR8ciepfeNp4X72tbXMgrFVHUdu8nKOA31LOpvgP10YhodpqzOvEBg==
X-Received: by 2002:a05:6a00:acd:b0:65b:6097:7961 with SMTP id c13-20020a056a000acd00b0065b60977961mr347455pfl.17.1686047358342;
        Tue, 06 Jun 2023 03:29:18 -0700 (PDT)
Received: from devbox.. ([103.165.115.136])
        by smtp.gmail.com with ESMTPSA id e12-20020a62aa0c000000b0064fc715b380sm3893569pff.176.2023.06.06.03.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 03:29:17 -0700 (PDT)
From:   Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
To:     b-liu@ti.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
Subject: [PATCH 2/2] drivers: usb: musb: musb_gadget: replaced bare unsigned to unsigned int
Date:   Tue,  6 Jun 2023 15:59:10 +0530
Message-Id: <20230606102910.1013674-1-neelchakrabortykernelwork@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced code that was using bare unsigned to use unsigned int

Signed-off-by: Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
---
 drivers/usb/musb/musb_gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 3cb7fc4c84ed..8912118883dc 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -521,7 +521,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	struct usb_request	*request = &req->request;
 	struct musb_ep		*musb_ep;
 	void __iomem		*epio = musb->endpoints[epnum].regs;
-	unsigned		len = 0;
+	unsigned int		len = 0;
 	u16			fifo_count;
 	u16			csr = musb_readw(epio, MUSB_RXCSR);
 	struct musb_hw_ep	*hw_ep = &musb->endpoints[epnum];
-- 
2.40.1

