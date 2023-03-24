Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FAB6C81AC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjCXPoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjCXPo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:44:28 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC9910253;
        Fri, 24 Mar 2023 08:44:24 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O4NqGq019840;
        Fri, 24 Mar 2023 10:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=g/TnY/OaO04QVHLYcuDQ+/2YAxNGLMjLvSnsiN8wOwg=;
 b=RX36056P1uMVGeGv0VhDmCi02rzFdesHzLHQhTvJlXXNZFOea4q1RTKPMQ8mByVYXC9T
 eLXzUTWeIMjwMb6EmIfL5w/6Qyyyy/gHywQA7izSdxWv+ASlnsBGXmf8ziXuxYfOOHt0
 MW+YhCVcCp4nIi0LIz0lvdu0QKlVUTWTw06MggzOtothh2fiG4x+vgACFAQ6PYiIXzv5
 Hh67sUiSPjDe3+/jX1uANeve2TywVaDIhllCzR5Y0o6dHL1MiDxTot3Rm2IwjqiA/9Pp
 yjvKjcXRulYzYblKKm1PH9UKgCOkm0T3v1awoL88SkyoX0+2/sKTLp6TOrh1kTTBOdqb 5w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pgy7ds8mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 10:44:17 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 24 Mar
 2023 10:44:07 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Fri, 24 Mar 2023 10:44:07 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7AD5C45;
        Fri, 24 Mar 2023 15:44:07 +0000 (UTC)
Date:   Fri, 24 Mar 2023 15:44:07 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Doug Anderson <dianders@chromium.org>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH] regulator: wm8994: Use PROBE_FORCE_SYNCHRONOUS
Message-ID: <20230324154407.GP68926@ediswmail.ad.cirrus.com>
References: <CGME20230323083330eucas1p1f7e3f9beb5ba168c6b13374d74c158f0@eucas1p1.samsung.com>
 <20230323083312.199189-1-m.szyprowski@samsung.com>
 <20230323114035.GL68926@ediswmail.ad.cirrus.com>
 <CAD=FV=UYO1KaoAZ7o5cA83SC1VHRomvJfaXVWyYPKrEZHyNNjg@mail.gmail.com>
 <20230323174531.GM68926@ediswmail.ad.cirrus.com>
 <CAD=FV=X0SAEk_iUGQ=J-PWk_MzVc7ZikBM3N8rrnhGFzcdBNpw@mail.gmail.com>
 <20230324092353.GO68926@ediswmail.ad.cirrus.com>
 <CAD=FV=WUCqhq-wCoiir-1sNQpTNJfr-c2vAYvyJc6hKi8U4u_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WUCqhq-wCoiir-1sNQpTNJfr-c2vAYvyJc6hKi8U4u_w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: E7tBqr1gl9hIYVexQmwzb7D7uktLU8jN
X-Proofpoint-GUID: E7tBqr1gl9hIYVexQmwzb7D7uktLU8jN
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 08:06:15AM -0700, Doug Anderson wrote:
> On Fri, Mar 24, 2023 at 2:23 AM Charles Keepax
> > On Thu, Mar 23, 2023 at 11:00:32AM -0700, Doug Anderson wrote:
> > > On Thu, Mar 23, 2023 at 10:45 AM Charles Keepax
> I've spent a whole lot of time dealing with similar issues, though,
> and I think there is actually another related concern with that design
> (where the regulator is synchronous). ;-) If the child device ends up
> depending on a resource that _never_ shows up then you can get into an
> infinite probe deferral loop at bootup. If it works the way it did
> last time I analyzed similar code:
> 
> 1. Your MFD starts to probe and kicks off probing of its children
> (including the regulator).
> 
> 2. Your regulator tries to probe and tries to get a resource that will
> never exist, maybe because of a bug in dts or maybe because it won't
> show up until userspace loads a module. It returns -EPROBE_DEFER.
> 
> 3. The MFD realizes that the regulator didn't come up and it also
> returns -EPROBE_DEFER after removing all its children.
> 
> 4. That fact that we added/removed devices in the above means that the
> kernel thinks it should retry probes of previously deferred devices
> because, maybe, the device showed up that everyone was waiting for.
> Thus, we go back to step #1.
> 
> ...the system can actually loop forever in steps #1 - #4 and we ended
> up in that situation several times during development with similar
> architected systems.

Hmm... shoot yes you are correct that would indeed happen.

Thanks,
Charles
