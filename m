Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0396CC712
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjC1PuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjC1Pt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:49:56 -0400
X-Greylist: delayed 575 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Mar 2023 08:49:51 PDT
Received: from 10.mo562.mail-out.ovh.net (10.mo562.mail-out.ovh.net [46.105.72.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4203198B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:49:51 -0700 (PDT)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
        by mo562.mail-out.ovh.net (Postfix) with ESMTPS id A031F23F86;
        Tue, 28 Mar 2023 15:31:37 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <lee@kernel.org>; Tue, 28 Mar 2023 15:31:37 +0000 (UTC)
Received: from pro2.mail.ovh.net (unknown [10.108.1.191])
        by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 714D61FE70;
        Tue, 28 Mar 2023 15:31:37 +0000 (UTC)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 28 Mar
 2023 17:31:37 +0200
Message-ID: <d1771420-b45e-3ce1-f469-bc5fd9ab6dfa@traphandler.com>
Date:   Tue, 28 Mar 2023 17:31:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 6/6] leds: Add a multicolor LED driver to group
 monochromatic LEDs
To:     Lee Jones <lee@kernel.org>
CC:     <lee.jones@linaro.org>, <pavel@ucw.cz>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230102081021.138648-1-jjhiblot@traphandler.com>
 <20230102081021.138648-7-jjhiblot@traphandler.com>
 <20230315155241.GA9667@google.com>
Content-Language: en-US
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <20230315155241.GA9667@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: CAS2.emp2.local (172.16.1.2) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 601512026505099739
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehgedgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpedvfeekudegkeeuuedvueeuveejffdtvdethfelkefhfefftdetteffiefgvddtieenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepughirhgvtghtohhrgedruggvrhhprdhmrghilhdqohhuthdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqlhgvughssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedv
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/03/2023 16:52, Lee Jones wrote:
>> +	for (;;) {
>> +		struct led_classdev *led_cdev;
>> +
>> +		led_cdev = devm_of_led_get_optional(dev, count);
>> +		if (IS_ERR(led_cdev))
> 
> Doesn't devm_of_led_get_optional() return NULL on failure?

Hi Lee,

Thanks for you review. I'll send an updated version shortly.


devm_of_led_get_optional() return an error-pointer when it cannot get 
the LED (like EPROBE_DEFER or ENOMEM). When the LED is not defined, it 
returns NULL.

> 
>> +			return dev_err_probe(dev, PTR_ERR(led_cdev),
>> +					     "Unable to get led #%d", count);
>> +		/* Reached the end of the list ?*/
> 
> Besides the incorrect formatting, that '?' isn't filling me with
> confidence.
The comment just meant that NULL indicates the end of the list of the LEDs.

JJ
> 
>> +		if (!led_cdev)
>> +			break;
>> +
>> +		priv->monochromatics = devm_krealloc_array(dev, priv->monochromatics,
>> +					count + 1, sizeof(*priv->monochromatics),
>> +					GFP_KERNEL);
>> +		if (!priv->monochromatics)
>> +			return -ENOMEM;
>> +
>> +		priv->monochromatics[count] = led_cdev;
>> +
>> +		max_brightness = max(max_brightness, led_cdev->max_brightness);
>> +		count++;
>> +	}
>> +
>> +	subled = devm_kcalloc(dev, count, sizeof(*subled), GFP_KERNEL);
>> +	if (!subled)
>> +		return -ENOMEM;
>> +	priv->mc_cdev.subled_info = subled;
>> +
>> +	for (i = 0; i < count; i++) {
>> +		struct led_classdev *led_cdev = priv->monochromatics[i];
>> +
>> +		subled[i].color_index = led_cdev->color;
> 
> '\n'
> 
>> +		/* configure the LED intensity to its maximum */
> 
> Use correct grammar in comments please.
> 
> Start with an uppercase char.
> 
>> +		subled[i].intensity = max_brightness;
>> +	}
>> +
>> +	/* init the multicolor's LED class device */
> 
> As above and please be fully forthcoming in comments: "Initialise".
> 
>> +	cdev = &priv->mc_cdev.led_cdev;
>> +	cdev->flags = LED_CORE_SUSPENDRESUME;
>> +	cdev->brightness_set_blocking = led_mcg_set;
>> +	cdev->max_brightness = max_brightness;
>> +	cdev->color = LED_COLOR_ID_MULTI;
>> +	priv->mc_cdev.num_colors = count;
>> +
>> +	init_data.fwnode = dev_fwnode(dev);
>> +	ret = devm_led_classdev_multicolor_register_ext(dev, &priv->mc_cdev,
>> +							&init_data);
> 
> Use the full 100-char limit everywhere please.
> 
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +			"failed to register multicolor led for %s.\n",
> 
> "LED"
> 
>> +			cdev->name);
>> +
>> +	ret = led_mcg_set(cdev, cdev->brightness);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "failed to set led value for %s.",
>> +				     cdev->name);
>> +
>> +	for (i = 0; i < count; i++) {
>> +		struct led_classdev *led_cdev = priv->monochromatics[i];
>> +
>> +		/* Make the sysfs of the monochromatic LED read-only */
>> +		mutex_lock(&led_cdev->led_access);
>> +		led_sysfs_disable(led_cdev);
>> +		mutex_unlock(&led_cdev->led_access);
>> +
>> +		/* Restore sysfs access when the multicolor LED is released */
>> +		devm_add_action_or_reset(dev, restore_sysfs_access, led_cdev);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id of_led_mcg_match[] = {
>> +	{ .compatible = "leds-group-multicolor" },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, of_led_mcg_match);
>> +
>> +static struct platform_driver led_mcg_driver = {
>> +	.probe		= led_mcg_probe,
>> +	.driver		= {
>> +		.name	= "leds_group_multicolor",
>> +		.of_match_table = of_led_mcg_match,
>> +	}
>> +};
>> +module_platform_driver(led_mcg_driver);
>> +
>> +MODULE_AUTHOR("Jean-Jacques Hiblot <jjhiblot@traphandler.com>");
>> +MODULE_DESCRIPTION("multi-color LED group driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:leds-group-multicolor");
>> --
>> 2.25.1
>>
> 
> --
> Lee Jones [李琼斯]
