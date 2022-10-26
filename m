Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A52C60DF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiJZLGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiJZLGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:06:32 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA243C4591
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:06:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k8so17057623wrh.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8fw059w/DKGSzGISpKiD55jlFKGFxUmcqcrxLcKoWk=;
        b=L5rHIBQ3/dPpSeWOe9aN4GAPujJGcy+UIpAjXeVt+wCcGjILATyaGSYM5c7NpfVYIz
         KLhqOwdpJiJv5/Ys8yn+8p6C+KA2rTVjT8W3/FL+NuGNRk2X5mc4AX8cYrSvPbpGAqIY
         xnFClyAhyW97mvY2bgfoKJFCwzasqIEmLIOzHCDCQx8sULd7DYFgKb6qG5x32IaHMYOn
         O5fOhl6/7fTjnb/JMuRtIqWoXlemHQ2SaQE3ou0Em+YJTKPj01HxZKpSckHFoL8xWz+3
         p2JRuEeT1PYkK3lm5CDTjWN2WI1EsOeFBUjuPP/t8SMops1975KMa8eo+bp/uxnYyQAn
         Gwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8fw059w/DKGSzGISpKiD55jlFKGFxUmcqcrxLcKoWk=;
        b=L718un5K8s3aVS3nXCpGEGAEgNS5Kg/6IRnkKLBhOsOeEfcHYV3qGqiZU+HztJ80cd
         pBaAcXgvWQjTSKLmvyusfEsLgtkzXTva2kf+7MmqBRvwFlWHs2G5up6dskw5bSxwl+fh
         LFP/7hl0RsQuCmKo+rVdpr/TZ2fJaijFG1BB9imHVo64wjioe7SUWQwrZsNFTF8qlhSp
         YRBe3h4Z/WGnUSjM4U5mPbeNQVk6MXvaFHh5qIs9PJk5yatUkkWSnfQu9LGmso/ZZDMl
         xiRhSjMxyfhSUCs5iZ6hd2WYlYO6uNfvxFFzx0oalg1adEyI4bKx1RhWjFu9eVMIIeRn
         pDhw==
X-Gm-Message-State: ACrzQf3EBvCt6qlCIeeYHGMim0i3bTqq2rRlHUlgdg0T1OTafbVTjJql
        NKr6io7a/TVnCpJ3cwhQ2V9fYtv21c5J5ucU
X-Google-Smtp-Source: AMsMyM7oPIoIE/u7ZKsOay8p997qZyK/s4D5Ay9/yVEXL2Ya6jVDAv7Jo9S6B8DaLvpudGyjSiU2mA==
X-Received: by 2002:a05:6000:1ace:b0:22f:7201:74c0 with SMTP id i14-20020a0560001ace00b0022f720174c0mr28767128wry.216.1666782380391;
        Wed, 26 Oct 2022 04:06:20 -0700 (PDT)
Received: from rdm ([41.75.188.129])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d688e000000b0023660f6cecfsm4867344wru.80.2022.10.26.04.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:06:20 -0700 (PDT)
Date:   Wed, 26 Oct 2022 14:06:07 +0300
From:   UMWARI JOVIAL <umwarijovial@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: most: dim2: hal: aligning function parameters
Message-ID: <20221026110607.GA37960@rdm>
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

