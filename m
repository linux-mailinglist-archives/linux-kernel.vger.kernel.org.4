Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D96868F213
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjBHPeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjBHPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:34:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2A1036698;
        Wed,  8 Feb 2023 07:34:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD9ED1477;
        Wed,  8 Feb 2023 07:34:55 -0800 (PST)
Received: from bogus (unknown [10.57.10.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23E203F8C6;
        Wed,  8 Feb 2023 07:34:10 -0800 (PST)
Date:   Wed, 8 Feb 2023 15:34:07 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Kazuki <kazukih0205@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: s2idle breaks on machines without cpuidle support
Message-ID: <20230208153407.4a5vnbctf77xf5vf@bogus>
References: <20230204152747.drte4uitljzngdt6@kazuki-mac>
 <20230206101239.dret3fv65cnzpken@bogus>
 <20230207194818.exskn3dhyzqwr32v@kazuki-mac>
 <20230208103511.w7jzxw6spy6humdn@bogus>
 <20230208112031.sdfuluajjerf4wwp@kazuki-mac>
 <20230208141658.kede5ylqk4zqvrnj@bogus>
 <20230208144327.3ftjxnquwhsdykfc@kazuki-mac>
 <20230208150306.ve2pnt3pvlmf5wbu@bogus>
 <20230208151939.meya6c5gayspvmtr@kazuki-mac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208151939.meya6c5gayspvmtr@kazuki-mac>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 12:19:39AM +0900, Kazuki wrote:
> On Wed, Feb 08, 2023 at 03:03:06PM +0000, Sudeep Holla wrote:

[...]

> > Well, if we are allowing to boot on such a system, then we must allow
> > adding a platform specific idle driver. It may be useful once we info
> > to add deeper than WFI states.
>
> Hmmm, I thought for arm64, non-PSCI idle drivers were prohibited? Or am
> I mistaken here?

I don't know. I am not against it especially now that we have allowed a
non-PSCI based production system to boot the kernel.

> > Are we ? I thought were making changes to enable it. Or are you saying
> > we allow to enter into such a state and render the system unusable, if
> > so we need to fix it.
>
> Both as I mentioned in my first email. Apologies if it turned out to
> be confusing.

Sorry still confusing. Are you saying you can enter s2idle and crash or
hang the system without changes(especially around this s2idle code) ?

If yes, then it is a bug. If the hang/crash is only after your changes,
we need to check.

-- 
Regards,
Sudeep
