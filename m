Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3894E707D84
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjERKGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjERKGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:06:02 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F49E54;
        Thu, 18 May 2023 03:06:00 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I8e9jF027959;
        Thu, 18 May 2023 05:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=H6FDbp1npII27yTlAhF24XW68RkUa7dX7o8yv6tiCqc=;
 b=rFZUlfipRPwbaM3Gb1MOlnJexT2Hp6JgRgs9R54rn4p1uYbs9vn1WXeFkYbvfL3VZy0l
 prsdomk3BUHSQPlj2W8bdiSL2vTSAwhZf0AFbViZ9hxUNo2vf5Y3zTULdqTCKbhQl1+u
 7OOXSoP7XzyTNrDJ/klgMsOgp+xZCNJ8dGqsoOSAGZumvz87bkJU21KFsZ5dsdwJSkch
 Py/UsEZ9mL46fomxwXkrB3fnJDuO3FR5KVf+piQ94g2AUPpfhAn89kn3BdwdFaUwogm9
 B3bbUR3l8jIiU2lXH0EshPQzdlJm9FFi/FFFWE298ael1p03cydopKWtmaL0pP+m4kJm Pw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qngq1g37w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 05:05:35 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 18 May
 2023 05:05:34 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 May 2023 05:05:34 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E56B711CA;
        Thu, 18 May 2023 10:05:33 +0000 (UTC)
Date:   Thu, 18 May 2023 10:05:33 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <broonie@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/10] mfd: cs42l43: Add support for cs42l43 core driver
Message-ID: <20230518100533.GY68926@ediswmail.ad.cirrus.com>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-7-ckeepax@opensource.cirrus.com>
 <c79e354d-4d09-a04b-798b-e42bdc47d694@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c79e354d-4d09-a04b-798b-e42bdc47d694@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: ZkIENuEU-gCo6RFU-Z0OcYxUupdNyKMS
X-Proofpoint-ORIG-GUID: ZkIENuEU-gCo6RFU-Z0OcYxUupdNyKMS
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 09:52:21AM -0500, Pierre-Louis Bossart wrote:
> > +static int cs42l43_sdw_interrupt(struct sdw_slave *sdw,
> > +				 struct sdw_slave_intr_status *status)
> > +{
> > +	/*
> > +	 * There is only a single bit in GEN_INT_STAT_1 and it doesn't clear if
> > +	 * IRQs are still pending so doing a read/write here after handling the
> > +	 * IRQ is fine.
> > +	 */
> > +	sdw_read_no_pm(sdw, CS42L43_GEN_INT_STAT_1);
> > +	sdw_write_no_pm(sdw, CS42L43_GEN_INT_STAT_1, 1);
> > +
> > +	return 0;
> > +}
> 
> not really getting the comment and code above. Where is the IRQ handled?
> In the 'other non-SoundWire part"?

Yeah in the actual IRQ handler, I will update the comment to make
this more clear.

> > +	ret = regmap_register_patch(cs42l43->regmap, cs42l43_reva_patch,
> > +				    ARRAY_SIZE(cs42l43_reva_patch));
> > +	if (ret) {
> > +		dev_err(cs42l43->dev, "Failed to apply register patch: %d\n", ret);
> > +		goto err;
> > +	}
> > +
> > +	pm_runtime_mark_last_busy(cs42l43->dev);
> > +	pm_runtime_put_autosuspend(cs42l43->dev);
> 
> any reason why the two pm_runtime routines are not placed last, just
> before the return?

Yeah that probably makes more sense I will update.

> > +	ret = cs42l43_power_up(cs42l43);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pm_runtime_set_autosuspend_delay(cs42l43->dev, 250);
> > +	pm_runtime_use_autosuspend(cs42l43->dev);
> > +	pm_runtime_set_active(cs42l43->dev);
> > +	pm_runtime_get_noresume(cs42l43->dev);
> 
> you probably want a comment to explain that the get_noresume() is
> intentional to prevent the device from suspending before the workqueue
> is handled.

Yeah will add one.

> > +	/*
> > +	 * Don't care about being resumed here, but we do want force_resume to
> > +	 * always trigger an actual resume, so that register state for the
> > +	 * MCU/GPIOs is returned as soon as possible after system resume
> > +	 */
> > +	pm_runtime_get_noresume(dev);
> > +
> > +	ret = pm_runtime_force_suspend(dev);
> > +	if (ret) {
> > +		dev_err(cs42l43->dev, "Failed to force suspend: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	pm_runtime_put_noidle(dev);
> 
> Is the get_noresume/put_noidle useful here? What does it do?

The hope was the comment would explain this :-) Yeah it is a
slightly surprising sequence. It is about ensuring force_resume
runs a runtime resume, which it will only do if the reference
count is resumed when we suspend.

I will add a little more to the comment to hopefully clarify why
we are doing this.

> And it seems wrong anyways, if pm_runtime_force_suspend() fails then the
> usage-count is not decreased.

Yeah that is bug, thanks for the spot I will fix that up.

> > +static int __maybe_unused cs42l43_runtime_resume(struct device *dev)
> > +{
> > +	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> > +	unsigned int reset_canary;
> > +	int ret;
> > +
> > +	dev_dbg(cs42l43->dev, "Runtime resume\n");
> > +
> > +	ret = cs42l43_wait_for_attach(cs42l43);
> 
> is there a specific reason why the existing initialization_complete is
> not used?

Not massively, the driver does a fair amount of detaching and
attaching during probe (has to soft reset a few times and they
cause the device to fall off the bus). It was just slightly
easier to keep track of all of them keeping the code internal to
the driver and once we were doing it anyway it was less code to
use the same mechanism on resume.

Thanks,
Charles
