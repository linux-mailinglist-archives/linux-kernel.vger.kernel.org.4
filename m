Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5454563C8CA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiK2Tw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiK2Twz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:52:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB0D13DC6;
        Tue, 29 Nov 2022 11:52:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97D80B818BE;
        Tue, 29 Nov 2022 19:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F184C433C1;
        Tue, 29 Nov 2022 19:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669751571;
        bh=EbjnWIA7UlHyqlpI/1Jvnvf0lorL9t5cddUnbOhAQ58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/oz/HhM+Wn+gey9GJ6O0RVeUiKsExYFx2io5qjeI+k7bxvIL3Lk09bpRGaUjn9ud
         LEaKIsPwAW8RvmDYXV61mNwBS3DquLR/pG3kNawcIs6NnnSXS1hITrcUHO9rPyIfik
         UhuV8jzwPo3T1PJutHygiibbPQSTHeftiWXnPURwzMY5xowazTsUvxHiCvRtufDwHQ
         5YT/i2GLIa0cd69Q/Zan2Ev+MoEJlKOx86+eiGodHi6We92958h28S7CpSE1Hm+eKQ
         rHkgolwM+Ys9CsiRadQMKZV8IKYsGvC2sx4cSxPKqs0W3qOrumInkjFvSkq1I+f8jV
         Q6x/rvlA+b1/w==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/perf: Replace PMU version number '0' with ID_AA64DFR0_EL1_PMUVer_NI
Date:   Tue, 29 Nov 2022 19:52:43 +0000
Message-Id: <166973110482.2371212.6194416321613362626.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221128025449.39085-1-anshuman.khandual@arm.com>
References: <20221128025449.39085-1-anshuman.khandual@arm.com>
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

On Mon, 28 Nov 2022 08:24:49 +0530, Anshuman Khandual wrote:
> __armv8pmu_probe_pmu() returns if detected PMU is either not implemented or
> implementation defined. Extracted ID_AA64DFR0_EL1_PMUVer value, when PMU is
> not implemented is '0' which can be replaced with ID_AA64DFR0_EL1_PMUVer_NI
> defined as '0b0000'.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] arm64/perf: Replace PMU version number '0' with ID_AA64DFR0_EL1_PMUVer_NI
      https://git.kernel.org/will/c/cc91b9481605

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
