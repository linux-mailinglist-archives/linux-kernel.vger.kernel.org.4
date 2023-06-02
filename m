Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ED671FC36
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjFBIif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjFBIia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:38:30 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0579E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:38:29 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35273kMd018220;
        Fri, 2 Jun 2023 03:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=gXsHwXIkqIMPI+sU77tOM2/Q0dJ8eT8YqESfqpSpNww=;
 b=hZo2EPAHqAvS4bLxSPIRXIKHFOF/bnglY6aTEYtUhpLFUbZoi4imV2Mipf/XwqwJ0uP7
 SJWKMUkNQPp9ZCfD/H0bParGBbagDNJSCMdsHos6X3skgDrOQoq5wDqENjNLR2wBRslg
 ZgBQHn4u1caoSDCgYkQ3vSHv9w4FkwmBnW38idiXaL1qHdMYnpsvZ24h+FTQ9ENmejPd
 dmb8pd47QMgCQ7H+4Yg9QkIqaOTeqXJKF7J1wGk18ni6ap69qNcRb/+AnhwbuAA13R5G
 xkBnO6IEFueqGcx1EpHNYc9wNl5xWBDAp4iN479/PTHbeN0xgAsivCLlaavERFBEcASL mQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3quf90y5s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 03:38:12 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 2 Jun
 2023 09:38:10 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 2 Jun 2023 09:38:10 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 57E8715A4;
        Fri,  2 Jun 2023 08:38:10 +0000 (UTC)
Date:   Fri, 2 Jun 2023 08:38:10 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 4/4] soundwire: stream: Tidy do_bank_switch error messages
Message-ID: <20230602083810.GK68926@ediswmail.ad.cirrus.com>
References: <20230601161622.1808135-1-ckeepax@opensource.cirrus.com>
 <20230601161622.1808135-4-ckeepax@opensource.cirrus.com>
 <4e90380f-b328-5806-4305-0a794cadc550@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4e90380f-b328-5806-4305-0a794cadc550@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 8C9lHObPsMRu1WPHQ1nYgXrAnLxE34WY
X-Proofpoint-ORIG-GUID: 8C9lHObPsMRu1WPHQ1nYgXrAnLxE34WY
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 11:34:10AM -0500, Pierre-Louis Bossart wrote:
> On 6/1/23 11:16, Charles Keepax wrote:
> > Every error path in do_bank_switch prints an error message so there is no
> > need for the callers to also print error messages. Indeed in multi-master
> > cases these extra messages are confusing because they print out against a
> > random bus device whereas the do_bank_switch messages print against the bus
> > that actually failed.
> 
> Errm, what?
> 
> There is no way to know which bus failed in multi-master mode, and the
> 'stream' can span multiple buses so the use of pr_err was intentional.

Apologies this is the commit message not quite keeping pace with
the code base. Originally when I wrote the patch the error
message after do_bank_switch were a "dev_err(bus->dev", that was
then fixed up in commit d014688eb373 ("soundwire: stream: remove
bus->dev from logs on multiple buses").

> There's just no other way to report issues, and I don't see why one
> would remove such logs and fail silently.
> 
> I just don't get what you are trying to address.
>

The current code would say produce something like:

Bank switch failed: -5
_sdw_prepare_stream: do_bank_switch failed: -5

I am sensing you are keen to keep both error messages, so fair
enough I will drop that. Although worth noting originally before
that patch I mention above this would have been:

Bank switch failed: -5
do_bank_switch failed: -5

Which is really what I was attempting to address, that is clearly
redundant. Now with the addition of the function in the print I
guess it is slightly less redundant.

> > This also allows clean up of a couple of if's and variable initialisations
> > that were only there to silence potentially uninitialised variable
> > warnings on the bus variable.
> 
> That should be a separate patch IMHO.
> 

I will trim the patch down to leave the duplicate error messages
and just remove those bits.

Thanks,
Charles
