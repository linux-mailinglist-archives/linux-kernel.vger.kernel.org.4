Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A61B74613A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGCRPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGCRPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:15:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9C89B2;
        Mon,  3 Jul 2023 10:15:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A1662F4;
        Mon,  3 Jul 2023 10:15:53 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.27.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D85E3F663;
        Mon,  3 Jul 2023 10:15:08 -0700 (PDT)
Date:   Mon, 3 Jul 2023 18:15:02 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, ast@kernel.org,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        catalin.marinas@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 0/3] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
Message-ID: <ZKMCFtlfJA1LfGNJ@FVFF77S0Q05N>
References: <20230626085811.3192402-1-puranjay12@gmail.com>
 <7e05efe1-0af0-1896-6f6f-dcb02ed8ca27@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e05efe1-0af0-1896-6f6f-dcb02ed8ca27@iogearbox.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 06:40:21PM +0200, Daniel Borkmann wrote:
> Hi Mark,

Hi Daniel,

> On 6/26/23 10:58 AM, Puranjay Mohan wrote:
> > BPF programs currently consume a page each on ARM64. For systems with many BPF
> > programs, this adds significant pressure to instruction TLB. High iTLB pressure
> > usually causes slow down for the whole system.
> > 
> > Song Liu introduced the BPF prog pack allocator[1] to mitigate the above issue.
> > It packs multiple BPF programs into a single huge page. It is currently only
> > enabled for the x86_64 BPF JIT.
> > 
> > This patch series enables the BPF prog pack allocator for the ARM64 BPF JIT.

> If you get a chance to take another look at the v4 changes from Puranjay and
> in case they look good to you reply with an Ack, that would be great.

Sure -- this is on my queue of things to look at; it might just take me a few
days to get the time to give this a proper look.

Thanks,
Mark.
