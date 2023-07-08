Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECAB74BCD1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 10:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjGHIkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 04:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjGHIkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 04:40:41 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC37FF;
        Sat,  8 Jul 2023 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1688805636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kZp/RuTQA9sv6le/NdMKkvZz1qlquoEfqK2QgHrlgBk=;
        b=J9y0FOqnmMfGk1BCYAQa7QaGavIpGz2/AHbajLggP+WjAmsu9+p8Byugu9B/MYr2G+altw
        3qrac/FtnmYpqJeSU/IOFriu9y33/ZySeB4Ztquv69DXCS2BXqxv3Ln60QyvMelixdRqRv
        2i7rcThlMWnQe2kW4gIyp2T4Y1aMFpM=
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
Subject: [PATCH v2 0/3] Galaxy S2 (i9100) panel updates v2
Date:   Sat,  8 Jul 2023 10:40:24 +0200
Message-Id: <20230708084027.18352-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Follow-up on my patchset that fixes the display of the Samsung Galaxy S2
when running PostmarketOS.

The first two patches update the LD9040 panel driver so that it looks
much better, and supports setting the backlight.

The third patch fixes the size of the panel in the Device Tree. The
previous values were completely bogus and caused Phosh (PmOS' UI) to
display tiny icons and text as it thought the DPI was much lower.

Changes since V1:
[1/3]: Remove spurious new line
[2/3]: Remove .get_brightness() callback, use bl_get_data() and
       backlight_get_brightness()

Cheers,
-Paul

Paul Cercueil (3):
  drm/panel: ld9040: Use better magic values
  drm/panel: ld9040: Register a backlight device
  ARM: dts: exynos/i9100: Fix LCD screen's physical size

 arch/arm/boot/dts/exynos4210-i9100.dts       |  4 +-
 drivers/gpu/drm/panel/panel-samsung-ld9040.c | 42 +++++++++++++++++---
 2 files changed, 38 insertions(+), 8 deletions(-)

-- 
2.40.1

