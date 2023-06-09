Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D785E729B49
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241319AbjFINQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbjFINQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:16:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4813B30D2;
        Fri,  9 Jun 2023 06:16:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-97458c97333so289706066b.2;
        Fri, 09 Jun 2023 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686316561; x=1688908561;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A71BXjlUDVXCg+JAr14IuRpqlxxYNAUtMGrcYwGKyYM=;
        b=IXCv+rlY3Br1TYfJ268W0avwZqJzHgj+QtEkSm7WOZwKDf3hMl3OaVmj2uEgSIdqWe
         V1/XHnDNAAOmpvwfc30feQiOPScRWyrxtwmwmz004PBwvVGIBGyvgFx+GW03Rfxh82Gh
         82eZAOjeOxsEL3od2w143xj3Q62uY2YhSxGwFgJGsHVisnpy0bAh2IzDHvzp1rcEhSQa
         p8J9yWtQ5nyXjlMtQSaWvxFI4/q6wplnNiaMe2DHI0m10QlcCxQW/YMEUP7VzmIz1Qhv
         KQ/w31LLfeN9Z0/YpiYoFm5YZ1OSoCtK/uaWlgRshyknlnZ9DsalEo24i72qdVPEd01g
         CWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686316561; x=1688908561;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A71BXjlUDVXCg+JAr14IuRpqlxxYNAUtMGrcYwGKyYM=;
        b=MX80d38f+mlSRlLK56x9G2IgWsVmhmvqYCZOxq/ysRnNMYeE1O+7J7kYbdaPk14M94
         xSLutU/33/T6PahXPdRUjJ8vY+TRzMrnjc8YTPsInDnbF7ONo8VPpCRjKoEeGlw0L54a
         fGRxRx28dNxP5qfX8Adk9LYXRo/t3b2vJX0qhzKZpsqqJYbrPsS8Ipb+1hBelB6TJaCH
         TaK3tILduHIIDPsai7tU7+eo5YC3D0K6S335Gxr+nQ8kZzEJvKU3ASGSIs1ORmHlHMJv
         kWk9Ax+XRjQWiiaOYb8rGxZn+K4GrzyuzTpJMeZM8DO8RPP/sRBN78k0j8oY7qQN+hPZ
         GMzQ==
X-Gm-Message-State: AC+VfDx6Yj1hPntSlC27GTtNFDpdSpTBMSP5UiBpUF9/nAakGw0vPe34
        kwfASt2tncGC234GcsyYsnQniKhvtkQ4Fw==
X-Google-Smtp-Source: ACHHUZ6cGLDpct71nIIMskad/yTqJxckMskn8XlwD2RzjS8HsoeQ4Sv3Ov5PDvKNXscTQ/tgT4jcvw==
X-Received: by 2002:a17:907:7fab:b0:978:9380:bc0b with SMTP id qk43-20020a1709077fab00b009789380bc0bmr1969523ejc.75.1686316561353;
        Fri, 09 Jun 2023 06:16:01 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id jt5-20020a170906dfc500b0097462d8dc04sm1284596ejc.100.2023.06.09.06.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 06:16:01 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH 0/2] media: uapi: Add V4L2_CID_VTOTAL control
Date:   Fri, 09 Jun 2023 15:15:54 +0200
Message-Id: <20230609-v4l2-vtotal-v1-0-4b7dee7e073e@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAomg2QC/x2N0QqDMAwAf0XyvECtc2P7leFDWqMGXB1JKQPx3
 1f3eBzH7WCswgbPZgflIiZbqtBeGogLpZlRxsrgne/czT2wXFePJW+ZVuTQ9mN3jzQxQS0CGWN
 QSnE5mzdZZj3FR3mS73/zGo7jB7v6lCR2AAAA
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     laurent.pinchart@ideasonboard.com, jacopo.mondi@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This series adds a new control for the vertical total time.
As camera sensors usually have registers regarding the total time and
not the blanking time, this would simplify driver implementations and
could therefore be seen as a replacement or upgrade for V4L2_CID_VBLANK.
Additionally, its value is independent from format changes and therefore
simplifies calculations in user space.

2/2 implements it for the imx290, basically extending the current
V4L2_CID_VBLANK implementation.

---
Benjamin Bara (2):
      media: uapi: Add V4L2_CID_VTOTAL control
      media: i2c: imx290: Add support for V4L2_CID_VTOTAL

 .../media/v4l/ext-ctrls-image-source.rst           |  6 +++
 drivers/media/i2c/imx290.c                         | 47 ++++++++++++++++------
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  1 +
 include/uapi/linux/v4l2-controls.h                 |  1 +
 4 files changed, 43 insertions(+), 12 deletions(-)
---
base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
change-id: 20230609-v4l2-vtotal-eb15d37cafea

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

