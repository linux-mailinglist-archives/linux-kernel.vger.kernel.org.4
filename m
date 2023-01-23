Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF7D677E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjAWOko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjAWOkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:40:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA16018A8F;
        Mon, 23 Jan 2023 06:40:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61EDEB80DDA;
        Mon, 23 Jan 2023 14:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EABBC433D2;
        Mon, 23 Jan 2023 14:40:32 +0000 (UTC)
Date:   Mon, 23 Jan 2023 14:40:29 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, ndesaulniers@google.com, ojeda@kernel.org,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        revest@chromium.org, robert.moore@intel.com, will@kernel.org
Subject: Re: [PATCH v3 0/8] arm64/ftrace: Add support for
 DYNAMIC_FTRACE_WITH_CALL_OPS
Message-ID: <Y86cXUmCn7c76AQY@arm.com>
References: <20230123134603.1064407-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123134603.1064407-1-mark.rutland@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Jan 23, 2023 at 01:45:55PM +0000, Mark Rutland wrote:
> I'm not sure how we want to merge this, so I've moved the core ftrace
> patch to the start of the series so that it can more easily be placed on
> a stable branch if we want that to go via the ftrace tree and the rest
> to go via arm64.

Happy to queue the whole series since Steve acked the ftrace changes.
But I'll put on a stable branch in case there are any conflicts with the
ftrace tree.

-- 
Catalin
