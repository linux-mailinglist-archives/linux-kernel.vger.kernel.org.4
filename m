Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D883469E5C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbjBURTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjBURTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:19:17 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320D122DCA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:19:15 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LHHMWQ001982;
        Tue, 21 Feb 2023 11:18:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=4Uv4Wl3WLY+qPDivrAHO8fHuS3+FUjV+/MkHhUOl7OI=;
 b=ZPni5iEWPK5r4B0Aj8AxmsY/sKhOQoOr78XXRZ4dLMuYSBoafe3YL/czh47sIxTCAzgv
 f3cS+6pOursXv6PKOIbUVofnE9FACDeQhUxp281VD6SG0zhhGZCxv09Eyv9k5v2KE9rH
 MQMQPwlF6jVxTagZCqAMaADXHe1w1VD7zseoLPJpN9bDcLLvKrMObLfA5yBJpN03hl3g
 oZCzJX/NRderg4iz3W1hc3Oq5pxuqh41VXJO6+QZwIlknmRbIDZQP8OIGSNvdyn/FWI3
 rCA3nOZq+NOHtp7cWnv6ewd3d+nALlv0+OwajlY+lYrNqragvHsp5kCte9aSWPjXscXs XA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nvmnqrxan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 11:18:49 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Tue, 21 Feb
 2023 11:18:47 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Tue, 21 Feb 2023 11:18:47 -0600
Received: from [198.90.251.127] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 45FE1B0E;
        Tue, 21 Feb 2023 17:18:47 +0000 (UTC)
Message-ID: <59866a98-077a-4645-b85b-a18fc1d65a54@opensource.cirrus.com>
Date:   Tue, 21 Feb 2023 17:18:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 08/10] ASoC: cs35l56: Add driver for Cirrus Logic CS35L56
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <broonie@kernel.org>, <cezary.rojewski@intel.com>,
        <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <kai.vehmanen@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20230217161410.915202-1-rf@opensource.cirrus.com>
 <20230217161410.915202-9-rf@opensource.cirrus.com>
 <2d55b8c9-e7f9-6b2e-aad8-5cc902d69000@linux.intel.com>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <2d55b8c9-e7f9-6b2e-aad8-5cc902d69000@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2P-I37zqGJce2jihQR9oOCStcfnex5Ei
X-Proofpoint-GUID: 2P-I37zqGJce2jihQR9oOCStcfnex5Ei
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2023 16:45, Pierre-Louis Bossart wrote:
> 
>> +static int cs35l56_sdw_interrupt(struct sdw_slave *peripheral,
>> +				 struct sdw_slave_intr_status *status)
>> +{
>> +	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
>> +
>> +	/* SoundWire core holds our pm_runtime when calling this function. */
>> +
>> +	dev_dbg(cs35l56->dev, "int control_port=%#x\n", status->control_port);
>> +
>> +	if ((status->control_port & SDW_SCP_INT1_IMPL_DEF) == 0)
>> +		return 0;
>> +
>> +	/* Prevent host controller suspending before we handle the interrupt */
>> +	pm_runtime_get_noresume(cs35l56->dev);
> 
> can this happen that the manager suspends in this function?
> 
> Or is this needed because of the queued work which the manager has no
> knowledge of?
> 

Because you issue a Bus-Reset when you suspend and clock-stop, if we
didn't take our pm_runtime there is a small window of time where we
could be reset before we've handled the interrupt. It's unlikely to
happen but better to be safe than to rely on autosuspend delays.

>> +
>> +	/*
>> +	 * Mask and clear until it has been handled. The read of GEN_INT_STAT_1
>> +	 * is required as per the SoundWire spec for interrupt status bits
>> +	 * to clear. GEN_INT_MASK_1 masks the _inputs_ to GEN_INT_STAT1.
>> +	 * None of the interrupts are time-critical so use the
>> +	 * power-efficient queue.
>> +	 */
>> +	sdw_write_no_pm(peripheral, CS35L56_SDW_GEN_INT_MASK_1, 0);
>> +	sdw_read_no_pm(peripheral, CS35L56_SDW_GEN_INT_STAT_1);
>> +	sdw_write_no_pm(peripheral, CS35L56_SDW_GEN_INT_STAT_1, 0xFF);
>> +	queue_work(system_power_efficient_wq, &cs35l56->sdw_irq_work);
>> +
>> +	return 0;
>> +}
> 
>> +static int __maybe_unused cs35l56_sdw_handle_unattach(struct cs35l56_private *cs35l56)
>> +{
>> +	struct sdw_slave *peripheral = cs35l56->sdw_peripheral;
>> +
>> +	if (peripheral->unattach_request) {
>> +		/* Cannot access registers until master re-attaches. */
> 
> not sure what the comment means, the manager does not attach. did you
> mean resume the bus?
> 

If the manager has forced us to reset we can't access the registers
until the manager has recovered its state.

>> +		dev_dbg(cs35l56->dev, "Wait for initialization_complete\n");
>> +		if (!wait_for_completion_timeout(&peripheral->initialization_complete,
>> +						 msecs_to_jiffies(5000))) {
>> +			dev_err(cs35l56->dev, "initialization_complete timed out\n");
>> +			return -ETIMEDOUT;
>> +		}
>> +
>> +		peripheral->unattach_request = 0;
>> +
>> +		/*
>> +		 * Don't call regcache_mark_dirty(), we can't be sure that the
>> +		 * Manager really did issue a Bus Reset.
>> +		 */
>> +	}
>> +
>> +	return 0;
>> +}
> ...
> 
>> +static void cs35l56_dsp_work(struct work_struct *work)
>> +{
>> +	struct cs35l56_private *cs35l56 = container_of(work,
>> +						       struct cs35l56_private,
>> +						       dsp_work);
>> +	unsigned int reg;
>> +	unsigned int val;
>> +	int ret = 0;
>> +
>> +	if (!wait_for_completion_timeout(&cs35l56->init_completion,
>> +					 msecs_to_jiffies(5000))) {
>> +		dev_err(cs35l56->dev, "%s: init_completion timed out\n", __func__);
>> +		goto complete;
>> +	}
>> +
>> +	if (!cs35l56->init_done || cs35l56->removing)
>> +		goto complete;
>> +
>> +	cs35l56->dsp.part = devm_kasprintf(cs35l56->dev, GFP_KERNEL, "cs35l56%s-%02x",
>> +					   cs35l56->secured ? "s" : "", cs35l56->rev);
>> +
>> +	if (!cs35l56->dsp.part)
>> +		goto complete;
>> +
>> +	pm_runtime_get_sync(cs35l56->dev);
> 
> test that this is successful?
> 

Could do. Wasn't really expecting it to fail unless the hardware is
already broken.

>> +
>> +	/*
>> +	 * Disable SoundWire interrupts to prevent race with IRQ work.
>> +	 * Setting sdw_irq_no_unmask prevents the handler re-enabling
>> +	 * the SoundWire interrupt.
>> +	 */
>> +	if (cs35l56->sdw_peripheral) {
>> +		cs35l56->sdw_irq_no_unmask = true;
>> +		cancel_work_sync(&cs35l56->sdw_irq_work);
>> +		sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_MASK_1, 0);
>> +		sdw_read_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_STAT_1);
>> +		sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_STAT_1, 0xFF);
>> +	}
>> +
>> +	ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_SHUTDOWN);
>> +	if (ret) {
>> +		dev_dbg(cs35l56->dev, "%s: CS35L56_MBOX_CMD_SHUTDOWN ret %d\n", __func__, ret);
>> +		goto err;
>> +	}
>> +
>> +	if (cs35l56->rev < CS35L56_REVID_B0)
>> +		reg = CS35L56_DSP1_PM_CUR_STATE_A1;
>> +	else
>> +		reg = CS35L56_DSP1_PM_CUR_STATE;
>> +
>> +	ret = regmap_read_poll_timeout(cs35l56->regmap, reg,
>> +				       val, (val == CS35L56_HALO_STATE_SHUTDOWN),
>> +				       CS35L56_HALO_STATE_POLL_US,
>> +				       CS35L56_HALO_STATE_TIMEOUT_US);
>> +	if (ret < 0)
>> +		dev_err(cs35l56->dev, "Failed to poll PM_CUR_STATE to 1 is %d (ret %d)\n",
>> +			val, ret);
>> +
>> +	/* Use wm_adsp to load and apply the firmware patch and coefficient files */
>> +	ret = wm_adsp_power_up(&cs35l56->dsp);
>> +	if (ret) {
>> +		dev_dbg(cs35l56->dev, "%s: wm_adsp_power_up ret %d\n", __func__, ret);
>> +		goto err;
>> +	}
>> +
>> +	if (cs35l56->removing)
>> +		goto err;
>> +
>> +	mutex_lock(&cs35l56->irq_lock);
>> +
>> +	init_completion(&cs35l56->init_completion);
>> +
>> +	cs35l56_system_reset(cs35l56);
>> +
>> +	if (cs35l56->sdw_peripheral) {
>> +		if (!wait_for_completion_timeout(&cs35l56->init_completion,
>> +						 msecs_to_jiffies(5000))) {
>> +			dev_err(cs35l56->dev, "%s: init_completion timed out (SDW)\n", __func__);
> 
> shouldn't do the same routine as for a regular pm_runtime resume,
> including re-synching regmaps?
> 

Not sure it would help. It's not the same as runtime_resume because
we've changed the firmware and rebooted it (the firmware is retained
in a runtime_suspend). We need to do some of the first-time init()
code again, which we don't need to do in runtime_resume.

Also would create a circular dependency between this driver and the
cs35l56-sdw driver. (We _could_ call our dev->pm->runtime_resume pointer
but that's a bit ugly)

> 
>> +			goto err_unlock;
>> +		}
>> +	} else {
>> +		if (cs35l56_init(cs35l56))
>> +			goto err_unlock;
>> +	}
>> +
>> +	cs35l56->fw_patched = true;
>> +
>> +err_unlock:
>> +	mutex_unlock(&cs35l56->irq_lock);
>> +err:
>> +	pm_runtime_mark_last_busy(cs35l56->dev);
>> +	pm_runtime_put_autosuspend(cs35l56->dev);
>> +
>> +	/* Re-enable SoundWire interrupts */
>> +	if (cs35l56->sdw_peripheral) {
>> +		cs35l56->sdw_irq_no_unmask = false;
>> +		sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_MASK_1,
>> +				CS35L56_SDW_INT_MASK_CODEC_IRQ);
>> +	}
>> +
>> +complete:
>> +	complete_all(&cs35l56->dsp_ready_completion);
>> +}
