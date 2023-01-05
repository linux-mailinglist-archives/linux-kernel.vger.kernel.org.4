Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4777265F366
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjAESFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjAESFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:05:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A0C5D415
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 10:04:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EFF861C04
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 18:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E086C433EF;
        Thu,  5 Jan 2023 18:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672941860;
        bh=0KieN4fCWKrHRYJJR1ar4AhONoNLqkUZuze8+zZiMU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BXtG08wKTsCa24bHEPMrsd1lIIxd41LyV79YfBKSrxrHjVk7iMkxOUd3NnJjhcxvq
         MQOzNfhhwHLdU7/ojbpcJqTfQ7Dk5IS2y6qoO0LNdBzdvtmKJodcpMbmVK/PgNGjpE
         0SL2k9WICq5If6c6x4nAX6/P8eH4A0AgMgjpXmxcQyE4QcMEQ535Zmk/Jgo+EHUDYM
         EikROdszqdtO0J4u50pnHqGLUMunFeSGi6fkaEWLOtoy0hiM9cin2kLlcO91bsqAne
         XCcsYtLUWoCZpg4i2gmiI1HGXD5Bq5oFzlW4lnHhAzTBPGMbcDUrkgTDq/qTHiUto8
         p5rgpesPXin7A==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Zenghui Yu <yuzenghui@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, zhouquan65@huawei.com,
        oleg@redhat.com, sundongxu3@huawei.com, broonie@kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH] arm64: ptrace: Use ARM64_SME to guard the SME register enumerations
Date:   Thu,  5 Jan 2023 18:04:01 +0000
Message-Id: <167293131195.1463811.15086370081939565055.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221214135943.379-1-yuzenghui@huawei.com>
References: <20221214135943.379-1-yuzenghui@huawei.com>
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

On Wed, 14 Dec 2022 21:59:43 +0800, Zenghui Yu wrote:
> We currently guard REGSET_{SSVE, ZA} using ARM64_SVE for no good reason.
> Both enumerations would be pointless without ARM64_SME and create two empty
> entries in aarch64_regsets[] which would then become part of a process's
> native regset view (they should be ignored though).
> 
> Switch to use ARM64_SME instead.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: ptrace: Use ARM64_SME to guard the SME register enumerations
      https://git.kernel.org/arm64/c/eb9a85261e29

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
