Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EA55F2FCB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 13:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJCLpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 07:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJCLpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:45:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785DD1837E;
        Mon,  3 Oct 2022 04:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664797502; x=1696333502;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=LHek2QVys//zPdkCoc7Ih96b13PllPOVQVjSU9pfDqk=;
  b=OiZIy1j1E0UC4Hbxa344IosrG1kjlUWTQN9FGRjGBgLQXQphfsGQw7CJ
   /o1ghrrMv0kv/Gg0ptBKl70eXNRa2lgdt5k80yMtk3gEfN96rgdwdapNo
   GOiMC8W5jNAHhMqi7MurvSUR6Cs5ecuRQqmrtMQ1QBxsArsN5FhzBjnt6
   TZAPR6CG5vkhnw2RhtvW/nmDF8pvprQwFiNkXOUE9DXeAMy5+vt82zKpj
   8PrQe13AyW4Gv/4vgk2PnmcU8qLD5xYgJ2ZGNYGAxSykxwvvr6FA7MUyk
   wxsOFz15R8Yv0yt+KRZwi/Xij4620Mv0qZoakq+00b1yyWLlcrjYAM9vd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="329006940"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="329006940"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 04:45:01 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="686081568"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="686081568"
Received: from zlukwins-mobl.ger.corp.intel.com (HELO localhost) ([10.252.60.249])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 04:44:58 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
In-Reply-To: <YzcL8VLpk00hC1so@pendragon.ideasonboard.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
 <20220929130410.hxtmwmoogzkwcey7@meerkat.local>
 <5d15ec50-e0b7-dc90-9060-3583633070e8@leemhuis.info>
 <52d93e6c-c6f0-81dd-07ca-cdae13dffba4@gmx.com>
 <YzcL8VLpk00hC1so@pendragon.ideasonboard.com>
Date:   Mon, 03 Oct 2022 14:44:55 +0300
Message-ID: <87y1txuo5k.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> E-mail *clients* are horrible to keep track of state. E-mail itself,
> as in RFC822 (and newer), SMTP and other protocols, only handle
> transport of data. As the data within the e-mail body is free-formed,
> and wasn't meant to track items and their state, clients never evolved
> in that direction.

Email is a massively distributed software fuzzing project that lets you
transmit messages in the sideband. :p

> Bugzilla won't solve this. The huge elephant in the room is that most
> maintainers are overworked. Whether a bug report arrives in my mailbox
> as an e-mail straight from the reporter or from a bug tracker will
> make very little difference if I don't have time to look into it (I
> would even argue that bug trackers are even worse there: if I'm really
> short of time, I'm more likely to prioritize replying to e-mails
> instead of having to open a link in a web browser).

I think a bug tracker helps in quantifying the problems you have,
though, including the maintainer bandwidth. Email doesn't easily lend
itself to that kind of analysis. I can't point managers at list emails
and ask for help. And if you do get people to help, having a centralized
place for the bug data helps them.

The flip side is that it's easier for me to ignore notification mails
from a bug tracker because I know the info isn't lost in a sea of other
mails.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
