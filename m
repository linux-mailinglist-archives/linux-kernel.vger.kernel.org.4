Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3DF68F18D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjBHPDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjBHPDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:03:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6DB732506;
        Wed,  8 Feb 2023 07:03:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 102221477;
        Wed,  8 Feb 2023 07:03:54 -0800 (PST)
Received: from bogus (unknown [10.57.10.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EB9C3F8C6;
        Wed,  8 Feb 2023 07:03:09 -0800 (PST)
Date:   Wed, 8 Feb 2023 15:03:06 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Kazuki <kazukih0205@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: s2idle breaks on machines without cpuidle support
Message-ID: <20230208150306.ve2pnt3pvlmf5wbu@bogus>
References: <20230204152747.drte4uitljzngdt6@kazuki-mac>
 <20230206101239.dret3fv65cnzpken@bogus>
 <20230207194818.exskn3dhyzqwr32v@kazuki-mac>
 <20230208103511.w7jzxw6spy6humdn@bogus>
 <20230208112031.sdfuluajjerf4wwp@kazuki-mac>
 <20230208141658.kede5ylqk4zqvrnj@bogus>
 <20230208144327.3ftjxnquwhsdykfc@kazuki-mac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208144327.3ftjxnquwhsdykfc@kazuki-mac>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:43:27PM +0900, Kazuki wrote:
> On Wed, Feb 08, 2023 at 02:16:58PM +0000, Sudeep Holla wrote:

[...]

> > I was about ask you earlier as why can't you implement just system
> > suspend in PSCI where the last cpu just calls WFI if you are interested
> > in system sleep state. Or you can implement CPU_SUSPEND with an additional
> > retention state which enters PSCI implementation just to make sure there is
> > an active cpuidle driver and the s2idle state machinery works as expected.
>
> The machine I have (Macbook with Apple M1) doesn't have PSCI.

Well, if we are allowing to boot on such a system, then we must allow
adding a platform specific idle driver. It may be useful once we info
to add deeper than WFI states.

> I guess we should ensure that systems without a cpuidle driver
> will not suspend maybe around here then.
>

Are we ? I thought were making changes to enable it. Or are you saying
we allow to enter into such a state and render the system unusable, if
so we need to fix it.

--
Regards,
Sudeep
