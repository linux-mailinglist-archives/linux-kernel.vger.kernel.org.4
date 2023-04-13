Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A2D6E1486
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjDMSp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjDMSps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:45:48 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85C1AD3F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:45:22 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MBUuP-1pdyiq1tt9-00CyK2; Thu, 13 Apr 2023 20:44:27 +0200
Message-ID: <9de62851-73a6-0070-4e64-94b6614c11fd@i2se.com>
Date:   Thu, 13 Apr 2023 20:44:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] ARM: dts: Add nvmem node for BCM2711 bootloader
 public key
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230413085206.149730-1-iivanov@suse.de>
 <20230413085206.149730-3-iivanov@suse.de>
 <9b03551a-278d-16dc-08ed-1ef0f89dc79c@i2se.com>
 <duuhz5pju4q7lnvzwndcnruqwqzbwy4jhrfn42vov2rfct4i7c@qh55cifhoud7>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <duuhz5pju4q7lnvzwndcnruqwqzbwy4jhrfn42vov2rfct4i7c@qh55cifhoud7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:hyaZiqomSHwiu+IWfU2nlYY4f7s2yzaMv4rmt9rE2xuGEtKHPFz
 HtLEVK1LqcdwEtsWfHUezeuuo/Npx3Jq2f+Q4FPnFpB4ZofkDG2zjmx4gW9Fg0NfMfX08aQ
 H6qe5PGhesGkUKsU7pxKJf3+oOKZaUPy5JoIWCoBwoeC9CbVZXhZr+pgGI7VesLLFkUHjwW
 IYPpY/YpddHgbEQdxSBrg==
UI-OutboundReport: notjunk:1;M01:P0:8t1tl6IeacI=;UdIIlDy/BICJx1lyXkkQjRnNd+s
 c1NLNwLkjLy994Jb7Q3IXrWMCtZz4l18G9w5pmdo4v/SsmaCKrKBtGB1r5s2trye43EOkO2Yj
 3MPrn5JZhiLbawAu931Z+yRZC+cn3F/V7g3R+2cfD+/k4pxQmGvGryankaMtO5ZLu9YupK5Ch
 xYi3+TJykadAJRaA6bxcsTriycU29lTO6uhqa/wN8hUI4QQjn9yTY4no+SjPLGDIG876N4CLj
 RDOKkpv6gzv9Z1R8p61p5WNq9mGE+hZI49pAQzR1d8eMTtINfJb9YVJ0i9eGOIgjA/Q9uR+D5
 IgjeigTJK27FJi5JIjFoKPl4rXpcPA7HAuJpkWlP4f1tyFJfXHQ1YwZ3BmjM3f7KkgUkFwqBs
 TRaxx0HELsC0BwD+PLeJv2meSTodSOJiu0LBo1HQB99Jj2az7j64HXQIpF8xepozF+d2vNUmE
 dB471Jw6sL8UBqJXP71D8dExcNBciQP88Ii+WTKBcRjNLQuH4EL7guSwWPmn5fujUGhJFH8fM
 lxvRjUnyIZf4wRoEWc3Ctm5a/neRQnMVM1SfwLAFcfkzwYrAMAZHxzWAztAxVBBOLTYMiBLwS
 64VPyKjHJ0HzfzMKVnaabM+NpRM88rT6OjLCNqF1YckmZ5zrgBkk9Wji+pvGH+vErH7ZJ+Q8E
 Gaehq/ETJl8eINd21doZzyLuB7iMkYwASlBMrxhFFQ==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

Am 13.04.23 um 20:18 schrieb Ivan T. Ivanov:
> On 04-13 18:15, Stefan Wahren wrote:
>>
>> Hi Ivan,
>>
>> Am 13.04.23 um 10:52 schrieb Ivan T. Ivanov:
>>> From: Tim Gover <tim.gover@raspberrypi.com>
>>>
>>> Make a copy of the bootloader secure-boot public key available to the OS
>>> via an nvmem node. The placement information is populated by the
>>> Raspberry Pi firmware if a public key is present in the BCM2711
>>> bootloader EEPROM.
>>
>> It would be nice to have a helpful link like:
>> https://www.raspberrypi.com/documentation/computers/configuration.html#nvmem-nodes
> 
> Yep, make sense.
> 
>>> +
>>> +	/*
>>> +	 * RPi4 will copy the binary public key blob (if present) from the bootloader
>>> +	 * into memory for use by the OS.
>>> +	 */
>>> +	blpubkey: nvram@1 {
>>> +		compatible = "raspberrypi,bootloader-public-key", "nvmem-rmem";
>>
>> Yes this looks better, but this introduce a new dtbs_check issue. The new
> 
> Oops, yes, I forgot to make this check.
> 
>> compatible must be documented in
>> Documentation/devicetree/bindings/nvmem/rmem.yaml in a separate patch and
>> reviewed by the DT guys.
> 
> Or I can drop the new compatible string altogether? It looks like
> only alias is strictly required?! Tim Gover is this correct?

i cannot speak for the firmware side, but i think we should try to keep 
it compatible with the vendor DTB here.

> 
> Regards,
> Ivan
> 
