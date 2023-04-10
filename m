Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB406DC4B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 10:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDJI5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 04:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDJI5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 04:57:11 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D8610B;
        Mon, 10 Apr 2023 01:57:09 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33A7OmAs031776;
        Mon, 10 Apr 2023 03:56:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=0sxDC0GxsMFU0uxIEZQeJV7fsDCdmM52NUcRqVSVze4=;
 b=LpK/oCnC6uZnJDvvoVM+pzCefuqs2pjjf85e//qaU7yT49/eB8eOMqWMQcr81FP0B1uO
 OAe8Xx64TuRjg7k4xCn/94YbgSg2B3AXQ7uEJb1sIAcTQX1XTDWLn5GDfZOtrXVwsw+B
 c2Rs6l5gGEK6XR+HGm1THJ4DBmGEN2kNVQR5UMRKyvVzPZzKGAWuyRQnzSSyZXXJkugH
 0NjJ/TsttQwqfL6Ru/KfhcUeYa1K4VfKKuUvvjTw/A4sZDtCOG2LelFzYhpCpBORpVSK
 7C2U2dd5rWeXBNHOYJeJTFN7yxLnOAeodw7S5yFcatjJ1KpS5sjoq7tc7N+ccSMXEeYw Cw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pu4pq2g6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 03:56:35 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 10 Apr
 2023 03:56:34 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 10 Apr 2023 03:56:34 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 28B6311D4;
        Mon, 10 Apr 2023 08:56:34 +0000 (UTC)
Date:   Mon, 10 Apr 2023 08:56:34 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Jeff LaBundy <jeff@labundy.com>
CC:     Fred Treven <fred.treven@cirrus.com>, <dmitry.torokhov@gmail.com>,
        <ben.bright@cirrus.com>, <james.ogletree@cirrus.com>,
        <lee@kernel.org>, <jdelvare@suse.de>, <joel@jms.id.au>,
        <cy_huang@richtek.com>, <rdunlap@infradead.org>,
        <eajames@linux.ibm.com>, <ping.bai@nxp.com>, <msp@baylibre.com>,
        <arnd@arndb.de>, <bartosz.golaszewski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] Input: cs40l26: Support for CS40L26 Boosted Haptic
 Amplifier
Message-ID: <20230410085634.GV68926@ediswmail.ad.cirrus.com>
References: <SupportforCS40L26BoostedHapticAmplifier>
 <1680819415-28806-1-git-send-email-fred.treven@cirrus.com>
 <ZDI0p5Rkp74SzJCv@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDI0p5Rkp74SzJCv@nixie71>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: SWgUxhHWrMHqKrWeDmqCoV8z858exedl
X-Proofpoint-ORIG-GUID: SWgUxhHWrMHqKrWeDmqCoV8z858exedl
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2023 at 10:44:39PM -0500, Jeff LaBundy wrote:

Hi Jeff,

Thanks for the detailed review, very much appreciated. I agree
with most of your comments, save a couple of exceptions below,
well and one that I just felt the need to agree with you
explictly:

> > +static bool cs40l26_readable_reg(struct device *dev, unsigned int reg)
> > +{
> > +	switch (reg) {
> > +	case CS40L26_DEVID ... CS40L26_REVID:
> > +	case CS40L26_TEST_KEY_CTRL:
> > +	case CS40L26_GLOBAL_ENABLES:
> > +	case CS40L26_ERROR_RELEASE:
> > +	case CS40L26_PWRMGT_CTL ... CS40L26_PWRMGT_STS:
> > +	case CS40L26_REFCLK_INPUT:
> > +	case CS40L26_PLL_REFCLK_DETECT_0:
> > +	case CS40L26_VBST_CTL_1 ... CS40L26_BST_IPK_CTL:
> > +	case CS40L26_TEST_LBST:
> > +	case CS40L26_NGATE1_INPUT:
> > +	case CS40L26_DAC_MSM_CONFIG ... CS40L26_TST_DAC_MSM_CONFIG:
> > +	case CS40L26_IRQ1_STATUS:
> > +	case CS40L26_IRQ1_EINT_1 ... CS40L26_IRQ1_EINT_5:
> > +	case CS40L26_IRQ1_STS_1 ... CS40L26_IRQ1_STS_5:
> > +	case CS40L26_IRQ1_MASK_1 ... CS40L26_IRQ1_MASK_5:
> > +	case CS40L26_MIXER_NGATE_CH1_CFG:
> > +	case CS40L26_DSP_MBOX_1 ... CS40L26_DSP_VIRTUAL2_MBOX_8:
> > +	case CS40L26_OTP_MEM0 ... CS40L26_OTP_MEM31:
> > +	case CS40L26_DSP1_XMEM_PACKED_0 ... CS40L26_DSP1_XMEM_PACKED_6143:
> > +	case CS40L26_DSP1_XROM_PACKED_0 ... CS40L26_DSP1_XROM_PACKED_4604:
> > +	case CS40L26_DSP1_XMEM_UNPACKED32_0 ... CS40L26_DSP1_XROM_UNPACKED32_3070:
> > +	case CS40L26_DSP1_SYS_INFO_ID:
> > +	case CS40L26_DSP1_XMEM_UNPACKED24_0 ... CS40L26_DSP1_XMEM_UNPACKED24_8191:
> > +	case CS40L26_DSP1_XROM_UNPACKED24_0 ... CS40L26_DSP1_XROM_UNPACKED24_6141:
> > +	case CS40L26_DSP1_CCM_CORE_CONTROL:
> > +	case CS40L26_DSP1_YMEM_PACKED_0 ... CS40L26_DSP1_YMEM_PACKED_1532:
> > +	case CS40L26_DSP1_YMEM_UNPACKED32_0 ... CS40L26_DSP1_YMEM_UNPACKED32_1022:
> > +	case CS40L26_DSP1_YMEM_UNPACKED24_0 ... CS40L26_DSP1_YMEM_UNPACKED24_2045:
> > +	case CS40L26_DSP1_PMEM_0 ... CS40L26_DSP1_PMEM_5114:
> > +	case CS40L26_DSP1_PROM_0 ... CS40L26_DSP1_PROM_30714:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> 
> Is this function necessary? Are there cases throughout the driver that may
> attempt to read an illegal register, and you depend on the regmap call to
> fail? If not, I think you can just drop this function.
> 

I would much rather we kept this one, at the very least such
that the debugfs representation of the regmap shows the correct
registers.

> > +static inline void cs40l26_pm_runtime_setup(struct cs40l26_private *cs40l26)
> > +{
> > +	pm_runtime_mark_last_busy(cs40l26->dev);
> > +	pm_runtime_use_autosuspend(cs40l26->dev);
> > +	pm_runtime_set_autosuspend_delay(cs40l26->dev, CS40L26_AUTOSUSPEND_DELAY_MS);
> > +	pm_runtime_enable(cs40l26->dev);
> 
> My first impression was that this driver is doing an uncommonly large
> amount of PM-related housekeeping. In fact, not a single haptic driver
> in mainline is calling any of these. What is unique about this device
> that calls for this much overhead?
> 
> Can the device wake up from hibernation (AoH?) from both control port
> and GPIO triggers? If so, why not to simply allow the device to hibernate
> at its own discretion and avoid all PM-related housekeeping? Stated
> another way, it seems some of the DSP's job is unnecessarily duplicated
> in the kernel.
> 
> In case I have misunderstood, please let me know.
> 

I would far rather not have every single attempt to communicate
with the device wrapped in a retry if the communication failed
incase the device is hibernating. It seems much cleaner, and less
likely to risk odd behaviour, to know we have brought the device
out of hibernation.

> > +static int cs40l26_irq_update_mask(struct cs40l26_private *cs40l26, u32 reg, u32 val, u32 bit_mask)
> > +{
> > +	u32 eint_reg, cur_mask, new_mask;
> > +	int ret;
> > +
> > +	if (reg == CS40L26_IRQ1_MASK_1) {
> > +		eint_reg = CS40L26_IRQ1_EINT_1;
> > +	} else if (reg == CS40L26_IRQ1_MASK_2) {
> > +		eint_reg = CS40L26_IRQ1_EINT_2;
> > +	} else {
> > +		dev_err(cs40l26->dev, "Invalid IRQ mask reg: 0x%08X\n", reg);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = regmap_read(cs40l26->regmap, reg, &cur_mask);
> > +	if (ret) {
> > +		dev_err(cs40l26->dev, "Failed to get IRQ mask\n");
> 
> Having a custom error message for every possible failed register read
> does not ultimately aid in debugging and unnecessarily grows the size
> of the driver.
> 
> If a specific message is absolutely necessary, then add wrappers around
> regmap_read/write and print the failed address. However, this does not
> seem necessary either. Simply propagate the error code all the way up
> to the caller, whether it is probe or a sysfs attribute.
> 
> Stated another way:
> 
> error = regmap_...(...);
> if (error)
> 	return error;
> 

Not sure I feel super strongly on this one, but I do find when
debugging issues on drivers that do this that I usually end up
adding the printks back in.

> > +static int cs40l26_dsp_state_get(struct cs40l26_private *cs40l26, u8 *state)
> > +{
> > +	bool mutex_available = !mutex_is_locked(&cs40l26->dsp.pwr_lock);
> 
> This is dangerous and a sign that locks are not properly managed. What would
> be a case where you do not know the state of the lock upon entering this function?
> If you do not know whether the mutex is locked inside this function, it is not the
> proper place to grab it.
> 

Yes I whole heartedly agree here this should not be done this
way.

> > +	cs40l26->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> > +	if (IS_ERR_OR_NULL(cs40l26->reset_gpio)) {
> > +		dev_err(dev, "Failed to get reset GPIO: %d\n", (int) PTR_ERR(cs40l26->reset_gpio));
> > +		ret = -ENOENT;
> > +		goto err;
> > +	}
> > +
> > +	usleep_range(CS40L26_MIN_RESET_PULSE_WIDTH_US, CS40L26_MIN_RESET_PULSE_WIDTH_US + 100);
> > +
> > +	gpiod_set_value_cansleep(cs40l26->reset_gpio, 1);
> 
> This is backwards, which means your dts must be backwards as well. gpiod is
> a logical API, so you should actually declare the GPIO as GPIOD_OUT_HIGH, i.e.
> asserted, and then call gpiod_set_value_cansleep() with 0, i.e. de-asserted.
> The definition of "asserted" then comes from the polarity defined in dts.
> 
> By the way, did you test this driver without a reset GPIO defined in dts? It's
> an optional GPIO, rightfully so, but you need to check whether reset_gpio is
> NULL prior to acting upon it.
> 

gpiod does the NULL check for you no need to duplicate it in the
driver.

Thanks,
Charles
