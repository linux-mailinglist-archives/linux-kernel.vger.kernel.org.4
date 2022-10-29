Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D938D611EB8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 02:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJ2A3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 20:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2A3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 20:29:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E0952DDA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 17:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667003386; x=1698539386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=129hnGUQvsxt/lwpqd+6L+N0PJvRLE66kgZPbDoSL7I=;
  b=PjzcDZ/1dXDVRvCe5DDckKKgEi9neT5WGziWAUOFrvAlo+SXYrIwK/de
   209VYVjynMqpj55UULtz6QkmXGy/QeT/tenzULZvvV1GD3WL7sXv17Ztp
   m4hfZaW3781aUqkk69jlzcCqglLvAkBFTZKmc1pCQG4qLONkksaRAlp76
   Pp4D2aQ7QXzHReyuoOYUZB1PGD6tBCPCm+VbAVrVeT0PNpU2RKjkQMdFL
   oRjq7UT9ptINkI9n+fmuX91CoqK2ZqoZe0f7svjUP4+3S8fyW9LE7HRS8
   q6ZSsBt7doDIGETwXiIlYdo5k9niWRM4+oiw/AspytBE/R/cMg/ux7IB2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="291914882"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="291914882"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 17:29:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="584104027"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="584104027"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.175.207])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 17:29:46 -0700
Date:   Fri, 28 Oct 2022 17:29:44 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v9 0/6] Checkpatch cleanup in rxtx.c
Message-ID: <Y1xz+ETEgDg5dd9u@aschofie-mobl2>
References: <cover.1666995639.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666995639.git.tanjubrunostar0@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tanjuate,

Wow - I've seen 4 revs of this in 12 hours?!

I reviewed each Patch against the feedback previously
offered, and it was not addressed, so I'm going to NAK
this set and ask you to rework carefully before resending.
I expect to see each specific piece of reviewer feedback,
called out as addressed in the changelog.

BTW - I still prefer a single patch at a time while you are
learning these mechanics, and to make sure that this type
of patch is going to be accepted.

If you are still amenable to doing that, keep the version,
but only send one patch at a time. When one gets accepted,
apply those learnings to the second patch, and so on.

That should go more smoothly for you and your reviewers.

Alison

On Fri, Oct 28, 2022 at 11:23:21PM +0000, Tanjuate Brunostar wrote:
> v9: reorganized the changelog messages on this patch
> 
> v8: made commit messages clearer, unsuccessfuly
> 
> v7: made log messages less confusing
> 
> v6: fixed some errors on commit messages
> 
> v5: shortend changelog comments
> 
> v4: made some changes on the code
> 
> v3: fixed compilation errors
> 
> v2: tried fixing compilation erros unsuccessfuly
> 
> Tanjuate Brunostar (6):
>   staging: vt6655: fix lines of code ending in a '('
>   staging: vt6655: split long lines of code in s_uGetRTSCTSDuration
>   staging: vt6655: split long lines of code in s_uFillDataHead
>   staging: vt6655: split long lines of code in s_vGenerateTxParamete
>   staging: vt6655: split long lines of code in some functions
>   staging: vt6655: fix lines of code ending in a '('
> 
>  drivers/staging/vt6655/rxtx.c | 542 ++++++++++++++++++++--------------
>  1 file changed, 324 insertions(+), 218 deletions(-)
> 
> -- 
> 2.34.1
> 
> 
