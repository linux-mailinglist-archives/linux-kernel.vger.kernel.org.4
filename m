Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8BE6AAB42
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 17:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCDQuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 11:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDQuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:50:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D8E199DC;
        Sat,  4 Mar 2023 08:50:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90F6B60025;
        Sat,  4 Mar 2023 16:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D0BC433EF;
        Sat,  4 Mar 2023 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677948605;
        bh=g63VeFCTOha5QCpBtftoQYbnqqy7jEjVRXZS332qKIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CE6O/4HKeLjwohvUTkyl0SRjbLUKX/LKSBJHw88upu6hi7TvFHpDaeZsvyCjUoTvj
         nNWy3lMF2fWXzgcwyT/OzBhdsFJuDdjUHaqDip4VdaDx/YonwhMgnpB6abjPH2AUhH
         fhvIcOiy1dlupuJ+WRj7AS8R2vOjiPfWip/N9HeE6fkIbboStbnMYBXniAbqJylrSn
         IWe7AV3rgY1K7SN46WBVpF+e7c12NPijP6JlJAQ78q/AKYgskbz9F/aZ9COhpC6m7X
         nPbQT6bJynnQYTa3EwS/GWgoUU5ai6gV/hMyrlDQgdPDvNHho/Z4GonDXCWLQ/mg5Y
         3afjIUXqWdidg==
Date:   Sat, 4 Mar 2023 16:50:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     lars@metafoo.de, andriy.shevchenko@linux.intel.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: Rename iio_trigger_poll_chained and add
 kernel-doc
Message-ID: <20230304165000.7329fbb6@jic23-huawei>
In-Reply-To: <841b533cba28ca25a8e87280c44e45979166e8e2.1677761379.git.mehdi.djait.k@gmail.com>
References: <cover.1677761379.git.mehdi.djait.k@gmail.com>
        <841b533cba28ca25a8e87280c44e45979166e8e2.1677761379.git.mehdi.djait.k@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Mar 2023 14:04:36 +0100
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Rename the function to iio_trigger_poll_nested.
> Add kernel-doc with a note on the context where the
> function is expected to be called.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
I tweaked the comment a bit in here as well in a similar fashion to the
previous patch.

Also rewrapped the patch description to nearer 75 chars.

Applied to the togreg branch of iio.git which I'll rebase once rc1 is
out.

This might cause some fun for those with lots of out of tree drivers
but that's their problem ;)  Who could I be thinking of? 

Jonathan

> ---
> v2:
> - no changes
> 
>  drivers/iio/accel/bma400_core.c                    |  2 +-
>  drivers/iio/accel/kionix-kx022a.c                  |  2 +-
>  drivers/iio/accel/mma8452.c                        |  2 +-
>  drivers/iio/accel/msa311.c                         |  2 +-
>  drivers/iio/adc/ad7606.c                           |  2 +-
>  drivers/iio/adc/at91-sama5d2_adc.c                 |  2 +-
>  drivers/iio/adc/max11410.c                         |  2 +-
>  drivers/iio/common/st_sensors/st_sensors_trigger.c |  4 ++--
>  drivers/iio/gyro/fxas21002c_core.c                 |  2 +-
>  drivers/iio/gyro/mpu3050-core.c                    |  2 +-
>  drivers/iio/humidity/hts221_buffer.c               |  2 +-
>  drivers/iio/industrialio-trigger.c                 | 12 ++++++++++--
>  drivers/iio/light/acpi-als.c                       |  2 +-
>  drivers/iio/light/rpr0521.c                        |  2 +-
>  drivers/iio/light/st_uvis25_core.c                 |  2 +-
>  drivers/iio/light/vcnl4000.c                       |  2 +-
>  drivers/iio/light/vcnl4035.c                       |  2 +-
>  drivers/iio/potentiostat/lmp91000.c                |  2 +-
>  drivers/iio/pressure/zpa2326.c                     |  2 +-
>  drivers/iio/proximity/as3935.c                     |  2 +-
>  drivers/iio/trigger/iio-trig-loop.c                |  2 +-
>  include/linux/iio/trigger.h                        |  2 +-
>  22 files changed, 32 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index b612d0146d4d..0b78248596bc 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -1709,7 +1709,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
>  
>  	if (FIELD_GET(BMA400_INT_DRDY_MSK, le16_to_cpu(data->status))) {
>  		mutex_unlock(&data->mutex);
> -		iio_trigger_poll_chained(data->trig);
> +		iio_trigger_poll_nested(data->trig);
>  		return IRQ_HANDLED;
>  	}
>  
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 1c3a72380fb8..6fc490a60e81 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -900,7 +900,7 @@ static irqreturn_t kx022a_irq_thread_handler(int irq, void *private)
>  	mutex_lock(&data->mutex);
>  
>  	if (data->trigger_enabled) {
> -		iio_trigger_poll_chained(data->trig);
> +		iio_trigger_poll_nested(data->trig);
>  		ret = IRQ_HANDLED;
>  	}
>  
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index f97fb68e3a71..ea14e3aaa30a 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1067,7 +1067,7 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
>  		return IRQ_NONE;
>  
>  	if (src & MMA8452_INT_DRDY) {
> -		iio_trigger_poll_chained(indio_dev->trig);
> +		iio_trigger_poll_nested(indio_dev->trig);
>  		ret = IRQ_HANDLED;
>  	}
>  
> diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
> index af94d3adf6d8..6690fa37da8f 100644
> --- a/drivers/iio/accel/msa311.c
> +++ b/drivers/iio/accel/msa311.c
> @@ -951,7 +951,7 @@ static irqreturn_t msa311_irq_thread(int irq, void *p)
>  	}
>  
>  	if (new_data_int_enabled)
> -		iio_trigger_poll_chained(msa311->new_data_trig);
> +		iio_trigger_poll_nested(msa311->new_data_trig);
>  
>  	return IRQ_HANDLED;
>  }
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index dd6b603f65ea..1928d9ae5bcf 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -477,7 +477,7 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
>  
>  	if (iio_buffer_enabled(indio_dev)) {
>  		gpiod_set_value(st->gpio_convst, 0);
> -		iio_trigger_poll_chained(st->trig);
> +		iio_trigger_poll_nested(st->trig);
>  	} else {
>  		complete(&st->completion);
>  	}
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index ed4f8501bda8..f155609f1141 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1194,7 +1194,7 @@ static void at91_dma_buffer_done(void *data)
>  {
>  	struct iio_dev *indio_dev = data;
>  
> -	iio_trigger_poll_chained(indio_dev->trig);
> +	iio_trigger_poll_nested(indio_dev->trig);
>  }
>  
>  static int at91_adc_dma_start(struct iio_dev *indio_dev)
> diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
> index fdc9f03135b5..7acb2d0359d2 100644
> --- a/drivers/iio/adc/max11410.c
> +++ b/drivers/iio/adc/max11410.c
> @@ -677,7 +677,7 @@ static irqreturn_t max11410_interrupt(int irq, void *dev_id)
>  	struct max11410_state *st = iio_priv(indio_dev);
>  
>  	if (iio_buffer_enabled(indio_dev))
> -		iio_trigger_poll_chained(st->trig);
> +		iio_trigger_poll_nested(st->trig);
>  	else
>  		complete(&st->completion);
>  
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 899b640c0a70..a0df9250a69f 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -85,7 +85,7 @@ static irqreturn_t st_sensors_irq_thread(int irq, void *p)
>  	 */
>  	if (sdata->hw_irq_trigger &&
>  	    st_sensors_new_samples_available(indio_dev, sdata)) {
> -		iio_trigger_poll_chained(p);
> +		iio_trigger_poll_nested(p);
>  	} else {
>  		dev_dbg(indio_dev->dev.parent, "spurious IRQ\n");
>  		return IRQ_NONE;
> @@ -110,7 +110,7 @@ static irqreturn_t st_sensors_irq_thread(int irq, void *p)
>  		dev_dbg(indio_dev->dev.parent,
>  			"more samples came in during polling\n");
>  		sdata->hw_timestamp = iio_get_time_ns(indio_dev);
> -		iio_trigger_poll_chained(p);
> +		iio_trigger_poll_nested(p);
>  	}
>  
>  	return IRQ_HANDLED;
> diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> index 3ea1d4613080..c28d17ca6f5e 100644
> --- a/drivers/iio/gyro/fxas21002c_core.c
> +++ b/drivers/iio/gyro/fxas21002c_core.c
> @@ -813,7 +813,7 @@ static irqreturn_t fxas21002c_data_rdy_thread(int irq, void *private)
>  	if (!data_ready)
>  		return IRQ_NONE;
>  
> -	iio_trigger_poll_chained(data->dready_trig);
> +	iio_trigger_poll_nested(data->dready_trig);
>  
>  	return IRQ_HANDLED;
>  }
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index 6a6d84a3deda..a791ba3a693a 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -939,7 +939,7 @@ static irqreturn_t mpu3050_irq_thread(int irq, void *p)
>  	if (!(val & MPU3050_INT_STATUS_RAW_RDY))
>  		return IRQ_NONE;
>  
> -	iio_trigger_poll_chained(p);
> +	iio_trigger_poll_nested(p);
>  
>  	return IRQ_HANDLED;
>  }
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> index 2a4107a79662..11ef38994a95 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -68,7 +68,7 @@ static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
>  	if (!(status & HTS221_RH_DRDY_MASK))
>  		return IRQ_NONE;
>  
> -	iio_trigger_poll_chained(hw->trig);
> +	iio_trigger_poll_nested(hw->trig);
>  
>  	return IRQ_HANDLED;
>  }
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index bb0a44df8740..19cf36bd3de5 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -223,7 +223,15 @@ irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private)
>  }
>  EXPORT_SYMBOL(iio_trigger_generic_data_rdy_poll);
>  
> -void iio_trigger_poll_chained(struct iio_trigger *trig)
> +/**
> + * iio_trigger_poll_nested() - Call the threaded trigger handler of the
> + * consumers
> + * @trig: trigger which occurred
> + *
> + * This function needs to be called from a kernel thread context.

This function should only be called from a kernel thread context.

> + *
> + */
> +void iio_trigger_poll_nested(struct iio_trigger *trig)
>  {
>  	int i;
>  
> @@ -238,7 +246,7 @@ void iio_trigger_poll_chained(struct iio_trigger *trig)
>  		}
>  	}
>  }
> -EXPORT_SYMBOL(iio_trigger_poll_chained);
> +EXPORT_SYMBOL(iio_trigger_poll_nested);
>  
>  void iio_trigger_notify_done(struct iio_trigger *trig)
>  {
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index e1ff6f524f4b..2d91caf24dd0 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -108,7 +108,7 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
>  	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev)) {
>  		switch (event) {
>  		case ACPI_ALS_NOTIFY_ILLUMINANCE:
> -			iio_trigger_poll_chained(als->trig);
> +			iio_trigger_poll_nested(als->trig);
>  			break;
>  		default:
>  			/* Unhandled event */
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 668e444f6049..9d0218b7426e 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -431,7 +431,7 @@ static irqreturn_t rpr0521_drdy_irq_thread(int irq, void *private)
>  	struct rpr0521_data *data = iio_priv(indio_dev);
>  
>  	if (rpr0521_is_triggered(data)) {
> -		iio_trigger_poll_chained(data->drdy_trigger0);
> +		iio_trigger_poll_nested(data->drdy_trigger0);
>  		return IRQ_HANDLED;
>  	}
>  
> diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
> index c737d3e193ae..50f95c5d2060 100644
> --- a/drivers/iio/light/st_uvis25_core.c
> +++ b/drivers/iio/light/st_uvis25_core.c
> @@ -161,7 +161,7 @@ static irqreturn_t st_uvis25_trigger_handler_thread(int irq, void *private)
>  	if (!(status & ST_UVIS25_REG_UV_DA_MASK))
>  		return IRQ_NONE;
>  
> -	iio_trigger_poll_chained(hw->trig);
> +	iio_trigger_poll_nested(hw->trig);
>  
>  	return IRQ_HANDLED;
>  }
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 69c5bc987e26..5e041a491390 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -1068,7 +1068,7 @@ static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
>  	}
>  
>  	if (isr & VCNL4010_INT_DRDY && iio_buffer_enabled(indio_dev))
> -		iio_trigger_poll_chained(indio_dev->trig);
> +		iio_trigger_poll_nested(indio_dev->trig);
>  
>  end:
>  	return IRQ_HANDLED;
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index 84148b944000..14e29330e972 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -89,7 +89,7 @@ static irqreturn_t vcnl4035_drdy_irq_thread(int irq, void *private)
>  							IIO_EV_TYPE_THRESH,
>  							IIO_EV_DIR_EITHER),
>  				iio_get_time_ns(indio_dev));
> -		iio_trigger_poll_chained(data->drdy_trigger0);
> +		iio_trigger_poll_nested(data->drdy_trigger0);
>  		return IRQ_HANDLED;
>  	}
>  
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index b82f093f1e6a..0083e858c21e 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -118,7 +118,7 @@ static int lmp91000_read(struct lmp91000_data *data, int channel, int *val)
>  
>  	data->chan_select = channel != LMP91000_REG_MODECN_3LEAD;
>  
> -	iio_trigger_poll_chained(data->trig);
> +	iio_trigger_poll_nested(data->trig);
>  
>  	ret = wait_for_completion_timeout(&data->completion, HZ);
>  	reinit_completion(&data->completion);
> diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> index 67119a9b95fc..421e059d1f19 100644
> --- a/drivers/iio/pressure/zpa2326.c
> +++ b/drivers/iio/pressure/zpa2326.c
> @@ -829,7 +829,7 @@ static irqreturn_t zpa2326_handle_threaded_irq(int irq, void *data)
>  	}
>  
>  	/* New sample available: dispatch internal trigger consumers. */
> -	iio_trigger_poll_chained(priv->trigger);
> +	iio_trigger_poll_nested(priv->trigger);
>  
>  	if (cont)
>  		/*
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index ebc95cf8f5f4..96fa97451cbf 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -257,7 +257,7 @@ static void as3935_event_work(struct work_struct *work)
>  
>  	switch (val) {
>  	case AS3935_EVENT_INT:
> -		iio_trigger_poll_chained(st->trig);
> +		iio_trigger_poll_nested(st->trig);
>  		break;
>  	case AS3935_DISTURB_INT:
>  	case AS3935_NOISE_INT:
> diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
> index 96ec06bbe546..7aaed0611899 100644
> --- a/drivers/iio/trigger/iio-trig-loop.c
> +++ b/drivers/iio/trigger/iio-trig-loop.c
> @@ -46,7 +46,7 @@ static int iio_loop_thread(void *data)
>  	set_freezable();
>  
>  	do {
> -		iio_trigger_poll_chained(trig);
> +		iio_trigger_poll_nested(trig);
>  	} while (likely(!kthread_freezable_should_stop(NULL)));
>  
>  	return 0;
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index 42da55dc3aa7..51f52c5c6092 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -152,7 +152,7 @@ void iio_trigger_unregister(struct iio_trigger *trig_info);
>  int iio_trigger_set_immutable(struct iio_dev *indio_dev, struct iio_trigger *trig);
>  
>  void iio_trigger_poll(struct iio_trigger *trig);
> -void iio_trigger_poll_chained(struct iio_trigger *trig);
> +void iio_trigger_poll_nested(struct iio_trigger *trig);
>  
>  irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private);
>  

