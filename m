Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4454737482
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjFTSr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFTSr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:47:58 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93B9DC;
        Tue, 20 Jun 2023 11:47:56 -0700 (PDT)
From:   Furkan Kardame <f.kardame@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1687286875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x5Ty4pCnpwGR7JhrU4QbNphR7Ex1qOB/BOQRkHNf7iY=;
        b=TsqWWY2qIfNlMBfSe+2Mdfr7D45iOXSDGrxYIRYVSZlkNZuaAvrJHTUFsDS5U7UvOH2p81
        ubx1lhwY3veyGiD6yO7unhOQfSiU0InRti1nMdAgwynfAg02keW/m4Zb+Ba4lQP2Z8S3PT
        TJGa3z9lUDWZcuY4G4YbWK1brohjK8en1rm7uf5FeATS6h2nWvRctDYZ621RB+kF9X6SPg
        wDIOCHBUpBHc/VwWV8RH65ji8Ao6tfsJk0G36QeK/pjwxGaLlFKGJ4ky18bRfpaV6HEgFP
        sWCE7N9L6IpnlxQx31qA2xU7JFanZ+EC+LMOVkiWjplg6+hLJ8KGWPPJfexgLA==
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, broonie@kernel.org, deller@gmx.de,
        dsterba@suse.com, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Furkan Kardame <f.kardame@manjaro.org>
Subject: [PATCHv4 0/2] Add support for Firefly Station P2 aka rk3568-roc-pc
Date:   Tue, 20 Jun 2023 21:47:44 +0300
Message-Id: <20230620184746.55391-1-f.kardame@manjaro.org>
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

Please review and I hope it is all good this time :)

Furkan Kardame

--- 
V4: 
- Fix indentation
- Remove unused regulator nodes
- Add space before the property.

V3:  https://lore.kernel.org/all/20230619184856.23066-1-f.kardame@manjaro.org/
- Change tab to space in devicetree binding.

v2: https://lore.kernel.org/all/20230617135315.25441-1-f.kardame@manjaro.org/
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
 .../arm64/boot/dts/rockchip/rk3568-roc-pc.dts | 654 ++++++++++++++++++
 3 files changed, 660 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-roc-pc.dts

-- 
2.40.1

