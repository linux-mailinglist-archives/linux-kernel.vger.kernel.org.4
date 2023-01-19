Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBA4674B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjATEvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjATEuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:50:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DBDDA105;
        Thu, 19 Jan 2023 20:43:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64D60B82704;
        Thu, 19 Jan 2023 19:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1A4C4339B;
        Thu, 19 Jan 2023 19:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674155352;
        bh=O8EqujrCDWQhmahEnByqQnxnFzoB7MH2mXsWRFN52Mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCBzneJO7dRED2v4lv2ZbSHg5WbBGmTFzqM4xK3fgpvoAEqu6ZLdZSbqmLpq9rtl6
         wq48bNONYaZner6lsQGhqSyCcigU50swBn+xj6Fc88Odnxx7//YqyV39HWspRzFutz
         TmISZKwnTn4Yd+m9uO3ifc86RAFQvExJBNk6LjBYs4qqnkjhP7LuVp6OdZda8LINL8
         /EV5YaO5Jq4cgjcic3GOj/OrqX7eF1/xfPra7zdgbAky80nIvQBBNJ47ZtC+q9s3a2
         P/qXEzv8p1ZLMC6mtVmv1gS+12nmVd2twa5t+ifz48XHz0mM33G5FHz2MFkqpGGSyJ
         YGpsGmVUEtBtg==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>, iommu@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] dt-bindings: arm-smmu: disallow clocks when not used
Date:   Thu, 19 Jan 2023 19:08:38 +0000
Message-Id: <167415014318.2380979.10340725775001244773.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
References: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 22 Dec 2022 10:23:55 +0100, Krzysztof Kozlowski wrote:
> Disallow clocks for variants other than:
> 1. SMMUs with platform-specific compatibles which list explicit clocks
>    and clock-names,
> 2. SMMUs using only generic compatibles, e.g. arm,mmu-500, which have a
>    variable clocks on different implementations.
> 
> This requires such variants with platform-specific compatible, to
> explicitly list the clocks or omit them, making the binding more
> constraint.
> 
> [...]

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: disallow clocks when not used
      https://git.kernel.org/will/c/3a3f20bae0ce

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
