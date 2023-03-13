Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B086B7A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCMOQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCMOQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:16:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7104EEA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:16:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7349061295
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 14:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204A1C433D2;
        Mon, 13 Mar 2023 14:11:15 +0000 (UTC)
Date:   Mon, 13 Mar 2023 14:11:13 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, nd@arm.com,
        acme@redhat.com, izbyshev@ispras.ru, peterx@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 1/4] mm: deduplicate error handling for
 map_deny_write_exec
Message-ID: <ZA8vAQ+KoHFRiZ7h@arm.com>
References: <20230308190423.46491-1-joey.gouly@arm.com>
 <20230308190423.46491-2-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308190423.46491-2-joey.gouly@arm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 07:04:20PM +0000, Joey Gouly wrote:
> Commit cc8d1b097de7 ("mmap: clean up mmap_region() unrolling") deduplicated
> the error handling, do the same for the return value of `map_deny_write_exec`.
> 
> Fixes: b507808ebce2 ("mm: implement memory-deny-write-execute as a prctl")
> Reported-by: Alexey Izbyshev <izbyshev@ispras.ru>
> Link: https://lore.kernel.org/linux-arm-kernel/8408d8901e9d7ee6b78db4c6cba04b78@ispras.ru/
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
