Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9967051C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjEPPO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjEPPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:14:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D4E40CE
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:14:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C90A5631C6
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3D7C4339E;
        Tue, 16 May 2023 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684250091;
        bh=ueF5/kwgF3xX7zaJFl7ngpNccINdb6ggK5yQp+xHDm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d5G+bUp7BIUvb/qbm1jI7l4csElNcYSfcgFNRjs4QbzP2Moe3a2GS/jfTUsRL0nkQ
         jxVqe1EYPgcA6GRKx4vdVgNH85T8wGIQjD4Adb6VjdSZY2V4CKAOfwQj3O0LmnihmX
         R2gNuJGXgVwhVZ6nU3qPvJcHrWL95kFOdTx1bnPkN7VnuRdIjmHzCg7e5PAItVYMwN
         /+UUOU2p14KE58sWcmHW0ZtqmbRmnXBTQZJenT4O7hzqy47GZatnbVsgGWLAIP/WI+
         D5ouJWp9uE4l9Nm9pGJjuiaIVpnLPS1lvqZ2PSKbAqlOQHTJfasHnin66uxfpMlUth
         uWFnFXrJG9G5A==
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM/arm64: Mark all accessor functions inline
Date:   Tue, 16 May 2023 16:14:40 +0100
Message-Id: <168424545094.607408.9407141334580132518.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1683561087.git.geert+renesas@glider.be>
References: <cover.1683561087.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2023 18:05:17 +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series adds missing "inline" keywords to the few perf
> accessors that lack them.
> 
> BTW, I tried converting my local timing code to the new unified system.
> This works fine on arm64, but broke on arm32.  Is read_pmccntr()
> supposed to work on arm32? I get an undefined instruction exception on
> Cortex A15 and A9.  Before, my custom code used "mrc p15, 0, %0, c9,
> c13, 0" (as is also used in arch/arm/kernel/perf_event_v7.c), for which
> there is no accessor yet.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/2] ARM: perf: Mark all accessor functions inline
      https://git.kernel.org/arm64/c/68e3f61eb9f5
[2/2] arm64: perf: Mark all accessor functions inline
      https://git.kernel.org/arm64/c/3bc879e355da

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
