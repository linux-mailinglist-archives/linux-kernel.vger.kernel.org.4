Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B636DD68D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjDKJ1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDKJ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:27:45 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A451736;
        Tue, 11 Apr 2023 02:27:44 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B4pNUi026389;
        Tue, 11 Apr 2023 04:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=tbVjMlrmInbvJ7aczvEH3xSHbYoDsBqY+xs8DjEREbo=;
 b=fry3zmp8rtSd424svKSkVlV9XPH/+OsPxxxWzpgHfXls0gLPKBKHu2p6gXEjUjFXnmXb
 VtRj6wWjqRrUeEQHiWuMp6BKZys6BKXfDmm+n+TTXDNXfS/JU6rHcONz551AiCIwSb9M
 YTe099nnLQ9135sinAH5H4MP5/GLNKvw7i+my416gYDwlpp5QI6d1Q7PSjwv3Cb3pZCp
 FofkWhSUeGk9JuTnsjbF1vrQtZPcBz6jWy6xkSHlyoDxqL8MF8z7qq2fTJ4YVJl0pR0W
 Y03Eg1t+a05gXr7eGMcPnQpL8ANHDFgMwn+Jg07eCvBvCj9+tdp5nUQQOalYxHXxh3+l jQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pu4pq4gnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 04:27:10 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 11 Apr
 2023 04:27:09 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 11 Apr 2023 04:27:09 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E486915A4;
        Tue, 11 Apr 2023 09:27:08 +0000 (UTC)
Date:   Tue, 11 Apr 2023 09:27:08 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Jeff LaBundy <jeff@labundy.com>
CC:     Fred Treven <fred.treven@cirrus.com>, <dmitry.torokhov@gmail.com>,
        <ben.bright@cirrus.com>, <james.ogletree@cirrus.com>,
        <lee@kernel.org>, <jdelvare@suse.de>, <joel@jms.id.au>,
        <cy_huang@richtek.com>, <rdunlap@infradead.org>,
        <eajames@linux.ibm.com>, <ping.bai@nxp.com>, <msp@baylibre.com>,
        <arnd@arndb.de>, <bartosz.golaszewski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] Input: cs40l26: Support for CS40L26 Boosted Haptic
 Amplifier
Message-ID: <20230411092708.GX68926@ediswmail.ad.cirrus.com>
References: <SupportforCS40L26BoostedHapticAmplifier>
 <1680819415-28806-1-git-send-email-fred.treven@cirrus.com>
 <ZDI0p5Rkp74SzJCv@nixie71>
 <20230410085634.GV68926@ediswmail.ad.cirrus.com>
 <ZDSqfHemG8pKj1k7@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDSqfHemG8pKj1k7@nixie71>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: UOXRTSioca8bC0ylK2hAIDGKJ6guRXkM
X-Proofpoint-ORIG-GUID: UOXRTSioca8bC0ylK2hAIDGKJ6guRXkM
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 07:31:56PM -0500, Jeff LaBundy wrote:
> On Mon, Apr 10, 2023 at 08:56:34AM +0000, Charles Keepax wrote:
> > On Sat, Apr 08, 2023 at 10:44:39PM -0500, Jeff LaBundy wrote:
> > I would far rather not have every single attempt to communicate
> > with the device wrapped in a retry if the communication failed
> > incase the device is hibernating. It seems much cleaner, and less
> > likely to risk odd behaviour, to know we have brought the device
> > out of hibernation.

> A common way to deal with this is that of [1], where the bus calls
> are simply wrapped with all retry logic limited to two places (read
> and write). These functions could also print the register address
> in case of failure, solving the problem of having dozens of custom
> error messages thorughout the driver.

I suspect this really comes down to a matter of taste, but my
thoughts would be that the code is shorter that way, but not
necessarily simpler. This feels far more error prone and likely
to encounter issues where the device hibernates at a time someone
hadn't properly thought through. I am far more comfortable with
the device is blocked from hibernating whilst the driver is
actively engaged with it and it keeps any special handling for
exiting hibernate in one place.

> Does the current implementation at least allow the device to hibernate
> while the system is otherwise active, as opposed to _only_ during
> runtime suspend? If so, that's still a marked improvement from L25
> era where customers rightfully pointed out that the downstream driver
> was not making efficient use of hibernation. ;)

I am not entirely sure I follow this one, yes the device can only
hibernate whilst it is runtime suspended. But I don't understand
why that is a problem being runtime resumed implies this device
is active, not the system is otherwise active. I am not sure if
I am missing your point or there is some confusion here between
runtime and system suspend. The device can only hibernate during
runtime suspend, but the only thing that determines being runtime
resumed is activity on this device so in general it shouldn't be
hibernating at that point anyway.

> I don't feel particularly strongly about it, so if the current
> implementation will stay, perhaps consider a few comments in this
> area to describe how the device's state is managed.
> 

I certainly never object to adding some comments.

Thanks,
Charles
