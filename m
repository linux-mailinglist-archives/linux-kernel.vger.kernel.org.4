Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4077C5F2BE1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJCIdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiJCIdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:33:08 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8446C67453
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 01:05:16 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q17so10866876lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 01:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=fSpMO7Q7ztMkeSMVfIkdP3tgEsFHMk6ik3iJDreqgKk=;
        b=xsJPA1MYeKwG/NkMGQFDx6CFF+4DZWrdboI6deotot+SkpJtzdCX5g+dqpXMD7lWwH
         HQ2mpHglJ7d/doU0mitPoaRH82+8Wf3Wu4H0HQHBHlq1cIFkkQsZ7SG/tc+68IBWnMIo
         cLOzN3m1ej/ceKYcg8ufIWb84/qDHhAUNn9uCx+mJIZkqP7k315ZVDkvrAqz5hvbE90f
         lPbQtM76/HXzbg3X4Nz4huiHoBXUIetjdjY9ocFgsngSP074QxwU+Sa3PM8kdFy3oN28
         40JRdYRMc9Mw6JVyAxXi1+6GkCKOHxJ8o6GX2vk/OkwNEiWqis+GEUwoqpz8tfGoUgb6
         AJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=fSpMO7Q7ztMkeSMVfIkdP3tgEsFHMk6ik3iJDreqgKk=;
        b=X8VLsS+c5NDuA108Z6D9Le8j+Hs4t5ZzXZcHiT0pSbKZoujZBXjYLhQHi0TnA4UBm0
         X3De6f2IHrWqolFHJam5d4pe0smPgi7r8cox6D8YiHIA3L7b/Pu38TmOsqfaJ4WJ1zoT
         tM/li3jO7IT/TaMOHgnmWe9gRkb5tVWbF5i9uAEa14ZgbUMO4Mh+1c03AZGwGkYElEbD
         w/eR/CpwZo0/qHBV0U51h/lHWHz+YUg8dL7lh7516w49m3W8k0EABIqjNMfKTZcMKLLb
         +b2ayW4FX2XvjyeK5buFbi9TCycUfoGbca+vmqcX/laOHKTB6kcGETRJbDPFbfAfXp48
         YZDg==
X-Gm-Message-State: ACrzQf0lgQS2Ibo5pel0Q2iAjXQ98tyIzEZDKn7MuFcUnfUHOQ1lj/PN
        +35YDfuvm2jgMTXiZPOp7CS7ob/FoZ9qyA==
X-Google-Smtp-Source: AMsMyM7NIQMLyCL91JNcZS0wsarQdgReHoMPkFKv0DwxtJZ8MqlxMbVCPH2TtS9XOneObUd3TPmdQg==
X-Received: by 2002:a05:6512:33c3:b0:4a2:4c1a:a07 with SMTP id d3-20020a05651233c300b004a24c1a0a07mr108251lfg.551.1664782759257;
        Mon, 03 Oct 2022 00:39:19 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g22-20020a056512119600b00499f9aaa9desm1347678lfr.179.2022.10.03.00.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 00:39:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] ARM/arm64: dts: samsung: Late round for v6.1
Date:   Mon,  3 Oct 2022 09:39:16 +0200
Message-Id: <20221003073916.12588-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Late pull of fixes for v6.1 for DTS: both ARM and ARM64.  The pull is based on
master (not previous pull).  If it is too late, please consider this for fixes
after v6.1 merge window.

Best regards,
Krzysztof


The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-dt64-6.1-2

for you to fetch changes up to 17fffac44943a619ec76463655b1ed7fccd8bea7:

  ARM: dts: s5pv210: correct double "pins" in pinmux node (2022-09-30 17:14:24 +0200)

----------------------------------------------------------------
Samsung DTS ARM and ARM64 changes for v6.1

Late cleanup and fixes for Samsung DTS:
1. Fix polarity of pins:
   - enable GPIO of NFC chip in Exynos5433 TM2 boards,
   - vbus GPIO of EHCI in Exynos4412 Origen board.
2. Correct name of pin configuration nodes - redundant "pins" in the
   name (no functional impact).

----------------------------------------------------------------
Dmitry Torokhov (2):
      arm64: dts: exynos: fix polarity of "enable" line of NFC chip in TM2
      ARM: dts: exynos: fix polarity of VBUS GPIO of Origen

Krzysztof Kozlowski (1):
      ARM: dts: s5pv210: correct double "pins" in pinmux node

 arch/arm/boot/dts/exynos4412-origen.dts               | 2 +-
 arch/arm/boot/dts/s5pv210-aries.dtsi                  | 4 ++--
 arch/arm/boot/dts/s5pv210-galaxys.dts                 | 2 +-
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)
