Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D455BA1B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 22:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIOUGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 16:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiIOUGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 16:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270E83FA3D;
        Thu, 15 Sep 2022 13:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC04162651;
        Thu, 15 Sep 2022 20:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C0DC433D6;
        Thu, 15 Sep 2022 20:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663272401;
        bh=de7jzm93A3T+Xyc6RXxLW+F0i/C5VJ38aJEFDi9L3so=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qgiRHoEIAC0V5qvPL+C0yZCzzWDEHEFYgKtbkuTkKy03ayJTMrK5oFhtrqnEqqevV
         +1/MGnvKkzvj3yCAFJ4rPAL2PUHLfpA6NXfL5GO096QeI+cBQEJQ0HUYi3dHUC4o32
         U5heB67UUVl2haE/M/lsGD6c0hoRMZ+h7olYvxx4=
Date:   Thu, 15 Sep 2022 13:06:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-Id: <20220915130640.cec443b3ffb6650e16d9e610@linux-foundation.org>
In-Reply-To: <YyNUtA1vRASOE4+M@monkey>
References: <20220915170758.71068f92@canb.auug.org.au>
        <YyNUtA1vRASOE4+M@monkey>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2022 09:37:08 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> Andrew, the following change to 47bc61e7caf9 ("hugetlb: add vma based lock for
> pmd sharing") will fix the issue.  Would you like to just add the fix, or
> would you like another version of 47bc61e7caf9, or perhaps another version of
> the series?  Happy to do whatever is easier for you.

This simple fix is easiest for me.  More importantly, I think it's
easier for reviewers, who don't have to plough through a whole new
series unsure what might have changed.
