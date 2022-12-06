Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA244643E66
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiLFIWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiLFIWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:22:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54557BA6;
        Tue,  6 Dec 2022 00:22:17 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1043721C00;
        Tue,  6 Dec 2022 08:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670314935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WaCu1Ojq4kfH2gp2d92pnAhcFNf7wSvBwoos1Dg52Z4=;
        b=FahdYhpuOA/qTKpNsfBSSERYQqID5rfXSpwFO+xZphaMEyZsP+zAeUki946qxFfiKgaM67
        eLmdcGTw/Pyu1Z9hfzft2pD+PZAnZ0uj/rfWcQWGG8inS7uLhBV1VUWXcab+P76tbcHfsy
        Z2f/mA6mTNtPbbUdNJTZZQXX0h7kBJQ=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9B7A62C141;
        Tue,  6 Dec 2022 08:22:14 +0000 (UTC)
Date:   Tue, 6 Dec 2022 09:22:14 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH v1 0/2] PM: sleep: Avoid using pr_cont() in tasks
 freezing code
Message-ID: <Y477tlqofSqUpd8M@alley>
References: <4441789.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4441789.LvFx2qVVIh@kreacher>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-12-01 19:31:59, Rafael J. Wysocki wrote:
> Hi All,
> 
> The first patch in this series rearranges the tasks freezing code used during
> system-wide suspend and hibernation to avoid printing continuation messages
> with pr_cont() which is problematic.
> 
> The second patch refines one more message in that code on top of the first one.

Both patches seems to do what they are supposed to do. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

That said, I am not familiar with the freezer code. For example, I was
not aware of linux-pm/tools/power/pm-graph/sleepgraph.py. Anyway,
both changes make perfect sense and I do not see any problem.

Best Regards,
Petr
