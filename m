Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FE96134E7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiJaLuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiJaLuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:50:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4430EE10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:50:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B69491FB;
        Mon, 31 Oct 2022 04:50:13 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.5.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 428EB3F5A1;
        Mon, 31 Oct 2022 04:50:06 -0700 (PDT)
Date:   Mon, 31 Oct 2022 11:50:03 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, catalin.marinas@arm.com,
        will@kernel.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: entry: Fix typo
Message-ID: <Y1+2a1syAdi2R7xD@FVFF77S0Q05N>
References: <1667027268-1255-1-git-send-email-quic_mojha@quicinc.com>
 <Y10sNSE6/B2p95+I@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y10sNSE6/B2p95+I@debian.me>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 08:35:49PM +0700, Bagas Sanjaya wrote:
> On Sat, Oct 29, 2022 at 12:37:48PM +0530, Mukesh Ojha wrote:
> >  /*
> >   * Handle IRQ/context state management when exiting a debug exception from
> >   * kernel mode. After this function returns it is not safe to call regular
> > - * kernel code, intrumentable code, or any code which may trigger an exception.
> > + * kernel code, instrumentable code, or any code which may trigger an exception.
> >   */
> >  static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
> >  {
> 
> What about "... it is unsafe to call regular kernel, instrumentable, or
> any other code ..." instead?

I much prefer this as-is, but with the typo fixed.

Thanks,
Mark.
