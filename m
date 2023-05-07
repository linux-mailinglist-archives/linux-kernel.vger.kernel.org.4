Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BC76F9C63
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 00:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjEGWCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 18:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjEGWCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 18:02:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31212107;
        Sun,  7 May 2023 15:02:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50ADE611E7;
        Sun,  7 May 2023 22:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32AEC433EF;
        Sun,  7 May 2023 22:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683496941;
        bh=BJlaWwcTZmYTjOELCU/kndId2NcMMsVmpbbLNpJal9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G6LyHD5mOb5RnU0RIMjrhBt1Kscv/GXcxFuyFZew4aDlpmQ9xBrLjtNTFgE9fhnz6
         PaIDa2GpUkYob+ZnT9n/k/x2jFkCE5sttPksYn+Tvor4Ch4HrokQpafzpXDcF8q75x
         j/lmmVwLi9X4FPuw5sYG8hUvDCxB0Ckqr8dQJLs7tfNwJLb8Xl62TJgxfxZaEFCObg
         RX4nBfQlQGpkHqXVR0aiLehIGTJKIAe9KphukoZBqVsB+m+PfweZdesiL056SG41z1
         7zNxoe2dOhZjJu17JSJaSp/QY8gmPKYEGKGD6gkM1tCT3LfQhYWomWkSABIHNYFIde
         C7q1T9/Je18Cg==
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        Walker Chen <walker.chen@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1] riscv: dts: starfive: Add PMU controller node
Date:   Sun,  7 May 2023 23:02:10 +0100
Message-Id: <20230507-postwar-discount-89cc89917fe2@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417034728.2670-1-walker.chen@starfivetech.com>
References: <20230417034728.2670-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=354; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=j5UAhVrZomsiM9bXTzDgVTozeZ71uctOxV2VIj5ocB8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCkR8g/CZ3yKszifvO4Zh++pqxrps9ac6HM0ENls8He+7 N+iSRu6O0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRoMOMDB2rNzv2SYY6Rl3K VjP+9ZjnoHhUx8mJu0Qm90VOE1b468XI8NHl8Sq+fytn7Oq0Uzrzx3baaxa+hyuOSHVkZi02WFg xix8A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 17 Apr 2023 11:47:28 +0800, Walker Chen wrote:
> Add the pmu controller node for the StarFive JH7110 SoC. The PMU needs
> to be used by other modules, e.g. VPU,ISP,etc.
> 
> 

Applied to riscv-dt-for-next, thanks!

[1/1] riscv: dts: starfive: Add PMU controller node
      https://git.kernel.org/conor/c/6a887bcc4138

Thanks,
Conor.
