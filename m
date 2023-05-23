Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A3C70DEDC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbjEWOMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbjEWOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:12:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4EE1733
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:11:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF6496284B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F83C433D2;
        Tue, 23 May 2023 14:11:55 +0000 (UTC)
Date:   Tue, 23 May 2023 15:11:52 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v2 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
Message-ID: <ZGzJqKAVx7QfOzn/@arm.com>
References: <20230517150321.2890206-1-revest@chromium.org>
 <20230517150321.2890206-4-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517150321.2890206-4-revest@chromium.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 05:03:19PM +0200, Florent Revest wrote:
> Alexey pointed out that defining a prctl flag as an int is a footgun
> because, under some circumstances, when used as a flag to prctl, it can
> be casted to long with garbage upper bits which would result in
> unexpected behaviors.
> 
> This patch changes the constant to a UL to eliminate these
> possibilities.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> Suggested-by: Alexey Izbyshev <izbyshev@ispras.ru>

FWIW, I'm fine with this patch and I don't think it introduces an ABI
change.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
