Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28FA6B7812
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCMMwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjCMMwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:52:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4698857095;
        Mon, 13 Mar 2023 05:52:48 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r27so15550615lfe.10;
        Mon, 13 Mar 2023 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678711966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hXDQnsFmBpDrK5iiFWtfvH+xdXHDrrJVrU+nT5wLFy0=;
        b=o98vSzAWUGX1iqJ4KGGZOAF+ZmWjPqcMg5+wOev1CIbp4cO7eNQ3gYreTGkn47Ajor
         mJL/lyvmp/Jh5bAkCMLzVKrgxBDym6v/R7leF8zWE1sNi77q15Bnsf70fsFCv2XFbZhu
         wqW334jMAxnf6v6KzKpTgpGIqe/IiciMpvLvcc1KSWdzXqiwT0XbxfgnaH31uSYWhjZi
         XWvX5LwxIzzhfW5SPBQ80V8quEvkBB7uX+emnT0ORLOwVSQVuqLplR7h7cCXt1wULywq
         nodz60da0hnQofqU35LINsuQu7Uh1KKM9au5ECXqQcmAskddsWxn52sPsUwHAFC7iXwk
         fgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678711966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXDQnsFmBpDrK5iiFWtfvH+xdXHDrrJVrU+nT5wLFy0=;
        b=t9rn5PWSiJ3kS8OLbzfTppBp/yIPrEOY+481rKzfLmTk7UgEZnXMua1/bd1ZG6Na/w
         kPU3NXizQvODcKVnv14/3zVpeRGslYTs8FwNB/R5UhFas6ia+OluX/YX2TJ+BN41SzFw
         NBMZhHxy1SLCDyApUiIr+ZXgz/j+cj1lIGE80zSrWbSaA2Ezog1doQ7lX6DktNTVl1SL
         4XE/d/dKyQ5CO1da0SHfDhIHhVUwJuxKkOK/dZHyNmIUgqS5jUId1xxGin93AzhG4KOL
         EFMnqxPVqnXOowTcVAdHidjMGPAe5Bd4MzyFwTLtzezOEmfFy2joFsVMQuI2ISoPil8W
         r+EQ==
X-Gm-Message-State: AO0yUKWEkPAz+CU1ks5XwNnHj54v9TLvNiUEQ7DfHz2W4IKEiF7uV8bs
        UtnxSb37PQa+CCpJ7HzLkvVceubjGeI=
X-Google-Smtp-Source: AK7set/qWNMC5XOTIfkhbOKCbNxPAenU/K1sQSJHPWYbyFskDvPPTtuNkf0/V0BU9RBN5N0lPEOsoA==
X-Received: by 2002:ac2:5283:0:b0:4de:21c9:8a37 with SMTP id q3-20020ac25283000000b004de21c98a37mr10979718lfm.1.1678711966514;
        Mon, 13 Mar 2023 05:52:46 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id m1-20020ac24241000000b004d1dbacdc93sm950103lfl.299.2023.03.13.05.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 05:52:46 -0700 (PDT)
Message-ID: <d6a3fbb8-d51d-b1cf-444c-f9422c22927c@gmail.com>
Date:   Mon, 13 Mar 2023 14:52:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <20230312170638.3e6807b7@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230312170638.3e6807b7@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/23 19:06, Jonathan Cameron wrote:
> On Mon, 6 Mar 2023 11:17:15 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Some light sensors can adjust both the HW-gain and integration time.
>> There are cases where adjusting the integration time has similar impact
>> to the scale of the reported values as gain setting has.
>>
>> IIO users do typically expect to handle scale by a single writable 'scale'
>> entry. Driver should then adjust the gain/time accordingly.
>>
>> It however is difficult for a driver to know whether it should change
>> gain or integration time to meet the requested scale. Usually it is
>> preferred to have longer integration time which usually improves
>> accuracy, but there may be use-cases where long measurement times can be
>> an issue. Thus it can be preferable to allow also changing the
>> integration time - but mitigate the scale impact by also changing the gain
>> underneath. Eg, if integration time change doubles the measured values,
>> the driver can reduce the HW-gain to half.
>>
>> The theory of the computations of gain-time-scale is simple. However,
>> some people (undersigned) got that implemented wrong for more than once.
>>
>> Add some gain-time-scale helpers in order to not dublicate errors in all
>> drivers needing these computations.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Trying not to duplicate what Andy has raised...
> 
> 
> At some stage I want to go through the maths very carefully but it's
> not happening today and I don't want to delay resolving other remaining comments
> so that can wait for a later version. I'm sure it's fine but I like to be
> paranoid :)
> 

This is more than welcome! I tried to add some test cases for verifying 
some parts - but extra pair of eyes is always more than appreciated! 
I've written and read way too many bugs to not appreciate a healthy 
amount of paranoia :)

>> +int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
>> +{
>> +	const struct iio_itime_sel_mul *itime;
>> +
>> +	if (!iio_gts_valid_gain(gts, gain))
>> +		return -EINVAL;
>> +
>> +	if (!gts->num_itime)
>> +		return gain;
>> +
>> +	itime = iio_gts_find_itime_by_time(gts, time);
>> +	if (!itime)
>> +		return -EINVAL;
>> +
>> +	return gain * itime->mul;
>> +}
>> +EXPORT_SYMBOL(iio_gts_get_total_gain);
> 
> All of them want to be in the namespace.

Seems like I accidentally did not use the EXPORT_SYMBOL_GPL for this 
one. It must thus have evaded my conversion to name space one. Thanks!

> 
> 
>> diff --git a/drivers/iio/light/iio-gts-helper.h b/drivers/iio/light/iio-gts-helper.h
>> new file mode 100644
>> index 000000000000..4b5a417946f4
>> --- /dev/null
>> +++ b/drivers/iio/light/iio-gts-helper.h
> 
> ...
> 
>> +int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
>> +					       int old_gain, int old_time_sel,
>> +					       int new_time_sel, int *new_gain);
>> +int iio_gts_build_avail_tables(struct iio_gts *gts);
>> +int devm_iio_gts_build_avail_tables(struct device *dev, struct iio_gts *gts);
>> +int iio_gts_build_avail_scale_table(struct iio_gts *gts);
>> +int devm_iio_gts_build_avail_scale_table(struct device *dev, struct iio_gts *gts);
>> +int iio_gts_build_avail_time_table(struct iio_gts *gts);
>> +int devm_iio_gts_build_avail_time_table(struct device *dev, struct iio_gts *gts);
> 
> Given most modern IIO drivers use fully devm_ based probing, for now I would not
> expose anything else.  That will reduce the interface a lot which I think
> is probably a good thing at this stage.
> 
> Keep the non devm stuff internally though as it is a nice structure to have
> an I can see we may want some of these in non devm form in the future.
> 
> Similarly - for now don't expose the individual table building functions
> as we may never need them in drivers.  We (more or less) only support interfaces
> that are used and so far they aren't.
> 
> For other functions it's worth thinking about whether to not export them
> initially. I haven't been through them all to figure out what is not currently used.
> 
>> +void iio_gts_purge_avail_scale_table(struct iio_gts *gts);
>> +void iio_gts_purge_avail_time_table(struct iio_gts *gts);
>> +void iio_gts_purge_avail_tables(struct iio_gts *gts);
>> +int iio_gts_avail_times(struct iio_gts *gts,  const int **vals, int *type,
>> +			int *length);
>> +int iio_gts_all_avail_scales(struct iio_gts *gts, const int **vals, int *type,
>> +			     int *length);
>> +int iio_gts_avail_scales_for_time(struct iio_gts *gts, int time,
>> +				  const int **vals, int *type, int *length);
>> +
>> +#endif
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

