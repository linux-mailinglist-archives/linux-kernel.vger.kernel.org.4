Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC4C6FBC42
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjEIBBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjEIBBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:01:43 -0400
Received: from sonic307-7.consmr.mail.ir2.yahoo.com (sonic307-7.consmr.mail.ir2.yahoo.com [87.248.110.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2E226B3
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 18:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683594099; bh=XZkwtW0u4vlso9cBKVw2n7DK5kOM5HPTovVW04FEo00=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=AwfGVOOotX883i+WXzgrq7KHucOo81Ufg5IoeIFWfpFBIK/NIHNWNV2j091K5j7iIHMIwWdK01jYkaWCUPc4lZFUTxVQFkiD3NZ3yGfdCNyqQfX258+cFdcVaU4pulmSOg7hcjO9IOuFbvI5cVzh52uxOsaX60MM76YmVFnbvkewuLOsoxUxHM9cS2pwO9JRodFXO19SEOloHzbEMRYE2/maqJ+UObXJeZgFNOqsL8P0k9L1rtS6ULLh8v9mlFrs3/ntKOiLz7roqmdcdaUQGKTBRO2TruS114OlYJdDZyiRVLhEMUcbkXgRb25jiXEEQ9AzJeg5/Z0/7g2TygG5fA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683594099; bh=HFTdkLJk4shlQuPS0rdRDeEiD8oh2qhB0+DRkDhThW9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gHso3PbgMO4LnnkTicxPFtM7gAUjTXZbioyPMyVTrqy2/xfosvkaVJdlAsAmCNNsXDS8Sj4tVusynNTn/Kc4tg/pvc7v7ylp11xlqAWgpmPnqMO89gTubmS4ZhaaFNPe2MYUhdNhyP61UumrVOTafK+bY3fZWqxqwvQo3F66vhqSdv222Kjz3sxqO4zLjAn/1HB0Had/qLpHiTiSGPQfcd0rL54IV/Nqpe0oSwmNvFx0WyeDNDXpeyGYo3YjtNysei6X2RS+PRNz7Y1purPfEkFs+d2rzPjz3IBOvdYrKbREQWP+LdQz9Fne+ZcnIgbPDZElo/E4LOE3k66NfFG9+w==
X-YMail-OSG: 1_hNPywVM1nTL7PbYVkmg2L6rc6BT0lZtoH_kr.DF6NQD06IouxMUg68n3uNdi9
 hzV1RcWFaYdrZpTlp6GP6Wjzrx578qp0AfatE1u6LX7HrlS31MRZkfwiwlG.bx5zqYFARlFEMU73
 SYBTPj3RSHBXd3HDz0DIY4Mtx13981MLXRk6h5s9er3z_ukqWKUd9lY28GFAKsbSnJhxQleQlFbQ
 9geV4QBh_yKwmZ.7KzFsdpX.Ff.zcp7IH.QnWOh6LgC6woE5SOve69NHuwbvK5duZpcBwmmfjh5G
 uwmeCxF7Fj963kz.PQ1yqMcGMab8dI.He6in179dATQP7nq9HQ0s0QPZZ_DYA1CwXzV332RxAlEz
 Yp9NAVJsIDXModPBSFeAZ3lR7vn9lscyY070AkmSUFyiieBSoMuv5nvtUX4D5lX3sGB6jKeEmCKN
 fi5lifWAWxbI77_D6qb2W7VTsGMFLgl3JIu978ob5Yyn97PPiBh4aiTYHDvfiwTcap01S.yb2krr
 3w5a4TZSJdIw7DNSNu0Xu5ONQBacq0Rm71.8Y2aZhWEbUTYE_dWXQ07IqS8S9rlkq48M0ab7ca15
 JTKZWAa3m0dYzLtvt5tPvX7I8UBDuAuLK5hLQbbKg0L5yi3z35v_Zu9p8MgmZgf6Pl.DHPdbu0Zr
 L0UeUsjtaveTTEpC5FVJkHKdvoa5RebH_29e5OOVoFnDqDCWqOC7ZbFtkVHvkI2zRxPCAJplGrsi
 jBAwhTehzQykdyu8WMBq4WISAhKUDmnyGONxsaGb1hxfSttUkoYs.FaoXCWszaAGoa6vG5MN6mLq
 5D3easfIAXp4fKhJ0ob7S.ifqL_1xsJHD2bahIwyMj5cNCTs7S9yTygykYVdoQkSc4t1mdsx.hMD
 8r2.3Lxqn_.9t7U8eOc4D1cwkg5daJ4HLDOkH9o6XvWs5K.3NK6zt0mwNSxzKDs3nEdNanwRAccc
 8JbMHXWj9ZmpqVnnkIQTYuuPAaBVNr4kkSnLV1PT2zbHj51tf5GPU5luQsol9bjaUrrXdod4XB7_
 d7fAWbulmK3g_BDG7IFM26llAgAhIcTJansZmjtlMf0n53D1KK6UV61d3YT3zrfxznBd6pceuxFY
 ZSimMNpwEUvwllBa61AM6d3D.HgG1PMDjDne3Lf1nI4EtRIH3VBJXx1PTms8L.SRIKMuWmFzYKVS
 OJMwScxBY8_t3NDR0hftcnNEjU9SaoDohZdwgEqAMl1Mv1JSILM.PmNdE2eTqzsGLUxY8qd0iE9f
 e1RdfVMp.Ie2EZ5JVUxBDLSH_ITPeEAKCPUxvazCw9gvR3KYFK8C8Z.aRPaO52vrz50cTAXXUhr1
 wQ6Ci7RmFWMkMn0h9vUNHViv3clicbSAPYQnXTP1UIHBtPo2hoq.If_z3Cur6rejcPmwWxtWUmB9
 gENZBTS_CAHeVZJ6Cwu6HFPQpgiHdk1OJHipjKdPVeWPyb4jPKaj1gdU9w30GcQSat3snqBxSaK1
 TQLbeI.u5Y6opB7DrbhuOSGnzfCErySlIwScjIytmuFod9CkvZdr1l0jYc9CDCK009bndYDH3cvs
 wlHb34iq5GukOh1uXzxHdXJOG5sWuxwfGvF_E2TKKPxk89TuVmAykaHTmt.7OkdAZNkVvIYS7q1.
 UuxMZbj_tGlvx64LDFVwDhVtOYBcNGVCRdZ74KJQMgvpw0WtZytkICtSL5pVJS5ofDQ3Dh67BRZi
 oCQ9knHqoHdTZTMUoJvDIQeq_Q54lx.mlrCXnbcxZ6UJ7IMku3_BUVq0JhAXYGM7SwqSwjAeW.8x
 pSrchPslJBqRVam5DBqr6y8Jueieq35gVvnA07ulvTR98iC1ZE7ApXHhKEQ.m2lpuDS7_gKTae8L
 XMMXhoe1lzIHwrPjxwOasnBMdw83HSfLaGIkeX4ctJIK3q1UHqw.Bz.wxwjD7eGRNblIGLlfAswZ
 Si11MTEpuSdlGcnQlqJk0HeMaptkCynhCHahQjBvWs1i92pQzpLNtE9qlsUG9S90.JsaplDv4IuV
 ok6rO8rK6O9NibcHOrub6a9UV.4m6NraA.EuxrOAKTonLVpoiwrKHv8VNI8QEjkS2f1Wh3FcgMGR
 CaoCyO5d6oDIlePCliSJmAZlhT6ws6hrps7UERWSDTNRd29aQzl4y8iAyV8ifZFf0nXDWYVhS97S
 zD7YDJcN4Nu9gQvwE_GOrR39eM6nYMPb.hyVvudHcQRehtxyx8AK0._8fCp.kb_rGixNz4Abe_UU
 oMXHGZHrsS4qSeXWCAdAb_fmUObkavfvz45NR6mNofJkSv.NNTVjF27.asbEhkmGI6J9IkUyUS7q
 EdDU-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 89fb71b9-7047-47cd-8ce5-db1cef7dbb64
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Tue, 9 May 2023 01:01:39 +0000
Received: by hermes--production-ir2-74cd8fc864-msrld (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e39504d2ac763bd7ad95b4e52adf3d61;
          Tue, 09 May 2023 01:01:34 +0000 (UTC)
Message-ID: <55fd9835-4246-00e8-b641-c8b0ee3f7e22@rocketmail.com>
Date:   Tue, 9 May 2023 03:01:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 7/8] power: supply: rt5033_battery: Adopt status
 property from charger
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
 <899d6604-7b15-ac37-c624-987a2bb7875e@rocketmail.com>
 <20230508220605.kderc3nihhezouit@mercury.elektranox.org>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20230508220605.kderc3nihhezouit@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21417 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 09.05.23 00:06, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, May 08, 2023 at 11:18:28PM +0200, Jakob Hauser wrote:
>> On 08.05.23 13:35, Sebastian Reichel wrote:
>>> On Sat, May 06, 2023 at 05:54:34PM +0200, Jakob Hauser wrote:
>>>> The rt5033-battery fuelgauge can't get a status by itself. The rt5033-charger
>>>> can, let's get this value.
>>>>
>>>> Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
>>>> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
>>>> ---
>>>>    drivers/power/supply/rt5033_battery.c | 24 ++++++++++++++++++++++++
>>>>    1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
>>>> index 5c04cf305219..a6520716d813 100644
>>>> --- a/drivers/power/supply/rt5033_battery.c
>>>> +++ b/drivers/power/supply/rt5033_battery.c
>>>> @@ -12,6 +12,26 @@
>>>>    #include <linux/mfd/rt5033-private.h>
>>>>    #include <linux/mfd/rt5033.h>
>>>> +static int rt5033_battery_get_status(struct i2c_client *client)
>>>> +{
>>>> +	struct power_supply *charger;
>>>> +	union power_supply_propval val;
>>>> +	int ret;
>>>> +
>>>> +	charger = power_supply_get_by_name("rt5033-charger");
>>>> +	if (!charger)
>>>> +		return POWER_SUPPLY_STATUS_UNKNOWN;
>>>> +
>>>> +	ret = power_supply_get_property(charger, POWER_SUPPLY_PROP_STATUS, &val);
>>>> +	if (ret) {
>>>> +		power_supply_put(charger);
>>>> +		return POWER_SUPPLY_STATUS_UNKNOWN;
>>>> +	}
>>>
>>> struct rt5033_battery *battery = i2c_get_clientdata(client);
>>> ret = power_supply_get_property_from_supplier(battery->psy, POWER_SUPPLY_PROP_STATUS, &val);
>>> if (ret)
>>>       val.intval = POWER_SUPPLY_STATUS_UNKNOWN;
>>
>> I don't think this works. There is no direct relationship between
>> rt5033-charger and rt5033-battery. They operate independently from each
>> other.
> 
> That should be fine as long as the supply dependency is properly declared.
> 
>> I had a short try and the status property of rt5033-battery was "unknown".
>>
>> Just for the record, the full function I tried was:
>>
>> static int rt5033_battery_get_status(struct i2c_client *client)
>> {
>>          struct rt5033_battery *battery = i2c_get_clientdata(client);
>>          union power_supply_propval val;
>>          int ret;
>>
>>          ret = power_supply_get_property_from_supplier(battery->psy,
>>                                               POWER_SUPPLY_PROP_STATUS,
>>                                               &val);
>>          if (ret)
>>                  val.intval = POWER_SUPPLY_STATUS_UNKNOWN;
>>
>>          return val.intval;
>> }
>>
>> Later on I added a read-out of the "ret" value. It is "-19". I guess that's
>> the "return -ENODEV;" from function
>> power_supply_get_property_from_supplier(). [2]
>>
>> [2] https://github.com/torvalds/linux/blob/v6.4-rc1/drivers/power/supply/power_supply_core.c#L397-L421
> 
> I suppose your DT is missing the connection between the charger and
> the battery:
> 
> rt5033_charger: charger {
>      compatible = "rt5033-charger";
>      ...
> }
> 
> fuel-gauge {
>      compatible = "rt5033-battery";
>      ...
>      power-supplies = <&rt5033_charger>; // you are probably missing this
> };
> 
> See also Documentation/devicetree/bindings/power/supply/power-supply.yaml

...

Thanks for the hints.

This leads to updating the dt-bindings because adding the 
"power-supplies" property is important to be aware of.

Btw. first it didn't work. It took me quite some time to debug. I needed 
to add "psy_cfg.of_node = client->dev.of_node;" to the rt5033-battery 
probe function.

Now it works. However, there is a new problem. The battery driver gets 
probed first. The charger driver a bit later. In the meantime the 
battery driver spams dmesg with several "Failed to register power 
supply" because the charger driver isn't available yet. Once the charger 
driver is there, it works fine and dmesg becomes silent.

With the current state of the patchset:
dmesg | grep rt5033
[   13.628030] rt5033 6-0034: Device found (rev. 6)
[   13.633552] rt5033-led: Failed to locate of_node [id: -1]
[   13.790478] rt5033-charger rt5033-charger: DMA mask not set

With the changes discussed here:
dmesg | grep rt5033
[   15.741915] rt5033-battery 4-0035: Failed to register power supply
[   15.752894] rt5033-battery 4-0035: Failed to register power supply
[   15.795458] rt5033-battery 4-0035: Failed to register power supply
[   15.910760] rt5033-battery 4-0035: Failed to register power supply
[   15.913187] rt5033 6-0034: Device found (rev. 6)
[   15.914341] rt5033-led: Failed to locate of_node [id: -1]
[   15.920052] rt5033-battery 4-0035: Failed to register power supply
[   15.927262] rt5033-battery 4-0035: Failed to register power supply
[   16.017131] rt5033-battery 4-0035: Failed to register power supply
[   16.017401] rt5033-charger rt5033-charger: DMA mask not set

The message is comming from the rt5033-battery probe function, it's the 
power_supply_register() that fails.

Any ideas what could be done about this?

Kind regards,
Jakob
