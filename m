Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FF171368A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 23:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjE0VmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 17:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE0VmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 17:42:10 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BA8A4;
        Sat, 27 May 2023 14:42:07 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 2924C5FD05;
        Sun, 28 May 2023 00:42:05 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685223725;
        bh=zmU0QPWcuI+QjTo74SKplYsoabitGqIxBH6oJBP+2UI=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=ii5NBgjz5NCk3QYnd2XdVMDVL6kZ53KILjsmPugDyLRoprEttMOv6gmr2LseMaeAY
         eCuu8egj1AcY0RveOi6Rs9rJilsZSJ5i0btJLya7qM4h2yfdgywrfY3K5xG4dIHyVE
         8x2OOxuNv6DO/0yStBGO3LznGm5HwuTX1Qa5pdU9l8XGCQnE79ykhmxj+4FqR4ZO2W
         7uTFgRuWSPR7DFboyr0vse+vpj6/XMZnlIeyUXncQmt3L6ipQ9hfFrN8Nn0uGpwRdR
         sa6Mmmh92412MAUgNWclaYxpDroq4gPobK9W8axF+W6wecsJkN3w8uAKvPBpUNlTjC
         cDRpkZvFbeduA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Sun, 28 May 2023 00:42:00 +0300 (MSK)
Message-ID: <7485514e-4c10-361a-6468-050a5897f0d5@sberdevices.ru>
Date:   Sun, 28 May 2023 00:37:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] meson saradc: add iio device attrib to switch channel
 7 mux
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>, kernel <kernel@sberdevices.ru>
References: <20230524000111.14370-1-gnstark@sberdevices.ru>
 <ZHG9bYO1PNuPJhWn@smile.fi.intel.com>
From:   George Stark <gnstark@sberdevices.ru>
In-Reply-To: <ZHG9bYO1PNuPJhWn@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/27 20:13:00 #21359908
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

Thanks for review. I fixed it in patch v2

Best regards
George


On 5/27/23 11:21, Andy Shevchenko wrote:
> On Wed, May 24, 2023 at 03:01:11AM +0300, George Stark wrote:
>> Patch adds two sysfs nodes: chan7_mux to set mux state
>> and chan7_mux_available to show available mux states.
>> Mux can be used to debug and calibrate adc by
>> switching and measuring well-known inputs like gnd, vdd etc.
> GND
> Vdd
>
> ...
>
>> +static ssize_t chan7_mux_store(struct device *dev,
>> +			       struct device_attribute *attr,
>> +			       const char *buf, size_t count)
>> +{
>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(chan7_vol); i++)
>> +		if (!strcmp(chan7_vol[i], buf)) {
>> +			meson_sar_adc_set_chan7_mux(indio_dev, i);
>> +			return count;
>> +		}
>> +
>> +	return -EINVAL;
> NIH sysfs_match_string().
>
>> +}
> ...
>
>> +static IIO_DEVICE_ATTR_RW(chan7_mux, -1);
>> +static IIO_DEVICE_ATTR_RO(chan7_mux_available, -1);
> Place each of them near to the respective callback(s),
>
> ...
>
>> +static struct attribute *meson_sar_adc_attrs[] = {
>> +	&iio_dev_attr_chan7_mux_available.dev_attr.attr,
>> +	&iio_dev_attr_chan7_mux.dev_attr.attr,
>> +	NULL,
> No comma for the terminator entry.
>
>> +};


