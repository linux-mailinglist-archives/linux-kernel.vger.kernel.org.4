Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98F1735D91
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjFSStN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSStL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:49:11 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE390FC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:49:09 -0700 (PDT)
From:   Furkan Kardame <f.kardame@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1687200544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ae3ENTYqA6QaF2da+eLhQOSZLm32/u2EEfpTMqxtDYQ=;
        b=dQoUXm/jQerMgBPuN0QfirrjC30PWjQWtbcrjt2qMFKE2lU6SAKpnzqMM+Ymb+ql9lj9wg
        yDNWN1KMbdAZb5qC+7s6Ij5+dK35GelJYKvHtvE3mFfeKwRYHRYlUwqTJz/KJYZGS5IXnL
        sYIfhQ1mqF+Eum7fw3YPeLNuC5Ni4BGJBy6bfgUbRKbcM4wzEN3J5ZHAcwspC6WM+HuftQ
        DVxgVmhzX3qvoZFfzWs/8LZxo/kawREvfqcnze6fn9l8m0ImorBAh2eFP5OOk/iifd5+N8
        MYms3iwhTa9tEWRyq4Nrl0EwI+SMgL8+E2sDIxYEuCs5wVzDtSELQCkxni5Pyg==
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, broonie@kernel.org, deller@gmx.de,
        dsterba@suse.com, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Furkan Kardame <f.kardame@manjaro.org>
Subject: [PATCHv3 0/2] Add support for Firefly Station P2 aka rk3568-roc-pc
Date:   Mon, 19 Jun 2023 21:48:54 +0300
Message-Id: <20230619184856.23066-1-f.kardame@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=f.kardame@manjaro.org smtp.mailfrom=f.kardame@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 adds the requisite dt-binding.
Patch 2 adds Firefly Station P2 device tree

Apologies for adding tab in devicetree binding in v2.

Please review and hopefully should be okay to merged now :)

Furkan Kardame

--- 
V3: 
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
 .../arm64/boot/dts/rockchip/rk3568-roc-pc.dts | 673 ++++++++++++++++++
 3 files changed, 679 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-roc-pc.dts

-- 
2.40.1

