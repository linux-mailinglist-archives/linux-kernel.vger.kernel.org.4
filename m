Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B58B64CA47
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbiLNNMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238556AbiLNNLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:11:43 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174B51FFAE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:11:25 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BECLZwt013250;
        Wed, 14 Dec 2022 07:10:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=ECE0JzFx1yAM1iX1f/txwsbLEnwzkF68ppFA5PubotU=;
 b=TlznTHJLCkLmrelBlqBCUl+EnbVm7D+kg1a1PRTL1HFhooVBtt1Ni2gEsVLoXB5IrWa/
 tetjOiUX3JVQIF1eHFa12tB1sWE5T1kdt+zXlUvO4y2zb6KzxJXIgjcw2HxBQ0nhaX0f
 dXMYEGwo6qo6kruD8HOqZi50gcjzRVEryNQhc53UG4GRFoBHeTPas7xjntAr/Rd3oFok
 k3mxgslgJcrOQtPJwxbP/JDvRE7mNN5FcTPX3lfYZoy4bXmMZpo5W5JLTMxJtglG8N5A
 J7YCo2D/Sych7nRNMrmiKF09G6nMUHgDV0fQrvCPUPa9/aR9C+Dtr8Jb3m4czcQwQHYA oQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3mf6rw8dk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 07:10:28 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Wed, 14 Dec
 2022 07:10:26 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Wed, 14 Dec 2022 07:10:26 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7A6E8459;
        Wed, 14 Dec 2022 13:10:26 +0000 (UTC)
Date:   Wed, 14 Dec 2022 13:10:26 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lukasz Majewski <lukma@denx.de>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Stephen Kitt <steve@sk2.org>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] ASoC: wm8940: Remove warning when no plat data
 present
Message-ID: <20221214131026.GP105268@ediswmail.ad.cirrus.com>
References: <20221214123743.3713843-1-lukma@denx.de>
 <20221214123743.3713843-2-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221214123743.3713843-2-lukma@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: P2Bst2QvLgba_Ha4sbx2JDaHuvWUN8TC
X-Proofpoint-ORIG-GUID: P2Bst2QvLgba_Ha4sbx2JDaHuvWUN8TC
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 01:37:40PM +0100, Lukasz Majewski wrote:
> The lack of platform data in the contemporary Linux
> shall not be the reason to display warnings to the
> kernel logs.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
