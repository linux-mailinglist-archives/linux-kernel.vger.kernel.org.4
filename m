Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075E9603463
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJRUzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJRUzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:55:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D2250523
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDD68616F4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CE9C433D6;
        Tue, 18 Oct 2022 20:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666126509;
        bh=/wjPaj4hMDgvB9PGYzwx7w23XxCmDgS1FeMxQ9Lnm/8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t6A6TUsmq2JbEbJPF9njM4iC/QgtcTd8Ie8guuS+lxgJow8hHqyHDECrTFzFOEIND
         TYh5EUoTvOkUT3id59yExMEevKehALV6PEULymcHTv+fiCRZCCe4/R+39vX/9x9hBB
         imwUJ1ccCDJ1WzY7UQOKdLp99XWaWAsSZzUk4d44=
Date:   Tue, 18 Oct 2022 13:55:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH] mm/memremap: Mark folio_span_valid() as __maybe_unused
Message-Id: <20221018135508.d1844e583974b03eaa9aa354@linux-foundation.org>
In-Reply-To: <634ee87229a37_6be129430@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221018152645.3195108-1-nathan@kernel.org>
        <634ee87229a37_6be129430@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 10:54:58 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> > ---
> > 
> > I am aware the Fixes SHA is probably not stable but I figured I would
> > include it anyways.
> 
> This fix looks good to me, but I assume commit-ids are not stable until
> the patch moves from mm-unstable to mm-stable. Andrew, do I have that
> right?

Yes, mm-unstable hashes change daily.  But knowing the title of the
patch which needs the fix is quite helpful.

