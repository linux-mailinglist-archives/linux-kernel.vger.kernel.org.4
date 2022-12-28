Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D71657526
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiL1KGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiL1KGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:06:09 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938DA116C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 02:06:08 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id jl4so9368550plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 02:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B70QifF2futZ63jMxA/rA/1s14ICX6BqPGHLhFxdZa0=;
        b=C5LRlCYxs+Yia2f5B39XlmdkJYHY8WTupDIQkic48F5l6WDBaZ/pad1YZYYQvALNg1
         6d2UxERLj5a29ytg7CMPt+IALgNSCrpsWJ9nJSMRcrcwQtdTQkTj1Dl7ob6weS69oUHN
         jZQDgtyDpq0B7ACB2qx1YUJcKhxjAsihYDGNBIX9ulltQdeiEKo3+jjIdO3nXBVls9Y4
         rIdhgpbWhW3KdcmII7viMXmv5IJZhpyP3TnjiLyxA4hjjniMZrChcF8Fr93cOrUKMEEJ
         /5Dr992kKAsNO9g9W20WJ5AZtTheJEh14Van1RNv8e5u4HWL0dPuj1oS8GIh2UQ8lsWi
         VNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B70QifF2futZ63jMxA/rA/1s14ICX6BqPGHLhFxdZa0=;
        b=FXLhuR7l9g0qf4h1Xt9X6F7q8/swUHbHyrSzI3GWT/gxsvQecR60lRVDr0RRsQ2nd1
         lT2KXC3p/7AG+9Z0WKFIldMkfAkI0NFQfkgcyojgION3368+KDMp5VCjok0WUr9L4bA4
         wrPPDrRhAlUhFPRmwlY5aYZJoQZwNpURl4VdxZ9BetbQZpnedaWW66ChrA7wld2/Z3dk
         Q/xogDasbb9wKIJeQUA7Udw+fNizJM/1BClnihoZQ4/3bwZWUn45f49jEGSgyAHX4Mmm
         Wsd7dnMl/BUTrIRzE0IZrYkQPvKjeAys2DM1ZdbiK8it8+1WHo+ZYSeP6rYHuvLJN/fJ
         tvug==
X-Gm-Message-State: AFqh2koo8+0MZOXfeicX6sWC16aN2EbmgwXZhh7lEbUSU519xwohoeWP
        uXKBT6HgkkiWroVQhN6/TQE=
X-Google-Smtp-Source: AMrXdXt2DmvRUj5RYrhmw0WxMvEch62Z/kg4VaWDUxOSffUKFNhsMcNy+zZq1EU2ixETUe8eh/vO1A==
X-Received: by 2002:a17:902:8ec7:b0:192:4f85:b91d with SMTP id x7-20020a1709028ec700b001924f85b91dmr28793805plo.46.1672221968158;
        Wed, 28 Dec 2022 02:06:08 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b0019277df45a6sm5794915plb.53.2022.12.28.02.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:06:07 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 11/11] arm64: defconfig: Enable USB onboard HUB driver
Date:   Wed, 28 Dec 2022 10:03:20 +0000
Message-Id: <20221228100321.15949-12-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221228100321.15949-1-linux.amoon@gmail.com>
References: <20221228100321.15949-1-linux.amoon@gmail.com>
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

Enable the USB onboard HUB driver, used on Amlogic boards.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 851e8f9be06d..42c3528a2473 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -923,6 +923,7 @@ CONFIG_USB_SERIAL_CP210X=m
 CONFIG_USB_SERIAL_FTDI_SIO=m
 CONFIG_USB_SERIAL_OPTION=m
 CONFIG_USB_HSIC_USB3503=y
+CONFIG_USB_ONBOARD_HUB=m
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=m
-- 
2.38.1

