Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C787466E9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 03:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGDBgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 21:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGDBgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 21:36:52 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A598EE76;
        Mon,  3 Jul 2023 18:36:47 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id D4305100024;
        Tue,  4 Jul 2023 04:36:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D4305100024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688434605;
        bh=9d2SacWrLQhIifC5uQWe8H+fWqQ4hgB6GNB4ZvX7lF0=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=lHJEXYBRUxDrK/MWMqffWfo39uCoSGF0vI0ZMEj6zcCilolOa/CI7zAYyMoOxiyGu
         E9D2zTwb4HwiWb95OzZh4l8Wvl469U5HzebkSkt3YiynDqJbG24WqwF6O/o9LFdOCN
         NWIhqM8GV/kDY5vczMhRRZ4cgLgGKwOBzGaS+AuT/lLWDo+1hzMRQhjulHUZTdwTRK
         +NWgfXDFLjtXVpCGv5N7Ja5wwiVN1Gt/FUD+C9qA+tTlYSlwGJqJLv/YA4ipnnGrTh
         Yab2HLXwbUSCj99cHWEdo0+qMRoKb2pEOpOy5bIsK5DwUEEGEHem5P+zHQ2/fjWaSQ
         CGhIQR4IXe9WA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 04:36:45 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 4 Jul 2023 04:36:39 +0300
Message-ID: <fd219f32-7783-59ce-99c7-8f00616085dd@sberdevices.ru>
Date:   Tue, 4 Jul 2023 04:32:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 4/5] meson saradc: add channel labels
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
 <20230627224017.1724097-5-gnstark@sberdevices.ru>
 <20230702171614.00000480@Huawei.com>
From:   George Stark <gnstark@sberdevices.ru>
In-Reply-To: <20230702171614.00000480@Huawei.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
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

On 7/2/23 12:16, Jonathan Cameron wrote:
> On Wed, 28 Jun 2023 01:37:17 +0300
> George Stark <gnstark@sberdevices.ru> wrote:
>
>> Add attribute 'label' to all iio channels.
> Why?  Reasoning is more useful here than a simple statement of 'what'.
Adding labels make sense only for newly-added channels,
base channels' default node names are close enough to datasheet names.
Ack for extending the commit message.
>> Signed-off-by: George Stark <GNStark@sberdevices.ru>
>> ---
>>   drivers/iio/adc/meson_saradc.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
>> index b87f05dfb322..85970fe852af 100644
>> --- a/drivers/iio/adc/meson_saradc.c
>> +++ b/drivers/iio/adc/meson_saradc.c
>> @@ -1058,8 +1058,20 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
>>   	return ret;
>>   }
>>   
>> +static int read_label(struct iio_dev *indio_dev,
>> +		      struct iio_chan_spec const *chan,
>> +		      char *label)
>> +{
>> +	if (chan->type == IIO_TEMP)
>> +		return sprintf(label, "%s\n", "temp-sensor");
>> +	if (chan->type == IIO_VOLTAGE)
>> +		return sprintf(label, "channel-%d\n", chan->channel);
>> +	return 0;
>> +}
>> +
>>   static const struct iio_info meson_sar_adc_iio_info = {
>>   	.read_raw = meson_sar_adc_iio_info_read_raw,
>> +	.read_label = read_label,
>>   };
>>   
>>   static const struct meson_sar_adc_param meson_sar_adc_meson8_param = {

-- 
Best regards
George

