Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A604372CE7B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbjFLSeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjFLSeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:34:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C180A1711;
        Mon, 12 Jun 2023 11:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09654628E9;
        Mon, 12 Jun 2023 18:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3456EC433EF;
        Mon, 12 Jun 2023 18:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686594818;
        bh=Nb5X5bo+ew4Zt7z5zMsi3ZeUJLtS19io9VEBOewjWbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hafr2+mkzpv3gHWKge7eq0sB230h3g6bLAOK+7ruEGOP0pJaH69N5vq1tMcIR+iHj
         /YPLBh/pqBkCXAz6/zpLStfyMuVYd/UdzO7NP8I6TxPKYOGU9LnPZ6widyGuogizEA
         T352q9Sw9njpvr4pQw+cRC0pYxOW/md6SVpX3G0w=
Date:   Mon, 12 Jun 2023 11:33:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        npiggin@gmail.com
Subject: Re: [merged mm-hotfixes-stable]
 lazy-tlb-fix-hotplug-exit-race-with-mmu_lazy_tlb_shootdown.patch removed
 from -mm tree
Message-Id: <20230612113337.c33bed8dc3dc0811ce7c7a8a@linux-foundation.org>
In-Reply-To: <87zg576ip1.ffs@tglx>
References: <20230607200008.C2154C433D2@smtp.kernel.org>
        <87zg576ip1.ffs@tglx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jun 2023 00:44:42 +0200 Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, Jun 07 2023 at 13:00, Andrew Morton wrote:
> 
> > The quilt patch titled
> >      Subject: lazy tlb: fix hotplug exit race with MMU_LAZY_TLB_SHOOTDOWN
> > has been removed from the -mm tree.  Its filename was
> >      lazy-tlb-fix-hotplug-exit-race-with-mmu_lazy_tlb_shootdown.patch
> >
> > This patch was dropped because it was merged into the mm-hotfixes-stable branch
> > of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> 
> Can you please drop that completely as there is no point to merge a
> bogus "fix'.
> 

OK, I dropped this.  I also dropped "lazy tlb: consolidate lazy tlb mm
switching", as it no longer applied.

