Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD456119EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJ1SLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJ1SLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:11:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D2C22E0F1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666980696; x=1698516696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lOfBg+KlCrq6cb2QH12RSluxIBmgdy3fmEm6/zLxFb0=;
  b=fz8i9bwwQ32bcMynZhO2OtXtUYPoThxklVeJEYNbf9Kk+EEpAtt9kW9N
   83+JMwxbQ9HnPB9BRSTWkFUC0/4+boHOME6GtJYt4R4gf+MUuzaUQCv5R
   989rF8P8XW9FZLwTtUXcRRkgOCvyxLPSaYRquiJMuQCeHjXn+5+xYFaF7
   ORGOad9/DGj1P97+0JwPTQo+GB85+0BpVASL+M5FGnSFurtUfEaITWWW2
   IfBKXxdweee1yaVoKNm8U5IRzuMgaMjFZNytrno6vCNdlLPI4sgs2sWGO
   nOJialLd4Nl4Pubvcd+nBmWVVFJj8eDZvHJSsbkxbOwTiweYzo95O/ryZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="308553286"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="308553286"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 11:11:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="627605452"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="627605452"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.175.207])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 11:11:35 -0700
Date:   Fri, 28 Oct 2022 11:11:33 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v8 0/6] staging: vt6655: a series of checkpatch fixes on
 the file: rxtx.c
Message-ID: <Y1wbVeLCLZClEQ6L@aschofie-mobl2>
References: <cover.1666978292.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666978292.git.tanjubrunostar0@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We know it's a patchset or series, saying so in subject line is 
redundant. Perhaps - 'Checkpatch cleanup in rxtx.c'

On Fri, Oct 28, 2022 at 05:40:52PM +0000, Tanjuate Brunostar wrote:
> The fixes are similar, mostly long lines splitting. I had to make
> serveral patches to ease the work of inspectors
  ^
Please use a spell checker.

> 
> v2: fixed a compilation error found by the kernel test robot and
> recompiled the code

Expected to be in reverse order, with latest changes first.
ie. Here you would start with v8

> v3: tends out the error persisted in the second version. this version is
> a correction of that

?

> 
> v4: did some corrections as recommended by Greg KH

State what changed. Do not expect your review to go back
hunting for past review comments.

Same for all below.

> 
> v5: shortend changelog comments as recommended by Greg KH
> 
> v6: did some corrections as recommended by Greg KH
> 
> v7: fixed some errors on my changelog comments
> 
> v8: fixed some errors pointed out by Philipp Hortmann
> 
> Tanjuate Brunostar (6):
>   staging: vt6655: fix lines ending in a '('

Move ( to end of line

>   staging: vt6655: fix long lines of code in s_uGetRTSCTSDuration

This doesn't match what was actually done

>   staging: vt6655: fix long lines of code in s_uFillDataHead
>   staging: vt6655: fix long lines of code in s_vGenerateTxParamete
>   staging: vt6655: fix long lines of code in the rest of the file

Each commit msg needs to stand alone. The one above only makes
sense (still it's a poor message) when viewed in this patchset.
Once the patches are applied, it must stand alone.

The commit msg should read like a directive. Fix is too general.
Commit msg states what you did, commit log states why you did it.

I see you took 'refactoring' out of the commit messages, but left it
in the commit logs. It doesn't belong in the logs. As another
reviewer pointed out, this is not a refactor.

Alison
> 
>  drivers/staging/vt6655/rxtx.c | 542 ++++++++++++++++++++--------------
>  1 file changed, 324 insertions(+), 218 deletions(-)
> 
> -- 
> 2.34.1
> 
> 
