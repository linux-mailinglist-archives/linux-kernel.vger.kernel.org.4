Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ADE6F98E1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 16:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjEGOTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 10:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEGOTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 10:19:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99AC4C25;
        Sun,  7 May 2023 07:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FEDC60C5E;
        Sun,  7 May 2023 14:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87675C433EF;
        Sun,  7 May 2023 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683469144;
        bh=bWgS6xVM0twb9Tsnumkxrs/bEwi5vgZbTfEs1wm2qpE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KZtfAxBTe1PzHtVUjKhzGpl/THFP1BusGfi3cHxlTOrlwR1wmEPpsxD7LW/4kO7gx
         B/z3nQtF7CjX2SJ/R19g7ujBU1b+Qq6nGNMeIn2cBJKAOvuc8fjdDAxsXINz2TMsKr
         zMQOSCjOhSC1d8JHnEvbMDKQBwN4cjO6W2u+YuW5xYrvZROsyjRxdIsGwDtk9LyqeY
         VfjMEybKv/lqHC/V0j9IbgGvoXdIfyevsJ/XnmIIUEz+P4XxcZFJX4gXCSGqytasEd
         lCWTk5f9FJC3eRoRD7cibRb09kqZfAqROOtkJ5F2wnGcQ5j1iOVWnmqegblgQi0uKo
         HKgCpK6aT7slw==
Date:   Sun, 7 May 2023 15:34:57 +0100
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
Subject: Re: [PATCH v4 2/5] iio: trigger: Add simple trigger_validation
 helper
Message-ID: <20230507153457.3b6bbfed@jic23-huawei>
In-Reply-To: <dab917aa8f2442ad10aa2a266395edd3cd7ce1d7.1683105758.git.mazziesaccount@gmail.com>
References: <cover.1683105758.git.mazziesaccount@gmail.com>
        <dab917aa8f2442ad10aa2a266395edd3cd7ce1d7.1683105758.git.mazziesaccount@gmail.com>
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

On Wed, 3 May 2023 12:48:57 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Some triggers can only be attached to the IIO device that corresponds to
> the same physical device. Implement generic helper which can be used as
> a validate_trigger callback for such devices.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 

Noticed a trivial capitalisation issue inline.

Jonathan

> ---
> Revision history
> v2: => v3:
>  - Fix title (space after iio:)
> v2: New patch
> ---
>  drivers/iio/industrialio-trigger.c | 22 +++++++++++++++++++++-
>  include/linux/iio/trigger.h        |  1 +
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 784dc1e00310..c616297aa754 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -322,7 +322,7 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>  	 * this is the case if the IIO device and the trigger device share the
>  	 * same parent device.
>  	 */
> -	if (pf->indio_dev->dev.parent == trig->dev.parent)
> +	if (iio_validate_own_trigger(pf->indio_dev, trig))
>  		trig->attached_own_device = true;
>  
>  	return ret;
> @@ -728,6 +728,26 @@ bool iio_trigger_using_own(struct iio_dev *indio_dev)
>  }
>  EXPORT_SYMBOL(iio_trigger_using_own);
>  
> +/**
> + * iio_validate_own_trigger - Check if a trigger and IIO device belong to
> + *  the same device
> + * @idev: the IIO device to check
> + * @trig: The IIO trigger to check

The / the consistency needs fixing. I'm not sure on the local / file convention, but
it hopefully isn't a random mixture!

> + *
> + * This function can be used as the validate_trigger callback for triggers that
> + * can only be attached to their own device.
> + *
> + * Return: 0 if both the trigger and the IIO device belong to the same
> + * device, -EINVAL otherwise.
> + */
> +int iio_validate_own_trigger(struct iio_dev *idev, struct iio_trigger *trig)
> +{
> +	if (idev->dev.parent != trig->dev.parent)
> +		return -EINVAL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iio_validate_own_trigger);
> +
>  /**
>   * iio_trigger_validate_own_device - Check if a trigger and IIO device belong to
>   *  the same device
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index 51f52c5c6092..bce3b1788199 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -171,6 +171,7 @@ void iio_trigger_free(struct iio_trigger *trig);
>   */
>  bool iio_trigger_using_own(struct iio_dev *indio_dev);
>  
> +int iio_validate_own_trigger(struct iio_dev *idev, struct iio_trigger *trig);
>  int iio_trigger_validate_own_device(struct iio_trigger *trig,
>  				     struct iio_dev *indio_dev);
>  

