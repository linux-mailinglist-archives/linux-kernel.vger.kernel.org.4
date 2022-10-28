Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5836113CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiJ1N74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiJ1N7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:59:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1775DEC6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:59:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BC97B82A79
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4ADC433D6;
        Fri, 28 Oct 2022 13:59:48 +0000 (UTC)
Date:   Fri, 28 Oct 2022 14:59:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] mm/kmemleak: Prevent soft lockup in kmemleak_scan()'s
 object iteration loops
Message-ID: <Y1vgUBjb4xBNrrq0@arm.com>
References: <20221020175619.366317-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020175619.366317-1-longman@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 01:56:19PM -0400, Waiman Long wrote:
> Commit 6edda04ccc7c ("mm/kmemleak: prevent soft lockup in first object
> iteration loop of kmemleak_scan()") adds cond_resched() in the first
> object iteration loop of kmemleak_scan(). However, it turns that the
> 2nd objection iteration loop can still cause soft lockup to happen in
> some cases. So add a cond_resched() call in the 2nd and 3rd loops as
> well to prevent that and for completeness.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
