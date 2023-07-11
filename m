Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC2174EB98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjGKKPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGKKPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:15:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6059E;
        Tue, 11 Jul 2023 03:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689070550; x=1720606550;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5JKHxewAX38O2bl/4vldtDfvVadZmqcSMbKGWm6ot3k=;
  b=jbYvQOGUYgCsqB+P2IfvYNMAp50HGicPQclJM+O5Btc7pILEus3amk5u
   fP60Aj+3zPdYka0IadmTNF00NUgbjARckqeWSateto0A/QlrGuLyIdpT5
   xYNGTlz263JB9FQYxDOz63HQdVkjuY8/6/wYr60fF7+gbeK80irD4KO5o
   voXQiXEQqRp6tjmTb8gYVD+mNnxijeXtaS+g5ZUS9NI+lYCbdal87y1do
   TvNXCEJaR1688jP1QokH59A7X50u+motXbKYevvTpSQhgExeivhdxVoPL
   tViuto3YaakOx3ktMu+pkKD+4G3HMjJmJDI2IJ2YqNwzf8kOi9gZkFyFO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="364616391"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="364616391"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 03:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="967739956"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="967739956"
Received: from sneaga-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.52.179])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 03:15:47 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 1/3] docs: stable-kernel-rules: mention other
 usages for stable tag comments
In-Reply-To: <d30686781c47c83927e0a41f6a1167a679fa822c.1689008220.git.linux@leemhuis.info>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1689008220.git.linux@leemhuis.info>
 <d30686781c47c83927e0a41f6a1167a679fa822c.1689008220.git.linux@leemhuis.info>
Date:   Tue, 11 Jul 2023 13:15:44 +0300
Message-ID: <871qheiwj3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> Document how to delay backporting or send a note to the stable team
> using shell-style inline comments attached to stable tags.
>
> CC: Greg KH <gregkh@linuxfoundation.org>
> CC: Sasha Levin <sashal@kernel.org>
> CC: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/process/stable-kernel-rules.rst | 22 ++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> index 51df1197d5ab..6e4026dd6882 100644
> --- a/Documentation/process/stable-kernel-rules.rst
> +++ b/Documentation/process/stable-kernel-rules.rst
> @@ -55,9 +55,10 @@ To have the patch automatically included in the stable tree, add the tag
>  
>       Cc: stable@vger.kernel.org
>  
> -in the sign-off area. Once the patch is merged it will be applied to
> -the stable tree without anything else needing to be done by the author
> -or subsystem maintainer.
> +in the sign-off area; to accompany a note to the stable team, use a shell-style
> +inline comment (see below for details). Once the patch is merged it will be
> +applied to the stable tree without anything else needing to be done by the
> +author or subsystem maintainer.
>  
>  .. _option_2:
>  
> @@ -139,6 +140,21 @@ The tag has the meaning of:
>  
>  For each "-stable" tree starting with the specified version.
>  
> +To delay pick up of patches submitted via :ref:`option_1`, use the following
> +format:
> +
> +.. code-block:: none
> +
> +     Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
> +
> +For any other requests related to patches submitted via :ref:`option_1`, just
> +add a note to the stable tag. This for example can be used to point out known
> +problems:
> +
> +.. code-block:: none
> +
> +     Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for >= 6.3
> +

To me, this seems like promoting *any* free text after the #, making it
harder to parse in scripts.

Of course, I'm only ever producing this, and never consuming, so if the
manual reading is fine for the stable developers, who am I to argue.


BR,
Jani.


>  Following the submission:
>  
>   - The sender will receive an ACK when the patch has been accepted into the

-- 
Jani Nikula, Intel Open Source Graphics Center
