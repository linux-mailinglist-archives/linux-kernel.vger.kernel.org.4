Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D4A6D3ED9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjDCIW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjDCIW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:22:26 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C51FF759;
        Mon,  3 Apr 2023 01:21:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 08873604F2;
        Mon,  3 Apr 2023 10:21:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680510115; bh=VR2LCqV2q9HM27fPvLYDKiWzVBKaBoH1u3xFXAzaijY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mSX2x3Kuu63fMrLgRWEHuQUFIILw8lmBZLsBlwL3aM9kMGdKWUImmZUkweSKJOKbg
         LTiCvPMd/J+JljHj9t9FbrWATv+TxRsWZYU1fmIUUjXZ0q3XS7PRxtwgD7i5xhLp51
         NFUHMNGBS2BHjOrz2p2T8D0IzSxTKhmgmkEU1UuWmLRYbuiQv3oo2nFCvWIpR5II0m
         0jdX9l3RG1g10pbvH7k5jDOWuDOZ0vKtBQHW8QC51hrmwsS6vrlqxBc1InZ2uiVR6C
         CBmXLBAcaC8ryVNg3SI1AUWn/SHmFuduN9HT/CHuiLkNlm0F7Oc/xnzvmY+0YwVWmT
         BqHGqQpTXbHgA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FmoxYBoraDrP; Mon,  3 Apr 2023 10:21:52 +0200 (CEST)
Received: from [10.0.1.57] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id A5172604F0;
        Mon,  3 Apr 2023 10:21:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680510112; bh=VR2LCqV2q9HM27fPvLYDKiWzVBKaBoH1u3xFXAzaijY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=xI0ezHIhxyFIypwTZrhe/C1do7yN5sViTFM4PEHn9xTjfSRn2IylInrTfjLIt8DSc
         b+zlrTAYjXxyWmEJTqP94JfQl2ht39/+HKGKOFI3ixjTQ6aX8BB/TGCDeSJwZe7MQJ
         IKBIahQn2ogfKcXzdfRSd/WSrQSKphrEefxcQCEaeIjH4Rdm8SJ3vKa9TbQfXq6UVa
         +Re13tyI9w6Mn/nYydjenKX8qFShfkiHmD3Uoi8vblZ07Z00elycb14SQ3cwki0S7C
         AxHzbHTdNkDDGvzUWwzeDmEjgN49YUbOMj41DR7Fd57AzyNr4/9zJgkKWk6yVT/0lY
         9zIPGF1we5yhw==
Message-ID: <d976e978-6555-4adf-40fd-06870864a1aa@alu.unizg.hr>
Date:   Mon, 3 Apr 2023 10:21:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] platform/x86: think-lmi: Clean up display of
 current_value on Thinkstation
Content-Language: en-US, hr
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     hdegoede@redhat.com, markgross@kernel.org, W_Armin@gmx.de,
        linux@weissschuh.net, Mario.Limonciello@amd.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20230403013120.2105-1-mpearson-lenovo@squebb.ca>
 <20230403013120.2105-2-mpearson-lenovo@squebb.ca>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230403013120.2105-2-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.4.2023. 3:31, Mark Pearson wrote:
> On ThinkStations on retrieving the attribute value the BIOS appends the
> possible values to the string.
> Clean up the display in the current_value_show function so the options
> part is not displayed.
> 
> Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
> Reported by Mario Limoncello <Mario.Limonciello@amd.com>
> Link: https://github.com/fwupd/fwupd/issues/5077#issuecomment-1488730526
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> Changes in v2: For some reason v2 doesn't apply cleanly so rebased and
> started again. Hopefully this one works
> 
>   drivers/platform/x86/think-lmi.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 87f832142d8d..78dc82bda4dd 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -920,7 +920,7 @@ static ssize_t display_name_show(struct kobject *kobj, struct kobj_attribute *at
>   static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
>   {
>   	struct tlmi_attr_setting *setting = to_tlmi_attr_setting(kobj);
> -	char *item, *value;
> +	char *item, *value, *p;
>   	int ret;
>   
>   	ret = tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID);
> @@ -931,9 +931,12 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
>   	value = strpbrk(item, ",");
>   	if (!value || value == item || !strlen(value + 1))
>   		ret = -EINVAL;
> -	else
> +	else {
> +		/* On Workstations remove the Options part after the value */
> +		p = strchrnul(value, ';');
> +		*p = '\0';
>   		ret = sysfs_emit(buf, "%s\n", value + 1);
> -
> +	}
>   	kfree(item);
>   
>   	return ret;

I can confirm the build against the Torvalds 6.3-rc5 tree and Armin's patch
applied w these.

[root@pc-mtodorov kernel]# uname -rms
Linux 6.3.0-rc5-mt-20230401-00005-g10de4cefccf7 x86_64
[root@pc-mtodorov kernel]# cat /sys/kernel/debug/kmemleak
[root@pc-mtodorov kernel]# echo scan > !$
echo scan > /sys/kernel/debug/kmemleak
[root@pc-mtodorov kernel]# cat /sys/kernel/debug/kmemleak
[root@pc-mtodorov kernel]# echo scan > /sys/kernel/debug/kmemleak
[root@pc-mtodorov kernel]# cat /sys/kernel/debug/kmemleak
[root@pc-mtodorov kernel]# echo scan > /sys/kernel/debug/kmemleak
[root@pc-mtodorov kernel]# cat /sys/kernel/debug/kmemleak
[root@pc-mtodorov kernel]#

The leak is apparently gone in the original setup that reproduced the leak.

At your convenience, you can please add

Tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

Have a nice day.

Best regards,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

