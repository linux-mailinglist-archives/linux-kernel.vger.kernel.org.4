Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EC96C4E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjCVOzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjCVOzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:55:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496DA3AA6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:54:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h17so17358248wrt.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679496876;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pX52XM0zRvUzVxvJJ0vn8RkPlcGXAVjIMg1ZZMuVw6A=;
        b=EqJVSA+xNvSC9aOZxnb40FR82uDcF+8Oj9rB3jgYZp+vaPQxRzWvXCU74/i0cCEcKN
         3cbSIA1r2CRpbKrIzSDGrSxzl2hXhBoLggzqBD5ypEkSSg0pa2qj+Jm/6EZYiWeNQFD5
         fULQ8GSCwnkm9dh87GcMj0vNq+jsdIPlAiRjAHQ1oI6OUh2kIG5W0ThE6DQv2ZcdjC7O
         75NRcHruEgJdMVPjrS+L04qEMjmvlYMGPsc3xV1ZnHFj6RAjyoRDai+FzZySbUZtrLQb
         fRmy7cgqdhpYqPiBD4n7o2SxAUFNVh8CgoQMUWqAfJ97LMjOFpHJntjJetRSP8r4fla6
         Fy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679496876;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pX52XM0zRvUzVxvJJ0vn8RkPlcGXAVjIMg1ZZMuVw6A=;
        b=1+9eCjQW8/e+xW/shtONl5LX6V1lxqIh9CXFaMwVnhUjI6yXCK13fycx1AtHbCy3Hh
         GJ8nPpyl5zu7Yen1wWvb5ZZ7TI5mOmO8RJ/Wb0d1vZHVCxqZ6T9br276UYRDxs0rMuo/
         GVQH/mJ+tDYB+IjumFgZdCgzSE9xvAWESbTbGElkJNhAtr5NI8h2DrJDDJPLEWAzNTsl
         sD7J7unBu7pMdAeWPzZ7LT0+ayVZYtZbK1ES9YSvlqbWlM5HPFnHqF1by2GOSYp+P1wU
         /kgFQbTz351BfPkcn/XP8VwWOwCN12Q7P5wnKpEhLEojlBw1ZGBg/XlDVMUr7StmYuWn
         EHrg==
X-Gm-Message-State: AAQBX9cwj2c/NpuwlVIZnx6C1bXKB1gPmrHGmpvELV2f1GleFJWQoUaO
        jg8YdUEaQjkWI6oWfHWJiUn1iUhrm9Aq2I/Y
X-Google-Smtp-Source: AKy350bSRC+Dd6x/j8rAOkZ9rZcq8qbU0nauUKFSCJzSivumQ/SBuHylXSGyA2TzZeCPpSe07wBftA==
X-Received: by 2002:adf:ce01:0:b0:2cf:ec6c:f253 with SMTP id p1-20020adfce01000000b002cfec6cf253mr75143wrn.20.1679496876462;
        Wed, 22 Mar 2023 07:54:36 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id c15-20020adffb0f000000b002c6e8cb612fsm13946440wrr.92.2023.03.22.07.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:54:36 -0700 (PDT)
Date:   Wed, 22 Mar 2023 19:54:33 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: most: fix line ending with '('
Message-ID: <ZBsWqT8lLAW383RG@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting function header to multiple lines because of 80 characters per
line limit, results in ending the function call line with '('.
This leads to CHECK reported by checkpatch.pl

Move the function parameters right after the '(' in the function call
line.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/most/video/video.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index ffa97ef21ea5..6254a5df2502 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -365,8 +365,7 @@ static const struct video_device comp_videodev_template = {

 /**************************************************************************/

-static struct most_video_dev *get_comp_dev(
-	struct most_interface *iface, int channel_idx)
+static struct most_video_dev *get_comp_dev(struct most_interface *iface, int channel_idx)
 {
 	struct most_video_dev *mdev;
 	unsigned long flags;
--
2.34.1

