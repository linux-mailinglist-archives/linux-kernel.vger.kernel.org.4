Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5375B6C7154
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCWTvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCWTvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:51:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21C5206BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:51:36 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ek18so91518892edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679601095;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gkkF864aZS59/wrLTPRII1/9wrsBmF5g69w8PpiScM=;
        b=ZDntVr7hGYS17cMcBRD2/8NnbvON+Hi1QWuvh42GyExWsfuN07qDtZ0LLP0TrhD9uS
         lZNHg6vYXPNhxGE1BSx87OXFANVOSVD9ms7Zkj5IaHPnF8euA5DtFTB2ZMW7o2xZq7ft
         zBWdPjYw8jivP6BTmS/0b7pDCJvqgE1oqyu5Yl0gFzMzdDeHudQ+Ur8KlLem8jD736fA
         o05MV2R+bwhYbyha1T8gZ1lj2bpX/IZQGqC6RySEpBohg8lCtF1GsZOxVSN4CdGleWtP
         9GVyz4+NSDVA5iCboEK81aaVUHpXt2dnhdlfWU1NFub1ky0PoLK0wQD+FYJ8/YgJPzEY
         uYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679601095;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gkkF864aZS59/wrLTPRII1/9wrsBmF5g69w8PpiScM=;
        b=KzjfUwg+rGx5cjiop4sqHo3XRPYjJuTQe1ztfuCcLWFJxttZduj9EW0vZ9hQLK/Wf3
         afKSvnpLuqK2CMPgE2KKTiXuJx+HLE+VW8tvxxlyGCJKS9JHMI2Cto2ID7Vi/YwbMzaU
         QCOpCTHJaOys1V5zkpIot62YPxN352lZbAGKSwcR4UrvZjhSVr4kD2G6DMVqCEXqAEVh
         hNr2TCT1cY7ED5qRY0p+/RHGnlKkF5oGveciN4bt5ADTfftgaPHsj3IkSkdJ5UWZ+OTQ
         IXFaa8W8aRZvcn9ggLWAXIT9dCX4Aa7+3AoQ8U1kgzKx6s4TWXtPbnqWSfa5z2+m928v
         CMLg==
X-Gm-Message-State: AAQBX9chWcqOkYNLT/D8K/5UpeGRMpWNN/sxhuWhbTA7bWqibohvm+dd
        xHQ2chVuSkbyX97JEIjarnVLB/KbWFC+MSad
X-Google-Smtp-Source: AKy350ZumT4pJKPLCEo18Nd347kxtyvr7vACqOLRVSXvIyrVAiJCF8uHCHjiELSF+VZxWwBFDOWj8g==
X-Received: by 2002:a17:906:7109:b0:931:32f5:1f31 with SMTP id x9-20020a170906710900b0093132f51f31mr234075ejj.9.1679601094826;
        Thu, 23 Mar 2023 12:51:34 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id ot9-20020a170906ccc900b009331450d04esm7997236ejb.178.2023.03.23.12.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 12:50:47 -0700 (PDT)
Date:   Fri, 24 Mar 2023 00:49:44 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: most: fix line ending with '(' in video/
Message-ID: <ZBytWDocM7XbXkRx@khadija-virtual-machine>
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

Splitting function header to multiple lines because of 80 characters per
line limit, results in ending the function call line with '('.
This leads to CHECK reported by checkpatch.pl

Move the function parameters right after the '(' in the function call
line.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---

Changes in v2:
 - Changed the subject name because there was another patch for most/
   with the same name. This was causing confusion.

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

