Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A316CA874
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjC0PB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjC0PBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:01:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304146AA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85E6461303
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998E5C433D2;
        Mon, 27 Mar 2023 15:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679929300;
        bh=ft9ZngomNFXyHaFy8SsUJheCRVSuDL/qVf53VLAESlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l9D4pLeVZJaWfFvFgFuP49TGOYNf+0oN1j0tX4mJVlCZBYvSUlF4cdmqBhx3zqOlk
         hJ+pDNbQojDFehY49cM7kRKPlObPhqgXzcmBVvrH144g/g2tfuRbtjv35YPTTRctJW
         xT/6i2iTPc0Kf72vgF63TZwpUTDeF0Jyssm4zXG1Faj/IG9HUmuPIe7wqWnF7P2Mmd
         zCXghtnvtwYqi8xRJE/HhNboL456lL3Wrfrn37YYFYU+rccUaIb9CpMPStlifmdvST
         k7vvMLw6PJSOZck513SsKQLBYuY8kUaOCQRfFaLDh5yEfLxfIiO0kKq8iDD312l6AX
         aZ9HyZfeEiEuQ==
From:   Will Deacon <will@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] perf: arm: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 27 Mar 2023 16:01:17 +0100
Message-Id: <167992575273.3834103.6973520632485101788.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230315023017.35789-1-yang.lee@linux.alibaba.com>
References: <20230315023017.35789-1-yang.lee@linux.alibaba.com>
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

On Wed, 15 Mar 2023 10:30:17 +0800, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf: arm: Use devm_platform_get_and_ioremap_resource()
      https://git.kernel.org/will/c/d7f4679dc8d1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
