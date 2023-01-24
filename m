Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C57679756
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjAXMKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjAXMKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:10:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E4C42DD9;
        Tue, 24 Jan 2023 04:10:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76C0AB81197;
        Tue, 24 Jan 2023 12:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96242C433EF;
        Tue, 24 Jan 2023 12:10:42 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, ndesaulniers@google.com, ojeda@kernel.org,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        revest@chromium.org, robert.moore@intel.com
Subject: Re: [PATCH v3 0/8] arm64/ftrace: Add support for DYNAMIC_FTRACE_WITH_CALL_OPS
Date:   Tue, 24 Jan 2023 12:10:40 +0000
Message-Id: <167456223711.325781.3444355742803808035.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123134603.1064407-1-mark.rutland@arm.com>
References: <20230123134603.1064407-1-mark.rutland@arm.com>
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

On Mon, 23 Jan 2023 13:45:55 +0000, Mark Rutland wrote:
> I'm not sure how we want to merge this, so I've moved the core ftrace
> patch to the start of the series so that it can more easily be placed on
> a stable branch if we want that to go via the ftrace tree and the rest
> to go via arm64.
> 
> This is cleanly pasing the ftrace selftests from v6.2-rc3 (results in
> the final patch).
> 
> [...]

Applied to arm64 (for-next/ftrace), thanks!

[1/8] ftrace: Add DYNAMIC_FTRACE_WITH_CALL_OPS
      https://git.kernel.org/arm64/c/cbad0fb2d8d9
[2/8] Compiler attributes: GCC cold function alignment workarounds
      https://git.kernel.org/arm64/c/c27cd083cfb9
[3/8] ACPI: Don't build ACPICA with '-Os'
      https://git.kernel.org/arm64/c/8f9e0a52810d
[4/8] arm64: Extend support for CONFIG_FUNCTION_ALIGNMENT
      https://git.kernel.org/arm64/c/47a15aa54427
[5/8] arm64: insn: Add helpers for BTI
      https://git.kernel.org/arm64/c/2bbbb4015aa1
[6/8] arm64: patching: Add aarch64_insn_write_literal_u64()
      https://git.kernel.org/arm64/c/e4ecbe83fd1a
[7/8] arm64: ftrace: Update stale comment
      https://git.kernel.org/arm64/c/90955d778ad7
[8/8] arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
      https://git.kernel.org/arm64/c/baaf553d3bc3

-- 
Catalin

