Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7865BF8E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiIUISz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiIUISj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:18:39 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B548B9F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663748318;
  x=1695284318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jiRLDh887L4stWEL7ewRK0p/C0iReg1uXK5CF30Jnd8=;
  b=bUC/y54QJIvkYnXXGmt5R9cdfBrzbbHKYavhda6icvKg+7AfYOl74p1N
   FFaTipMUTw2CsoAvbeYZDgHnIile2Tv2UT174efzcYBZlOZVLd+kA7Zzu
   OQxI7m01RbGiX5gQ08pVvzBLAesG3pFzv8pCJa9THb0FnOWaTkg1msKxI
   QSSrjDmkSRYyycw1+dUskyD71tmjoj+9KSjJPdXYv+n4ftD8eZrSww2L+
   MoEEmogNwgn5pvndMVEtNrjBaT9/102MqIcX3EFNsX8DXmNOtMFm5BC79
   bPmTYMDl0ow4xwjFubyIa43GxGzOOewHVTr8F7MHuLrmtBqkc48jTNFrK
   w==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astridr@axis.com>,
        Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v4 0/3] ASoC: ts3a227e control debounce times
Date:   Wed, 21 Sep 2022 10:18:31 +0200
Message-ID: <20220921081834.22009-1-astrid.rost@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Astrid Rost <astridr@axis.com>

PATCH 1 - convert ts3a227e bindings to yaml.
PATCH 2 - add ts3a227e bindings to support debounce times.
PATCH 3 - add ts3a227e driver to support debounce times.

v3 -> v4
Removed the comments on enums in Patch2.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>


Astrid Rost (3):
  dt-bindings: sound: ti,ts3a227e: convert to yaml
  dt-bindings: sound: ti,ts3a227e: add control of debounce
  ASoC: ts3a227e: add parameters to control debounce times

 .../bindings/sound/ti,ts3a227e.yaml           | 94 +++++++++++++++++++
 .../devicetree/bindings/sound/ts3a227e.txt    | 30 ------
 sound/soc/codecs/ts3a227e.c                   | 61 ++++++++++--
 3 files changed, 149 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/ts3a227e.txt

-- 
2.20.1

