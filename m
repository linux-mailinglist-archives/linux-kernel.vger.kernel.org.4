Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5387467D822
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjAZWDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjAZWDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:03:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A2CF2886A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:03:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7657D2F;
        Thu, 26 Jan 2023 14:03:59 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CC973F71E;
        Thu, 26 Jan 2023 14:03:16 -0800 (PST)
Date:   Thu, 26 Jan 2023 22:03:10 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH] regulator: scmi: Allow for zero voltage domains
Message-ID: <Y9L4nplArbRMP9DK@pluto>
References: <20230126180511.766373-1-cristian.marussi@arm.com>
 <Y9LInDhFoVkWMe7d@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9LInDhFoVkWMe7d@sirena.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 06:38:20PM +0000, Mark Brown wrote:
> On Thu, Jan 26, 2023 at 06:05:11PM +0000, Cristian Marussi wrote:
> > SCMI Voltage protocol allows the platform to report no voltage domains
> > on discovery, while warning the user about such an odd configuration.
> 
> This patch removes all diagnostics in this case?

You'll still see a warning from the SCMI core Voltage Protocol saying:

	"No Voltage domains found."

but nothing from the regulator driver itself which will successfully probe,
albeit not creating any regulators...if this is what you mean.

Thanks for having a look,
Cristian
