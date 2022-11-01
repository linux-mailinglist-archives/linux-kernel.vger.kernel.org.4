Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED746144A7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 07:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiKAG0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 02:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKAG0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 02:26:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6897B16587
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:26:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so17970807pjk.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmtzlJtofIdyT91pfPGIdJT3CouMXo21i2AbO1DpQkE=;
        b=Q3ObJHWoSQyQnVhBa7/0d2PopodKZvFO0jqSSwZr+4UueRCxWev/G/wIkRLDcgQ4Pu
         eXnUcskEwJRBnx+4sZLGmqVdE9nZt9LqXeUF2uGLPCfXA3TNMrT5mqOzCNfkKSL0sjdg
         fqJa05T/3PfJxdsIJt3r1G76i+EBnTjltpJiE4H0nwnlUEtBPE36KzToyYucjvp1C0lx
         EQcVflp5291JLQPyK9cOZRDnXn2B9TiasbjVp4YsWuYY6ggKmhT6AWqcFjHR7DLOIbMd
         AqdD17rU25IVRitJnDPvkmO3Lx0lg9iKx84C4hznaUoiITGs4vtRsWiF69C6WW1QDcbr
         DtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmtzlJtofIdyT91pfPGIdJT3CouMXo21i2AbO1DpQkE=;
        b=uV75vMNm9HbAtpm4css1i7ft+BzkypmWLQgOkH4zOd2qnMLYPZFQ+0zt/Iq7BieWgg
         Z3T00E5HsTpMU0spUZgt5Qyr47BD8WuYOg/PuRVqDUiED8/gZVUm/JEIqDC65Qf9K2Z4
         Mp6SU3Vqzh9O3Y5C190tdynqOcb4T0cJh6xVhHgjMOuJNNipNM/tcslAXqZ3ASIbbqvf
         JKA3KQkxbtjnvB1t1jHcoSBq0oQf3w1Gs4mRMt2R0y5F9GYs9h31AEPnJSv1wbLPVZdl
         XsJPkWn/QBhygYL/tTAihlcW9psfj5l9IqoxhBi7qkKm/mBB1Cxt0EI0f7oG332LN+L5
         EZ+w==
X-Gm-Message-State: ACrzQf2a6ww/TyCoWBoi68Yt/VxL5wnX9vIEPWtxFEI2oXT5Sz6wvFy3
        k6uD8cgmt68TB5c3ERKxvPc=
X-Google-Smtp-Source: AMsMyM7v/qFUuD2ZpJ/6Dk3ddoWdOKrqjZRuA7qPaHuyL/UJHX2S4us9Ej1r+CzMc/+5BrfNKS7CSA==
X-Received: by 2002:a17:90a:d901:b0:213:dc98:8b0d with SMTP id c1-20020a17090ad90100b00213dc988b0dmr10345145pjv.11.1667284000883;
        Mon, 31 Oct 2022 23:26:40 -0700 (PDT)
Received: from ubuntu ([218.237.158.230])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7988b000000b0056babe4fb8asm5660439pfl.49.2022.10.31.23.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 23:26:40 -0700 (PDT)
Date:   Tue, 1 Nov 2022 15:26:36 +0900
From:   Gabhyun Kim <kimgaby415@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8192e: Remove line breaks to match coding
 style
Message-ID: <20221101062636.GA3257@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant line break in function definition to
correct coding style.

Signed-off-by: Gabhyun Kim <kimgaby415@gmail.com>
---
Changes in v2:
 -only one logical type of change per patch

 drivers/staging/rtl8192e/rtllib_softmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 1a3ca3e57623..1253de481805 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -148,8 +148,7 @@ static void init_mgmt_queue(struct rtllib_device *ieee)
 }
 
 
-u8
-MgntQuery_TxRateExcludeCCKRates(struct rtllib_device *ieee)
+u8 MgntQuery_TxRateExcludeCCKRates(struct rtllib_device *ieee)
 {
 	u16	i;
 	u8	QueryRate = 0;
-- 
2.25.1

