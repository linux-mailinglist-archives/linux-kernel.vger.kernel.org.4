Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75DB6BCC98
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCPKVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjCPKVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:21:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06116BCB9B;
        Thu, 16 Mar 2023 03:20:56 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 67A6066030A7;
        Thu, 16 Mar 2023 10:20:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678962053;
        bh=3GXafAdQmj7KJvnDtfsbN8H0g0sDtqhLZbndyfx7ewg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=en3zTI6JULuMGdA06Z2jl35WgPdA4yH3N2FqGUtRMZJtXhCSdQSV44iTOILb3qS+l
         9PhbxcxSa+0zcDjwEKBEbo6nvU/tl639ddlwJ7ZCGn5Ep7Nd8JlmXQjWDakKl+XbgS
         p4+AvyVhiKHNnASdYmtVvHsKKzq/pWOEJJ/d2DXve/dLrNkmnUawtyWBWl2gFaQLpJ
         hNMMdpLl78ssCYXhKRx6js5Wr2FEfO6kCsnKyK3NA8T+ItFgttygCva+a0rW/lrdBa
         o0UbQXNvJPD+fIzHG7EWTMJVG1xnGo82OhVe90HK2tSlVtShT961P0mSuo+6/rbmo7
         mBMcu7rW6Dclw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     airlied@gmail.com
Cc:     daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v5 08/12] drm/panfrost: Increase MAX_PM_DOMAINS to 5
Date:   Thu, 16 Mar 2023 11:20:37 +0100
Message-Id: <20230316102041.210269-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316102041.210269-1-angelogioacchino.delregno@collabora.com>
References: <20230316102041.210269-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

Increase the MAX_PM_DOMAINS constant from 3 to 5, to support the
extra power domains required by the Mali-G57 on the MT8192.

Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/panfrost/panfrost_device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index d9ba68cffb77..b0126b9fbadc 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -23,7 +23,7 @@ struct panfrost_job;
 struct panfrost_perfcnt;
 
 #define NUM_JOB_SLOTS 3
-#define MAX_PM_DOMAINS 3
+#define MAX_PM_DOMAINS 5
 
 struct panfrost_features {
 	u16 id;
-- 
2.39.2

