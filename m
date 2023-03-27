Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C3D6CA86F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjC0PBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjC0PBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:01:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D53E46BA;
        Mon, 27 Mar 2023 08:01:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF5C561311;
        Mon, 27 Mar 2023 15:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A6EC433D2;
        Mon, 27 Mar 2023 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679929289;
        bh=yDuzPp/Y8i3wczmI9BSnUwzDQ290RdGPC9bThn+97ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTs7O88VfU3zhiuy3PLNuS7OX06Rx5bMfMxS5f/NR7RMa2p0MV06tT1IWZMxduMdJ
         xAbWXHXGfvUWHxZ95oneOHex7FKflZfRsGZE/e6fwL6F+keOXHV2f8kNrGKa2hWBrL
         0CjHsPSycliu1EfRdgXtlmt89UleSXSMHUKLPrpT1kStBM/uGmJL4ZY8OTJkZWnk7R
         r2DM8Zo21V/Gv1RhHPg5o+iOuistJbmKZJ+zZz5Lg2RYvdJ2Yn6cHsW3RJ7t2Crs6W
         cgbhohKkN06v4s9YHslWr7sDxQyfxiCcUPTqSuN+ucQ95D7wolnDMw1YsIjpIdZl2L
         /2qsfjrsIh1eQ==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Janne Grunau <j@jannau.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] Apple M2 PMU support
Date:   Mon, 27 Mar 2023 16:01:13 +0100
Message-Id: <167992651494.3835994.856905717068311161.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230214-apple_m2_pmu-v1-0-9c9213ab9b63@jannau.net>
References: <20230214-apple_m2_pmu-v1-0-9c9213ab9b63@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 11:38:00 +0100, Janne Grunau wrote:
> This small series adds support for the PMU in Apple M2 cores. The PMU
> itself appears to work in the same way as om M1. We still want to add
> CPU type specific compatible strings so that we can distinguish counters
> in the case they count (slightly) different things on different CPU
> uarchs.
> 
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] dt-bindings: arm-pmu: Add PMU compatible strings for Apple M2 cores
      https://git.kernel.org/will/c/640a3b7a3d13
[2/2] drivers/perf: apple_m1: Add Apple M2 support
      https://git.kernel.org/will/c/7d0bfb7c9977

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
