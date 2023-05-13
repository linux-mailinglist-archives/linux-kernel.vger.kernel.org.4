Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7386B701881
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjEMRgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjEMRgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:36:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A242686;
        Sat, 13 May 2023 10:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ECF1601DB;
        Sat, 13 May 2023 17:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74121C433D2;
        Sat, 13 May 2023 17:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683999396;
        bh=Up3kRvV2utStQ+dNNUIlZUZeRXb35QvlSL9rahOYgKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SOyhOemMlsKTzAJWuSChiWXJKvqLR0iGhozNoq/El3xAyrGsW8Us1DpqUV+biuLvv
         oGvHtE2rrzkCTpuW+seXAFtnsYQIhXOdL6AEgv17KT2bJAIVkYVA1pUN4YBEjgPrRp
         oxGTNAjD57Svw/sR/Fz/q4w8tzhXCxLu2LCjvFiSBfM8iXS0eH7civkQs+t1ajVI6O
         s6rJ8HrPZjF1lDAFusLAROsw0MOixEW7ycB6qayfoDAh6H4bjqqeAJlpMGuabezIC5
         hWYxTHcgpr9XbBpGQyVuPdQHCdZXFCAqjbc9F/umTFNK6WsEJIqiyjcqZQWNUR1rRC
         9+WZXdDkPPhYQ==
Date:   Sat, 13 May 2023 18:52:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
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
Subject: Re: [PATCH v4 4/5] iio: light: ROHM BU27008 color sensor
Message-ID: <20230513185236.39bbface@jic23-huawei>
In-Reply-To: <dca5df2f-b7c0-b5af-f374-7cc5ef854cdb@gmail.com>
References: <cover.1683105758.git.mazziesaccount@gmail.com>
        <6d1e37f95dd039d9c96a992b1855fd193bdded40.1683105758.git.mazziesaccount@gmail.com>
        <20230507155434.3d05daa5@jic23-huawei>
        <dca5df2f-b7c0-b5af-f374-7cc5ef854cdb@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2023 09:32:28 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Jonathan,
> 
> On 5/7/23 17:54, Jonathan Cameron wrote:
> > On Wed, 3 May 2023 12:50:14 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
> >> and IR) with four configurable channels. Red and green being always
> >> available and two out of the rest three (blue, clear, IR) can be
> >> selected to be simultaneously measured. Typical application is adjusting
> >> LCD backlight of TVs, mobile phones and tablet PCs.
> >>
> >> Add initial support for the ROHM BU27008 color sensor.
> >>   - raw_read() of RGB and clear channels
> >>   - triggered buffer w/ DRDY interrtupt
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>  
> > Mostly stuff that you asked about in response to earlier version but
> > which I hadn't replied to until today.
> > 
> > Upshot, don't need the manual irq handling in here.
> > 
> > Whilst you aren't setting IRQF_ONESHOT for the pollfunc side of the trigger
> > (the downstream IRQ / IRQ thread) the IIO utility functions are.  
> 
> I tried doing:
> 
> static int bu27008_setup_trigger(struct bu27008_data *data, struct 
> iio_dev *idev)
> {
> 	struct iio_trigger *itrig;
> 	char *name;
> 	int ret;
> 
> 	ret = devm_iio_triggered_buffer_setup(data->dev, idev,
> 					      &iio_pollfunc_store_time,
> 					      bu27008_trigger_handler,
> 					      &bu27008_buffer_ops);
> 	if (ret)
> 		return dev_err_probe(data->dev, ret,
> 			     "iio_triggered_buffer_setup_ext FAIL\n");
> 
> 	itrig = devm_iio_trigger_alloc(data->dev, "%sdata-rdy-dev%d",
> 				       idev->name, iio_device_id(idev));
> 	if (!itrig)
> 		return -ENOMEM;
> 
> 	data->trig = itrig;
> 
> 	itrig->ops = &bu27008_trigger_ops;
> 	iio_trigger_set_drvdata(itrig, data);
> 
> 	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-bu27008",
> 			      dev_name(data->dev));
> 
> 	ret = devm_request_irq(data->dev, data->irq,
> 				/* No IRQ disabling */
> 			       &iio_trigger_generic_data_rdy_poll,
> 			       0, name, itrig);
> 	if (ret)
> 		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
> 
> 	ret = devm_iio_trigger_register(data->dev, itrig);
> 	if (ret)
> 		return dev_err_probe(data->dev, ret,
> 				     "Trigger registration failed\n");
> 
> 	/* set default trigger */
> 	idev->trig = iio_trigger_get(itrig);
> 
> 	return 0;
> }
> 
> It seems to me we get IRQ storm out of it, bu27008_trigger_handler never 
> being called. My assumption is that as soon as the IRQ handling code 
> exits the iio_trigger_generic_data_rdy_poll, it re-enables the IRQ - and 
> because we have level active IRQ and because the 
> bu27008_trigger_handler() has not yet had a chance to read the VALID bit 
> which restores the IRQ-line - we will immediately enter back to the IRQ 
> handling.

Ah. I'd miss understood what was going on here. I thought we were talking
race conditions only - not a level interrupt. Sorry for confusion / being
half asleep. If it has an Ack like this I'd argue this is really an edge
interrupt but that would require a guaranteed drop in the signal.
I am assuming the sensor merrily carries on grabbing data, whether or
not anyone reads it and so if we treated this as an edge interrupt then
the clear to set cycle could be very short (and hence not detected).
If it instead doesn't read new data until previous has been read, then things
are much simpler.

Hmm. How to make this work cleanly assuming it's case 1. It might be that your
current approach is the best though it would be nice to do something in the
IIO code (with risk of breaking everyone  :()  I don't think we can though
as we have no way from the trigger implementation side to know if we might
get threaded interrupt handling or not on the downstream side.

We have reference counting to reenable a trigger that actually has a hardware
mask at the device end when all consumers are done - that should be used for
the reenable, not do it in the pollfunc handler.  As it's a level interrupt
you avoid need to do a bonus read in there I think (sometimes that's necessary
because of an edge trigger and a slow read back on a possible unrelated device).

The subtle difference between IRQF_ONESHOT and irq_disable is one uses
the irq_mask / unmask callbacks on the irq chip and the other is using
the enable / disable ones.  That may make no practical difference - I'm not
entirely sure.  A quick glance at some drivers suggests masking is usually
lighter weight as less state is rewrite on reenable.

So in short, move the irq_enable() into the iio_trig->reenable() callback.


> 
> This problem does not occur when I use bu27008_data_rdy_poll() (which is 
> the same but disables the IRQ) instead of 
> iio_trigger_generic_data_rdy_poll(), and re-enable the IRQ only after 
> the handler bu27008_trigger_handler() has restored the IRQ line.
> 
> Does the sequence above (bu27008_setup_trigger()) look sane?
> 
> > 
> >   
> >> +static irqreturn_t bu27008_trigger_handler(int irq, void *p)
> >> +{
> >> +	struct iio_poll_func *pf = p;
> >> +	struct iio_dev *idev = pf->indio_dev;
> >> +	struct bu27008_data *data = iio_priv(idev);
> >> +	struct {
> >> +		__le16 chan[BU27008_NUM_HW_CHANS];
> >> +		s64 ts __aligned(8);
> >> +	} raw;
> >> +	int ret, dummy;
> >> +
> >> +	memset(&raw, 0, sizeof(raw));
> >> +
> >> +	/*
> >> +	 * After some measurements, it seems reading the
> >> +	 * BU27008_REG_MODE_CONTROL3 debounces the IRQ line
> >> +	 */
> >> +	ret = regmap_read(data->regmap, BU27008_REG_MODE_CONTROL3, &dummy);
> >> +	if (ret < 0)
> >> +		goto err_read;
> >> +
> >> +	ret = regmap_bulk_read(data->regmap, BU27008_REG_DATA0_LO, &raw.chan,
> >> +			       sizeof(raw.chan));
> >> +	if (ret < 0)
> >> +		goto err_read;
> >> +
> >> +	iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
> >> +err_read:
> >> +	iio_trigger_notify_done(idev->trig);
> >> +
> >> +	enable_irq(data->irq);  
> > 
> > As below. This shouldn't be needed (and if it was it should be in the
> > reenable path that is ultimately a result of that notify_done above and
> > some reference counting fun).  
> 
> I will see the reenable callback, thanks!

Great

> 
> >   
> >> +
> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >> +static int bu27008_buffer_preenable(struct iio_dev *idev)
> >> +{
> >> +	struct bu27008_data *data = iio_priv(idev);
> >> +	int chan_sel, ret;
> >> +
> >> +	/* Configure channel selection */
> >> +	if (test_bit(BU27008_BLUE, idev->active_scan_mask)) {
> >> +		if (test_bit(BU27008_CLEAR, idev->active_scan_mask))
> >> +			chan_sel = BU27008_BLUE2_CLEAR3;
> >> +		else
> >> +			chan_sel = BU27008_BLUE2_IR3;
> >> +	} else {
> >> +		chan_sel = BU27008_CLEAR2_IR3;
> >> +	}
> >> +
> >> +	chan_sel = FIELD_PREP(BU27008_MASK_CHAN_SEL, chan_sel);
> >> +
> >> +	ret = regmap_update_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
> >> +				 BU27008_MASK_CHAN_SEL, chan_sel);
> >> +	if (ret)
> >> +		return ret;  
> > 
> > Hmm. I'd missed this before but. This is in the wrong place really
> > (though it probably doesn't make much difference), stuff related to
> > enabling particular channels should be in iio_info->update_scan_mode()  
> 
> Oh. I'll check this out as well.
> 
> > 
> > It's arguable that the actual measurement mode setting might come
> > in the postenable callback (after the update_scan_mode() call which
> > in turn follows the preenable callback).
> > 
> > All these callbacks have become a bit blurry over time as we end
> > up with devices that need to do nasty thing in one place.  In this
> > particular case it's pretty simple though, so nicer to move
> > the scan mask stuff to the callback that is given the active_scan
> > mask as a parameter.
> >   
> >> +
> >> +	return bu27008_meas_set(data, BU27008_MEAS_EN);
> >> +}
> >> +
> >> +static int bu27008_buffer_postdisable(struct iio_dev *idev)
> >> +{
> >> +	struct bu27008_data *data = iio_priv(idev);
> >> +
> >> +	return bu27008_meas_set(data, BU27008_MEAS_DIS);
> >> +}
> >> +
> >> +static const struct iio_buffer_setup_ops bu27008_buffer_ops = {
> >> +	.preenable = bu27008_buffer_preenable,
> >> +	.postdisable = bu27008_buffer_postdisable,
> >> +};
> >> +
> >> +static irqreturn_t bu27008_data_rdy_poll(int irq, void *private)
> >> +{
> >> +	/*
> >> +	 * The BU27008 keeps IRQ asserted until we read the VALID bit from
> >> +	 * a register. We need to keep the IRQ disabled until this
> >> +	 */
> >> +	disable_irq_nosync(irq);  
> > 
> > As per my late reply to your question on this, shouldn't be needed
> > as IRQF_ONESHOT is ultimately set for the interrupts nested below this
> > so they'll get the resulting queuing on the threads which is fine.  
> 
> I see an IRQ storm if I omit this. The threaded trigger handler which 
> 'ACKs' the IRQ gets never ran. I'll see the reenable though! Thanks!

As you probably figured, I was wrong. Reenable bit stands though!.

Jonathan

> 
> Yours,
> 	-- Matti
> 

