Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501F563D0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiK3IbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbiK3Iaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:30:35 -0500
X-Greylist: delayed 73 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 00:26:46 PST
Received: from smtpcmd13147.aruba.it (smtpcmd13147.aruba.it [62.149.156.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7917E165A3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:26:46 -0800 (PST)
Received: from [172.16.17.150] ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id 0IP0pCBoNrgwj0IPHptnt0; Wed, 30 Nov 2022 09:25:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1669796728; bh=8GxmAn9FPx7OVjQiSkb/5VYJvjX4v/d/WJkRd1lTttI=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=E3VbpZ+3kn9KWFeeWM1FHUZTMczJxqBuSavvSyXpiyHftdxlUGjdNc3TOXxxT6V5f
         UIGyMpoDQZ8PyTzCS3y9P5DSmPhz7cY9XWGL8I/UeiK/HdAwY9vSaAZ/ptJu7JIaTW
         NlFXduMHthbYa2Bau3uS91O4WMQl4WyoucATQ4vKIdej7c/foZ5qnBifGZlGeb4SZa
         O1RQoOTP1BI6nzxo4NqRLzJK65jdNxEncDoOFXRoTOaESFkjgXl3SyEmvv3LL+9SB3
         EIve4/6CyxLPXXBXCmzTz9913zA0t25d75PqFjk88r7Egidl7C72sHR3flk9tKmSt7
         vBLwGZr7a8L/Q==
Message-ID: <714c731c-2d46-aa39-a134-c41077ed7e0c@brickedbrain.com>
Date:   Wed, 30 Nov 2022 09:25:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/3] ads7846: don't report pressure for ads7845
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luca Ellero <l.ellero@asem.it>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221129151959.26052-1-l.ellero@asem.it>
 <20221129151959.26052-2-l.ellero@asem.it>
 <Y4Yx9o4z9+nhHfLa@smile.fi.intel.com>
Content-Language: en-GB
From:   Luca Ellero <luca.ellero@brickedbrain.com>
In-Reply-To: <Y4Yx9o4z9+nhHfLa@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFxrgwloq7+D/ywRJnqu8gkDzm2gyeGpwl4ohvDB7TX6eG/emk54D0KWXXh3o/CScHDd1o6jpmnabBb8FYZ23O/NnAnKD2wSx5XqeL26Fv+YMr8jQbmd
 9ZE4zMbZbSh0jCRVE3Goicl0Yuj1qicY8fgvj9fPrBtXw5M1SSIZklrQ/X1cqxl8RlsCdZGpkKxW6/8GXESyYmXZlXl86AsX6EMAhJsnmBFbzZNKRERWCoR/
 rBu0EeYNtRKwHJelEJyLIT9NXvPiuBcN3/85J9CZRRonkgGG8Y5Ofgg+TkB2nUCfXkwKevfUjp3FGrV4Wev0T5wnllnFFO7fV9/iypnTdF3RNf9RCygFkuU/
 QcQXoHUNNx8SqB+RapFITRUCK0sY+9lGI9GxcsOF+FIRMX+4u5WVMCAJKi83g/tX/MxXry8NSsi+Cq6rveBxEPH4oOLphcmwbi7R+PInH3vME9kcV1TIA+XE
 pU9hfeUAdexGV2rlgGJe8BboMTml/31eI3m6wvx36DbD6yd4IH/xiMutBIkdC849d6ZGemX0VqARiMGArE3XBboG9SY2ZYMawtRStW7jKr5Xn6s5TuPyK/zi
 UBE=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 17:23, Andy Shevchenko wrote:
> On Tue, Nov 29, 2022 at 04:19:57PM +0100, Luca Ellero wrote:
>> ADS7845 doesn't support pressure.
>> This patch avoids the following error reported by libinput-list-devices:
>> "ADS7845 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE".
> 
> Fixes tag?
> 
> If you run
> 
> 	git log --no-merges -- drivers/input/touchscreen/ads7846.c
> 
> you can get what prefix should be for these patches.
> 

Hi Andy,
thank you for your comments.
I will fix the patches and resend.
Regards

-- 
Luca Ellero


