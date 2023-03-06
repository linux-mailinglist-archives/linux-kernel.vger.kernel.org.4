Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75AA6AB997
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCFJVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCFJVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:21:08 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC01BDFA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:21:03 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3268mIU0002784;
        Mon, 6 Mar 2023 03:20:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=vZqp51sKsGwz1zvQ8Nsz5SwMHcMBKIvby0aKVXMTYa8=;
 b=Vc35di5EZI+SlgIOYi5qnzu3edUTokAYvI0RcWslcVGBmI88DYNRYBm1MVmwLuRshLD0
 A3OCC006OQ28HgMl920dLzBMRINKI11f+9NweJC9p171ha1uiJ9/Up3og+5m+c9B80Dd
 MR56EHPERzPxR+eP8gQYvc7Qmq1EbLsTlyt047CKoCujisBNIdr98ICBauEndIa9f1sL
 z2jE716+1QNsSt2JtLaRio18sCA1vOD/BXcztkujt+IEnAZXUAfNYEALZS+esRGenzln
 hywIuBQ12N5DagJQk7mUgXpU7nHzoW/Hjid0hf43P2yxqdDmtaH5roQ9QHkRSjtTxBPA Ug== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3p439tabqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 03:20:40 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 6 Mar
 2023 03:20:39 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 6 Mar 2023 03:20:39 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 196B5475;
        Mon,  6 Mar 2023 09:20:39 +0000 (UTC)
Date:   Mon, 6 Mar 2023 09:20:39 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vlad Karpovich <vkarpovi@opensource.cirrus.com>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: Re: [PATCH v2 2/5] ASoC: dt-bindings: cs35l45: GPIOs configuration
Message-ID: <20230306092039.GN68926@ediswmail.ad.cirrus.com>
References: <20230303192151.2437221-1-vkarpovi@opensource.cirrus.com>
 <20230303192151.2437221-2-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230303192151.2437221-2-vkarpovi@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 30IzqJp8msj6eh57qzKJTSHkZrP4nTLT
X-Proofpoint-ORIG-GUID: 30IzqJp8msj6eh57qzKJTSHkZrP4nTLT
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 01:21:48PM -0600, Vlad Karpovich wrote:
> From: "Vlad.Karpovich" <vkarpovi@opensource.cirrus.com>
> 
> This adds description of CS35L45 GPIOs configuration.
> 
> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
> ---

Your missing the DT maintainers and list from your CC list on
this patch.

Thanks,
Charles
