Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF1C667DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbjALSTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240518AbjALSSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:18:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EA9DEF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:49:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC35CB81F08
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 17:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D14C43398;
        Thu, 12 Jan 2023 17:49:53 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cpufeature: Remove 4 bit assumption in ARM64_FEATURE_MASK()
Date:   Thu, 12 Jan 2023 17:49:50 +0000
Message-Id: <167354578784.3644325.17415348273046160452.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222-arm64-arm64-feature-mask-v1-1-c34c1e177f90@kernel.org>
References: <20221222-arm64-arm64-feature-mask-v1-1-c34c1e177f90@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022 13:00:39 +0000, Mark Brown wrote:
> The ARM64_FEATURE_MASK(), used extensively by KVM, assumes that all ID
> register fields are 4 bits wide but this is not the case any more, for
> example there are several 1 bit fields in ID_AA64SMFR0_EL1. Fortunately
> we now have generated constants for all the ID mask registers which can
> be used instead. Rather than create churn from updating existing users
> update the macro to reference the generated constants and replace the
> comment with a note advising against adding new users.
> 
> [...]

Applied to arm64 (for-next/sysreg), thanks!

[1/1] arm64/cpufeature: Remove 4 bit assumption in ARM64_FEATURE_MASK()
      https://git.kernel.org/arm64/c/e978eaca4bee

-- 
Catalin

