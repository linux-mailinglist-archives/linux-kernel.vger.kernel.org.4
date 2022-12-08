Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4E5646D7B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiLHKr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiLHKq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:46:27 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B107F8B2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:42:10 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g10so1116944plo.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CODFi1ANb1ySAO16p5Asfj1qvIextX70iiopA8xy4QM=;
        b=CexMx3cAR3NK1djvohOjT/FiOSMyLd2oWvWfola5CCDoFSckIdOoEgQnEEG0XJ99A4
         3tdB4UzZt874HqMzkkii2Ktk/9ACdHbn1/xT2ZgcHDc9dyqGjoeHV3q7IYB9OcoEFBX+
         BPZ3wnmUvTxg5HTExwkZkTBChBeuKH/pfVONml8ymyUOqJrqOpxNDp+k50/4uq8QEIYG
         u88ZLwVk6bQ7Ih1PUhKQiaJ/vWpP7HQMI3sYg4DUX0lEt8++YCBUkNM8yzUdRnXZgGC8
         295hOcouV0k/xP5NWhcMc02iFbVzgVH3rCqjQDa4wb3OzKKsB22qnClbEciMbsXlJi+t
         teag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CODFi1ANb1ySAO16p5Asfj1qvIextX70iiopA8xy4QM=;
        b=QoAmi8j4oeK3XZ9dN57cj9oOsnT2dqB+Jk5Csg4hLFPqpU0+CIdzwLp+PZ3zx6kVOG
         L5r6inyuKPz6bJm30ZAHYkoG+fHNGuyscFfiHtOJL2wRTqRvw+Oy8jHlnFI/btI/9QxG
         Nt8EhfIvB8Nc3pnbqsQHk5znEs/R3dgh4EdTFJR5+OoekxvZp3UkrbOGlDR4WZcpoONz
         FVSb2BEAF3qxXXmp4SnYsW54IS+YWA96uYncE77NZ9fcYtkj5aNVYS6nqXfhejPrWZxM
         N002xKRJuHtCnapvFrAdnDKzwh9yNHP/Ya9109upVqIyCHoEhOk7OCRmuzikXb0uxcKx
         1v0w==
X-Gm-Message-State: ANoB5pk2PedSqhff4YJ0A5toGrSL8fC7fvHne9niBL/ojLL8MJAS4yNJ
        14Q5kpNKCC6iP7s1c/q1h84=
X-Google-Smtp-Source: AA0mqf6/Tai4V1iD72eI7S7emTTCgEWoBIfqaMaGvnBNsCgXMyVGbQ24XlVkPT20eybFFxVn4DZW4A==
X-Received: by 2002:a17:90a:6382:b0:219:fbc:a088 with SMTP id f2-20020a17090a638200b002190fbca088mr64077086pjj.162.1670496130179;
        Thu, 08 Dec 2022 02:42:10 -0800 (PST)
Received: from zoo868e (1-170-0-91.dynamic-ip.hinet.net. [1.170.0.91])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f54b00b00177faf558b5sm16298205plf.250.2022.12.08.02.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 02:42:09 -0800 (PST)
Date:   Thu, 8 Dec 2022 18:42:08 +0800
From:   Matt Jan <zoo868e@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 3/3] staging: vme_user: replace 'unsigned' with 'unsigned
 int'
Message-ID: <20221208104208.GA100388@zoo868e>
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
index 5da2643e20d5..11df0a5e7f7b 100644
--- a/drivers/staging/vme_user/vme_bridge.h
+++ b/drivers/staging/vme_user/vme_bridge.h
@@ -84,7 +84,7 @@ struct vme_error_handler {
 	unsigned long long end;		/* End of error window */
 	unsigned long long first_error;	/* Address of the first error */
 	u32 aspace;			/* Address space of error window*/
-	unsigned num_errors;		/* Number of errors */
+	unsigned int num_errors;	/* Number of errors */
 };
 
 struct vme_callback {
-- 
2.25.1
v2: Resend the correct patch set, noted by Greg Kroah-Hartmamn <gregkh@linuxfoundation.org>
	Align the comment correctly, noted by Dan Carpenter <error27@gmail.com>
