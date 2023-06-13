Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D80E72DB67
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbjFMHpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240753AbjFMHo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:44:59 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0693A1A5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:44:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f61d79b0f2so6514040e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686642296; x=1689234296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02PxR/+kVAvvGBTO7SEoXtDE8MZbxhIVxDygWi88kew=;
        b=Ub2HPpEiDQy1wdpzr5FtQ1+0dalyu1mh4DpWc2O9pNCvXcdg4omJJ9EecsB9yEcI8D
         iN0trlwGD9r2L/9KTL1Ed4e9kSbHYIsntR38N3vtPlt/2zUH+1BNKN/PGr4EC/L7flT1
         BJhCxdQms1G3TvC/wxUM71eWAJaTNS+6Ea3iA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686642296; x=1689234296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02PxR/+kVAvvGBTO7SEoXtDE8MZbxhIVxDygWi88kew=;
        b=UTzIcIOJBHp7aKUSChMHZ2hgnDqVuXly25veOHY9gvLDvVUMQy22EvU2C2S2lwpNdi
         m3ipdzN7azw79EpbRgpgzmxS7ptvj3xaxZx8BAf2O6sEt0mqrrGI+GpJmDD1wS1rSGpL
         kKUXzs/UTXk+ah7JoSTyn3DUDWvw+7pC+SNRoiBkW4n0weM2egsdpy99XJyR6ZepWKoZ
         FB1WENxM932bZAwA4uBznPnxhd1O+MVBVkjcHzQ8hkIe+LTcw9P8vQCSBihj0jkMCJPL
         e8uQHS9qVBOlHmNLgp2y08aj7hf4Gyxly0w8LiAgE3DC9ucm0JG77krOzfuaASZeUoUL
         ba+g==
X-Gm-Message-State: AC+VfDwfgiaFMqs7NpPbJnyuQ4bPuLLZgb7uSvkHRpptwd5KXPjCevxz
        aC9HWkiKznHH7zUD5bccp5xZAQ==
X-Google-Smtp-Source: ACHHUZ58Byy+VmtD139tVQSXxePOCFJUK7DJPemhhPHwWC7DNIMMaYVgPI6uquHnw/OYQngEQ6jzMQ==
X-Received: by 2002:a19:504c:0:b0:4f6:138a:8ee1 with SMTP id z12-20020a19504c000000b004f6138a8ee1mr5024264lfj.47.1686642296140;
        Tue, 13 Jun 2023 00:44:56 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a7-20020a056512020700b004d4d7fb0e07sm1677507lfo.216.2023.06.13.00.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 00:44:55 -0700 (PDT)
Message-ID: <f3dc01bc-cdd1-ab0c-5891-083f6d255a4c@rasmusvillemoes.dk>
Date:   Tue, 13 Jun 2023 09:44:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6/8] rtc: isl12022: trigger battery level detection during
 probe
Content-Language: en-US, da
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230612113059.247275-7-linux@rasmusvillemoes.dk>
 <20230612141518c2119835@mail.local>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230612141518c2119835@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 16.15, Alexandre Belloni wrote:
> On 12/06/2023 13:30:56+0200, Rasmus Villemoes wrote:
>> Since the meaning of the SR_LBAT85 and SR_LBAT75 bits are different in
>> battery backup mode, they may very well be set after power on, and
>> stay set for up to a minute (i.e. until the battery detection in VDD
>> mode happens when the seconds counter hits 59). This would mean that
>> userspace doing a ioctl(RTC_VL_READ) early on could get a false
>> positive.
>>
>> The battery level detection can also be triggered by explicitly
>> writing a 1 to the TSE bit in the BETA register. Do that once during
>> boot (well, probe), and emit a single warning to the kernel log if the
>> battery is already low.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  drivers/rtc/rtc-isl12022.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
>> index 1b6659a9b33a..690dbb446d1a 100644
>> --- a/drivers/rtc/rtc-isl12022.c
>> +++ b/drivers/rtc/rtc-isl12022.c
>> @@ -280,8 +280,25 @@ static void isl12022_set_trip_levels(struct device *dev)
>>  	mask = ISL12022_REG_VB85_MASK | ISL12022_REG_VB75_MASK;
>>  
>>  	ret = regmap_update_bits(regmap, ISL12022_REG_PWR_VBAT, mask, val);
>> -	if (ret)
>> +	if (ret) {
>>  		dev_warn(dev, "unable to set battery alarm levels: %d\n", ret);
>> +		return;
>> +	}
>> +
>> +	ret = regmap_write_bits(regmap, ISL12022_REG_BETA,
>> +				ISL12022_BETA_TSE, ISL12022_BETA_TSE);
>> +	if (ret) {
>> +		dev_warn(dev, "unable to trigger battery level detection: %d\n", ret);
> 
> This is too verbose, there is no action for the user upon getting this
> message.

OK.

> Setting TSE also enables temperature compensation, which may be an
> undesirable side effect. Shouldn't this be reverted if necessary?

Well, I can't imagine the board designer not wanting/expecting
temperature compensation to be enabled since they've spent the $$ on
using a part with that capability. Also, we anyway set TSE if
CONFIG_HWMON so that the TEMP registers get updated once per minute.

If you insist I'll do the proper logic to set it back to 0 if it wasn't
set beforehand, but I prefer to just keep it as-is.

> 
>> +		return;
>> +	}
>> +
>> +	ret = isl12022_read_sr(regmap);
>> +	if (ret < 0) {
>> +		dev_warn(dev, "unable to read status register: %d\n", ret);
>> +	} else if (ret & (ISL12022_SR_LBAT85 | ISL12022_SR_LBAT75)) {
>> +		dev_warn(dev, "battery voltage is below %u%%\n",
>> +			 (ret & ISL12022_SR_LBAT75) ? 75 : 85);
> 
> This message is useless, I'd drop the whole block.

I only added this as "compensation" for ripping out the warning in 1/8,
since I assumed somebody actually wanted at least one warning in the
kernel log if the battery is low.

I/we are not going to scrape dmesg but will use the ioctl() to monitor
the battery, so I'm perfectly happy to just remove this. That will also
make the question of how long to wait after setting TSE moot, since
certainly userspace won't be able to issue the ioctl() soon enough to
see stale values in the LBAT bits.

Rasmus

