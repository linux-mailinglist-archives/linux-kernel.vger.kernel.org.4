Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D88A6FB945
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjEHVTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjEHVSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:18:37 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66564EF4
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683580713; bh=27b+1IMgCf5mpsg63z+6nJNfhOzMk8w9cAd03AJE9YI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=MURgF0Csap+WiM0hlT5N7aaNkcRGyjWv5nW47f920mbJ5FoohRXQu5i2qq+ZDFaATpZN6mFeo8bQSvd7Hpje00R031NePFEe95MiCzcxuju6pqe4Ui7DmcOjlmrayEO8T3mvAN+iAHKw2IwfmrUxijKFcTZoW1Pvl/vil1U3xSB9U5ZsH0p1yYspxU+Opwf2rNqH6hu9zvL12spD2kSIoEFFh/UDxDuoU1GfXT7Ox0H/PwgYBUXM04N58UdjH3yEBCn4YEykyAsQGaHvCecV8CBSJtCjKj3L9FH6HLAnoiv4N/pwo+7Fit42OTC7LkmB/VeD6WR4RWv9SUy/nrEEdQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683580713; bh=MDRFjs8sp4ntsJes64IkcJ6MAEWFp/KvMlDRgCaMErV=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Xb3XwIpVM/MIVgd8uhvek1l9ihlqFxEvc0Yn2ky1dCjZRFNkPx60XxB7vNk3OSwwGmasqnDBMHhXruTCmp2TXbPfDh+U4ip1yuR/HV2OVBDly8cVfZUbGqHByElktciwhuds1HPFjXXh0rQBAY0DhZHMNJL0osu+zoJ/Nrjms1NXeMbLAeuipxehuyVxwhufuP5Mh4P6MzKIuNs7ZeepnJBwMBaSDTdOzeGGxXuWMsRVfBi2otop2D+YV5kgD7hmYsFgYCYR+KQRAsxw0P4FDzb04YpqTiPTWOe78iy2SAFpvsdfWBVtsSvGz/t2kTwf212p+jvUG2g5x9xNy3qfDw==
X-YMail-OSG: Ts1PdjkVM1nMPD3JPHz11WsxZT658QLVdgWDPVxBE7pQtAR1fagqIPwA.WLEA7t
 l1QwqsG5Yu4rqwVAA6n9r.gXj7Nl_1LQlfK5UnDRAl70XWGqLd4mBDJNFBd2.w6HTHO8C2r9xnqd
 FxkBDKv4xB0NWBwmHPsNOdr.68dqUNZTDcqYjcg6jpEtdPrFsZIopRK9JnOpf0IW5hiPEvSvP6Cu
 5fQlsOGsF24vf5PBwUKcsZL5riiYmEzoNFGtJELYGfL8GsTySwBk3FLd6GYLbeKoz50xX.7zOP0X
 2WXLp4J9P.BqBaisHrAx61w9mWIjey7684ATUDMasDjS5jexPyjh.qCkOFVcNBtz4_c00lAHrxBY
 ASx4eME3rkFIV05tXepTcnLKJeKRfhG_0JlUk650_d5OMo7QAk3y5ceL9H9chZQuom18Zzjz1TqH
 qmxFVPLNa6MxrA47ioXTw__MW4U_dCoHSAMFrD1P1uXmmTen8vYHHIAmPD5yOL_N3beUve4I0FaC
 sKoNuIVtTaz2_imSyEcgGR5JbKUWlCv6GuKCrrZyD.snPM3mFqVEk1JZjYzDmsc79fzoVD1_Ykbv
 ARaTpoSGPh0JHYeV620CPCEKlcLvrrmA9FPepiHe9nCpVwxuwsjYmFrKM5upptG0W7G30xUtS7n_
 UMZbK6M4ZX5PgPTromduMgxxjkaU2l208MXPZhQv2PWRyb.nVGw.v_IDJptf5y_K1ekd.TU9xThj
 OTFURCy9uCNCZlWhCKny6StDSkxkx6uuVnJG5uDes_Mcb28E.Ba4e.OOAIx0Rgp3L6Otbjxb0GOw
 iluqk0U2.Fx03hnvnrVVCIeScKRRpulPNasny57an5OxFLid7gzxi_wxIlOBThmRi_IHY.JWC2Yx
 R5HF39rYq7LJ2mkd7TtxI_d2GMZsI_7XUSZQF8NmqIzigmUP5840b8Uhw3tqsEnPrDpvOkgejgBH
 JaW6JAzB7Q4sqENhPafPEXuI.EHu5oUvdPjzP5RJnAaQr2Ml680QPgQtN6ObdHK_IVyTkh1_Puis
 qQki6NNO3NUSMo8iw8Q8iyBOLOuJvqShVxwKVhQ30F2u0.Q9lVW2Ne9aTjP0f4M_AnVonnhtydNJ
 .BqpIUjY2YN_TG8qC8itB4ae3xTmMQ6e7CUdVOuQ_WQPcpiqLHsdv35HX7rgTbsA.VhNEuyvaEAo
 XeGBtxpT.HPb2ajC.OjBQ.xkIE1V93iHbYGQ3eUBY1_pm3OKmJksPl4PIAA3WsIN3UGwtLCXzocK
 34TFaZybEc5z2OOgxdYRsuMnOr5ysaOsmdcK6_LUOb5aDG5mUSXs7sR.cfh108HWXkPlxfM6Ywzr
 R5lcZ9Cfd9wMKFNGzHusfY1HjTMRpeESjaZWzg0kJz5kF2eCB4Vee1Dt85rHpFBXEFxYGBhpeP3w
 htBCmXnm9pd1yVvvXhBoiZgyJgS6UQf7IpbNmvlFfa44avFpXIy2OxS4jrmytORRkxq4l2QhxPFQ
 3fRVOptnOKgNUW0MBl.jf8BR5QBNapRFX5Fx5Al3royQlRUA2NQC2sDlfExihYihxzfACxv9JufX
 HMGQVahq9al4DFlt2ZPkTOIBd48aqohHyeBo_R4P6A75HacWVBJM.9AyNDjBuDd0FU.AI57NAjDr
 ALyWDpL_v4W7NdM3I3cx4bHzKzM9lt4oSv39E269IzBHZbj7TZ4GDA_jYoOKcSMPGirhzkzAGAgF
 b.sRa0JcFR_wAYNMbvOonj4djnUTP8.H3otJ52RDKZvzKQEvmsHemY5aKbNM8AAHWalWsFXxu4go
 mJyiIUwZjL3CM.272ySZPblUC6qIyl.9r.r_QOaBCkvBPyRICLrGkDaCytFZ1a9Hpqie0Du_YhYt
 NR7jSMyA8u5bWZqZH39xbuuEcHI0Uo.lccEstohYEqqoGBEwDol5P8Hl1Rm7mszp99_eAcI0UXos
 68xwgZQyRGrf.FR1Ha3tCR3gZSklhKzZnsgqlNZdMhf3eHY1yDWP5CFhK2n1ajQXDPFrQtNK92hg
 ID4nK7ndv5_bRsBzfUeo9gdGF9Eagf5pom3lWJwFk.dfza.4Qz44eEwbVHPhmJT10UumUbpfW3oQ
 izDtMjQOImOIaXeXetAF7rpkO0.RRQ096k4DmqYVDw1JSVypY8yCy3xr9FDPq5qfdkFgUGPD6iXq
 3mRIIxSCqWV6pybSM1wUUvADn70hmUHzHbGWox4o2wNpvbWSzyvsxCOSSbgi8dUQqtv01lP84wA4
 vHOVZNzJ9TkmuI9X9VhCkc.AoPG_IEVVb5c04dMlZBHX80_yOL5jqOylGQzmyLXkqbNuLUxKJhHJ
 sXOO9MlM-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: ee6f087c-f5cd-41f7-bba5-7c04bfdcf2aa
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Mon, 8 May 2023 21:18:33 +0000
Received: by hermes--production-ir2-74cd8fc864-w4pg2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 67ddbaef5e74928d8488c962890c86c8;
          Mon, 08 May 2023 21:18:30 +0000 (UTC)
Message-ID: <899d6604-7b15-ac37-c624-987a2bb7875e@rocketmail.com>
Date:   Mon, 8 May 2023 23:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 7/8] power: supply: rt5033_battery: Adopt status
 property from charger
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230506155435.3005-1-jahau@rocketmail.com>
 <20230506155435.3005-8-jahau@rocketmail.com>
 <20230508113518.nfwchl5wusmnkjp6@mercury.elektranox.org>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20230508113518.nfwchl5wusmnkjp6@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21417 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 08.05.23 13:35, Sebastian Reichel wrote:
> Hi,
> 
> On Sat, May 06, 2023 at 05:54:34PM +0200, Jakob Hauser wrote:
>> The rt5033-battery fuelgauge can't get a status by itself. The rt5033-charger
>> can, let's get this value.
>>
>> Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
>> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
>> ---
>>   drivers/power/supply/rt5033_battery.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
>> index 5c04cf305219..a6520716d813 100644
>> --- a/drivers/power/supply/rt5033_battery.c
>> +++ b/drivers/power/supply/rt5033_battery.c
>> @@ -12,6 +12,26 @@
>>   #include <linux/mfd/rt5033-private.h>
>>   #include <linux/mfd/rt5033.h>
>>   
>> +static int rt5033_battery_get_status(struct i2c_client *client)
>> +{
>> +	struct power_supply *charger;
>> +	union power_supply_propval val;
>> +	int ret;
>> +
>> +	charger = power_supply_get_by_name("rt5033-charger");
>> +	if (!charger)
>> +		return POWER_SUPPLY_STATUS_UNKNOWN;
>> +
>> +	ret = power_supply_get_property(charger, POWER_SUPPLY_PROP_STATUS, &val);
>> +	if (ret) {
>> +		power_supply_put(charger);
>> +		return POWER_SUPPLY_STATUS_UNKNOWN;
>> +	}
> 
> struct rt5033_battery *battery = i2c_get_clientdata(client);
> ret = power_supply_get_property_from_supplier(battery->psy, POWER_SUPPLY_PROP_STATUS, &val);
> if (ret)
>      val.intval = POWER_SUPPLY_STATUS_UNKNOWN;

I don't think this works. There is no direct relationship between 
rt5033-charger and rt5033-battery. They operate independently from each 
other.

I had a short try and the status property of rt5033-battery was "unknown".

Just for the record, the full function I tried was:

static int rt5033_battery_get_status(struct i2c_client *client)
{
         struct rt5033_battery *battery = i2c_get_clientdata(client);
         union power_supply_propval val;
         int ret;

         ret = power_supply_get_property_from_supplier(battery->psy,
                                              POWER_SUPPLY_PROP_STATUS,
                                              &val);
         if (ret)
                 val.intval = POWER_SUPPLY_STATUS_UNKNOWN;

         return val.intval;
}

Later on I added a read-out of the "ret" value. It is "-19". I guess 
that's the "return -ENODEV;" from function 
power_supply_get_property_from_supplier(). [2]

[2] 
https://github.com/torvalds/linux/blob/v6.4-rc1/drivers/power/supply/power_supply_core.c#L397-L421

>> +
>> +	power_supply_put(charger);
>> +	return val.intval;
>> +}
>> +
>>   static int rt5033_battery_get_capacity(struct i2c_client *client)
>>   {
>>   	struct rt5033_battery *battery = i2c_get_clientdata(client);
>> @@ -84,6 +104,9 @@ static int rt5033_battery_get_property(struct power_supply *psy,
>>   	case POWER_SUPPLY_PROP_CAPACITY:
>>   		val->intval = rt5033_battery_get_capacity(battery->client);
>>   		break;
>> +	case POWER_SUPPLY_PROP_STATUS:
>> +		val->intval = rt5033_battery_get_status(battery->client);
>> +		break;
>>   	default:
>>   		return -EINVAL;
>>   	}
>> @@ -96,6 +119,7 @@ static enum power_supply_property rt5033_battery_props[] = {
>>   	POWER_SUPPLY_PROP_VOLTAGE_OCV,
>>   	POWER_SUPPLY_PROP_PRESENT,
>>   	POWER_SUPPLY_PROP_CAPACITY,
>> +	POWER_SUPPLY_PROP_STATUS,
>>   };
>>   
>>   static const struct regmap_config rt5033_battery_regmap_config = {
>> -- 
>> 2.39.2
>>
> 
> Otherwise LGTM.
> 
> -- Sebastian

Kind regards,
Jakob
