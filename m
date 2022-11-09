Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E3E622A3D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKILUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiKILUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:20:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A4921E05
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:20:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81BD1619D7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C16AC433D6;
        Wed,  9 Nov 2022 11:20:35 +0000 (UTC)
Date:   Wed, 9 Nov 2022 11:20:32 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        lvc-patches@linuxtesting.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH 03/13] arm64: ptrace: user_regset_copyin_ignore() always
 returns 0
Message-ID: <Y2uNAAeArdtpqgdO@arm.com>
References: <20221014212235.10770-1-s.shtylyov@omp.ru>
 <20221014212235.10770-4-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014212235.10770-4-s.shtylyov@omp.ru>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2022 at 12:22:25AM +0300, Sergey Shtylyov wrote:
> user_regset_copyin_ignore() always returns 0, so checking its result seems
> pointless -- don't do this anymore...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

What's happening with this series? (just going through my inbox)
