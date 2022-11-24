Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFA6637745
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiKXLOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKXLOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:14:12 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D0F8C096
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:14:10 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AO7cYDD023037;
        Thu, 24 Nov 2022 05:13:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=KzIVxiaUzFmwVmBqr6IdozjqkXgomj00FNdz4ozpdfc=;
 b=pkukmm3cD4KghaY8vpf6MnEx8wFqu1SRJxVpU5spAVt/aRGhnd1JdWf6JoCuWFliCWoE
 aLzqg2BVVki88jQAtDV4pRHr1CWp85xplq/MW4db87SSRWkZrtTvG5kh0mVkUrgxl3l+
 il5+7Zu1tq/W7b8TSLUzTlIzdGXb1RwBU1eZWqDRHtDxdDyhfELL3yWF1OXkuhVpo/dF
 52SR6CEbrR2rkG/qIMwAb9ApQY58E/LS1DCS5KKWvrm4C2iHp0QxLthG0fU743jEMroN
 lyo0XC3l2nhIjpEXyR+diR9DX6TV731DTLeTxLji7ibwx0W5KXsW1/5v4BNexF13bUUm HA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kxvet621g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 05:13:38 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 24 Nov
 2022 05:13:36 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Thu, 24 Nov 2022 05:13:36 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 88ED1477;
        Thu, 24 Nov 2022 11:13:36 +0000 (UTC)
Date:   Thu, 24 Nov 2022 11:13:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        Tan =?utf-8?B?TmF5xLFy?= <tannayir@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: SOC_DOUBLE_R_SX_TLV controls broken in cs24l51 driver
Message-ID: <20221124111336.GE105268@ediswmail.ad.cirrus.com>
References: <CABDcavYdsk-O4x3oPX4i4+T5wsoZV26_kpEq6JvpD8A_cAGHxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABDcavYdsk-O4x3oPX4i4+T5wsoZV26_kpEq6JvpD8A_cAGHxg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: mCedHBN3rX4G6ParltJ3gVv_xnRlraUI
X-Proofpoint-GUID: mCedHBN3rX4G6ParltJ3gVv_xnRlraUI
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 10:57:34AM +0100, Guillermo Rodriguez Garcia wrote:
> Hi all,
> 
> I am using a dev board with a Cirrus Logic cs24l51 codec.
> 
> This used to work fine prior to kernel version 5.x, however after 5.x
> it is not possible to set certain values for ALSA controls from
> userspace.
> 
> I believe this is related to the input validation that is mentioned in
> this thread: https://lore.kernel.org/all/Yph8C3bRxcr6ogW7@sirena.org.uk/T/,
> and possibly in this commit: 4f1e50d6a9cf9c1b8c859d449b5031cacfa8404e
> ("ASoC: ops: Reject out of bounds values in snd_soc_put_volsw_sx()")
> 
> For the cs24l51, all the controls that fail are using the
> SOC_DOUBLE_R_SX_TLV macro.
> 
> I have traced this to the checks in snd_soc_put_volsw_sx, specifically
> the (val > max - min) check:
> 

Can you try these two patches:

https://lore.kernel.org/all/165236477046.1016627.15470197691244479154.b4-ty@kernel.org/

It looks like they somehow got lost around 5.18, I have been
meaning to chase up what happened to them.

Thanks,
Charles
