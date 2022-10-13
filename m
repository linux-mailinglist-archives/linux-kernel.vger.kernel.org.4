Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4536A5FE145
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJMSb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiJMSbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:31:35 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBAD18DC02
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:26:38 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id b18so3328717ljr.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k+VQ8PIgKw2wXGL8CyxmdjJZoYsv8YucY3sAmtvnacY=;
        b=DDVWrlzPxXMsngCDo/QcByWaD1OiWqjlNo0qm2fhXYTe6IpxdiNpfJhoQ/XRHqkNH/
         ZL8aGReXB//kbbUw2a2BpQbb+im3SQb+37YiU6sDPOFlAKSG3BIPbwgt2/nIyQlKaGJH
         uzCbiOq+YopE+Igm4SZFz95FNkQx2jKOZlrXdAdvRC52OhIFclBz7Ejq9Ry5EnUpU188
         taWgVhbhdQTEtx7KNLnZl8GOg+grIzHwF57Bkk9JwW7l+lT8lr7kfOn2yr1YCDW00lvy
         A8vWb9Y58cJMm/F8YEXB5QEawLZN685VujBFaZC76ctrWAr/uUU0GHqJrTOrt1KkmLVW
         qJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+VQ8PIgKw2wXGL8CyxmdjJZoYsv8YucY3sAmtvnacY=;
        b=636XDVthnGL503eXMcl5NDeLc+7ZUyiWn71uWg4JQ+bspt9JlzWH3X80SYGxXbQb7s
         QR54jkReg1IHVbJc2xGGzLIQJjEDJKAfmqf7GAMByXjmslpbR5z5Ivhp2yS2mPOUV0Ew
         q3EOhbfwr8MAOwtVtU9Wz7STsyaW12WtvZpIvM/+78eJ0Pj1A1O5WDxolr2qX3taLxw0
         qqaS3WTUTQKnkge1GoZES5thhdgEiLZKmOB0Tf/OZDUDGvCTdmjphvcRI1S/rkMi/M62
         tGpmHUGOjdY/VUCNUWj91IaIunqkvze2YnQ5hRNNxW5G5VcKseAXAqCcPZF1bTwJleGQ
         bQAg==
X-Gm-Message-State: ACrzQf1J35Xr+5zoqv2/Ltiqdr8NE9F7p+/0m3BDIGN3ibUbSszOoL1I
        rA3jY1Q4f7n3swLiWR3mhRXiw55bRgHrCXys
X-Google-Smtp-Source: AMsMyM4ZxITJcZD3wjZMo6kOHrArjKX1JG1U07gSpHUbk5BeHsXrfW0RJfdb/yh86Mr9nLWyjuqABw==
X-Received: by 2002:a17:906:7308:b0:78e:191e:8389 with SMTP id di8-20020a170906730800b0078e191e8389mr759810ejc.170.1665684764848;
        Thu, 13 Oct 2022 11:12:44 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170907788f00b0078b551d2fa3sm211109ejc.103.2022.10.13.11.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:12:44 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     maxime@cerno.tech, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, wens@csie.org, samuel@sholland.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 0/5] iommu/sun50i: Fix various issues
Date:   Thu, 13 Oct 2022 20:12:15 +0200
Message-Id: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing IOMMU together with video decoder (Cedrus) exposed many bugs in
sun50i-iommu driver. This series addresses all issues so video decoder
works well with IOMMU.

First two patches address recovery issues in interrupt when either page
faults or permission errors were reported. Third patch fixes permission
domain assignment. Fourth patch fixes dma sync size. Sometimes sync also
touched some other buffers and kernel generated warning in dmesg. Fifth
patch fixes issue with synching PDE and PTE tables. Without it, page
faults were randomly generated even with valid iova addresses.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (5):
  iommu/sun50i: Fix reset release
  iommu/sun50i: Consider all fault sources for reset
  iommu/sun50i: Fix R/W permission check
  iommu/sun50i: Fix flush size
  iommu/sun50i: Invalidate iova in map and unmap callback

 drivers/iommu/sun50i-iommu.c | 66 +++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 5 deletions(-)

--
2.38.0

