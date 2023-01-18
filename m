Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6516728E1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjARUAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjART74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:59:56 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132775DC06
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:59:41 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m15so4345354wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NYfo4Xpw6lpycKMEhYHoVi36pIyA/1Ab3iBuTU5Cfmo=;
        b=OVXRq0MmA06K/0ZYWZm3e8LPfxuWQYN9ICf/jRJXE4zxyTOsHUBSrZ1vuBMso4YsHk
         FnogUQw0oLDCrhSdkrecrL5kofti5+mGTMFiqZ9D+sRp6dz+3knaF4E63Yp3Rs6GbMfg
         /wwmKWKYC0XH8xeRplMGLvl5kzDiKfqlkQuQeFdEL99V8btbGJTPJRKt54nP76XebRN/
         swK3kwT5GRWMBzXIyrCGzvxjlb8rjzDnqrq44lL1OrQfiRozVSnADBHcCJ9YWA68HLkZ
         dPujkWb3OVP/CO/0azHWZj8lrCSNrtxgz3o+m7NyvgRzCpDDtUP1TPvxBBvEuZEX3TPn
         CYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYfo4Xpw6lpycKMEhYHoVi36pIyA/1Ab3iBuTU5Cfmo=;
        b=EfsO2Jbg9OkJ27Ty+CO7i+izNR794uHGf57m2e35UrRxNF3qEUBRqwzQFxwk3oholQ
         BJvWRWVSlDTnt6pBHjBq6dAVqq/q0m1lUMkxM8AX67KJrXUbM3zqXBQ9JC2oWoQp78a+
         ypB6mAApWz53eMKfBP9sDN3nn+H2CkURYs+knKt0j1KyjKH6fpyhIUmK55FStEGGMXyr
         aqNNZ5UMmoa1nzmeY0o6IJNce3rLsmlc4HmTla9HD3m/wjUOdThfHV7Qxb3E1xmkoEhJ
         yJOqiO//vYBxHRGU3wwvAjZUIiR9VCwoC6BRhT4WXDmm6laX4+Ln6MOekRjRmUtznWrB
         qhUw==
X-Gm-Message-State: AFqh2krNLr7Bap3svmQ4kNY/3oYVj/wT3lErZcpa+dlloYVUvFe6rXOv
        etgqEDEQL0dcIHGdlGmG7EGAITLY+1Q=
X-Google-Smtp-Source: AMrXdXvHujm+t4eqyjK/849EKHpEzlO0ff+LRyvNKYQYAngMEyhG1C5J6C2tAAvpUuu3jCaenP5e3g==
X-Received: by 2002:a05:600c:3b29:b0:3da:f7a9:50ca with SMTP id m41-20020a05600c3b2900b003daf7a950camr2017219wms.0.1674071979519;
        Wed, 18 Jan 2023 11:59:39 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id h1-20020a05600c350100b003d990372dd5sm2986508wmq.20.2023.01.18.11.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 11:59:39 -0800 (PST)
Date:   Wed, 18 Jan 2023 20:59:37 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] staging: rtl8192e: Remove unused variable H2CTxCmdSeq
Message-ID: <3e6da78dff15cb5e5e26450d8e3f23e2e10ce61f.1674071236.git.philipp.g.hortmann@gmail.com>
References: <cover.1674071236.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674071236.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H2CTxCmdSeq is never used. Remove resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index e90cc61b3817..12a869a556bb 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -525,8 +525,6 @@ struct r8192_priv {
 	bool		force_lps;
 
 	bool		chan_forced;
-
-	u8		H2CTxCmdSeq;
 };
 
 extern const struct ethtool_ops rtl819x_ethtool_ops;
-- 
2.39.0

