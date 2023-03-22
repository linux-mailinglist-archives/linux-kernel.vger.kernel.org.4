Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999AA6C4ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjCVPB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjCVPB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:01:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8E643924
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:01:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n19so1492202wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679497315;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DgWPl66ZYekMljnHqI2dpfEQRj570j4dEOn6iVgr8Vk=;
        b=W+Oxrjx5FFH0z4MVlegTDfz7IZ+yko7Mg54TEmXyYH2w3I3HP62l+Q/x5B7AzrEPWE
         sagwKI2jQBZVxtMqyQnjm1Dmyp3IIZV0ioityrRHpw8KfaJT/YV4lzYPId/eatvacWkB
         8vzle0a0K5EbGmukGaMRdHpVGS2Hyhc9lkgZoLvQVHxiCeMxQAOhmBKB/XkvWwfuuHcP
         jzgS34YN6ucvrAj1hpcyzpQuTh1sR2sP0zrBI1NTIOj4g5gf0qfgf0F1qPj9PDzpH2q0
         3RjVwaKvK7svm6LSdU8uitZSO1q0ZKbjEwPT3NSlDKj/QcKtobq/ErTXiKw/RHLFB6ah
         TBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679497315;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DgWPl66ZYekMljnHqI2dpfEQRj570j4dEOn6iVgr8Vk=;
        b=dZ1+Bxmn+e8rD+1eys/aXqDp1OTDXcpOySY8J3j8nHbZwRHUzzgmCn8ms92B8McsNO
         BUUtHsBCgkob74F/mmbNm6nu8o3jdGzL5JpeLIpLVe/x4wj3N+q6psndYbHvKv/UZPm3
         t1cqZzladFboE9CBloGmLkbA4Nzi5jA62JbSsleiXonuSWvTXfqyfmSSRY9wPWmEMz0X
         hisVURTYP50QystHQOfQEUf90o1EhBk2XeGiHHZ+zr5QHHRU/1jO+uCVe71favET6yhL
         uSi2g+oBuSwqvEH/wqimQyax8xVZ2/6jwpn/Z7DJCBvBcGFLP45ZwDI/ZrpjKayo9Um9
         Odrw==
X-Gm-Message-State: AO0yUKW8vX6PlCjKi0c7f41cHD31RFtD6B82AkbwrcqxtnTeZOBG5ksB
        g6aPnfSLucZ43j9KMiOOlVgBey/IWHQFFeJU
X-Google-Smtp-Source: AK7set9FB+V5HVQj0fRSzaX064ikAu6JSuBgFDxBRfmO9C84Gk5570jz57xM3/gKtdsWJshsdP0yBw==
X-Received: by 2002:a7b:cd0c:0:b0:3ed:8bef:6a04 with SMTP id f12-20020a7bcd0c000000b003ed8bef6a04mr6007546wmj.27.1679497314922;
        Wed, 22 Mar 2023 08:01:54 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bc047000000b003ed2276cd0dsm17049264wmc.38.2023.03.22.08.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 08:01:54 -0700 (PDT)
Date:   Wed, 22 Mar 2023 20:01:52 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: most: fix line ending with '('
Message-ID: <ZBsYYAc1Ue/JnUAm@khadija-virtual-machine>
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
line. Align the rest of the parameters to the opening parenthesis.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---

Changes in v2:
 - Changed the description

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
2.34.1

