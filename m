Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3733A6CB842
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjC1Hfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjC1HfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:35:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB3E44B6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:34:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id kq3so10801644plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679988872;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74FtOghNrSOXlcsn5kCzAXgL3eR9Qjcb90tsTUubXFs=;
        b=LjpJwEAUIyoScr71Dd9QqoZ9v+7nFWU0SWT8gGgNLm0Q2xEx6jk3sVQpYX9a4LxEXI
         fcs95LsdjCcf9PxEhuxKQ2Ux4FHAbeb/7mP6tD3HZm6lsvDc/jzfC24035h+NrK2bNAb
         lmdGlJ8G6WpS5uRBoyMkr7EwsEnkabRzYxHGN+g/eJDP1ENEDGq6XD4pHXcEtFwM5QH+
         k8lihjsW6QNKswPATkG3OOpzs9NWAFljyN0gFW0Nx4y/v4CYVPzEI5Qjw31qZeIRjJHT
         MI8l1sl3XjTw+BdfWfF1H5MIkF3GzjewjyOq1DBmBcFWsCR6sQUD8O4pAMANKyBoPu9t
         iJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679988872;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74FtOghNrSOXlcsn5kCzAXgL3eR9Qjcb90tsTUubXFs=;
        b=TpeyrTLZI+4y1qXhelz03vstwuabkMpkwtwlPe4S3lVgfH34yjVArBb53i/jKragNJ
         MJyG1pQ+WEMMEXxhzcFp5RZMTlbZhK+7JLekkgXWEF6Ded+m+yO34xDCJWfhwK/9WO5V
         Aommk96G+Tzp6kdt0gUkr+4+uZ10DdwPAlMPOz1e3u8/FfdWA7R31K1v2Lv8LrpAkZWk
         LmfKVxQEqHel2z7L/isf5jIIikQXFijoyluVr5a2rz8N9fu9YfZbrxLaiAsfHq2yTXba
         xZ3I5KZ4aU+Kd5kqLnHEb4xbS4EpojEuOHXSV+cBgljGRmwU5eCnenS4w+XtrUhjAYxN
         1SYw==
X-Gm-Message-State: AAQBX9dRMnZKbWP0dd7naXSZQxBGY6VA/Q5YOp78wkOtKOrsokxL3fP2
        6olfhfKf8126jn23+Xhn1pcoKYLoc64=
X-Google-Smtp-Source: AKy350bsIvk5vENGCQauLzCQa8qbHe1+rPia+gx1rzsNB2dCkEpvwxKtnbHxtgJ5BdgoI1BmXIFWQw==
X-Received: by 2002:a17:90a:4fc2:b0:23d:4242:a7a5 with SMTP id q60-20020a17090a4fc200b0023d4242a7a5mr16518173pjh.47.1679988871799;
        Tue, 28 Mar 2023 00:34:31 -0700 (PDT)
Received: from trent-reznor ([2601:641:4000:81:94c0:86ec:d844:1f3f])
        by smtp.gmail.com with ESMTPSA id t16-20020a17090ad15000b002339195a47bsm5438626pjw.53.2023.03.28.00.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 00:34:31 -0700 (PDT)
Date:   Tue, 28 Mar 2023 00:34:29 -0700
From:   Daniel Watson <ozzloy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: move open curly to first line of if
Message-ID: <ZCKYhfonZN36ZHjG@trent-reznor>
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

Checkpatch flagged this as a fixable style error.

Signed-off-by: Daniel Watson <ozzloy@gmail.com>
---
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

