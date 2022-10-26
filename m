Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8381460DF15
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiJZK4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiJZK4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:56:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DCF62A45
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 03:56:22 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 21so6813084edv.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 03:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8fw059w/DKGSzGISpKiD55jlFKGFxUmcqcrxLcKoWk=;
        b=CLEyjBFayA83BBqUPHPVD2k/po+HkWh80ebuuSYJmU6QuV0NfDstV9jg4d+d3EgyME
         WApB62DSAgaDijYteIBvDCaxHE8heH4IGMqAJiheySzR77fbZWNpBVeAWv04GbJUdnAV
         /RfIbn1PNj7MREkpjGK8I0wpN3Ymy+M0JIRrNPsnFEPqOAi+y8MIQaOy/+cbcrs7/d/0
         gdMzMiKZWy4llAsPQeQthS+0qlJhhYbR7S7r5eIMLYFwtVAItFWAfKU8PTwU7EvC/ouO
         ZJmGUlIxj9lV1LIKH3ZSp1nqWKEO2+pt/iuQlsGsIoz5YADu3ZplTV5uBJRuej9VJZLQ
         ue7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8fw059w/DKGSzGISpKiD55jlFKGFxUmcqcrxLcKoWk=;
        b=HcvhwCOXOwTBfvioUOuwsJjwoy1iSGhFRCVx5yaWlavVofFpLNmfnSH1z99YM7qoO1
         uWCauXyTnHLFO8t0wmgkGdpPMj9Xwl03GmnORZal0dQSdpXTIZcPHazC18HfcEt2XIBV
         S9edjSNvu628XUK4rrqbtoVHYTBPl3cjSw+vkRHMowNyjwYujy5GsTxaKXjeEwtQEj5V
         v4UA35/31GSZUlJ4LwIgGqSYtMP+N+vR6UckncfyzbGq8O/P5DnwSO7yYvycd7J+g0JP
         S+72Lz9a8Nq3QU8hD2w6yOBdrrLUR7lQVCVYFA5oQZcbBpCA1UhzNOPhtH+ejGmaLf83
         s+XQ==
X-Gm-Message-State: ACrzQf2fhW6RblUC29P5lmBxTOb+iy/p2BUS4mBFC2BRy76Gt6DqR1rA
        W5iS/JmLC9KyuoKII5VZkIrqep2PEfvcPCi3
X-Google-Smtp-Source: AMsMyM6/tZmI5E8Yt3bmfs3zBrVnzh4DNNGgxvX1Cffob+Gfq9EdJtZbqag9MZprSWpOTwc0dIBVuA==
X-Received: by 2002:aa7:c14b:0:b0:461:c47d:48cf with SMTP id r11-20020aa7c14b000000b00461c47d48cfmr14101576edp.83.1666781781005;
        Wed, 26 Oct 2022 03:56:21 -0700 (PDT)
Received: from rdm ([41.75.188.39])
        by smtp.gmail.com with ESMTPSA id g8-20020aa7d1c8000000b004589da5e5cesm3265597edp.41.2022.10.26.03.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 03:56:20 -0700 (PDT)
Date:   Wed, 26 Oct 2022 13:56:11 +0300
From:   UMWARI JOVIAL <umwarijovial@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Outreachy Linux <outreachy@lists.linux.dev>
Subject: [PATCH] staging: most: dim2: hal: aligning function parameters
Message-ID: <20221026105611.GA37633@rdm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Linux Kernel Coding Style, lines should not end with a '('
Fix-issue reported by checkpatch.pl script.

Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
---
 drivers/staging/most/dim2/hal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/dim2/hal.c b/drivers/staging/most/dim2/hal.c
index a5d40b5b138a..6abe3ab2b2cf 100644
--- a/drivers/staging/most/dim2/hal.c
+++ b/drivers/staging/most/dim2/hal.c
@@ -346,9 +346,8 @@ static void dim2_clear_ctram(void)
 		dim2_clear_ctr(ctr_addr);
 }
 
-static void dim2_configure_channel(
-	u8 ch_addr, u8 type, u8 is_tx, u16 dbr_address, u16 hw_buffer_size,
-	u16 packet_length)
+static void dim2_configure_channel(u8 ch_addr, u8 type, u8 is_tx, u16 dbr_address,
+				   u16 hw_buffer_size, u16 packet_length)
 {
 	dim2_configure_cdt(ch_addr, dbr_address, hw_buffer_size, packet_length);
 	dim2_configure_cat(MLB_CAT, ch_addr, type, is_tx ? 1 : 0);
-- 
2.25.1

