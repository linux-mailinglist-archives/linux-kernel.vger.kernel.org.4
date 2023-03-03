Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF306A9C22
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjCCQsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjCCQst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:48:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C013B64E;
        Fri,  3 Mar 2023 08:48:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E50366189A;
        Fri,  3 Mar 2023 16:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D00C433A0;
        Fri,  3 Mar 2023 16:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677862103;
        bh=vLHp6zfTAtlmPAsNSVAaON653kcH7IWEthUS+f3d9jE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPi6ora5KkXwil7JTuFP5WMoI7+GYA51OE6LgUi8oxJmJKwxDEQacbEmofLEZs4bA
         4vGdSTrlImplGjX1478iDKA6GEh3AflKGr0Kvw8MO4Ux5zhvz2eiGsZGhP4fRZ30Hs
         oyQZ7y20+Z42gS9HAfM0O71N0rFOLGEYnwNUFE7kxDUzNFn6Vr1ofQkezosac0rXkI
         IulhKXidHaoIzsrxVARyef5JI7RA1lI9TEYyyuNnT96XqpM8Rf02Uoipz/9+8c9NOa
         22fRh35/cD2z7zIMl1Nw+lVgDnrjfBkEeV39TPEhD7ZW7Mwc9e3zSl/ZFbabxYC4O6
         y8UqrN0WK0zRg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pY8aV-0003Qi-Mx; Fri, 03 Mar 2023 17:48:55 +0100
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
Subject: [PATCH v2 4/4] drm/msm/adreno: clean up component ops indentation
Date:   Fri,  3 Mar 2023 17:48:07 +0100
Message-Id: <20230303164807.13124-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303164807.13124-1-johan+linaro@kernel.org>
References: <20230303164807.13124-1-johan+linaro@kernel.org>
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
index d9100e3870bc..f2cdc5ad7ce7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -571,8 +571,8 @@ static void adreno_unbind(struct device *dev, struct device *master,
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

