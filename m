Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374906A8778
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjCBRBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCBRBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:01:44 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437D23E0B6;
        Thu,  2 Mar 2023 09:01:43 -0800 (PST)
Received: from [192.168.1.141] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MrQ2R-1qLyUj0P5T-00oVnT; Thu, 02 Mar 2023 18:01:34 +0100
Message-ID: <2cc752fb-a25d-0789-0fad-54b99f08ced7@i2se.com>
Date:   Thu, 2 Mar 2023 18:01:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] serdev: Set fwnode for serdev devices
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, kernel-team@android.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230302023509.319903-1-saravanak@google.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230302023509.319903-1-saravanak@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KB/Rl9hlpDPP5vdb88R/eeV24DEll67IfsYLs4evYPMk2umXiXb
 OOFve/qn0SyoVeB8Di4b3IBlsdkF17kHBos2MdvXEw7/NL4gLupdYZk3AnmhVNmBSXgooEY
 QSrVgeNBp/OBVSHciDAIvO4X85F9zyaQq15cQ95YObkUpbrbxb4iCFllgvtnahCBjxv8toc
 pxzKUdr22u83Y+61aQ7fA==
UI-OutboundReport: notjunk:1;M01:P0:kuWDmCFCFQk=;51KcqFKLGNARRajFz9oMUlKaM8Z
 /ZYJjdPMNL2C3kVnu2g3GraetOn25n0PFt3iE+aBlC8dXSay9XETjxvaK5djeHX41Z45EegIs
 yUuZcOkz6WFPdV0mSjPflE412fjCvbMnvhLyRlriasMgbLGPbbkv8NBtfK6vanXPPaR1DRLn6
 8PNSpi5aT843bGZYtWqCiFrWKFsGqLck3YhE6es4MUK3kpGweR+jeeXmIfKAJg4nEdQgyOUAs
 6qObMLWri4Rnk0tYBPLX1DxE820qsIJo4zervWEeg9cnyQr7NHabksAyF+1xivCQIlrHPMJf7
 Hm5g4XKJ8/hVO4TFAmWhgd5plszXYTSN9qc3kUHTBnw7TsxecxzE4VaW/r+JJ4jrd6lP16Sh/
 kbXj5uuUJTZa2JtQpM7vBjuMrXpDyNmYtBbIWp3CSnz8VUmk/sgGN3+flHIdnquYsafWFgSEn
 S5BK7cD0/HKisW4OOuqK16CHS7TBrtURkOp4F80gY8pXJjvhS51x/8XNHhI/XpTiceJmeh8HA
 y7BZt5zppDZFP6alo4hrJCxTrQcfP8ct/f7FysCvm1AxS1v9GhG3IDrSyxFkTx6aSAOfXexyt
 +hqndt1hAR5AnV9VJN16XL8YwhlI92/W73XnXpd4ZjvlFr5nfHYOemW/tcF5GiM2hyjweuU2X
 E/KN6KspHPnO0RuY6DZJP7/xZl373qf4X4c6nVCiQQ==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

Am 02.03.23 um 03:35 schrieb Saravana Kannan:
> This allow fw_devlink to do dependency tracking for serdev devices.
>
> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
> Link: https://lore.kernel.org/lkml/03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com/
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

since this fixes an issue on Raspberry Pi 4, shouldn't this be mentioned 
in the commit message and providing a Fixes tag?

Thanks
Stefan

> ---
> Florian,
>
> Can you give it a shot and a tested-by please?
>
> -Saravana
>
>   drivers/tty/serdev/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index aa80de3a8194..678014253b7b 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -534,7 +534,7 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
>   		if (!serdev)
>   			continue;
>   
> -		serdev->dev.of_node = node;
> +		device_set_node(&serdev->dev, of_fwnode_handle(node));
>   
>   		err = serdev_device_add(serdev);
>   		if (err) {
