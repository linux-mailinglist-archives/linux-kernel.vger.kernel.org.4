Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9772A7123D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243212AbjEZJie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242782AbjEZJhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:37:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89FA198
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C1A464EBB
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70246C4339E;
        Fri, 26 May 2023 09:37:50 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cpufeature: Use helper for ECV CNTPOFF cpufeature
Date:   Fri, 26 May 2023 10:37:48 +0100
Message-Id: <168509386372.1547980.7271328276067450416.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523-arm64-ecv-helper-v1-1-506dfb5fb199@kernel.org>
References: <20230523-arm64-ecv-helper-v1-1-506dfb5fb199@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 22:49:00 +0100, Mark Brown wrote:
> The newly added support for ECV CNTPOFF open codes the recently added
> helper ARM64_CPUID_FIELDS(), make use of the helper.  No functional
> change.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/cpufeature: Use helper for ECV CNTPOFF cpufeature
      https://git.kernel.org/arm64/c/e34f78b970ea

-- 
Catalin

