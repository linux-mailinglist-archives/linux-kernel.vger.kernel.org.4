Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94AF734195
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 16:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbjFQOMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 10:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjFQOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 10:12:28 -0400
X-Greylist: delayed 607 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Jun 2023 07:12:25 PDT
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE13C19A9;
        Sat, 17 Jun 2023 07:12:24 -0700 (PDT)
From:   Furkan Kardame <f.kardame@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1687010018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Bbqiov4Op0v1yv6B2iZ6b4aJ69uVgQBZKHbEsOQQ+Ms=;
        b=XvONLIaguEdw3eRIvRs21O8r/dSNfd9QrB4ENd0VDyxkNR5Jdu35Hr3MBa26pR5/buXNVH
        Tt4evY92oirREYSScQj+4hDihmyXlZKt3yyMClCI38d4WG4Twz9fO4FhXSJ0/vliVRoGzQ
        5y196eoinHUVoBI/FWpM9RY+fW6bgbmD5VeKa7p82qFxmfyJUp0BufpUtMzqQpRc+yRN3P
        V9L3jyMwxiBOZCC5OiFS3Q8iF7+t6SkzLp9MS5RUejMHF5NX8S5US81rSd/zDoG+fnJKjX
        23FAZT9Wohsfqa4YTqjlfKTAV7o/NTrH9XXFK5UP5SVjdbszu4ytd1G/d7yv7Q==
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, broonie@kernel.org, deller@gmx.de,
        dsterba@suse.com, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Furkan Kardame <f.kardame@manjaro.org>
Subject: [PATCHv2 0/2] Add support for Firefly Station P2 aka rk3568-roc-pc
Date:   Sat, 17 Jun 2023 16:53:13 +0300
Message-Id: <20230617135315.25441-1-f.kardame@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=f.kardame@manjaro.org smtp.mailfrom=f.kardame@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 adds the requisite dt-binding.
Patch 2 adds Firefly Station P2 device tree

Please review and let me know if I have missed anything.

Furkan Kardame

--- 
v2: 
- Add regulator suffix to nodes
- Fix indentation
- Remove sdio_pwrseq node as it's not needed until sdmmc2 is added
- Remove underscore from pinctrl node name
- Fix dt-binding compatible name

v1: https://lore.kernel.org/all/20230616211020.55755-3-f.kardame@manjaro.org/

Furkan Kardame (2):
  dt-bindings: arm: rockchip: Add Firefly Station P2
  arm64: dts: rockchip: add dts for Firefly Station P2 aka rk3568-roc-pc

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../arm64/boot/dts/rockchip/rk3568-roc-pc.dts | 673 ++++++++++++++++++
 3 files changed, 679 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-roc-pc.dts

-- 
2.40.1

