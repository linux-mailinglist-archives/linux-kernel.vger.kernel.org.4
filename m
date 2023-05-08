Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB5F6F9FFF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjEHGcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjEHGcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:32:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C605596;
        Sun,  7 May 2023 23:32:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f14ec8d72aso2604050e87.1;
        Sun, 07 May 2023 23:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683527550; x=1686119550;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXPGowybNRivTrFpgw1LlsVLOHgiCVtEROMU0DPqPfs=;
        b=NaRR+8tqB6+Az45z0CW5/2h03wlGZ/jHwo2TDSGtIezmQ937QMrPoLT0vqM+FoHdZr
         6QX5D1PBf5+sTtoXdD/sTc67WuopaVuNdkd+/mhKHeBYIsOZJx8GFfyp+ViQAZoudmEP
         0QSJ+Gnpc2mJyMCCGQKsF3jBciX3y4wAJazjacF5Dvd01wO+yEN9FE23HJKLdgL2Jfa5
         usD8+/SGeaA1r2D/NA2lVSvCQK8gjsylNmxnX8ksPJt2s33V7Pr5IDWxYgejLLV4dCXY
         7jBw3kQaEIb9NLf5JHkT/U/kr59DmRvj2JjO0q4Y9fXNQ6McEImVyARqVLXagPo9LGxQ
         HlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683527550; x=1686119550;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXPGowybNRivTrFpgw1LlsVLOHgiCVtEROMU0DPqPfs=;
        b=HA/aLxxgzdBp4FuJui6voJXoYNy3tyIDQqmTNK7MCAwbBPxMkDmd7MBBkuIRftS+sq
         BD/8MrUBCcr3jEq+sA+e/vN/XQjbGw8C2G/wk9p0HGkc8Kyg0WFxqo8/6I9AEwpp1gOC
         5PPyTL06w4qfdYWxCfWfnzuiAsT/XU2E+IS9b6jx038j3ame/8GXIdqZ1xX8JXzC9KwH
         IprH15lUkCMXGWPVGXCjB2s3IUaE7h2TqpTCkiPWky+PYDYrP7kTeWNwIIbCsVmtjmQV
         WqmivPWujVjmiZoZd2qSLdGjsBZvz/k8ERwgk+M2Gb1Lyk42NbABrJQvqqJrEWABNnmB
         onqg==
X-Gm-Message-State: AC+VfDyE+MTM5vWbzncP0wYY0j0sAxxma5x0pqTazwT5eakhkyROMdI6
        EYNQQEdATXdXHTDQ9VSKdig=
X-Google-Smtp-Source: ACHHUZ7gAjzXagcSLUJ6rEfN8hF/5fXbhCG4Ezmws6yE/Q1dxn0bNFVNNsYVQsk3gQLrSYtvRjj4oA==
X-Received: by 2002:ac2:44b8:0:b0:4ec:8a0e:64c8 with SMTP id c24-20020ac244b8000000b004ec8a0e64c8mr2548532lfm.11.1683527549567;
        Sun, 07 May 2023 23:32:29 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id m4-20020a195204000000b004f13c4a21c6sm1179799lfb.152.2023.05.07.23.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 23:32:29 -0700 (PDT)
Message-ID: <dca5df2f-b7c0-b5af-f374-7cc5ef854cdb@gmail.com>
Date:   Mon, 8 May 2023 09:32:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1683105758.git.mazziesaccount@gmail.com>
 <6d1e37f95dd039d9c96a992b1855fd193bdded40.1683105758.git.mazziesaccount@gmail.com>
 <20230507155434.3d05daa5@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 4/5] iio: light: ROHM BU27008 color sensor
In-Reply-To: <20230507155434.3d05daa5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 5/7/23 17:54, Jonathan Cameron wrote:
> On Wed, 3 May 2023 12:50:14 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
>> and IR) with four configurable channels. Red and green being always
>> available and two out of the rest three (blue, clear, IR) can be
>> selected to be simultaneously measured. Typical application is adjusting
>> LCD backlight of TVs, mobile phones and tablet PCs.
>>
>> Add initial support for the ROHM BU27008 color sensor.
>>   - raw_read() of RGB and clear channels
>>   - triggered buffer w/ DRDY interrtupt
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
> Mostly stuff that you asked about in response to earlier version but
> which I hadn't replied to until today.
> 
> Upshot, don't need the manual irq handling in here.
> 
> Whilst you aren't setting IRQF_ONESHOT for the pollfunc side of the trigger
> (the downstream IRQ / IRQ thread) the IIO utility functions are.

I tried doing:

static int bu27008_setup_trigger(struct bu27008_data *data, struct 
iio_dev *idev)
{
	struct iio_trigger *itrig;
	char *name;
	int ret;

	ret = devm_iio_triggered_buffer_setup(data->dev, idev,
					      &iio_pollfunc_store_time,
					      bu27008_trigger_handler,
					      &bu27008_buffer_ops);
	if (ret)
		return dev_err_probe(data->dev, ret,
			     "iio_triggered_buffer_setup_ext FAIL\n");

	itrig = devm_iio_trigger_alloc(data->dev, "%sdata-rdy-dev%d",
				       idev->name, iio_device_id(idev));
	if (!itrig)
		return -ENOMEM;

	data->trig = itrig;

	itrig->ops = &bu27008_trigger_ops;
	iio_trigger_set_drvdata(itrig, data);

	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-bu27008",
			      dev_name(data->dev));

	ret = devm_request_irq(data->dev, data->irq,
				/* No IRQ disabling */
			       &iio_trigger_generic_data_rdy_poll,
			       0, name, itrig);
	if (ret)
		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");

	ret = devm_iio_trigger_register(data->dev, itrig);
	if (ret)
		return dev_err_probe(data->dev, ret,
				     "Trigger registration failed\n");

	/* set default trigger */
	idev->trig = iio_trigger_get(itrig);

	return 0;
}

It seems to me we get IRQ storm out of it, bu27008_trigger_handler never 
being called. My assumption is that as soon as the IRQ handling code 
exits the iio_trigger_generic_data_rdy_poll, it re-enables the IRQ - and 
because we have level active IRQ and because the 
bu27008_trigger_handler() has not yet had a chance to read the VALID bit 
which restores the IRQ-line - we will immediately enter back to the IRQ 
handling.

This problem does not occur when I use bu27008_data_rdy_poll() (which is 
the same but disables the IRQ) instead of 
iio_trigger_generic_data_rdy_poll(), and re-enable the IRQ only after 
the handler bu27008_trigger_handler() has restored the IRQ line.

Does the sequence above (bu27008_setup_trigger()) look sane?

> 
> 
>> +static irqreturn_t bu27008_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *idev = pf->indio_dev;
>> +	struct bu27008_data *data = iio_priv(idev);
>> +	struct {
>> +		__le16 chan[BU27008_NUM_HW_CHANS];
>> +		s64 ts __aligned(8);
>> +	} raw;
>> +	int ret, dummy;
>> +
>> +	memset(&raw, 0, sizeof(raw));
>> +
>> +	/*
>> +	 * After some measurements, it seems reading the
>> +	 * BU27008_REG_MODE_CONTROL3 debounces the IRQ line
>> +	 */
>> +	ret = regmap_read(data->regmap, BU27008_REG_MODE_CONTROL3, &dummy);
>> +	if (ret < 0)
>> +		goto err_read;
>> +
>> +	ret = regmap_bulk_read(data->regmap, BU27008_REG_DATA0_LO, &raw.chan,
>> +			       sizeof(raw.chan));
>> +	if (ret < 0)
>> +		goto err_read;
>> +
>> +	iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
>> +err_read:
>> +	iio_trigger_notify_done(idev->trig);
>> +
>> +	enable_irq(data->irq);
> 
> As below. This shouldn't be needed (and if it was it should be in the
> reenable path that is ultimately a result of that notify_done above and
> some reference counting fun).

I will see the reenable callback, thanks!

> 
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int bu27008_buffer_preenable(struct iio_dev *idev)
>> +{
>> +	struct bu27008_data *data = iio_priv(idev);
>> +	int chan_sel, ret;
>> +
>> +	/* Configure channel selection */
>> +	if (test_bit(BU27008_BLUE, idev->active_scan_mask)) {
>> +		if (test_bit(BU27008_CLEAR, idev->active_scan_mask))
>> +			chan_sel = BU27008_BLUE2_CLEAR3;
>> +		else
>> +			chan_sel = BU27008_BLUE2_IR3;
>> +	} else {
>> +		chan_sel = BU27008_CLEAR2_IR3;
>> +	}
>> +
>> +	chan_sel = FIELD_PREP(BU27008_MASK_CHAN_SEL, chan_sel);
>> +
>> +	ret = regmap_update_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
>> +				 BU27008_MASK_CHAN_SEL, chan_sel);
>> +	if (ret)
>> +		return ret;
> 
> Hmm. I'd missed this before but. This is in the wrong place really
> (though it probably doesn't make much difference), stuff related to
> enabling particular channels should be in iio_info->update_scan_mode()

Oh. I'll check this out as well.

> 
> It's arguable that the actual measurement mode setting might come
> in the postenable callback (after the update_scan_mode() call which
> in turn follows the preenable callback).
> 
> All these callbacks have become a bit blurry over time as we end
> up with devices that need to do nasty thing in one place.  In this
> particular case it's pretty simple though, so nicer to move
> the scan mask stuff to the callback that is given the active_scan
> mask as a parameter.
> 
>> +
>> +	return bu27008_meas_set(data, BU27008_MEAS_EN);
>> +}
>> +
>> +static int bu27008_buffer_postdisable(struct iio_dev *idev)
>> +{
>> +	struct bu27008_data *data = iio_priv(idev);
>> +
>> +	return bu27008_meas_set(data, BU27008_MEAS_DIS);
>> +}
>> +
>> +static const struct iio_buffer_setup_ops bu27008_buffer_ops = {
>> +	.preenable = bu27008_buffer_preenable,
>> +	.postdisable = bu27008_buffer_postdisable,
>> +};
>> +
>> +static irqreturn_t bu27008_data_rdy_poll(int irq, void *private)
>> +{
>> +	/*
>> +	 * The BU27008 keeps IRQ asserted until we read the VALID bit from
>> +	 * a register. We need to keep the IRQ disabled until this
>> +	 */
>> +	disable_irq_nosync(irq);
> 
> As per my late reply to your question on this, shouldn't be needed
> as IRQF_ONESHOT is ultimately set for the interrupts nested below this
> so they'll get the resulting queuing on the threads which is fine.

I see an IRQ storm if I omit this. The threaded trigger handler which 
'ACKs' the IRQ gets never ran. I'll see the reenable though! Thanks!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

