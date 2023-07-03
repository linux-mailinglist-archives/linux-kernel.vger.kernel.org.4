Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2E074650D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjGCVra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjGCVr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:47:29 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D5BE76;
        Mon,  3 Jul 2023 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1688420843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vwdXKx+U3iVVC3c7K/sn3Jj32FLhI0XzSGIe5REnjno=;
        b=XQ8ve/K5+LEPdWWGqH7Es/WRYg3CgtONQPWtjiIgc39X0EEeaaKnVfYjZpgQaGDcLjgbuR
        ebyQrrEc6ZYBkP81N47E0Av1GhhqjwXAWns4fxlVmz+k6cmjJ5OwytOTBGNvTyOfDUgEg/
        DjN2VuXN+uZIChZ3zeD1bINYTHLILGc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/3] Galaxy S2 (i9100) panel updates
Date:   Mon,  3 Jul 2023 23:47:12 +0200
Message-Id: <20230703214715.623447-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a small patchset that I created while playing with PostmarketOS
on my Samsung Galaxy S2.

The first two patches update the LD9040 panel driver so that it looks
much better, and supports setting the backlight.

The third patch fixes the size of the panel in the Device Tree. The
previous values were completely bogus and caused Phosh (PmOS' UI) to
display tiny icons and text as it thought the DPI was much lower.

Cheers,
-Paul

Paul Cercueil (3):
  drm/panel: ld9040: Use better magic values
  drm/panel: ld9040: Register a backlight device
  ARM: dts: exynos/i9100: Fix LCD screen's physical size

 arch/arm/boot/dts/exynos4210-i9100.dts       |  4 +-
 drivers/gpu/drm/panel/panel-samsung-ld9040.c | 51 ++++++++++++++++++--
 2 files changed, 48 insertions(+), 7 deletions(-)

-- 
2.40.1

