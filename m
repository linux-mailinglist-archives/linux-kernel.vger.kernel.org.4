Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BA95E74CC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiIWHXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiIWHXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:23:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060FF12B4A8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:23:30 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso2683887wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=94HaSh9+32pd4TeLZCxQu+v/VTpeSqDTLlUxTnk2PcE=;
        b=yi0fzJEZq7kHvVq4IR3U7KrxlHeSnGNNt9W7HtXTjCJLOhDn0+QGZ5hV5akHcR2nw2
         VQwlgYeKTUrj0irBZOjLv0OBAqGL3AK181kJ0MnrTlH8W7ssGEhNJJV6VEavx3bQeBJp
         46HFq40sTyyOOmpgDw9qyLbQmJjszkpkUeONbw03am0TMV1yG/oQkC5f6/YKyHneQTEc
         ZBh936OoIIcb18XETpYY6UEVkcrVsN8/t/vqvYYyTU/KYeeVbuTo3chP10n5SAVBYdlj
         yb1iLr7Dop58ZvThDPRx4Wye/cKcsOBm9lzO1pu+C2/+bCpbRUoFnTvOKRIuUTTof8NI
         ASbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=94HaSh9+32pd4TeLZCxQu+v/VTpeSqDTLlUxTnk2PcE=;
        b=0gObfG4GGqa3rBye4C1tSE6BoGxSdDug4pb+ukga3doriZdavTmMVIBVs6Qp9uecZu
         DTu0VrM/zj4qNfoh9KZqvDKfPaw5k8kMDF6idOHirLVNpuxJzxtbD2GcXUodje36TD4v
         Jhg+seKmk+kbuj5uqm3YH3/UC1dYq8X+3IS8h4Ugf8MJs/JL/TDw4osfPcqE9/l2INGt
         ZZg90Reiasl0eu3gvazyOph1IShG7DpVFM+fHYI1TaelR3qusix3OBpWJb+9rLTGwHuS
         mt7UNGpw0kUm8WPmmfidzE+SeSj6gHZCCh+ilO7iof3SOnwIScxo7G2zZW/g1Rnw+aJF
         DzNw==
X-Gm-Message-State: ACrzQf3obw4SdXBoyQMfFKXf5k3LFfzRMxHrWJ3GeyLZ0p80CKBCk4mQ
        1v366lHvE9gG+HV93AGod+XatFDjzVdBKQ==
X-Google-Smtp-Source: AMsMyM7sfCuqo6iKSam1u15Z4X6etCJIZaUwmsaCO5n7bgmRJgAd3lQevKaZcGAc2WitSEmEU/QcqQ==
X-Received: by 2002:a05:600c:6025:b0:3b4:8c0c:f3c9 with SMTP id az37-20020a05600c602500b003b48c0cf3c9mr11600612wmb.206.1663917808548;
        Fri, 23 Sep 2022 00:23:28 -0700 (PDT)
Received: from [192.168.1.70] (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id x8-20020adfdcc8000000b0022a2dbc80fdsm6742587wrm.10.2022.09.23.00.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 00:23:28 -0700 (PDT)
Message-ID: <2f3e5036-caab-f892-a4ad-b852f72db331@baylibre.com>
Date:   Fri, 23 Sep 2022 09:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v8 3/4] counter: ti-ecap-capture: capture driver support
 for ECAP
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
References: <20220922170402.403683-1-jpanis@baylibre.com>
 <20220922170402.403683-4-jpanis@baylibre.com> <Yy0G9a5S3OzwyEwW@fedora>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <Yy0G9a5S3OzwyEwW@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/09/2022 03:08, William Breathitt Gray wrote:
> On Thu, Sep 22, 2022 at 07:04:01PM +0200, Julien Panis wrote:
>> ECAP hardware on TI AM62x SoC supports capture feature. It can be used
>> to timestamp events (falling/rising edges) detected on input signal.
>>
>> This commit adds capture driver support for ECAP hardware on AM62x SoC.
>>
>> In the ECAP hardware, capture pin can also be configured to be in
>> PWM mode. Current implementation only supports capture operating mode.
>> Hardware also supports timebase sync between multiple instances, but
>> this driver supports simple independent capture functionality.
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> Hello Julien,
>
> Comments follow inline below.
>
>> +/**
>> + * struct ecap_cnt_dev - device private data structure
>> + * @enabled: device state
>> + * @clk:     device clock
>> + * @regmap:  device register map
>> + * @nb_ovf:  number of overflows since capture start
>> + * @pm_ctx:  device context for PM operations
>> + */
>> +struct ecap_cnt_dev {
>> +	bool enabled;
>> +	struct clk *clk;
>> +	struct regmap *regmap;
>> +	atomic_t nb_ovf;
>> +	struct {
>> +		u8 ev_mode;
>> +		u32 time_cntr;
>> +	} pm_ctx;
>> +};
> Provide documentation for the ev_mode and time_cntr members. You
> probably need a lock as well to protect access to this structure or
> you'll end up with race problems.

Hi William,

How can I end up with race problems ? pm_ctx members are only accessed at
suspend (after capture/IRQ are disabled) and resume (before capture/IRQ 
are re-enabled).
Is there any risk I did not identify ?

Julien

>
>
>> +static void ecap_cnt_capture_enable(struct counter_device *counter)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +
>> +	pm_runtime_get_sync(counter->parent);
>> +
>> +	/* Enable interrupts on events */
>> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG,
>> +			   ECAP_EVT_EN_MASK, ECAP_EVT_EN_MASK);
>> +
>> +	/* Run counter */
>> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_ECCTL_CFG_MASK,
>> +			   ECAP_SYNCO_DIS_MASK | ECAP_STOPVALUE_MASK | ECAP_ECCTL_EN_MASK);
>> +}
>> +
>> +static void ecap_cnt_capture_disable(struct counter_device *counter)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +
>> +	/* Disable interrupts on events */
>> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, ECAP_EVT_EN_MASK, 0);
>> +
>> +	/* Stop counter */
>> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_ECCTL_EN_MASK, 0);
> Shouldn't the counter be stopped before stopping the interrupts?
>
>> +static int ecap_cnt_count_get_val(struct counter_device *counter, unsigned int reg, u32 *val)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +	unsigned int regval;
>> +
>> +	pm_runtime_get_sync(counter->parent);
>> +	regmap_read(ecap_dev->regmap, reg, &regval);
>> +	pm_runtime_put_sync(counter->parent);
>> +
>> +	*val = regval;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ecap_cnt_count_set_val(struct counter_device *counter, unsigned int reg, u32 val)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +
>> +	pm_runtime_get_sync(counter->parent);
>> +	regmap_write(ecap_dev->regmap, reg, val);
>> +	pm_runtime_put_sync(counter->parent);
>> +
>> +	return 0;
>> +}
> The ecap_cnt_count_get_val() and ecap_cnt_count_set_val() functions only
> ever return 0. Redefine them as void functions and eliminate the
> unnecessary returns.
>
>> +static int ecap_cnt_count_write(struct counter_device *counter,
>> +				struct counter_count *count, u64 val)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +
>> +	if (ecap_dev->enabled)
>> +		return -EBUSY;
> You should return -EBUSY when the requested operation cannot be
> completed because the device currently performing a task -- i.e. the
> requested operation would stall or otherwise fail if forced. In this
> case, the count value actually can be set while the device is enabled,
> if I'm not mistaken; the count just continues increasing from the new
> written value (i.e. no stall/failure). Therefore, there's not need to
> return -EBUSY here and this check can be eliminated.
>
>> +static int ecap_cnt_pol_write(struct counter_device *counter,
>> +			      struct counter_signal *signal,
>> +			      size_t idx, enum counter_signal_polarity pol)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +
>> +	if (ecap_dev->enabled)
>> +		return -EBUSY;
> I suspect this check can go away for the same reason as above.
>
>> +static int ecap_cnt_cap_write(struct counter_device *counter,
>> +			      struct counter_count *count,
>> +			      size_t idx, u64 cap)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +
>> +	if (ecap_dev->enabled)
>> +		return -EBUSY;
> Same comment as above.
>
>> +static int ecap_cnt_nb_ovf_write(struct counter_device *counter,
>> +				 struct counter_count *count, u64 val)
>> +{
>> +	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>> +
>> +	if (ecap_dev->enabled)
>> +		return -EBUSY;
> Same comment as above.
>
>> +static struct counter_count ecap_cnt_counts[] = {
>> +	{
>> +		.id = 0,
> The id member is for differentiating between multiple Counts. You only
> have one Count in this driver so you don't need to set it because you
> never use it.
>
> William Breathitt Gray

