Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4911162FE1D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbiKRTlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241896AbiKRTlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:41:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F178C4B5;
        Fri, 18 Nov 2022 11:41:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3C706275F;
        Fri, 18 Nov 2022 19:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7570C433C1;
        Fri, 18 Nov 2022 19:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668800468;
        bh=gMurl95kRBLvoj+dTtcCxEZ2JyEw7e+FRQDZAoRXyIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RuwrqeHRn03zJx6z8HXce2pwGFOg/O4YGayaIuEJd7ZxsM7XsCvUwNMSUAYtMFcUi
         6pqVznXeisdoQSebpu1K9NJUjY0ej7rXjaOS4+HVfL+UjgBxB6Z70npngkYHp7N+Kq
         qcw1FxtKHUdtO2OqekLQHWQLj8T6wdl1zxqTImxthsaQhQdo5eTQYMYrJOQZ0lXxBT
         Do2LV2N1d+A8lg4z6NDfIPNznkBHDCOmo1wN9cPO2rtNd5HxcYhJpLZJ4aHUWHYdGe
         C01kqnAYb4s16nHDVEOo/U0/xekZ3hNXZ1fL83bxPZsgLmznOgP4UcQyDyDOcPk4Um
         uHiEvvuI0cuWg==
From:   Will Deacon <will@kernel.org>
To:     suzuki.poulose@arm.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        ywan@nvidia.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vsethi@nvidia.com,
        linux-tegra@vger.kernel.org, jonathanh@nvidia.com,
        treding@nvidia.com
Subject: Re: [PATCH] perf: arm_cspmu: Fix module cyclic dependency
Date:   Fri, 18 Nov 2022 19:40:43 +0000
Message-Id: <166877833240.3584782.4730226198999894697.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221116203952.34168-1-bwicaksono@nvidia.com>
References: <20221116203952.34168-1-bwicaksono@nvidia.com>
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

On Wed, 16 Nov 2022 14:39:52 -0600, Besar Wicaksono wrote:
> Build on arm64 allmodconfig failed with:
>   | depmod: ERROR: Cycle detected: arm_cspmu -> nvidia_cspmu -> arm_cspmu
>   | depmod: ERROR: Found 2 modules in dependency cycles!
> 
> The arm_cspmu.c provides standard functions to operate the PMU and the
> vendor code provides vendor specific attributes. Both need to be built as
> single kernel module.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf: arm_cspmu: Fix module cyclic dependency
      https://git.kernel.org/will/c/a91bbd5c9984

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
