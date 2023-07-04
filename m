Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B698F7466A6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 02:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjGDAns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 20:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGDAnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 20:43:46 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4FD130;
        Mon,  3 Jul 2023 17:43:43 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id D57DB120029;
        Tue,  4 Jul 2023 03:43:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D57DB120029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688431421;
        bh=zmd/y+4sYUjQ7RxU3hWIwpYfpIcP+p2El5X96AiHQzU=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=XJpLLbwy05/cHpRwF0bVJroxy9+v9/r9cIhJUeGDwiwIHMffnqyuYKiJZuaayBzeA
         o1mMPIDwzSA6fFLZW/LJvTKzPJe232XS7Vm3wBtRS484YSY6oShBxSqgInsFDQhmeZ
         EDlbmJSknETSz8qFb4328niYqjx+29YlbuvN1Z9ZLfCfPsWaCXLYGGVZtkYSmU9+8l
         J5TaPdtImk1Ffac2lnNJ5VnwxSRCB/6cs6SvrooZpuiGZtedoRRsUU6yWikcgnahkG
         7ei8se6fSu+DuKzTgQrVeuksIXFyfjm5deRgyjUgNs2lbZg8CX+si2cO6AhDphanqj
         rPLKU8VJKkCvA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 03:43:41 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 4 Jul 2023 03:43:35 +0300
Message-ID: <98908451-b110-c2a0-4434-ea0997712384@sberdevices.ru>
Date:   Tue, 4 Jul 2023 03:39:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/5] meson saradc: move enums declaration before
 variables declaration
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
References: <20230627224017.1724097-1-gnstark@sberdevices.ru>
 <20230627224017.1724097-2-gnstark@sberdevices.ru>
 <20230702171410.00007827@Huawei.com>
From:   George Stark <gnstark@sberdevices.ru>
In-Reply-To: <20230702171410.00007827@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178409 [Jul 03 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lists.infradead.org:7.1.1;sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/03 22:49:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/03 22:49:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/03 21:28:00 #21559073
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan

On 7/2/23 12:14, Jonathan Cameron wrote:
> On Wed, 28 Jun 2023 01:37:14 +0300
> George Stark <gnstark@sberdevices.ru> wrote:
>
>> Move enums declaration before variables declaration.
>>
> This is fairly harmless, but would be nice to say 'why'.
> Is this just for consistency with the rest of the driver or will
> it be required after changes later in the patch set?
Both refactoring patches 1/5 and 2/5 are required for the latter changes 
in this patch-set.
Ack for extending the commit message.

>
>> Signed-off-by: George Stark <GNStark@sberdevices.ru>
>> ---
>>   drivers/iio/adc/meson_saradc.c | 44 +++++++++++++++++-----------------
>>   1 file changed, 22 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
>> index 18937a262af6..af38d95bd504 100644
>> --- a/drivers/iio/adc/meson_saradc.c
>> +++ b/drivers/iio/adc/meson_saradc.c
>> @@ -202,6 +202,28 @@
>>   	.datasheet_name = "TEMP_SENSOR",				\
>>   }
>>   
>> +enum meson_sar_adc_avg_mode {
>> +	NO_AVERAGING = 0x0,
>> +	MEAN_AVERAGING = 0x1,
>> +	MEDIAN_AVERAGING = 0x2,
>> +};
>> +
>> +enum meson_sar_adc_num_samples {
>> +	ONE_SAMPLE = 0x0,
>> +	TWO_SAMPLES = 0x1,
>> +	FOUR_SAMPLES = 0x2,
>> +	EIGHT_SAMPLES = 0x3,
>> +};
>> +
>> +enum meson_sar_adc_chan7_mux_sel {
>> +	CHAN7_MUX_VSS = 0x0,
>> +	CHAN7_MUX_VDD_DIV4 = 0x1,
>> +	CHAN7_MUX_VDD_DIV2 = 0x2,
>> +	CHAN7_MUX_VDD_MUL3_DIV4 = 0x3,
>> +	CHAN7_MUX_VDD = 0x4,
>> +	CHAN7_MUX_CH7_INPUT = 0x7,
>> +};
>> +
>>   static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
>>   	MESON_SAR_ADC_CHAN(0),
>>   	MESON_SAR_ADC_CHAN(1),
>> @@ -227,28 +249,6 @@ static const struct iio_chan_spec meson_sar_adc_and_temp_iio_channels[] = {
>>   	IIO_CHAN_SOFT_TIMESTAMP(9),
>>   };
>>   
>> -enum meson_sar_adc_avg_mode {
>> -	NO_AVERAGING = 0x0,
>> -	MEAN_AVERAGING = 0x1,
>> -	MEDIAN_AVERAGING = 0x2,
>> -};
>> -
>> -enum meson_sar_adc_num_samples {
>> -	ONE_SAMPLE = 0x0,
>> -	TWO_SAMPLES = 0x1,
>> -	FOUR_SAMPLES = 0x2,
>> -	EIGHT_SAMPLES = 0x3,
>> -};
>> -
>> -enum meson_sar_adc_chan7_mux_sel {
>> -	CHAN7_MUX_VSS = 0x0,
>> -	CHAN7_MUX_VDD_DIV4 = 0x1,
>> -	CHAN7_MUX_VDD_DIV2 = 0x2,
>> -	CHAN7_MUX_VDD_MUL3_DIV4 = 0x3,
>> -	CHAN7_MUX_VDD = 0x4,
>> -	CHAN7_MUX_CH7_INPUT = 0x7,
>> -};
>> -
>>   struct meson_sar_adc_param {
>>   	bool					has_bl30_integration;
>>   	unsigned long				clock_rate;
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Best regards
George

