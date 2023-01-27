Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA6D67E87C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjA0Ols (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjA0Oln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:41:43 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481C183045;
        Fri, 27 Jan 2023 06:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674830502; x=1706366502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZRGIvL3M9OUyZouslOGgrzIuwLCzxUKq9L9bwPEwfGs=;
  b=ZVXdRpYjsGn2FmVzv6L+YZ4MLcWtUBeMhR2vKWxttdgjnVzph51PPBHr
   8GR6/gdadzqdvL4S637EtVL/2nHkarVDJCSJ39Q1AakzffT7HU9gNvNFq
   6CWBOzWhYIN+/InST2X5rcr62fLmX5aRrbidy7goPL3cCUfmFt4yFAiUD
   WK2Fs19ditd2qZkIOhaspBp/WnlzSE9LKEm3wm5IatxcseQR36Q3I1itz
   1MmGavN19ntmfw3J041my/Ek7kYRj8cRpwU8wJyRP3F6jV9XID025eXTy
   c6rDd/5nUTNA7+vuIQJtcA4KDyM1Bd4/KqdMwA9KOkFmINl2jsv5rItiN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="328383803"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="328383803"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 06:41:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="837134238"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="837134238"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 27 Jan 2023 06:41:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pLPv7-00G0PD-24;
        Fri, 27 Jan 2023 16:41:37 +0200
Date:   Fri, 27 Jan 2023 16:41:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 2/2] kbuild: make W=1 warn files that are tracked but
 ignored by git
Message-ID: <Y9PioQHu2ShZ2veo@smile.fi.intel.com>
References: <20221229074310.906556-1-masahiroy@kernel.org>
 <20221229074310.906556-2-masahiroy@kernel.org>
 <Y9PQxCTJGTRU1cuE@smile.fi.intel.com>
 <CAK7LNASJ6j7XEZ-poS+Qq+8nZ5iztLTuTSgkr+fMka7HYH8ekQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASJ6j7XEZ-poS+Qq+8nZ5iztLTuTSgkr+fMka7HYH8ekQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:31:07PM +0900, Masahiro Yamada wrote:
> On Fri, Jan 27, 2023 at 10:25 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Thu, Dec 29, 2022 at 04:43:10PM +0900, Masahiro Yamada wrote:
> > > The top .gitignore comments about how to detect files breaking
> > > .gitignore rules, but people rarely care about it.
> > >
> > > Add a new W=1 warning to detect files that are tracked but ignored by
> > > git. If git is not installed or the source tree is not tracked by git
> > > at all, this script does not print anything.
> > >
> > > Running it on v6.2-rc1 detected the following:
> >
> > Since patch was published there is no sign it was ever meet Linux Next.
> > What's the plan?
> 
> Oh?

Sorry, my mistake. I need to understand why these patches do not fix
the issue I have.

> I can see this patch in linux-next.
> 
> $ git log next-20230127 -- scripts/misc-check

-- 
With Best Regards,
Andy Shevchenko


