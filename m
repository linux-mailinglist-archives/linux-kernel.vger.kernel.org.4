Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E066C82FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCXRLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjCXRLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:11:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B42F212B8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:11:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCACDB825B4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 17:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFFFC433EF;
        Fri, 24 Mar 2023 17:11:38 +0000 (UTC)
Date:   Fri, 24 Mar 2023 17:11:35 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org, kexec@lists.infradead.org, ardb@kernel.org,
        rppt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] arm64: kdump : take off the protection on
 crashkernel memory region
Message-ID: <ZB3Zx85Ajnhzq3Pt@arm.com>
References: <20230324131838.409996-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324131838.409996-1-bhe@redhat.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 09:18:35PM +0800, Baoquan He wrote:
> Baoquan He (3):
>   arm64: kdump : take off the protection on crashkernel memory region
>   arm64: kdump: do not map crashkernel region specifically
>   arm64: kdump: defer the crashkernel reservation for platforms with no
>     DMA memory zones
> 
>  arch/arm64/include/asm/kexec.h    |  6 -----
>  arch/arm64/include/asm/memory.h   |  5 ----
>  arch/arm64/kernel/machine_kexec.c | 20 --------------
>  arch/arm64/mm/init.c              |  6 +----
>  arch/arm64/mm/mmu.c               | 43 -------------------------------
>  5 files changed, 1 insertion(+), 79 deletions(-)

This series works for me and it has a negative diffstat as well (though
I'm sure people will try to bring it back ;)).

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
