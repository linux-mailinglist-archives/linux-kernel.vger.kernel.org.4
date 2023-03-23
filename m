Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190796C66D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjCWLks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCWLkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:40:46 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0881B2FA;
        Thu, 23 Mar 2023 04:40:44 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N4wNTc023252;
        Thu, 23 Mar 2023 06:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=9TGqX4W62K3tpa0XL956cK3xYTZlgHcISQmo6QNyIEg=;
 b=KAM6BjHcS+RkSRgbnBgwl5iQMgX20ve6Mx1LhrNTa77J4aol9bagGU22Z9Sbr+LD5pmQ
 UTZ1Z0In2MJRmS5XUZQWvgOhzXlA6QuxvyajUG0ayx2FwyTfyrtLW6fAbcH9TiUKnbjz
 CuJ8uOxK7cWxcbnneE+MsfuAdIVvBSe1CxXsGiFA6PN4NC7jduSydaKW2GXjzj8seYQG
 7SDZWctb/91M1OT1auWWD602PH3MFJiSiYf0pT2k0TG+MVUwFz6V3LR9Qj4zqpMRvvcT
 I7555cDAxVWYX15lmcEEI7GfW+lF8at0onsv6bRj7XGgLao718m5sHb6Vxg9qtXe+FLc DA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pf7tj4m2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:40:37 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 23 Mar
 2023 06:40:35 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 23 Mar 2023 06:40:35 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D189E11D4;
        Thu, 23 Mar 2023 11:40:35 +0000 (UTC)
Date:   Thu, 23 Mar 2023 11:40:35 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH] regulator: wm8994: Use PROBE_FORCE_SYNCHRONOUS
Message-ID: <20230323114035.GL68926@ediswmail.ad.cirrus.com>
References: <CGME20230323083330eucas1p1f7e3f9beb5ba168c6b13374d74c158f0@eucas1p1.samsung.com>
 <20230323083312.199189-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230323083312.199189-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: -_tg5mKvL2lfs_8H1VsbxGuyuLJnQxI7
X-Proofpoint-GUID: -_tg5mKvL2lfs_8H1VsbxGuyuLJnQxI7
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 09:33:12AM +0100, Marek Szyprowski wrote:
> Restore synchronous probing for wm8994 regulators because otherwise the
> sound device is never initialized on Exynos5250-based Arndale board.
> 
> Fixes: 259b93b21a9f ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in 4.14")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/regulator/wm8994-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
> index 8921051a00e9..2946db448aec 100644
> --- a/drivers/regulator/wm8994-regulator.c
> +++ b/drivers/regulator/wm8994-regulator.c
> @@ -227,7 +227,7 @@ static struct platform_driver wm8994_ldo_driver = {
>  	.probe = wm8994_ldo_probe,
>  	.driver		= {
>  		.name	= "wm8994-ldo",
> -		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
>  	},
>  };

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Yes, these seems to be a wider problem with these complex CODECs
that have an internal LDO. Changing to async probe, means the
internal LDO driver doesn't probe before the code in the main MFD
carries on, which means the regulator framework finds no driver
and swaps in the dummy. Which means the CODEC never powers up.

I think these basically have to be forced sync, I will do a patch
to update the other devices working like this.

Thanks,
Charles
