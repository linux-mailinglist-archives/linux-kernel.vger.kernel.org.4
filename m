Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8C96CCBFF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjC1VQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjC1VP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:15:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC4E1BCE;
        Tue, 28 Mar 2023 14:15:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8756E6195E;
        Tue, 28 Mar 2023 21:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF88C4339C;
        Tue, 28 Mar 2023 21:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680038157;
        bh=8+1POfPIyk9eZyS7d4f6YafqwcEcQOb0IhINBdzdB6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FoSW+mH8RBQ6t5LbJoDJ3UB9/X38LJrkVRGo8Tdxgl0SBn8D+FFnXX0x/tf3AsioU
         pTL5wYZXjPlClIpKDkuRk1L6WYryHm2HscsoV36/lZDkwG08gfzuEKQcE61vF2fDV8
         h/B1dV2+r3r6CreTIYKGI9rIJ0WsntL6TC4BbBrSiza+MLfsD3V8CDLhS+2e8rphmW
         Z2tg0n0IJHDJkCFwmm6qG+AH4ShiGlUlGMfUI1S3dDn5dPM9CpjlX6BCss8pwFqGcQ
         uoQmGxkvTBuuCtIdF/H0rR1aRx9maa+eLaZQiCO6u7ylWtWrRSkAxjJAstAdDVDTMW
         ju2Ox/qm5s0HQ==
From:   Will Deacon <will@kernel.org>
To:     Yu Zhe <yuzhe@nfschina.com>, haibinzhang@tencent.com,
        hewenliang4@huawei.com, catalin.marinas@arm.com,
        mark.rutland@arm.com, renzhijie2@huawei.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        liqiong@nfschina.com, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: armv8_deprecated: remove unnecessary (void*) conversions
Date:   Tue, 28 Mar 2023 22:15:44 +0100
Message-Id: <168001462439.1894650.12936155000889402443.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230303025047.19717-1-yuzhe@nfschina.com>
References: <20230303025047.19717-1-yuzhe@nfschina.com>
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

On Fri, 3 Mar 2023 10:50:47 +0800, Yu Zhe wrote:
> Pointer variables of void * type do not require type cast.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: armv8_deprecated: remove unnecessary (void*) conversions
      https://git.kernel.org/arm64/c/0e2cb49ef104

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
