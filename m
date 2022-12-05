Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7A2642C21
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiLEPnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiLEPnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:43:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637DDBC0C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:43:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 083BB611A9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F138AC433C1;
        Mon,  5 Dec 2022 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670254989;
        bh=D/+BKVIlShuhR+UQ6Pz52NTeoGKKkf+tJ77kNXk0hZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7bquxzMr78fGNDfb9ivVZpS+1pTFDeSVwEFyDCPtrVpAk3ZeMEObpDsnyHBzMnaK
         zCOBxkdkyjWU5cXf7WpE9599BSUeSfm7kWettx5rIezCBqGLtx+zSg9v20AXSpgrWD
         N3iPqzaHkd3nwOOy/hRPoWoyBSm9UgNIFSJ2EpnFUxBvOk/7YbCfowwg9eo5NwvuGE
         NKBi/ey06eRe+0no/1VI9xJVUhwjo+BzpeVyrqLSuBx8pPzVjrYno8pTKOiB5ygOne
         Qr7awKLrAisGUDeN4aO4AEY7Hx6ogTOrkArEwL10XPaUAfIjAe25ZI3gQ80y9G/quP
         cXWnSoPlz0FSw==
From:   Will Deacon <will@kernel.org>
To:     catalin.marinas@arm.com, guo.ziliang@zte.com.cn
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huang.junhua@zte.com.cn
Subject: Re: [PATCH] arm64:uprobe fix the uprobe SWBP_INSN in big-endian
Date:   Mon,  5 Dec 2022 15:43:02 +0000
Message-Id: <167024898950.269185.3140250803235881009.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <202212021511106844809@zte.com.cn>
References: <202212021511106844809@zte.com.cn>
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

On Fri, 2 Dec 2022 15:11:10 +0800 (CST), guo.ziliang@zte.com.cn wrote:
> From: junhua huang <huang.junhua@zte.com.cn>
> 
> We use uprobe in aarch64_be, which we found the tracee task would exit
> due to SIGILL when we enable the uprobe trace.
> We can see the replace inst from uprobe is not correct in aarch big-endian.
> As in Armv8-A, instruction fetches are always treated as little-endian,
> we should treat the UPROBE_SWBP_INSN as little-endian。
> 
> [...]

Applied to arm64 (for-next/insn), thanks!

[1/1] arm64:uprobe fix the uprobe SWBP_INSN in big-endian
      https://git.kernel.org/arm64/c/60f07e22a73d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
