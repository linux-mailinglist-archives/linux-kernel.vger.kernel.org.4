Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90455F49A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJDTVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJDTVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:21:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5905051431;
        Tue,  4 Oct 2022 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664911305; x=1696447305;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Zg8xdnyfsZdNuvruzNB7XQ6E8sleAaO4vNo0suv9IoE=;
  b=DKHNsb7Hlp9VJwEkmNc9HOPPXsQnR1DQjC48hsYctxAIdfh07XU7cM53
   LR5bi29emNyACbqvhF7gsWUo02TODXkEo+iAYWofTligON2j27ikuESKU
   nawW3aHinaVTHjD7IdZKxWGNYueRRPbKmJ95LZl4k815yBvcK9hXMLUWE
   3qkPHA5/6THrxC6A3q54H2lEkoXiUFlbTVhp5Q6tdL4M4jNs2WmqJ4mIS
   CPgFi6Shg3IAMwA1dDr3s1nRzy1KsdP8npMAhmHN8l9++PU5aH6/OOEOr
   0ETAa+2ZdbcpJx4YggpvHdgFw+339znYOtTJXxT7V9OhVK3OD2yEnAekD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="364925484"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="364925484"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 12:21:33 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="575144544"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="575144544"
Received: from pvarla-mobl4.gar.corp.intel.com (HELO localhost) ([10.252.39.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 12:21:30 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     "Artem S. Tashkinov" <aros@gmx.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
In-Reply-To: <20221004175354.bfvg3vhfqch35ib5@meerkat.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <20221004175354.bfvg3vhfqch35ib5@meerkat.local>
Date:   Tue, 04 Oct 2022 22:21:27 +0300
Message-ID: <87fsg3s8co.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Oct 2022, Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> I'm happy to take care of everything bot-related (apparently, programming bots
> is what I do now -- I just wish it was the cool and glamorous kind).

As to bots, one idea would be to go through old & unchanged bugs after
every kernel release or so, ask to reproduce on the new kernel, and auto
close if there's no response within some time frame. This could be very
relaxed for starters, but would start closing all the stale and
neglected bugs that have crept up that are of no use to anyone.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
