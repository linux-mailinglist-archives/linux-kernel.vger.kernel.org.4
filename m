Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35CC5F3D88
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJDH4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJDH4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:56:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D3F2CCB9;
        Tue,  4 Oct 2022 00:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664870201; x=1696406201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qb9fbv/Io45XqXq5yw/xMnK70ks44Jqm3hPSzeSs3eY=;
  b=cr7kIxzGYkxdTqPCnw5bZdNLWD+nyVNWf9nr1MJBJy+LgXl68oINIk33
   Z09Yv7nAt1b/LZYndsF4Tx4uY6KOV4rarsugA7gJC7FyDDP4ya9gfCp8J
   gVUwWVqdGKv9nBvGE6vSj3RVM5f/KYQ8jgeaPoCObTv4hRxvQYawBoynH
   WobNb3iwAvwqpataJZCtCXbaxDZCtVILtc5vZ9Wu0ax+qPi2rQN9eEd51
   LxVcVJY+562xqD89iE+TuQvwvzUq0io+bl/4SiSIGn9qTWZdyV3f2RzAp
   0ifUIfqYMBjFBp2Jcwrncg9NR9hsssWBC2hgAO5C7S8O9Ko2709J1eJCI
   w==;
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="180241548"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2022 00:56:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 4 Oct 2022 00:56:39 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 4 Oct 2022 00:56:36 -0700
Date:   Tue, 4 Oct 2022 08:56:15 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
CC:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        <workflows@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        <ksummit@lists.linux.dev>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <YzvnH3NROBu4U5kW@wendy>
References: <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home>
 <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
 <20221002180844.2e91b1f1@rorschach.local.home>
 <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
 <YzoY+dxLuCfOp0sL@ZenIV>
 <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com>
 <YzqjfU66alRlGk5y@kernel.org>
 <20221003153718.o7fhrain5fnwwu3l@meerkat.local>
 <109147a2-621d-d4ce-f4b3-8516664e138e@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <109147a2-621d-d4ce-f4b3-8516664e138e@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 09:37:29AM +0200, Thorsten Leemhuis wrote:
> On 03.10.22 17:37, Konstantin Ryabitsev wrote:
> >
> > If we auto-create accounts for MAINTAINERS, that would allow them to be cc'd
> > by an actual human being triaging bugs, [...]
> 
> For the record: that would not be enough, as for bisected regressions
> you often want to CC the author of the culprit who might not be a

And possibly those who provided a review for the original patch too.

> maintainer. To catch that case as well, you'd have to create account for
> everyone that contributes a change.

As someone blissfully unaware of the workings of bugzilla, it is
possible to tie multiple emails to the same account? Not that I would be
happy about having an account created for me, but I certainly would not
want more than one account..

Thanks,
Conor.
