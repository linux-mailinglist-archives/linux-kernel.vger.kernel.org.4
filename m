Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BB867425D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjASTLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjASTK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:10:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32AB37B52
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:10:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A00561D5F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC558C433F1;
        Thu, 19 Jan 2023 19:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674155339;
        bh=PzsGsLFJCA6cYjYklvAS7QIGwwvvuls1Li0H1VAmV3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1biOferkXEx8K1aawBHUwiBK31XDSKrIhIXZlozncT/E4FmBM+zC/xnHqbnSzhvE
         Ir7SVKIvtSIgVspj6yzB0LmK4nBRPMdu0D6EffFKlau6q4p+3uj/LacY6vLKjslcwO
         mbCMhalSw1hBw/P05KP0qPEjSerBESo1FXOE3G/EaRCY+7vbC2eh0vwmwyQ8bcup+A
         4CXM56fOzqaNVghVTfykNaAlQtjtVp22QUOAh9WcDHpYJN4PpvPsUDDcTbOhH5acvb
         0ieuWP0k2xeswdH+DAAE4NtHl0tw9SMDdF5HuuVY8tjDz2qBviYETnFrutFkLPGR6A
         92MZZ/IWeqXbw==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, jonathan.cameron@huawei.com,
        linux-kernel@vger.kernel.org, Junhao He <hejunhao3@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, yangyicong@huawei.com,
        f.fangjian@huawei.com, shenyang39@huawei.com, linuxarm@huawei.com,
        prime.zeng@hisilicon.com
Subject: Re: [PATCH 0/3] Setting the pmu::capability and modify some code styles
Date:   Thu, 19 Jan 2023 19:08:34 +0000
Message-Id: <167415178825.3428813.2865493404001298820.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230119100307.3660-1-hejunhao3@huawei.com>
References: <20230119100307.3660-1-hejunhao3@huawei.com>
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

On Thu, 19 Jan 2023 18:03:04 +0800, Junhao He wrote:
> Advertise the PERF_PMU_CAP_NO_EXCLUDE capability.
> 
> And modify some code style, include the following:
> 1) Simplify the parameters of hisi_pmu_init() function.
> 2) Use hisi_pmu_init() function to simplify initialization of "hisi_pmu->pmu".
> 
> Junhao He (3):
>   drivers/perf: hisi: Advertise the PERF_PMU_CAP_NO_EXCLUDE capability
>   drivers/perf: hisi: Simplify the parameters of hisi_pmu_init()
>   drivers/perf: hisi: Extract initialization of "cpa_pmu->pmu"
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/3] drivers/perf: hisi: Advertise the PERF_PMU_CAP_NO_EXCLUDE capability
      https://git.kernel.org/will/c/7f95da9d2dc4
[2/3] drivers/perf: hisi: Simplify the parameters of hisi_pmu_init()
      https://git.kernel.org/will/c/053b5579dacf
[3/3] drivers/perf: hisi: Extract initialization of "cpa_pmu->pmu"
      https://git.kernel.org/will/c/e126f6f42f89

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
