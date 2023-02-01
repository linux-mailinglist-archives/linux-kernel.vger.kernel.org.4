Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F281686EF8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjBATb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjBATb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:31:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9477E6F8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:31:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88C17B8228F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290BFC433EF;
        Wed,  1 Feb 2023 19:31:18 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] arm64/signal: Signal handling cleanups
Date:   Wed,  1 Feb 2023 19:31:16 +0000
Message-Id: <167527987143.975309.11866617180631281587.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
References: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
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

On Tue, 31 Jan 2023 22:20:38 +0000, Mark Brown wrote:
> This series collects a number of small cleanups to the signal handling
> code which removes redundant validation of size information and avoids
> reading the same data from userspace twice.
> 
> There are some overlaps with both the TPIDR2 signal handling and SME2
> serieses which are also in flight, applying this will require
> adjustments in those serieses and vice versa.
> 
> [...]

Applied to arm64 (for-next/signal), thanks!

[1/7] arm64/signal: Don't redundantly verify FPSIMD magic
      https://git.kernel.org/arm64/c/92f14518cc43
[2/7] arm64/signal: Remove redundant size validation from parse_user_sigframe()
      https://git.kernel.org/arm64/c/0eb23720f29e
[3/7] arm64/signal: Make interface for restore_fpsimd_context() consistent
      https://git.kernel.org/arm64/c/4e4e93045fe1
[4/7] arm64/signal: Avoid rereading context frame sizes
      https://git.kernel.org/arm64/c/b57682b31558
[5/7] arm64/signal: Only read new data when parsing the SVE context
      https://git.kernel.org/arm64/c/f3ac48aa3a58
[6/7] arm64/signal: Only read new data when parsing the ZA context
      https://git.kernel.org/arm64/c/24d68345a02a
[7/7] arm64/signal: Only read new data when parsing the ZT context
      https://git.kernel.org/arm64/c/ad678be42387

-- 
Catalin

