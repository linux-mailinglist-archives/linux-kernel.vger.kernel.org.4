Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA37862FE16
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbiKRTk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiKRTk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:40:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DCF23173
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:40:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EC146275F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0821EC433B5;
        Fri, 18 Nov 2022 19:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668800455;
        bh=ao7w8PGY6CvyH02T0fXtKub8Tk+v9jD93VP1ZNrkqgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NylGndkcK8YJtHRgU20W6RmSYGDXrl/E8KySgSyxkW/RF07lwN1DYTJQcZe/z/3uU
         Rbj5iYOpPBdFFDt642TOmR5i7BT7BUmc/r1LvfY1DqLDpeLQxjboP/L1+sYAOCzLvN
         pOXSsrOioltTxM1scu6Gpe/ZuMg32cK2O465EHZHTGAGdXtTE7MUt5oKxdaqx6mVn7
         xoiBXoq1XQVr2NiWwVA7F5IPLtEiC4f51n/EQ/N8yZ7pmMedk0GJQ7+Qeai52foay1
         PmeAlwL7rxjIeF1CU7VUuSY+70UPZl2qcLsgpSb9oHcZ0j7HHg3YdZffY62hwMsC/a
         l31FOkfKCIzhA==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)
Date:   Fri, 18 Nov 2022 19:40:38 +0000
Message-Id: <166878064180.1782449.376709845468504621.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221118053102.500216-1-anshuman.khandual@arm.com>
References: <20221118053102.500216-1-anshuman.khandual@arm.com>
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

On Fri, 18 Nov 2022 11:01:02 +0530, Anshuman Khandual wrote:
> __create_pgd_mapping_locked() expects a page allocator used while mapping a
> virtual range. This page allocator function propagates down the call chain,
> while building intermediate levels in the page table. Passed page allocator
> is a necessary ingredient required to build the page table but its presence
> can be asserted just once in the very beginning rather than in all the down
> stream functions. This consolidates BUG_ON(!pgtable_alloc) checks just in a
> single place i.e __create_pgd_mapping_locked().
> 
> [...]

Applied to arm64 (for-next/trivial), thanks!

[1/1] arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)
      https://git.kernel.org/arm64/c/9ed2b4616d4e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
