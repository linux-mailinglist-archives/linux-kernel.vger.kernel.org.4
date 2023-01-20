Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A5867601F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjATWWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjATWWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:22:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B72671BDF;
        Fri, 20 Jan 2023 14:22:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 023C1B82A95;
        Fri, 20 Jan 2023 22:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E812FC4339B;
        Fri, 20 Jan 2023 22:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674253357;
        bh=/B3zFHsbmUuGcZFPrh9xj1KkPrOVA+AyCX+HZKfxBSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpYwxFukNmMNbXlyBZIS3seg83mrQYDkDXJPUU2/yt0Sevg1q41fnxmiXxikKHr+K
         TaLL6FeojH28nSTCZxdFLaESnSk7UrMiN4gRc4ykfl8JR4YRWwS1hJeGk/Jr1ruxuV
         Ksb0N/mBWl5NYBvUfxm4eZQeo3vXCN/qZTWtB6ZyO4UrUzmQ6VuO5n8Z+GGZBCZ7fo
         xxY+FsODVZgWKliDzH3WD+r6J+fdDsaUJC1M9o8fZTzfQhXmcdFmPNNgWj1VvtqI4r
         r+XP9P/ikkE/LATGVdkctIEICL5/cWnvppt4tTnXwnpA30gyW/r2E6x31TDbTUIfbs
         GbayQlsvzsiuQ==
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Walker Chen <walker.chen@starfivetech.com>
Cc:     conor@kernel.org, Daire McNamara <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] JH7110 PMU Support
Date:   Fri, 20 Jan 2023 22:21:54 +0000
Message-Id: <167425300253.196995.6414153954346182622.b4-ty@microchip.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119094447.21939-1-walker.chen@starfivetech.com>
References: <20230119094447.21939-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=934; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=PKB/daeDLqS7LF3I2YHL9Fy5Hx8w0JBq6gduu4aGKmM=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDMmnhf849mce2XZrb5Z/abxJmdacbacr3FcbLMhLFJiWp2Kt vep/RykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbi9YuR4VD73DnrulU3XPO+tuteo8 LEe3zGwasXsmxI29R5YmHFibOMDG8nKkzUjnz1Xr77VVpwQGRhTsk63eB9830LCqs/HFnDyA4A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Thu, 19 Jan 2023 17:44:45 +0800, Walker Chen wrote:
> This patchset adds PMU (Power Management Unit) controller driver for the
> StarFive JH7110 SoC. In order to meet low power requirements, PMU is
> designed for including multiple PM domains that can be used for power
> gating of selected IP blocks for power saving by reduced leakage
> current. The first patch adds device tree binding for PM domain provider
> and consumer. The second patch adds pmu driver and support JH7110 SoC.
> 
> [...]

Applied to riscv-soc-for-next, thanks!

[1/2] dt-bindings: power: Add starfive,jh7110-pmu
      https://git.kernel.org/conor/c/1fc7606d5083f79a20eb9cfd77c0dbd9299421c1
[2/2] soc: starfive: Add StarFive JH71XX pmu driver
      https://git.kernel.org/conor/c/08b9a94e8654d402bfd1f5496b077503d69aa2cf

I modified the MAINTAINERS entry to remove the include directory that
was deleted along the way.

Thanks,
Conor.
