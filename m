Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCE06D0BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjC3Qt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjC3QtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:49:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D0886AB;
        Thu, 30 Mar 2023 09:48:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g17so25341124lfv.4;
        Thu, 30 Mar 2023 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680194888;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeR6trew7HW2G4oYPc7uXwBQjgjSoJfWbtLdkhlcjW8=;
        b=npY/2p1fFHW2+YSwPXEbpgc6u491kVScGeEwTgy3n50qecYYvzlQYMUYIe9ymXcLZJ
         76NutjJY8PmVkWQgcvB5VmVkIUZZCKHSpWFQ8w9fH+OhkVsWGSgw+WhizddsYR2wUOnF
         OukSvcNxF6ecBzBIJ2MPZUr18ig6G6SSE8LqN6HGe+z2dHWINJT3mmku9q0sunayiFki
         XFQ6QrwvIwWw81Smz0zo/XhYoRtOnT1VVJc1USSYp0j9pSXkrnr4dvXLPwFFgbz4bBRG
         O+65H63G7og1NNaLO5sQFWeevJEH4ORrzlILDF2CYLsWho4IFYKyf3QJReNZN6f3OiY6
         P4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194888;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VeR6trew7HW2G4oYPc7uXwBQjgjSoJfWbtLdkhlcjW8=;
        b=wiRGBYz8EhIClywguPKa/FCBgRB9d+N8LBp5g677LL8NwZk5htBMSJOHE77pohAj1w
         1j6ogEhtqsxqx22yg7NpKUIguMYr5EnORNdgVFvJDlSQfXSjv3kapbOgLmJ5ZB2UkIBa
         n0QOWknLK8HzA6/KGjD6lUkk1PauC87kcJP0wWa6ZohgraLRf9NxUNKWu7b/ID2G08mg
         /ELugrSj3DdIOcnodXhmxRzejHgC3yhDY1HFIxEmTNdEyK6CtgCUyylUKzAEARtPqTVP
         4nOo+vGfLvU2+pDghmJYbpdZUUVB+dP+pvVn7jVCXfeLkz+yuP0k/kh4r6D7KqcH1go/
         w6ww==
X-Gm-Message-State: AAQBX9cCoyX2sFaMKjdT7T+rzmN9gJN9C8/4otTLuMdOSGl4ozqzBgyo
        J3CcsV6e64ve98RFCsYuMlN04FcLKxM=
X-Google-Smtp-Source: AKy350YZSEG5B6b6larqn6M4r5+w+Yj+9AxYSpCe9zgHb3AdBqr7Tq/4ZmlkoR9d5gReZqUacWO4kw==
X-Received: by 2002:ac2:46f9:0:b0:4e9:d719:3603 with SMTP id q25-20020ac246f9000000b004e9d7193603mr7425573lfo.55.1680194888041;
        Thu, 30 Mar 2023 09:48:08 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id b16-20020ac25630000000b004e846175329sm7749lff.202.2023.03.30.09.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 09:48:07 -0700 (PDT)
Message-ID: <b8904407-87d1-c8fa-d70c-67259211445e@gmail.com>
Date:   Thu, 30 Mar 2023 19:48:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1679915278.git.mazziesaccount@gmail.com>
 <68179bcc8371ef9026d1179847fc9c73aa7460f4.1679915278.git.mazziesaccount@gmail.com>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v6 2/7] iio: light: Add gain-time-scale helpers
In-Reply-To: <68179bcc8371ef9026d1179847fc9c73aa7460f4.1679915278.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/23 14:28, Matti Vaittinen wrote:
> Some light sensors can adjust both the HW-gain and integration time.
> There are cases where adjusting the integration time has similar impact
> to the scale of the reported values as gain setting has.
> 
> IIO users do typically expect to handle scale by a single writable 'scale'
> entry. Driver should then adjust the gain/time accordingly.
> 
> It however is difficult for a driver to know whether it should change
> gain or integration time to meet the requested scale. Usually it is
> preferred to have longer integration time which usually improves
> accuracy, but there may be use-cases where long measurement times can be
> an issue. Thus it can be preferable to allow also changing the
> integration time - but mitigate the scale impact by also changing the gain
> underneath. Eg, if integration time change doubles the measured values,
> the driver can reduce the HW-gain to half.
> 
> The theory of the computations of gain-time-scale is simple. However,
> some people (undersigned) got that implemented wrong for more than once.
> 
> Add some gain-time-scale helpers in order to not dublicate errors in all
> drivers needing these computations.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Currently it is only BU27034 using these in this series. I am however working
> with drivers for RGB sensors BU27008 and BU27010 which have similar
> [gain - integration time - scale] - relation. I hope sending those
> follows soon after the BU27034 is done.
> 

> +/**
> + * iio_gts_find_new_gain_sel_by_old_gain_time - compensate for time change
> + * @gts:		Gain time scale descriptor
> + * @old_gain:		Previously set gain
> + * @old_time_sel:	Selector corresponding previously set time
> + * @new_time_sel:	Selector corresponding new time to be set
> + * @new_gain:		Pointer to value where new gain is to be written
> + *
> + * We may want to mitigate the scale change caused by setting a new integration
> + * time (for a light sensor) by also updating the (HW)gain. This helper computes
> + * new gain value to maintain the scale with new integration time.
> + *
> + * Return: 0 on success. -EINVAL if gain matching the new time is not found.

Here we need to document another return value denote whether the 
@new_gain was updated.

> + */
> +int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
> +					       int old_gain, int old_time_sel,
> +					       int new_time_sel, int *new_gain)
> +{
> +	const struct iio_itime_sel_mul *itime_old, *itime_new;
> +	u64 scale;
> +	int ret;
> +
> +	itime_old = iio_gts_find_itime_by_sel(gts, old_time_sel);
> +	if (!itime_old)
> +		return -EINVAL;
> +
> +	itime_new = iio_gts_find_itime_by_sel(gts, new_time_sel);
> +	if (!itime_new)
> +		return -EINVAL;
> +
> +	ret = iio_gts_get_scale_linear(gts, old_gain, itime_old->time_us,
> +				       &scale);
> +	if (ret)
> +		return ret;
> +
> +	ret = gain_get_scale_fraction(gts->max_scale, scale, itime_new->mul,
> +				      new_gain);
> +	if (ret)
> +		return ret;
> +
> +	if (!iio_gts_valid_gain(gts, *new_gain))
> +		return -EINVAL;

I would change this to -ERANGE to differentiate the case where the new 
gain was computed but was not valid. The bu27034 (and 
not-yet-fully-finished bu27008) driver uses the computed gain to find 
closest matching gain the hardware supports. I am not super happy with 
the -ERANGE, as it is also possible the gain is in the "range" of 
supported gains but not _exactly_ supported one. In a sense -EINVAL 
would be more correct. The invalid time could in a sense be interpreted 
as an "time selector not found" - so maybe the -ENOENT could be somehow 
tolerated. Still, in my opinion the invalid integration time is very 
much more an -EINVAL than anything else...

> +
> +	return 0;
> +}

I will fix this for v7.

