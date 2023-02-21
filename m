Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229CE69DDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbjBUKQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjBUKQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:16:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C4323306;
        Tue, 21 Feb 2023 02:16:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0465B80E9D;
        Tue, 21 Feb 2023 10:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5A4C433AF;
        Tue, 21 Feb 2023 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676974605;
        bh=yMvJYHxVZptlOU5QkNPi2i647YDtCkktqGaRKrHuIIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDMSqzEIjkQp9Nbi1pc/AzuqhupeOI0A3vwNCZ+xQhLmKTVWYn/ECf7VyPVWCwLWD
         TuG7eYCCOaDEAGahZTISo0O92OQpg0Wy0ZylhuKSY364JZwl0PZN/d5PAJqjWOPTar
         UDHsyc2meB8Ioe2RWYK1b0W/OLDEvCQR65EUDoWh4OEtr/L4gHuLR+N8PhE/pY0UEw
         mCeQL/yDX+LVydQWluxQNOhU4w1cVrTfv9oJmTP2bI9Anz9A6jIrNY2IAEjrFEvisW
         nCnE9kysBsiCWJDtnFCLseC9daRe0P8aJpG2CSbTtOxSlgWMTgG3lH/GnNPtRoBVSL
         KYE9DoOW4CtlA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pUPhY-0003oL-8z; Tue, 21 Feb 2023 11:16:48 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 4/4] drm/msm/adreno: clean up component ops indentation
Date:   Tue, 21 Feb 2023 11:14:30 +0100
Message-Id: <20230221101430.14546-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221101430.14546-1-johan+linaro@kernel.org>
References: <20230221101430.14546-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the component ops initialisers which were indented one level
too far.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index cd009d56d35d..80947420ac19 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -563,8 +563,8 @@ static void adreno_unbind(struct device *dev, struct device *master,
 }
 
 static const struct component_ops a3xx_ops = {
-		.bind   = adreno_bind,
-		.unbind = adreno_unbind,
+	.bind   = adreno_bind,
+	.unbind = adreno_unbind,
 };
 
 static void adreno_device_register_headless(void)
-- 
2.39.2

