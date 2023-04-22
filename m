Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72746EBA2B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 18:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjDVQFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 12:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDVQFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 12:05:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E811736;
        Sat, 22 Apr 2023 09:05:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94a34d3812cso487568066b.2;
        Sat, 22 Apr 2023 09:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682179534; x=1684771534;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYcLnekjQPJfJ02gPVa4lLw0GXPBlTFUVleo72kNbmQ=;
        b=Ex1DQNWtLbC8EIw3ECbYiwwQqtKMPAF9oiISSRsHGQHP5vP3kp8Xf2/Qz23x6h6/jV
         dYj7ttGXlBTDsrLEKpJ+44XoKG3qQvb1pOHL15PklP+WAEdKVnBjTK1y5ARoohy3x5aA
         pR+NOJTwlE+rP7JSDxpfqUdurh2U5xtJqMbsMxIKPpOj717JDqBiIYLvY5bDmls1HIri
         0pKROrfVs112el3O9jeoKfHwCVpgVPRso+oc89qz3//MhaZk4yen4Ne1I1DDRHq2tGhQ
         gssJyDlolluSayrC9rlP52tMjlkrl+RQyGLyqyWxfshMsQeMp3FTJ0lSemuk77kr9fRM
         yPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682179534; x=1684771534;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYcLnekjQPJfJ02gPVa4lLw0GXPBlTFUVleo72kNbmQ=;
        b=HGW9Js5FG0j3REOgqakFWW7DJXv7oR8UyC6SktGzrMH//D/do86Q7AK+a6UitD0t45
         G43Q/l8Aptmqi0KWyOsr5R0iX86K52mUePc16vcb8HU1BqeipQW77OW7qkMQccSa/Nmh
         WTUID9LE1Sm+JUAwO9+l7jR7UNZOFUp0t//5knKm80Be0IWOf2VQfhvlqZsNeX5akvxX
         Ir9fPeqH2pP0sPXyPulnpCsSRFElbskXkH65JMoma3m/TixXAXc5PaM/PPN2v1r6xgc1
         d3wJEshm9kLOv6uRw297ZW8bRw2w71OKOiaIob0PXQH7D+Wsqxar7UI3SU2nvfjAqGsZ
         vSTQ==
X-Gm-Message-State: AAQBX9dLLtRmVkx+TzmV5uKBKBKfrZiQplZb+ITLKX81pq/3upnN0VrY
        xeiH8mAMbfUyaLIuc4vdyutKSUC9zs4=
X-Google-Smtp-Source: AKy350bpK4Rxqbj+q8j3pPhMzYKge7G6gWFKtcpEtm9PtB4Aid8BhygHyj6iBdwLZ2e0kPeqqwWH3A==
X-Received: by 2002:a17:906:ca2:b0:931:1e69:e1da with SMTP id k2-20020a1709060ca200b009311e69e1damr5476912ejh.7.1682179534117;
        Sat, 22 Apr 2023 09:05:34 -0700 (PDT)
Received: from jo-einhundert ([2a02:908:13d6:2180:1b01:a567:fcb4:e356])
        by smtp.gmail.com with ESMTPSA id jo2-20020a170906f6c200b009538cc79241sm3428272ejb.56.2023.04.22.09.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 09:05:33 -0700 (PDT)
Date:   Sat, 22 Apr 2023 18:05:32 +0200
From:   =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>, Greg KH <greg@kroah.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: gadget: drop superfluous ':' in doc string
Message-ID: <ZEQFzMntIrwvZl4+@jo-einhundert>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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

There was one superfluous ':' that kernel-doc complained about.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/all/c718a490-028d-2682-9ad7-8256d16504bf@infradead.org/
Fixes: fb6211f1584a ("usb: gadget: add doc to struct usb_composite_dev")
Signed-off-by: Jó Ágila Bitsch <jgilab@gmail.com>
---
 include/linux/usb/composite.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index a2448e98854f..07531c4f4350 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -443,7 +443,7 @@ static inline struct usb_composite_driver *to_cdriver(
  * @bcd_webusb_version: 0x0100 by default, WebUSB specification version
  * @b_webusb_vendor_code: 0x0 by default, vendor code for WebUSB
  * @landing_page: empty by default, landing page to announce in WebUSB
- * @use_webusb:: false by default, interested gadgets set it
+ * @use_webusb: false by default, interested gadgets set it
  * @os_desc_config: the configuration to be used with OS descriptors
  * @setup_pending: true when setup request is queued but not completed
  * @os_desc_pending: true when os_desc request is queued but not completed
-- 
2.39.2

