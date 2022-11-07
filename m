Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C17D61FE33
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiKGTI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiKGTIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:08:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B484B248F1;
        Mon,  7 Nov 2022 11:08:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 390B361298;
        Mon,  7 Nov 2022 19:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB590C43470;
        Mon,  7 Nov 2022 19:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667848126;
        bh=o+3qNZMSy/zjTLSUFqaqkQL+4XLaemV6mgyDOsuMDXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rc1b+htgpHYfT6dlGDMFei0vuJ0NIO10FYuYWOt8anYSzNiOd+krAhQCEfCt5TosG
         2gqeEclHFGBNoKSwrEadZQCSGSO9O6sF17+DzeFiczHGhfJTNB6g0YGY3Ebq4ejMPy
         NUC2ZAKfxMu7InsMK6iba7F0M7pLzC1PfYJHOPUmGy9Ik9gxy9Kcsi4wAsQk1Psz5w
         Fhar6BdNM5HxBi3PawcHSRCrXxLAUV0IZzTb2drgIgGZmvOr56mgijLDdbrThGZH2Y
         O0DkNxHwcHIbxsH9vM2Dg9DC7bjdm4oM+0CQt5sdqzN/NS048bKN5XV4RaZiAxKjEp
         IwbAaE05boa0Q==
From:   Will Deacon <will@kernel.org>
To:     guohanjun@huawei.com, rafael@kernel.org, lenb@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        lorenzo.pieralisi@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vsethi@nvidia.com,
        linux-acpi@vger.kernel.org, treding@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: ARM Performance Monitoring Unit Table (APMT) initial support
Date:   Mon,  7 Nov 2022 19:08:33 +0000
Message-Id: <166782973154.23022.17026705500797647098.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220929002834.32664-1-bwicaksono@nvidia.com>
References: <20220929002834.32664-1-bwicaksono@nvidia.com>
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

On Wed, 28 Sep 2022 19:28:34 -0500, Besar Wicaksono wrote:
> ARM Performance Monitoring Unit Table describes the properties of PMU
> support in ARM-based system. The APMT table contains a list of nodes,
> each represents a PMU in the system that conforms to ARM CoreSight PMU
> architecture. The properties of each node include information required
> to access the PMU (e.g. MMIO base address, interrupt number) and also
> identification. For more detailed information, please refer to the
> specification below:
>  * APMT: https://developer.arm.com/documentation/den0117/latest
>  * ARM Coresight PMU:
>         https://developer.arm.com/documentation/ihi0091/latest
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI: ARM Performance Monitoring Unit Table (APMT) initial support
      https://git.kernel.org/arm64/c/6251d38059ae

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
