Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC1E67CEAC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjAZOrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjAZOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:47:43 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5570440D9;
        Thu, 26 Jan 2023 06:47:42 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QEkccP016162;
        Thu, 26 Jan 2023 08:46:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=1it7hPA2inysBeJabD1ZO5LdTjzt22MjxOWqMTFDfuo=;
 b=P59Tw6WWZ+ii/DiKrvxex7CLWC6cDKRZngNrfSRCsi9dPxilFoRDHgEpcmV91n3ZnkPg
 fuHZ2b1ZBi+QQjwbFZ9myYTJ7dcIiSD4cQPmNYMoXnUzN65Jj1BuIO/2stRQwHd3t2/d
 bGIDx/skVahdUCCK3UDCVdV5zPgaVvk7InN55o5XOI+2afN/wWjWsVQxBOLeqJMrAunl
 MipSgCEp+fXjbNJt2f9Td9qnSoe7OHxt9XhteJldbtUhFgio55Inm3s24LH67Bb4Kp1I
 oDSyIimNSmJ1SmsnGMxYCA/F3+eZX9xBZ188x49o2G1Hp+54/3trRIAWdcnV0X6KkDJe vQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3n8eb60t4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 08:46:38 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Thu, 26 Jan
 2023 08:46:35 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Thu, 26 Jan 2023 08:46:35 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 88DDD11CC;
        Thu, 26 Jan 2023 14:46:35 +0000 (UTC)
Date:   Thu, 26 Jan 2023 14:46:35 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Arnd Bergmann <arnd@kernel.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Lucas Tanure" <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        <linux-gpio@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Wolfram Sang <wsa@kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: cs42l56: fix DT probe
Message-ID: <20230126144635.GA36097@ediswmail.ad.cirrus.com>
References: <20230126135552.3625887-1-arnd@kernel.org>
 <Y9KIN7GerLd4ziw0@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9KIN7GerLd4ziw0@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: VbqhXAb8-NZ7R5_DRLhPEJawqKGXlLr3
X-Proofpoint-ORIG-GUID: VbqhXAb8-NZ7R5_DRLhPEJawqKGXlLr3
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 02:03:35PM +0000, Mark Brown wrote:
> On Thu, Jan 26, 2023 at 02:55:29PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > While looking through legacy platform data users, I noticed that
> > this one could never be used with DT based probing as the
> > platform_data structure gets overwritten directly after it
> > is initialized.
> > 
> > There have never been any boards defining the platform_data in
> > the mainline kernel either, so this driver so far only worked
> > with patched kernels.
> 
> Or there is no mandatory properties/platform data and the
> defaults are fine for most systems (which is a common case).

I think Arnd is right here, the driver appears to allocate a big
block of zeros and then blat that over the top of everything it
read from device tree. So you can literally never use any of the
DT properties as it stands.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
