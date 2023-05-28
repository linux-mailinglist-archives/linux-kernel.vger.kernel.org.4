Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22511714109
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 00:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjE1WgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 18:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjE1Wf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 18:35:58 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA712C6;
        Sun, 28 May 2023 15:35:56 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 26F795FD05;
        Mon, 29 May 2023 01:35:55 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685313355;
        bh=PDk2TqIX07e40FKKbuuGyZQC6PVJSh481bsLGg5lsrE=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=huBcCseI7xOjEJMql0TsijO+TP6MUcW4Vt1Ex2qbtZVE9x11m91rlUe47KUyqNfdA
         Wts+ja+neWyjJst9rkjXq8dop63uJtMyCeBh3lApKP4hoXQVc56U+JGxdBpGHfvDKu
         h44vRWjAsH7mb4yg7j8XLJ6r+SvjRPJ0rBxyzU5UgwJh4gpia/Q7Shdjhf+h++L75+
         feiqOPlZBorqHAwoVlovgJjDFl9bDGGwrW9lRFYkLgPnh9+WoGiTANQz94xqoC18xM
         QmhhsMMAHULwZ7xcO5UVniage4u0T3IkFLLzXlck//bIGzuGe/Oi/7O0b8XDJgPCe9
         rv9BzQh88XYpQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 29 May 2023 01:35:52 +0300 (MSK)
Message-ID: <9df82b13-7594-a8f0-f27e-87bce5a38b74@sberdevices.ru>
Date:   Mon, 29 May 2023 01:31:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] meson saradc: add iio device attrib to switch channel
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
References: <20230527214854.126517-1-gnstark@sberdevices.ru>
 <ZHMxDHPBWQOJSuaZ@smile.fi.intel.com>
From:   George Stark <gnstark@sberdevices.ru>
In-Reply-To: <ZHMxDHPBWQOJSuaZ@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/28 19:12:00 #21364717
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

On 5/28/23 13:46, Andy Shevchenko wrote:

Hello Andy
> On Sun, May 28, 2023 at 12:48:54AM +0300, George Stark wrote:
>> Patch adds two sysfs nodes: chan7_mux to set mux state
>> and chan7_mux_available to show available mux states.
>> Mux can be used to debug and calibrate adc by
>> switching and measuring well-known inputs like GND, Vdd etc.
> Thank you for an update, my comments below.
>
> ...
>
>> ---
> Missing changelog, what has been done in v2, how it's different to v1.
Ok I'll keep it on mind
>
>>   drivers/iio/adc/meson_saradc.c | 65 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 65 insertions(+)
> ...
>
>> +static const char * const chan7_vol[] = {
>> +	"gnd",
>> +	"vdd/4",
>> +	"vdd/2",
>> +	"vdd*3/4",
>> +	"vdd",
>> +	"ch7_input",
>> +};
>> +
>> +static ssize_t chan7_mux_show(struct device *dev, struct device_attribute *attr,
>> +			      char *buf)
>> +{
>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>> +	unsigned int index = priv->chan7_mux_sel;
>> +
>> +	if (index >= ARRAY_SIZE(chan7_vol))
>> +		index = ARRAY_SIZE(chan7_vol) - 1;
> I think this is incorrect and prone to error in the future in case this array
> will be extended. What I would expect is to return something like "unknown".

I agree this part is unclean. Actually the register's last 3 (out of 8) 
possible values
are stand for the same mux input "ch7_input". So theoretically we can 
read from register
a value out of array bounds. There should be a comment at least.

About the question of naming mux inputs from the other letter (vdd/2 vs 
0.5Vdd etc).
While I fully agree with you that point is better than slash but mixing 
letter cases... should we?

e.g. this is how iio_info output looks like now:
...
             voltage7:  (input)
             3 channel-specific attributes found:
                 attr  0: mean_raw value: 0
                 attr  1: raw value: 1
                 attr  2: scale value: 0.439453125
         4 device-specific attributes found:
                 attr  0: chan7_mux value: gnd
                 attr  1: chan7_mux_available value: gnd vdd/4 vdd/2 
vdd*3/4 vdd ch7_input
                 attr  2: current_timestamp_clock value: realtime

                 attr  3: waiting_for_supplier value: 0

or naming with Jonathan's approach
/sys/devices/platform/soc/fe000000.bus/fe002c00.adc/iio:device0/in_voltage_0.5vdd_raw

Best regards
George

>> +	return sysfs_emit(buf, "%s\n", chan7_vol[index]);
>> +}
>> +
>> +static ssize_t chan7_mux_store(struct device *dev,
>> +			       struct device_attribute *attr,
>> +			       const char *buf, size_t count)
>> +{
>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +	int i;
>> +
>> +	i = sysfs_match_string(chan7_vol, buf);
>> +	if (i < 0)
>> +		return -EINVAL;
> Do not shadow the error code if it's not justified.
>
> 		return i;
>
>> +	meson_sar_adc_set_chan7_mux(indio_dev, i);
>> +	return count;
>> +}
>> +
> Redundant blank line.
>
>> +static IIO_DEVICE_ATTR_RW(chan7_mux, -1);
>> +
>> +static ssize_t chan7_mux_available_show(struct device *dev, struct device_attribute *attr,
>> +			      char *buf)
>> +{
>> +	int i, len = 0;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(chan7_vol); i++)
>> +		len += sysfs_emit_at(buf, len, "%s ", chan7_vol[i]);
>> +
>> +	return len;
>> +}
>> +
> Ditto.
>
>> +static IIO_DEVICE_ATTR_RO(chan7_mux_available, -1);


