Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055586AFF95
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCHHTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCHHT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:19:27 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E8793107;
        Tue,  7 Mar 2023 23:19:26 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cw28so61925916edb.5;
        Tue, 07 Mar 2023 23:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678259964;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DffdRwGDBop/pqo1Pf6hDrTszBK5MTXyDDUS5LoX44=;
        b=DKqRaeMBoqg23HyolHJ7ehExRKA3JVp9WMsXfCfuMP2g5MwlulLitZrSe7N23oWS+l
         z6O5exr7mxf5JnAJdPeaHzylHhsGtBPowONlVoRmPkplx3Ib2Pajj50G+QGk8TQvKaxd
         GMIaIp0EtB0RnKdi+1nG0m1way6Xb5mnOIFQ4g7nX0P5OFxr1ury0c+g6JTo9hUjuWLS
         0zhrhjLl6N3IAoogvs3DX5eXbf7b/KrHJkHox6x1ixjYPU4nSKDaAV90uftmQKW3lYVP
         l7XOd2YgA0VrBHeh3lW9WNlIVsBvVmCPMulWUOwTvxCazKNztJOlBa3WYrhZtAyRy+bL
         KKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678259964;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DffdRwGDBop/pqo1Pf6hDrTszBK5MTXyDDUS5LoX44=;
        b=6UC83hza59h0r+je+CqV9wrdR9ff0fpZhGQSqmmDwiOkDbpEM5PPPHoQkz6InNFiM2
         Qet3DwHGDUEMIU3IWnFEUgsg8zOiZmmzOjJEdC9Eifkd2aJPtvB0W7CZKMNFufItmEB/
         eDbGY/eo+It1XvfNGzFvkdesp6jhPbQ/KiBcc111vN16Ivo6K/gax3Zbo7+nxIRl/kGI
         LA03WOzw8fLuFoNvqKnaT6yopx5n5Xc2hEdtgsMa3+pedoyBKQAqD3JL6ht07qhEj31H
         hSHXEof8x//BRBXu2Y2MDKL5lwARjUQxKdC5dcaz/wnOB97niZbkIBqC8Et2cyUNy2ye
         Swzg==
X-Gm-Message-State: AO0yUKU7vqGiylALKmw62lvY8+x1ULqWShVfW12XMHMoZ+ZPvZEHNe+w
        7NuArznZ/UA4+m3EId9vLQCwDYTXanqV0Q==
X-Google-Smtp-Source: AK7set89QYt41YYVWHj5Y9CH01N7bzvlP2LuDopQGYI0Bl3Mglz73M2IdtVeSNyCooucMm289KznqQ==
X-Received: by 2002:a17:907:c24c:b0:8b1:293a:ef21 with SMTP id tj12-20020a170907c24c00b008b1293aef21mr17077217ejc.64.1678259964504;
        Tue, 07 Mar 2023 23:19:24 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:c4be:f7db:77fd:b9e5])
        by smtp.gmail.com with ESMTPSA id ot18-20020a170906ccd200b008e40853a712sm7101541ejb.97.2023.03.07.23.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 23:19:24 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Winischhofer <thomas@winischhofer.net>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: orphan SIS FRAMEBUFFER DRIVER
Date:   Wed,  8 Mar 2023 08:19:21 +0100
Message-Id: <20230308071921.10963-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was triggered by the fact that the webpage:

  http://www.winischhofer.net/linuxsisvga.shtml

cannot be reached anymore.

Thomas Winischhofer is still reachable at the given email address, but he
has not been active since 2005.

Mark the SIS FRAMEBUFFER DRIVER as orphan to reflect the current state.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d8f46f35aa4..354577534aef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19191,9 +19191,7 @@ W:	http://www.brownhat.org/sis900.html
 F:	drivers/net/ethernet/sis/sis900.*
 
 SIS FRAMEBUFFER DRIVER
-M:	Thomas Winischhofer <thomas@winischhofer.net>
-S:	Maintained
-W:	http://www.winischhofer.net/linuxsisvga.shtml
+S:	Orphan
 F:	Documentation/fb/sisfb.rst
 F:	drivers/video/fbdev/sis/
 F:	include/video/sisfb.h
-- 
2.17.1

