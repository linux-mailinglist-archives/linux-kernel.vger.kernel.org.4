Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBEF6C6F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCWRpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWRpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:45:41 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0463AAE;
        Thu, 23 Mar 2023 10:45:40 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5m0Hh012881;
        Thu, 23 Mar 2023 12:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=4zZwoU/ke6dQ47Fpxm1JOoGRUjkQ68oE18bTPBtGnSQ=;
 b=n5SeMFeSWfjHR72rba5hOWcSboS2zdP1AeKv9THzzFBSlcPEJ12a/DByd5il3XUnlqLb
 C1yKny3Da/mHqTT0DG4dOXwrf3J7Joftn6iPX5sBNznD7MWz29/phFDD4wt+LPnYdmhO
 ac8C+BVv2zDzY8UXai1s++DWFP+fOulUqD1cWkeaxdvYFRVJ1oTLQFNkgG9OM+SeaKWD
 E2nbA6g4UGVTgTp3yaiAv6h6GiXVlX0nVcNW28B8Rj5CytKZwq0icldAWqrz278lJ2Z1
 cSEvzBo77CWcnfFm/aSN8K39N0sKDmjEoTsZRRrakj2dmfeugTLLb0Kmuxbf/77YXWGG Ug== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pf7tj597b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 12:45:33 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 23 Mar
 2023 12:45:31 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Thu, 23 Mar 2023 12:45:31 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C4E80B06;
        Thu, 23 Mar 2023 17:45:31 +0000 (UTC)
Date:   Thu, 23 Mar 2023 17:45:31 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Doug Anderson <dianders@chromium.org>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH] regulator: wm8994: Use PROBE_FORCE_SYNCHRONOUS
Message-ID: <20230323174531.GM68926@ediswmail.ad.cirrus.com>
References: <CGME20230323083330eucas1p1f7e3f9beb5ba168c6b13374d74c158f0@eucas1p1.samsung.com>
 <20230323083312.199189-1-m.szyprowski@samsung.com>
 <20230323114035.GL68926@ediswmail.ad.cirrus.com>
 <CAD=FV=UYO1KaoAZ7o5cA83SC1VHRomvJfaXVWyYPKrEZHyNNjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UYO1KaoAZ7o5cA83SC1VHRomvJfaXVWyYPKrEZHyNNjg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: BOPtBcpPpYEA3VAHEFh4VZ5WuTIQKaDu
X-Proofpoint-GUID: BOPtBcpPpYEA3VAHEFh4VZ5WuTIQKaDu
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 09:53:18AM -0700, Doug Anderson wrote:
> On Thu, Mar 23, 2023 at 4:40 AM Charles Keepax
> If my analysis is correct, there's still potential to run into similar
> problems even with PROBE_FORCE_SYNCHRONOUS. I don't think that
> mfd_add_devices() is _guaranteed_ to finish probing all the
> sub-devices by the time it returns. Specifically, imagine that
> wm8994_ldo_probe() tries to get a GPIO that that system hasn't made
> available yet. Potentially the system could return -EPROBE_DEFER there
> and that would put the LDO on the deferred probe list. Doing so won't
> cause mfd_add_devices() to fail. Now we'll end up with a dummy
> regulator again. Admittedly most cases GPIO providers probe really
> early and so this argument is a bit of a stretch, but I guess the
> point is that there's no official guarantee that mfd_add_devices()
> will finish probing all sub-devices so it's not ideal to rely on.
> Also, other drivers with a similar pattern might have other reasons to
> -EPROBE_DEFER.
> 
> These types of issues are the same ones I faced with DP AUX bus and
> the solutions were never super amazing...
> 
> One solution we ended up with for the DP AUX bus was to add a
> "done_probing" callback argument to devm_of_dp_aux_populate_bus().
> This allowed the parent to be called back when all the children were
> done probing. This implementation is easier for DP AUX bus than it
> would be in the generic MFD case, but conceivably it would be possible
> there too?
> 
> Another possible solution is to somehow break the driver up into more
> sub-drivers. Essentially, you have a top-level "wm8994" that's not
> much more than a container. Then you create a new-sub-device and
> relegate anything that needs the regulators to the new sub-device. The
> new sub-device can just -EPROBE_DEFER until it detects that the
> regulators have finished probing. I ended up doing stuff like this for
> "ti-sn65dsi86.c" using the Linux aux bus (not to be confused with the
> DP Aux bus) and it was a bit odd but worked OK.

Yes I believe you are correct, there is still an issue here,
indeed a quick test suggests I can still cause this by forcing a
probe defer in the regulator driver.

I think really the best place to look at this would be at the
regulator level. It is fine if mfd_add_devices passes, the problem
really is that the regulator core doesn't realise the regulator is
going to be arriving, and thus returns a dummy regulator, rather
than returning EPROBE_DEFER. If it did the MFD driver would probe
defer at the point of requesting the regulator, which would all
make sense.

I will see if I can find some time to think about that further
but very unlikely to happen this week.

Thanks,
Charles
