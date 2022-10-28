Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EBD610DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJ1J6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiJ1J5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:57:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3018AE9874
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:56:50 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29S81dOv008832;
        Fri, 28 Oct 2022 04:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=mLLlKGaSg8bfJMwpwLDRI2y+lZnMRSiCP58wvZJft5w=;
 b=OdwJ6B/x5AElXSUaPjRCW3vGA8sNpMltLoCxHHXamjHlgD7t0EnO80PEc5RRI9RVjIxP
 RoVOo9dx3VXsEsQBRxQj5KwWmjEBj1smHvtKWAj4YT7PwjT4foz5PvPWaIG0TX9Ob9H/
 INcImWicjStgg6he6OTSkEWsjyXSvMF1PEtWhOBSvtxIlvYqlcmpk89upj7+Bodq6DKZ
 sBwKBSNnMb8XnfzTdsosNgSc6dh2TUBO2UNoWdpt0cUd07R/+amIR4MpId32jqtL8PSb
 fFIMcZQIixTBfuigmcXAR/8UMXybm0LXuSXciyMfD68Ih+a/BIWvthhpSHAsh8Vi2FT0 fw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kfajn270j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 04:55:56 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Fri, 28 Oct
 2022 04:55:54 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Fri, 28 Oct 2022 04:55:54 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9E00C478;
        Fri, 28 Oct 2022 09:55:54 +0000 (UTC)
Date:   Fri, 28 Oct 2022 09:55:54 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Peter Bergin <peter@berginkonsult.se>
CC:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <tanureal@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
        <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: cs42xx8-i2c.c: add module device table for of
Message-ID: <20221028095554.GG92394@ediswmail.ad.cirrus.com>
References: <20221027115057.442925-1-peter@berginkonsult.se>
 <20221028075045.493191-1-peter@berginkonsult.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221028075045.493191-1-peter@berginkonsult.se>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: gw3o-ik66YAcJDoBPu-y-Idi4u5gg213
X-Proofpoint-ORIG-GUID: gw3o-ik66YAcJDoBPu-y-Idi4u5gg213
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 09:50:44AM +0200, Peter Bergin wrote:
> Matching of device in cs42xx8_i2c_probe() is coded with inspiration
> from tlv320aic32x4-i2c.c.
> ---
> +	if (i2c->dev.of_node) {
> +		const struct of_device_id *oid;
> +
> +		oid = of_match_node(cs42xx8_of_match, i2c->dev.of_node);
> +		if (!oid)
> +			goto err_not_found;
> +		drvdata = (struct cs42xx8_driver_data *)oid->data;
> +	} else {
> +		const struct i2c_device_id *id;
> +
> +		id = i2c_match_id(cs42xx8_i2c_id, i2c);
> +		if (!id)
> +			goto err_not_found;
> +		drvdata = (struct cs42xx8_driver_data *)id->driver_data;
> +	}

Be worth noting a little more explicitly in the commit message
you updated this logic as part of the move. I would even be
tempted to put it as a separate patch personally.

> +static const struct cs42xx8_driver_data cs42448_data = {
> +	.name = "cs42448",
> +	.num_adcs = 3,
> +};
> +
> +static const struct cs42xx8_driver_data cs42888_data = {
> +	.name = "cs42888",
> +	.num_adcs = 2,
> +};

It is probably better to leave these two structures exported from
the primary module. These devices could technically have SPI
support added in the future and it might as well reuse these same
data structures.

Thanks,
Charles
