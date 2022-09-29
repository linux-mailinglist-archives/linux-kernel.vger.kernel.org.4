Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51F75EFC64
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbiI2Ry1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiI2RyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:54:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1CB153A7F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:54:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D47F5620EE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93513C433D6;
        Thu, 29 Sep 2022 17:54:11 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     will@kernel.org, Li Huafei <lihuafei1@huawei.com>,
        mark.rutland@arm.com
Cc:     wangkefeng.wang@huawei.com, andreyknvl@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Julia.Lawall@inria.fr, linux-arm-kernel@lists.infradead.org,
        elver@google.com, zhouchengming@bytedance.com, mingo@redhat.com,
        ardb@kernel.org, akpm@linux-foundation.org
Subject: Re: (subset) [PATCH 0/3] arm64: module/ftrace: Fix mcount-based ftrace initialization failure
Date:   Thu, 29 Sep 2022 18:54:09 +0100
Message-Id: <166447404204.3004179.896279920066200996.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220929094134.99512-1-lihuafei1@huawei.com>
References: <20220929094134.99512-1-lihuafei1@huawei.com>
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

On Thu, 29 Sep 2022 17:41:31 +0800, Li Huafei wrote:
> This series is mainly to fix the mcount-based ftrace initialization
> failure during module loading (see patch 3). The first two are cleanup
> patches.
> 
> Li Huafei (3):
>   arm64: module: Make plt_equals_entry() static
>   arm64: module: Remove unused plt_entry_is_initialized()
>   arm64: module/ftrace: Fix mcount-based ftrace initialization failure
> 
> [...]

Applied to arm64 (for-next/ftrace), thanks!

[1/3] arm64: module: Make plt_equals_entry() static
      https://git.kernel.org/arm64/c/3fb420f56cbf
[2/3] arm64: module: Remove unused plt_entry_is_initialized()
      https://git.kernel.org/arm64/c/5de229160508

-- 
Catalin

