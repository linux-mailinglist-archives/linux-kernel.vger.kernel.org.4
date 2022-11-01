Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA97614808
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiKAK5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiKAK5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:57:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A69819281
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 03:57:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y14so36048503ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 03:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MzqF9B0T/NfF3Y4vRqndF5M9IfCaL8dvD7GSKzyTcP8=;
        b=lQGDwX/mWuxEUr0j4yMjkVoxpOFzdmm9g1Sds8p+12S6LSzemeZIlDx96T/pzJgZws
         otH531H7MNRSIYOaMAJQGEn4AaAn0OAg3BLD/bdvAILXP79FRy3qpeCXqULMs0lyZUtt
         cVP+8vQOwsLGNLoQgF5g5245kxFB0uAAeIHw4bb1KDxbB3ALNJwBrCs+DZqRgaOtxhKm
         LryB8E4YQfIOhD2IJCwsZEYrXGLpoGenJvhpxch/+NPwTbBQwInV8xxIoAOwKmWwPKSY
         5QtB9kZA5Ghzgx6X9KUcUzYqnde4yEpKX4TaPWJsMmIk2146abylK5y80KLEdTeX351K
         AVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzqF9B0T/NfF3Y4vRqndF5M9IfCaL8dvD7GSKzyTcP8=;
        b=FzseXR7Vg2hYZt4XIUXyW/vg9S/g5iXmOux2wduNglaKnvbIQnnX5P7Vub+QoQzn49
         6Q5qa0h0YwgI/z5MOUsvdYrmspCukXwDrn3oq65quw425E8xjpk1rH1QBvhtxZJBfLJA
         gMEsnoEcztot0Keh4scDhdA3m/wIrztF7auWADFiFYZV0OW/eQCoqHvM/xc3kgaozYqp
         aes//kDoCO4rPOEPlC8A8BfSAddnwpmQdYse3Flayo625CB5DBWZ+BAwktWEx1Xn3zcK
         67rwsCZRa9PBI1YztAHnxFPF5GSomuHDJCvAsMlmGoylb5ws3bLYekJwXnLCfykqBV+q
         +Q7Q==
X-Gm-Message-State: ACrzQf34W22TwxlP8fnxDqLEDTjYqi2Fn7g5TevgnB7bIiFcn0PNgkq8
        Fd2iJjVdoKwA7+6aLdApp0wPqUC2d+DTPbbt
X-Google-Smtp-Source: AMsMyM5TlyWQMlfm4DDf8XjillnEJmZCm2eqgKjjRdzFp6MIN+0BwxHVhyeClBW4dYDu1dWcQ7SUyQ==
X-Received: by 2002:a17:907:7f02:b0:73d:dffa:57b3 with SMTP id qf2-20020a1709077f0200b0073ddffa57b3mr18307043ejc.19.1667300253693;
        Tue, 01 Nov 2022 03:57:33 -0700 (PDT)
Received: from rdm ([137.63.146.164])
        by smtp.gmail.com with ESMTPSA id p3-20020a17090653c300b007adf2e4c6f7sm368781ejo.195.2022.11.01.03.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 03:57:33 -0700 (PDT)
Date:   Tue, 1 Nov 2022 13:57:27 +0300
From:   UMWARI JOVIAL <umwarijovial@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [RESEND PATCH v3] staging: most: dim2: hal: aligning function
 parameters
Message-ID: <20221101105727.GA162791@rdm>
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

To improve readability, start the list of
function parameters on the same line as the function name.
Issue reported by checkpatch.

Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
---

Changes in v3:
    1.Updated the commit message to well explain the  changes made 

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

