Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0FF62A163
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiKOSdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiKOSdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:33:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F67930544
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:33:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CFB7B81A45
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 18:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAD8C433D6;
        Tue, 15 Nov 2022 18:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668537192;
        bh=aUlE+XlVtUegRenzbhP2nA8Eu9V4nyuIs/7txING2vE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmiVS0bwNsNgQR9IogJTkocpIWRJL4gMbDTftt+LqCKzy+ODrFWamEOjkp3qBKTXd
         gojnf5W1y5hOIbTk7a3Pw6X4QCy6WfVQOq+RN1TzR0jnXcEkdwtO1UjaruVGj8UFtt
         PMrw2qMfvFIlBqT6UquCepxuFmupbcjRR/4/z5Oeg/xF94yPGhqyfrnPVnVkZ8vAzH
         DyJ6Yaot/lkl+oB/8M7QIQ7ucSSedTEFjVBZoMiy3z3EpECPyJSMbZgHdgV8MiNSuM
         1QW/vBpNRflFf4GlyZbxA3Lipg6Lj8pTFWvQtSBRj/EchpRFF+pbgdawfyp64ShzPp
         ais38Hecsow7Q==
From:   Will Deacon <will@kernel.org>
To:     Chen Lin <chen45464546@163.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, robin.murphy@arm.com,
        treding@nvidia.com, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu: Warn once when the perfetcher errata patch fails to apply
Date:   Tue, 15 Nov 2022 18:32:54 +0000
Message-Id: <166851283020.1266596.8585820030047050712.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221103222121.3051-1-chen45464546@163.com>
References: <20221103222121.3051-1-chen45464546@163.com>
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

On Fri, 4 Nov 2022 06:21:21 +0800, Chen Lin wrote:
> Default reset value of secure banked register SMMU_sACR.cache_lock is 1.
> If it is not been set to 0 by secure software(eg: atf), the non-secure
> linux cannot clear ARM_MMU500_ACTLR_CPRE bit. In this situation,
> the prefetcher errata is not applied successfully, warn once.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: Warn once when the perfetcher errata patch fails to apply
      https://git.kernel.org/will/c/f87f6e5b4539

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
