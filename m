Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D0D6F30D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjEAMY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjEAMYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:24:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E760D191
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 05:24:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-95678d891d6so513530966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 05:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682943889; x=1685535889;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKzpM4h8wbSRzBbkziOSPLDHVWbVSy6w2o35fUStiww=;
        b=Hlip1jLuJkPpOwasZWpj+qVRWmUg81mLq0cS1ISIM7wchgnYqqBjAPqRLztNJbrM9P
         YzHiD03MQEAbUfgH9mx6VH2CrxavMOc+fcvcB6/pFLPcvXs8nUWVTVm7XzBWuuZ1wnHr
         2xc2iGzTLlrhWUdNLstcD+zeMWu7CdqMrkMTjqS2HHOPwJ6EDeV9H+En77ABKzTEZU/S
         vfkdxTltQSNYMwa/JMZqAdYJJ9xiIbKC9lIAAo5bqEF58VoPE5NeVZnMeKtx9/SrZ1YY
         +d1Er23sBz2PaDp6tuqf6gEBHWNbbCSxucYDFmWPD7fFoFlivFpGmE6XxT4g13mBCj8P
         ZTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682943889; x=1685535889;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKzpM4h8wbSRzBbkziOSPLDHVWbVSy6w2o35fUStiww=;
        b=V9apJxgjKKnmbq+iW4oYX9JJlq6UpNDxDqFrqWG7IecT2RvZzHD7JSzAEUEkpckDsa
         ertpNEB+T5fbqq0c8wFuXZBRZbZlRMmW5y4+MzSDvObuAAnN5u4lugvs3TCQaEYhRZDV
         JJDvWyoT8XcSUrfdz0F+4m7y5W/Vypwse9m2Qmf/tiBn7i6qGd7As3Ma3Fh2N7Clx4j+
         ti3Sxapi7cnmdsT9dfnc2MvxsHBC4jUC0HvMd3f13SjbQ4DOups6ddqe56pxDzc9OgPp
         5lWRkhJCgCSGT9YVP1RmQ1MS/nT+OdE8Nxdc7ZHWD03qrOQlCXKBloa1dMQNM9qCjvbj
         ghuw==
X-Gm-Message-State: AC+VfDwaFWP9Cq3cf3+9g9FsBrs+Te6Wfcslcjip4ob5E10sRS0aSLl2
        lpMipiVlxZ94wK+WSZuHUNUQNg==
X-Google-Smtp-Source: ACHHUZ4FlOrN4CRmfvRpotVXsvoEVNRy+/4hGrFjzqd3Zv5af7i/23WIpnqYoFGNWkaetdVsjhBwUg==
X-Received: by 2002:a17:907:94cc:b0:948:b9ea:3302 with SMTP id dn12-20020a17090794cc00b00948b9ea3302mr12214611ejc.1.1682943889295;
        Mon, 01 May 2023 05:24:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709064bca00b0095334355a34sm14747521ejv.96.2023.05.01.05.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 05:24:48 -0700 (PDT)
Message-ID: <42fbf7ad-54db-0917-bb85-a1be9f99cc45@linaro.org>
Date:   Mon, 1 May 2023 14:24:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 6/6] soundwire: qcom: do not probe devices before bus/link
 init
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Patrick Lai <quic_plai@quicinc.com>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
 <20230420101617.142225-7-krzysztof.kozlowski@linaro.org>
 <28141433-2130-e278-0f59-d9ab507b9be3@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <28141433-2130-e278-0f59-d9ab507b9be3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 23:37, Pierre-Louis Bossart wrote:
> 
> 
> On 4/20/23 05:16, Krzysztof Kozlowski wrote:
>> Soundwire devices are supposed to be kept in reset state (powered off)
>> till their probe() or component bind() callbacks.  However if they are
>> already powered on, then they might enumerate before the master
>> initializes bus in qcom_swrm_init() leading to occasional errors like:
> 
> The problem statement is really hard to follow.
> 
> The peripheral can only be enumerated AFTER
> a) the manager starts the bus clock and transmitting PING frames
> b) the peripheral detects the sync words for 16 frames in a row.
> c) the peripheral reports as Attached in the Device0 slot
> 
> That sequence holds whether the manager does the enumeration manually or
> relies on hardware-assisted autoenumeration. This is what the spec requires.
> 
> So why can't the bus clock start be controlled by the manager driver,
> and started once all required initializations are done?
> 
> I mean, there's got to be some sort of parent-child hierarchy with
> manager first, peripheral(s) second, I don't get how these steps could
> be inverted or race.
> 
>>   qcom-soundwire 6d30000.soundwire-controller: Qualcomm Soundwire controller v2.0.0 Registered
>>   wcd938x_codec audio-codec: bound sdw:0:0217:010d:00:4 (ops wcd938x_sdw_component_ops)
>>   wcd938x_codec audio-codec: bound sdw:0:0217:010d:00:3 (ops wcd938x_sdw_component_ops)
>>   qcom-soundwire 6ad0000.soundwire-controller: swrm_wait_for_wr_fifo_avail err write overflow
>>
>> The problem primarily lies in Qualcomm Soundwire controller probe() sequence:
>> 1. request_threaded_irq()
>> 2. sdw_bus_master_add() - which will cause probe() and component bind()
>>    of Soundwire devices, e.g. WCD938x codec drivers.  Device drivers
>>    might already start accessing their registers.
> 
> not if the bus clock hasn't started...
> 
>> 3. qcom_swrm_init() - which initializes the link/bus and enables
>>    interrupts.
> 
> if you can move the clock start in 3) then problem solved. Why can't
> this be done?

Responding to all your three responses:
The clock is enabled in this 3. qcom_swrm_init(), so the old code to my
knowledge is written exactly how you expect.

However even with stopped clock, the device enumerates at
sdw_bus_master_add(), before anything is enabled.

I also checked the reset values of these registers - clock is off after
reset. Assuming of course I look at correct clock registers... but I
have only one.

> 
>> Any access to device registers at (2) above, will fail because link/bus
>> is not yet initialized.
>>
>> However the fix is not as simple as moving qcom_swrm_init() before
>> sdw_bus_master_add(), because this will cause early interrupt of new
>> slave attached.  The interrupt handler expects bus master (ctrl->bus.md)
>> to be allocated, so this would lead to NULL pointer exception.
>>
>> Rework the init sequence and change the interrupt handler.  The correct
>> sequence fixing accessing device registers before link init is now:
>> 1. qcom_swrm_init()
>> 2. request_threaded_irq()
>> 3. sdw_bus_master_add()
>> which still might cause early interrupts, if Soundwire devices are not
>> in powered off state before their probe.  This early interrupt issue is
> 
> You'd need to clarify in which step the bus clock starts. In general,
> you want to clock started last.

Clock is enabled in qcom_swrm_init() step, but as I wrote above, it
looks like it does not matter for enumeration.

> 
>> fixed by checking if bus master (ctrl->bus.md) was allocated and if not,
>> scheduling delayed work for enumerating the slave device.  Since we
>> actually can handle early interrupt now, drop IRQF_TRIGGER_RISING flag
>> from the interrupt, because it is not really valid and driver should use
>> flags provided by DTS.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Change context depends on:
>> https://lore.kernel.org/r/20230209131336.18252-3-srinivas.kandagatla@linaro.org
>> https://lore.kernel.org/all/20230418095447.577001-1-krzysztof.kozlowski@linaro.org/
>>
>> Cc: Patrick Lai <quic_plai@quicinc.com>
>> ---
>>  drivers/soundwire/qcom.c | 89 ++++++++++++++++++++++++++++++++--------
>>  1 file changed, 72 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index 679990dc3cc4..802d939ce7aa 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/slimbus.h>
>>  #include <linux/soundwire/sdw.h>
>>  #include <linux/soundwire/sdw_registers.h>
>> +#include <linux/workqueue.h>
>>  #include <sound/pcm_params.h>
>>  #include <sound/soc.h>
>>  #include "bus.h"
>> @@ -187,6 +188,7 @@ struct qcom_swrm_ctrl {
>>  #endif
>>  	struct completion broadcast;
>>  	struct completion enumeration;
>> +	struct delayed_work new_slave_work;
>>  	/* Port alloc/free lock */
>>  	struct mutex port_lock;
>>  	struct clk *hclk;
>> @@ -606,6 +608,37 @@ static int qcom_swrm_enumerate(struct sdw_bus *bus)
>>  	return 0;
>>  }
>>  
>> +static void qcom_swrm_new_slave(struct work_struct *work)
>> +{
>> +	struct qcom_swrm_ctrl *ctrl = container_of(work, struct qcom_swrm_ctrl,
>> +						   new_slave_work.work);
>> +
>> +	/*
>> +	 * All Soundwire slave deviecs are expected to be in reset state (powered down)
>> +	 * during sdw_bus_master_add().  The slave device should be brougth
> 
> typo/grammar: brought out of reset

ack

> 
>> +	 * from reset by its probe() or bind() function, as a result of
>> +	 * sdw_bus_master_add().
>> +	 * Add a simple check to avoid NULL pointer except on early interrupts.
>> +	 * Note that if this condition happens, the slave device will not be
>> +	 * enumerated. Its driver should be fixed.
> 
> ???
> 
> The codec driver is NEVER involved in enumeration.

If the device stays in power down, only the driver bind can bring it on.
enumeration won't happen when device is powered down, right?

> 
> The only thing a codec driver should do is provide a callback to be
> notified of a status change for additional initialization, but the
> enumeration can be done even in the absence of a codec driver.
> 
> The proof in the pudding is that you can 'blacklist' a codec driver and
> bind it later, after the hardware is enumerated. You can even unbind a
> codec driver and nothing bad will happen (we hardened that sequence last
> year).
> 
> probe != enumeration != initialization for SoundWire codecs.
> 
> Probe and enumeration can happen in any order
> Initialization can only happen after both probe and enumeration happened.

I am speaking here about component_master_ops->bind() callback.
> 
>> +	 *
>> +	 * smp_load_acquire() paired with sdw_master_device_add().
>> +	 */
>> +	if (!smp_load_acquire(&ctrl->bus.md)) {
>> +		dev_err(ctrl->dev,
>> +			"Got unexpected, early interrupt, device will not be enumerated\n");
>> +		return;
>> +	}
>> +
>> +	clk_prepare_enable(ctrl->hclk);
>> +
>> +	qcom_swrm_get_device_status(ctrl);
>> +	qcom_swrm_enumerate(&ctrl->bus);
>> +	sdw_handle_slave_status(&ctrl->bus, ctrl->status);
>> +
>> +	clk_disable_unprepare(ctrl->hclk);
>> +};
>> +
>>  static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
>>  {
>>  	struct qcom_swrm_ctrl *ctrl = dev_id;
>> @@ -668,9 +701,17 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>>  					dev_dbg(ctrl->dev, "Slave status not changed %x\n",
>>  						slave_status);
>>  				} else {
>> -					qcom_swrm_get_device_status(ctrl);
>> -					qcom_swrm_enumerate(&ctrl->bus);
>> -					sdw_handle_slave_status(&ctrl->bus, ctrl->status);
>> +					unsigned long delay = 0;
>> +
>> +					/*
>> +					 * See qcom_swrm_new_slave() for
>> +					 * explanation. smp_load_acquire() paired
>> +					 * with sdw_master_device_add().
>> +					 */
>> +					if (!smp_load_acquire(&ctrl->bus.md))
>> +						delay = 10;
>> +					schedule_delayed_work(&ctrl->new_slave_work,
>> +							      delay);
>>  				}
>>  				break;
>>  			case SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET:
>> @@ -780,6 +821,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>>  
>>  	ctrl->intr_mask = SWRM_INTERRUPT_STATUS_RMSK;
>>  	/* Mask soundwire interrupts */
>> +
>>  	if (ctrl->version < SWRM_VERSION_2_0_0)
>>  		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
>>  				SWRM_INTERRUPT_STATUS_RMSK);
>> @@ -1485,6 +1527,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>>  	mutex_init(&ctrl->port_lock);
>>  	init_completion(&ctrl->broadcast);
>>  	init_completion(&ctrl->enumeration);
>> +	INIT_DELAYED_WORK(&ctrl->new_slave_work, qcom_swrm_new_slave);
>>  
>>  	ctrl->bus.ops = &qcom_swrm_ops;
>>  	ctrl->bus.port_ops = &qcom_swrm_port_ops;
>> @@ -1514,9 +1557,10 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>>  
>>  	ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &ctrl->version);
>>  
>> +	qcom_swrm_init(ctrl);
>> +
>>  	ret = devm_request_threaded_irq(dev, ctrl->irq, NULL,
>>  					qcom_swrm_irq_handler,
>> -					IRQF_TRIGGER_RISING |
>>  					IRQF_ONESHOT,
>>  					"soundwire", ctrl);
>>  	if (ret) {
>> @@ -1524,18 +1568,6 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>>  		goto err_clk;
>>  	}
>>  
>> -	ctrl->wake_irq = of_irq_get(dev->of_node, 1);
>> -	if (ctrl->wake_irq > 0) {
>> -		ret = devm_request_threaded_irq(dev, ctrl->wake_irq, NULL,
>> -						qcom_swrm_wake_irq_handler,
>> -						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>> -						"swr_wake_irq", ctrl);
>> -		if (ret) {
>> -			dev_err(dev, "Failed to request soundwire wake irq\n");
>> -			goto err_init;
>> -		}
>> -	}
>> -
>>  	pm_runtime_set_autosuspend_delay(dev, 3000);
>>  	pm_runtime_use_autosuspend(dev);
>>  	pm_runtime_mark_last_busy(dev);
>> @@ -1549,7 +1581,18 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>>  		goto err_clk;
>>  	}
>>  
>> -	qcom_swrm_init(ctrl);
>> +	ctrl->wake_irq = of_irq_get(dev->of_node, 1);
>> +	if (ctrl->wake_irq > 0) {
>> +		ret = devm_request_threaded_irq(dev, ctrl->wake_irq, NULL,
>> +						qcom_swrm_wake_irq_handler,
>> +						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>> +						"swr_wake_irq", ctrl);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to request soundwire wake irq\n");
>> +			goto err_init;
>> +		}
>> +	}
>> +
>>  	wait_for_completion_timeout(&ctrl->enumeration,
>>  				    msecs_to_jiffies(TIMEOUT_MS));
>>  	ret = qcom_swrm_register_dais(ctrl);
>> @@ -1589,6 +1632,18 @@ static int qcom_swrm_remove(struct platform_device *pdev)
>>  {
>>  	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
>>  
>> +	/*
>> +	 * Mask interrupts to be sure no delayed work can be scheduler after
> 
> typo/grammar: scheduled

ack

> 
>> +	 * removing Soundwire bus master.
>> +	 */
>> +	if (ctrl->version < SWRM_VERSION_2_0_0)
>> +		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
>> +				0);
>> +	if (ctrl->mmio)
>> +		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
>> +				0);
>> +
>> +	cancel_delayed_work_sync(&ctrl->new_slave_work);
>>  	sdw_bus_master_delete(&ctrl->bus);
>>  	clk_disable_unprepare(ctrl->hclk);
> 
> should the last two be inverted? Keeping a clock running while removing
> stuff is asking for trouble.

It is a reversed probe(), which is usually correct. Do you expect
probe() like:

	clk_enable
	sdw_bus_master_add

but remove() like:

	clk_disable
	sdw_bus_master_delete

?

Best regards,
Krzysztof

