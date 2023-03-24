Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5506C7B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjCXJWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjCXJWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:22:13 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FC3233C6;
        Fri, 24 Mar 2023 02:21:51 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O737JW001266;
        Fri, 24 Mar 2023 04:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=PjojhDR+j8OZSSeQ3YV5sggRek06OGFFYeqFFzU5slg=;
 b=KT9Ed3WONEmFg0DvcMihUxIoW8cXUx9QddLgqk1QveYSM+I94fkw2kYmzzAM0ZqsInrC
 Y6eisyyALiteRfRLls2TpDAcQDb1Px+r0T8N6e4s3K/bHg1EfCXJUzwk3rKVSUfxN/nm
 EZtX+ppSZq7Ib082ZXsYinc9le0WWTNjhLNX7+jKH+jf+FpG20mw/wTjX7YP4d4h3HgS
 3Ms9HkBOFRWbIinxgmUfB5qwYGumSEMfiLXwa9+WNxK0ZUds+b2Ln7zP8pg9iSl4lSvp
 YNRwSR/0oSK/EIvRPlwZRxv/BSjKU95S9ribeQ+oQyn8HSUMKFMweBogNiLd3Uj2IGrz OA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pgy7drqyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 04:21:43 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 24 Mar
 2023 04:21:41 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Fri, 24 Mar 2023 04:21:41 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BC8C545;
        Fri, 24 Mar 2023 09:21:41 +0000 (UTC)
Date:   Fri, 24 Mar 2023 09:21:41 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Doug Anderson <dianders@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH] regulator: wm8994: Use PROBE_FORCE_SYNCHRONOUS
Message-ID: <20230324092141.GN68926@ediswmail.ad.cirrus.com>
References: <CGME20230323083330eucas1p1f7e3f9beb5ba168c6b13374d74c158f0@eucas1p1.samsung.com>
 <20230323083312.199189-1-m.szyprowski@samsung.com>
 <20230323114035.GL68926@ediswmail.ad.cirrus.com>
 <CAD=FV=UYO1KaoAZ7o5cA83SC1VHRomvJfaXVWyYPKrEZHyNNjg@mail.gmail.com>
 <20230323174531.GM68926@ediswmail.ad.cirrus.com>
 <beeef631-943a-40db-af09-753c96b5b140@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <beeef631-943a-40db-af09-753c96b5b140@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: 3-rM4yn8D5wWzFtoApgRb1-j2A2GC718
X-Proofpoint-GUID: 3-rM4yn8D5wWzFtoApgRb1-j2A2GC718
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:49:28PM +0000, Mark Brown wrote:
> On Thu, Mar 23, 2023 at 05:45:31PM +0000, Charles Keepax wrote:
> 
> > I think really the best place to look at this would be at the
> > regulator level. It is fine if mfd_add_devices passes, the problem
> > really is that the regulator core doesn't realise the regulator is
> > going to be arriving, and thus returns a dummy regulator, rather
> > than returning EPROBE_DEFER. If it did the MFD driver would probe
> > defer at the point of requesting the regulator, which would all
> > make sense.
> 
> You need the MFD to tell the regulator subsystem that there's a
> regulator bound there, or to force all the users to explicitly do the
> mapping of the regulator in their firmwares (which isn't really a
> viable approach).

Yeah changing the firmware situation is definitely not a goer. I
need to just clarify in my head exactly what is missing, with
respect to the know the regulator exists.

Thanks,
Charles
