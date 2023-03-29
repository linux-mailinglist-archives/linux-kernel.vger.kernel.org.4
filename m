Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C40E6CCECC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 02:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjC2AaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 20:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC2AaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 20:30:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AD310EB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 17:30:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d13so12536548pjh.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 17:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680049800;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dDXDEKaPWyjVmYBq6F6y1pBkqb1wubgYG9yZaDIb+g=;
        b=n/dED3HhgTrJKd3HcAlbmgd4LrtzSNSBwSm0od/SyON23+Lnljpcpvvapng6VaQfQD
         cbpoxln89/Q86WDDVn9xDJvNlyMQtj/AQcx02+tTdlI+7hEnr82LhTGzSWkq2mZZKsiq
         nwUNgErJh2JOPAi7x9shhNWf/ywg62wkDl1tJ8yf8knm8uS7RgWn53+7pqyhnX2MbIqA
         XVKlMxZesro4ubZ68NyYaIdX3ctBLbWRmG5TU9EFnH2F8MzctGDnhZpLe8fVd1D1rdip
         8zqv1ZOqngLzUAVVHEpbmPwuewKjZ8T/1uc+uWoo0VWGCtS/4CO7rI4josyzoE/7R6Vc
         un3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680049800;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dDXDEKaPWyjVmYBq6F6y1pBkqb1wubgYG9yZaDIb+g=;
        b=gSWVVWdVHobz64Qk5iatZKI4lEjMWr/pMVAUqZGZmzCDN8VyuIPXUu+NraJE7RZQWE
         9hainZTstalkO2PZy+Ta8chaddPzar3Y57DWjoDBQLHWIMX0CPtMUwN1w+QpEIFxWk14
         vDaXVgqHFdy58CFTXmI5H4161bws+2kv7f7yaH2SkM1DRWMsw+sW14ltGbHyVSkcAqBZ
         B1zLXCL1JmnJpl0pZqFHu785LUh0SF3JGjyKRRf8ZZFv2CgK8x6rwKPU7kLcxFuIN6P5
         3Vq7Wc6xPiuDYnzR2ega5s7Pyx9D7IgNsJ1SAxGfOOR3YxHpDN4ANMjJtm7LE+7HXSuw
         ST0g==
X-Gm-Message-State: AAQBX9evXzBRtfpbPWhKpxaORolvh/jAmTDDu1rYLfKxyF3quZ/v/in7
        i4peRGJ3Uy0RxFIxpmQib/HLQ+TPZlU=
X-Google-Smtp-Source: AKy350bCmesSDRvdPkjekz+Z3jVn5m2WxHssAzk9i+O2Fcen0QNNUL/BxQEowyaU/VBhRJ13Yfd+SQ==
X-Received: by 2002:a17:902:fb4b:b0:1a1:924d:19f6 with SMTP id lf11-20020a170902fb4b00b001a1924d19f6mr14778667plb.66.1680049800637;
        Tue, 28 Mar 2023 17:30:00 -0700 (PDT)
Received: from trent-reznor ([2601:641:4000:81:6dd2:ac8f:513b:947b])
        by smtp.gmail.com with ESMTPSA id jl17-20020a170903135100b001a1d41d1b8asm16668689plb.194.2023.03.28.17.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 17:30:00 -0700 (PDT)
Date:   Tue, 28 Mar 2023 17:29:58 -0700
From:   Daniel Watson <ozzloy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: conform if's braces to kernel style
Message-ID: <ZCOGhkLvLtBEo92Y@trent-reznor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the open brace of if-statements to the same line. This matches the
brace placement style described in the kernel's style guide.

Signed-off-by: Daniel Watson <ozzloy@gmail.com>
---
v1 -> v2:
  - explicitly state in body that patch moves curly brackets
  - provide consistency reasoning (not just for checkpatch)

 drivers/staging/rtl8723bs/include/rtw_recv.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index 44f67103503ae..fef2fd0e8c84f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -398,8 +398,7 @@ static inline u8 *recvframe_pull(union recv_frame *precvframe, signed int sz)
 
 	precvframe->u.hdr.rx_data += sz;
 
-	if (precvframe->u.hdr.rx_data > precvframe->u.hdr.rx_tail)
-	{
+	if (precvframe->u.hdr.rx_data > precvframe->u.hdr.rx_tail) {
 		precvframe->u.hdr.rx_data -= sz;
 		return NULL;
 	}
@@ -425,8 +424,7 @@ static inline u8 *recvframe_put(union recv_frame *precvframe, signed int sz)
 
 	precvframe->u.hdr.rx_tail += sz;
 
-	if (precvframe->u.hdr.rx_tail > precvframe->u.hdr.rx_end)
-	{
+	if (precvframe->u.hdr.rx_tail > precvframe->u.hdr.rx_end) {
 		precvframe->u.hdr.rx_tail = prev_rx_tail;
 		return NULL;
 	}
@@ -451,8 +449,7 @@ static inline u8 *recvframe_pull_tail(union recv_frame *precvframe, signed int s
 
 	precvframe->u.hdr.rx_tail -= sz;
 
-	if (precvframe->u.hdr.rx_tail < precvframe->u.hdr.rx_data)
-	{
+	if (precvframe->u.hdr.rx_tail < precvframe->u.hdr.rx_data) {
 		precvframe->u.hdr.rx_tail += sz;
 		return NULL;
 	}
-- 
2.34.1

