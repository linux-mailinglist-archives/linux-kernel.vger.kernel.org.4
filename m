Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64CE6A83E9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCBOAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCBOAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:00:39 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E581E2333F;
        Thu,  2 Mar 2023 06:00:36 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id C17005FD11;
        Thu,  2 Mar 2023 17:00:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1677765633;
        bh=OrOwfh5mJRiMyU5mosrTfgs9+CKcxqZAEXZ0UG6pCW8=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=S10oa6xEdsy6Rf/BtUgrQGr8euxwm2wZ3ZhC9UKVjBNWW/yg5b0wDbc7yox23afwO
         5EN1qkdP19HKbihfYGfMRTxdhosKhVcQ8VVxcmvbllfjTm9snXdy2cUYKJe5BPgwWj
         4LJ3nWYuUQ7qCsmDpZkyWSYJZds8etV83W5Epv4XBmX4sIaC25dTgtJSXF/c4B5tuH
         3mRr8YC+A3KhbOYulREHtfx5bFscRqEk6zM9g0ZzCVAAtvo3bfSfkpchvgjlL5uO+R
         D07sB89XshHGFADe6RAZCuGjZAQslvil3p26WNh7DquN/mzhHv4pghoHVTFVokGi0L
         VTmIGXCcwkG8w==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  2 Mar 2023 17:00:32 +0300 (MSK)
Message-ID: <1a1017f5-b18f-b952-2504-e4301512c52b@sberdevices.ru>
Date:   Thu, 2 Mar 2023 17:00:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] leds: add aw20xx driver
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>
References: <20230228211046.109693-1-mmkurbanov@sberdevices.ru>
 <20230228211046.109693-3-mmkurbanov@sberdevices.ru>
 <Y/5xBGFC3b9Chdtb@duo.ucw.cz>
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
In-Reply-To: <Y/5xBGFC3b9Chdtb@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/02 07:22:00 #20908555
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-01 00:24, Pavel Machek wrote:
> Hi!
> 
>> +config LEDS_AW200XX
>> +	tristate "LED support for Awinic AW20036/AW20054/AW20072"
>> +	depends on LEDS_CLASS
>> +	depends on I2C
>> +	help
>> +	  This option enables support for the AW20036/AW20054/AW20072 LED driver.
>> +	  It is a 3x12/6x9/6x12 matrix LED driver programmed via
>> +	  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
>> +	  3 pattern controllers for auto breathing or group dimming control.
> 
> I'm afraid this should be handled as a display, not as an array of
> individual LEDs.

Hello Pavel,

Thank you for the quick feedback and your detailed thoughts, appreciate
it!
I'm totally agree with you, that matrix LED controllers should be
interpreted as display and it must be controlled as display from
userspace. But actually, AW20036 controller usage status is strongly
dependent from board PCB. In the our internal projects AW20036 controls
LEDs line. Each LED brightness/pattern/etc are managed from userspace
independently. From the current registers specification I can't imagine
that it's possible to develop display driver for that. All controller
features involve LED independent managing, like hardware patterns and
brightness setup. Therefore I suppose for AW20036 controller LED
subsystem is more suitable.

-- 
Best Regards,
Kurbanov Martin

