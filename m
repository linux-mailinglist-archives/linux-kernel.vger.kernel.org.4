Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA7F6B7A20
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCMOQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCMOQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:16:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D6F5C9D6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:16:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA39AB81123
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 14:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A13C433D2;
        Mon, 13 Mar 2023 14:11:36 +0000 (UTC)
Date:   Mon, 13 Mar 2023 14:11:33 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, nd@arm.com,
        acme@redhat.com, izbyshev@ispras.ru, peterx@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/4] mm: fix error handling for map_deny_write_exec
Message-ID: <ZA8vFU8iT82vYiGZ@arm.com>
References: <20230308190423.46491-1-joey.gouly@arm.com>
 <20230308190423.46491-3-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308190423.46491-3-joey.gouly@arm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 07:04:21PM +0000, Joey Gouly wrote:
> Commit 4a18419f71cd ("mm/mprotect: use mmu_gather") changed 'goto out;'
> to 'break' in the loop.
> This wasn't noticed while rebasing the MDWE patches, so fix it now.
> 
> Fixes: b507808ebce2 ("mm: implement memory-deny-write-execute as a prctl")
> Reported-by: Alexey Izbyshev <izbyshev@ispras.ru>
> Link: https://lore.kernel.org/linux-arm-kernel/8408d8901e9d7ee6b78db4c6cba04b78@ispras.ru/
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
