Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF2F61FE35
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiKGTJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiKGTIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:08:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE6B24F03
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:08:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95197B8166B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 19:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190F6C43142;
        Mon,  7 Nov 2022 19:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667848129;
        bh=nzaFLsk8YkEjIRSV7fsWVQdNN5jGiq4W2V9sztlWBgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VLTf5QJEhpz3z7uI0eAZ+VfTARvR8U2919x5rrmlK3nvIKPJryeaw8DaH49kjVImd
         qiUk1IjcKNUjUx9ZfjT80ZCCQjNbjxvfsV+KgG3Q1NZrRzJK/Ee31p0KE5IY5wOd6F
         NT6X23gPxme4lED658C1xrQgbOg/pIJRwXPgXqGL7kQ0GTVI18Y1iM8dCTMOe61aKM
         jIsGVP7vINabdYHgs2VpkRIy/MXjipR6E5HPq9c9YFXKMnPf0FTqPwo1oL14s6zCUC
         sSnRcRoKpfxNszI5SeoRwWELaWb0hIv6xMdBEHb1rvr6vbfTbCvhjEHzjk3Dqv4Aso
         EKBNDMQ3L1WXg==
From:   Will Deacon <will@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: constify arguments to satisfy asm constraints
Date:   Mon,  7 Nov 2022 19:08:34 +0000
Message-Id: <166783675509.31192.4803678263918237382.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221006075542.2658-1-jszhang@kernel.org>
References: <20221006075542.2658-1-jszhang@kernel.org>
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

On Thu, 6 Oct 2022 15:55:40 +0800, Jisheng Zhang wrote:
> Constify arguments of arch_static_branch(), arch_static_branch_jump()
> and alternative_has_feature_* to satisfy asm constraints.
> 
> Jisheng Zhang (2):
>   arm64: jump_label: mark arguments as const to satisfy asm constraints
>   arm64: alternative: constify alternative_has_feature_* argument
> 
> [...]

Applied to arm64 (for-next/asm-const), thanks!

[1/2] arm64: jump_label: mark arguments as const to satisfy asm constraints
      https://git.kernel.org/arm64/c/efbc95787cbe
[2/2] arm64: alternative: constify alternative_has_feature_* argument
      https://git.kernel.org/arm64/c/b9024f87d63f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
