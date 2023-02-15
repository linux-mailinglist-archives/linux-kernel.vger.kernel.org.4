Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC06C697A36
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjBOKvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjBOKvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:51:20 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894B1233D7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:51:19 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F7bm0B000769;
        Wed, 15 Feb 2023 04:51:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=1fJ7fDiw+kwjKFz5WaAgcT+dFb1U2KFb/MPMMwW/N8U=;
 b=WHTKj5VpZzU8lL9H2JOkvkFyTBIVcS1aSXVOR+Z78roNx0LD9KGnyv6obLtp9U1PQQnS
 Rx36lQyxUsgFsNbOIZSSx3bFZSuFmYfTsLXq+lkluld7VXWLr7fQjotY0ig07xNnQsyY
 3RQot1ajsO9EFWRMuuYYacLS7+fE9+yAbTxiooGkzgH889Ls/BE9+ljfVSiGXGGzwwHX
 2SGgzT1dCG8qmBdzHSeVj9ImVyStDgJuLoEJyK1twGmrjJaX5RWZVGN8IO4h6lCjtfJi
 zq0sF2UVBG56U75740yokOrklmFhEU7jD9CzTVnkwlZmt4R5YRGQR+Sf+fECoPzAfvS3 OQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nrm8wgkea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 04:51:13 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 15 Feb
 2023 04:51:11 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Wed, 15 Feb 2023 04:51:11 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7621111A8;
        Wed, 15 Feb 2023 10:51:11 +0000 (UTC)
Date:   Wed, 15 Feb 2023 10:51:11 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l45: Remove separate tables module
Message-ID: <20230215105111.GI68926@ediswmail.ad.cirrus.com>
References: <20230215103705.3302716-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230215103705.3302716-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: Fj_C7fMH6-_VlVRI5HpweHzEBbtDDE3c
X-Proofpoint-ORIG-GUID: Fj_C7fMH6-_VlVRI5HpweHzEBbtDDE3c
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 10:37:05AM +0000, Charles Keepax wrote:
> There is no reason to have a separate module for the tables file it just
> holds regmap callbacks and register patches used by the main part of the
> driver. Remove the separate module and merge it into the main driver
> module.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  sound/soc/codecs/Kconfig  | 5 -----
>  sound/soc/codecs/Makefile | 4 +---
>  2 files changed, 1 insertion(+), 8 deletions(-)

Apologies, just realised for neatness I should also remove the
MODULE_ macros at the bottom of cs35l45-tables.c, I will send a
new version shortly.

Thanks,
Charles
