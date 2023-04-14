Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44816E1ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 05:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDNDdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 23:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjDNDda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 23:33:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82B340EB;
        Thu, 13 Apr 2023 20:33:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DF626439A;
        Fri, 14 Apr 2023 03:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F07CC433D2;
        Fri, 14 Apr 2023 03:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681443207;
        bh=tJgDJuJY4A4modu0Rbf3HmOHnlGYZ+08MPv5hItppvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBc89w3C1U1Iq/3XzZFuDpBoQv8Vh6WnfoHgmcbOD4G8zVROhNHc9aWCCzwqbm30k
         CYveW63XGePyFmqhqU60qyFV7ygk9y6fBvswF0P9Z7lH0bbA8FTnvpityHGR5rip4g
         8ZXdXs4axcaJfxSYUbdprKJQDNgiZze1VkPlNi2BECQ4GldJ8zGf5ZeykTaziDvUjL
         ugR9teNWGyvCh8oFBPDMHFH/XUyfiOpae1mTKQYmxxaf4Ctm7hubGsmVVtVbmCWCqd
         LkCVqD4d4zrs0+6tfscjK3sqC7IcVlkRsh8oibXBSBdq3nBF0SwRLbtkl8wPKR4eSR
         oFLC9guoJCHYA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Will Deacon <will@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/7] arm64: dts: qcom: sa8775p: add more IOMMUs
Date:   Thu, 13 Apr 2023 20:37:02 -0700
Message-Id: <168144342195.2459486.2984526266369267613.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411125910.401075-1-brgl@bgdev.pl>
References: <20230411125910.401075-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 14:59:03 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the GPU and PCIe IOMMUs for sa8775p platforms as well as the required
> GPU clock controller driver.
> 
> NOTE: I didn't pick up Krzysztof's tag for patch 4/7 as the patch changed
> significantly.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: clock: qcom: describe the GPUCC clock for SA8775P
      commit: daa9e76d17570cdd2dbec28244e60e2cb0eafb36
[2/7] clk: qcom: add the GPUCC driver for sa8775p
      commit: 0afa16afc36d0e462c7f815b0131d2e9013849ac

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
