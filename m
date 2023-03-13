Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719036B7A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCMOOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjCMON6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:13:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEC0303EE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 883BE612EE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 14:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E47C4339B;
        Mon, 13 Mar 2023 14:13:09 +0000 (UTC)
Date:   Mon, 13 Mar 2023 14:13:06 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, nd@arm.com,
        acme@redhat.com, izbyshev@ispras.ru, peterx@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 4/4] tools headers UAPI: Sync linux/prctl.h with the
 kernel sources
Message-ID: <ZA8vcu90cytWrV9V@arm.com>
References: <20230308190423.46491-1-joey.gouly@arm.com>
 <20230308190423.46491-5-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308190423.46491-5-joey.gouly@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 07:04:23PM +0000, Joey Gouly wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Sync prctl.h after the changes in b507808ebce ("mm: implement memory-deny-write-execute as a prctl")
> 
> Fixes: 4cf1fe34fd18 ("kselftest: vm: add tests for memory-deny-write-execute")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> [joey: added commit message]
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
