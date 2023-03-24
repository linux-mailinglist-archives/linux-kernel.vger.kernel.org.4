Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C836C7B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjCXJYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjCXJYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:24:08 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C11C23A78;
        Fri, 24 Mar 2023 02:24:07 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O7kB4s028357;
        Fri, 24 Mar 2023 04:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=YX4W9MdvoAZtuc1bquhjvBcfk8W3dvwqaQOVgNc1aDo=;
 b=ppylE8CQ3XqKGunHvLvpvRjEbAFMLkgCrNeD39vUqxVDAE4R+NFvLzuY0Ipitr6QMwFU
 1RhzlkXRFlan9+kPHLkweDOtELcLT5AnHfBe2oZeYxGKpSYlJUxF9RLAWYfcVRK8sHZY
 zzQNvwHzUt8OclEwG4ukkLZZeCQ58qiGGwAj611YCiz6qpt6iViBgdzYxAt41DfVlEgZ
 DoD9iDfPgDLXSLGzL1REvyHwg8FaJxzazwONNb9Wk2Kj7ew1X6G/w1SW+h0xt0ze+drq
 iu83eQTTQ9qVagMxOQ8xLpRCXlUfh8OI/h4MO9YfKQbSRv/FAAsJnFOsFPoFM8GsoUd8 vQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pgy30gn2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 04:23:55 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 24 Mar
 2023 04:23:53 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 24 Mar 2023 04:23:53 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0A34DB06;
        Fri, 24 Mar 2023 09:23:53 +0000 (UTC)
Date:   Fri, 24 Mar 2023 09:23:53 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Doug Anderson <dianders@chromium.org>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH] regulator: wm8994: Use PROBE_FORCE_SYNCHRONOUS
Message-ID: <20230324092353.GO68926@ediswmail.ad.cirrus.com>
References: <CGME20230323083330eucas1p1f7e3f9beb5ba168c6b13374d74c158f0@eucas1p1.samsung.com>
 <20230323083312.199189-1-m.szyprowski@samsung.com>
 <20230323114035.GL68926@ediswmail.ad.cirrus.com>
 <CAD=FV=UYO1KaoAZ7o5cA83SC1VHRomvJfaXVWyYPKrEZHyNNjg@mail.gmail.com>
 <20230323174531.GM68926@ediswmail.ad.cirrus.com>
 <CAD=FV=X0SAEk_iUGQ=J-PWk_MzVc7ZikBM3N8rrnhGFzcdBNpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=X0SAEk_iUGQ=J-PWk_MzVc7ZikBM3N8rrnhGFzcdBNpw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: YOwIOATtHdJfrMHP7esprxLpyJ1QleCJ
X-Proofpoint-ORIG-GUID: YOwIOATtHdJfrMHP7esprxLpyJ1QleCJ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 11:00:32AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Mar 23, 2023 at 10:45 AM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > I think really the best place to look at this would be at the
> > regulator level. It is fine if mfd_add_devices passes, the problem
> > really is that the regulator core doesn't realise the regulator is
> > going to be arriving, and thus returns a dummy regulator, rather
> > than returning EPROBE_DEFER. If it did the MFD driver would probe
> > defer at the point of requesting the regulator, which would all
> > make sense.
> 
> I think something like your suggestion could be made to work for the
> "microphone" supply in the arizona MFD, but not for the others looked
> at here.
> 
> The problem is that if the MFD driver gets -EPROBE_DEFER then it will
> go through its error handling path and call mfd_remove_devices().
> That'll remove the sub-device providing the regulator. If you try
> again, you'll just do the same. :-)
> 
> Specifically in wm8994 after we've populated the regulator sub-devices
> then we turn them on and start talking to the device.
> 
> I think the two options I have could both work for wm8994's case:
> either add some type of "my children have done probing" to MFD and
> move the turning on of regulators / talking to devices there, or add
> another stub-device and add it there. ;-)

Is this true if we keep the regulator as sync though? Yes it will
remove the children but when it re-adds them the reason that the
regulator probe deferred in the first place will hopefully be
removed. So it will now fully probe in path.

Thanks,
Charles
