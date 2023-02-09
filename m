Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8F690BBD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjBIO3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjBIO3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:29:41 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B405C888;
        Thu,  9 Feb 2023 06:29:40 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id ch10so901799qtb.11;
        Thu, 09 Feb 2023 06:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNFkOC1ri8pHSlHXE/lbRq5WcnHDlXOzU5Aciz4rI7o=;
        b=Law0ungw4iwMGKH1Dw4DVqFfdN//0s15vpt5e0ManjipVQx+wiIsdUP3LxMLazOox0
         aBE4V8B2Lco6IQfpERnXkQ8FtT/ArCwCtil2y5AcSotBTqdWA3ZsZN9bd0uxlm845G3g
         O0C+ZGZMxghyWkAFWPEgdtPju9vbGEtINe/0VZeK39O3TF41dcrZakzQmgKpKhBiQlmN
         eU8JNIw7+P95a4Wpf7C5x+k1fE6DQ9SuCRJUkZLky0kaDb3pTbVjKB6eS0aYpFksgd2U
         KkaSn4uDT/T6Be9FREIUS3nYhy6hdC/gcdw1aBYk+R+3doY7Kr8RXepgViYzvN5JfObA
         EHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNFkOC1ri8pHSlHXE/lbRq5WcnHDlXOzU5Aciz4rI7o=;
        b=6a5Ht+3frdAIRTZdXYVTgMG6GdpzoedGOVPEl9ayB908NfyxEVIhafbi1ZtZi5v+yW
         xSCKwtGtMXuXsCHhSRCvCUow2ljP4flpemQTDTRZIVwpWm9q4tDqN9EJD5t3XW77ruaF
         PZyreo1a0+6oLE2zCFC6V2+EUEBFwfU0YosAyMRGJiGirkJALSOhn+l4gt12ZMtubTsM
         3bxCy79VFuPpoDk8IIu+qwAoquzPoneTZRvqIrQblMFntjzelP78bNvzx6MdWSIUL39R
         SjF01RZiLUiRAyKlSCB2yb6MBxXrrYSQkamGKMhzyZHrmxnX9bU8Bo6oWfhmTXHZ4JUk
         idUQ==
X-Gm-Message-State: AO0yUKWkL+oMhQPjNE0Qw0+1lG6Vz3vBh+3CUEAClBXn7q6CT5o4iy3l
        91C9/XFR09L1beSazf53EN7CD8j+oAg8nQ==
X-Google-Smtp-Source: AK7set8sstwJ7Me8QHQ2Zxuu7mjvpECOnntqrA3SvWcPK/MURCEo8fA6KMyfA2Z+MWBIfwUTpxd+dw==
X-Received: by 2002:a05:622a:493:b0:3b6:35cc:a5c1 with SMTP id p19-20020a05622a049300b003b635cca5c1mr19838498qtx.20.1675952978280;
        Thu, 09 Feb 2023 06:29:38 -0800 (PST)
Received: from [192.168.50.134] (99-176-3-182.lightspeed.brhmal.sbcglobal.net. [99.176.3.182])
        by smtp.gmail.com with ESMTPSA id o73-20020a37414c000000b0072b5242bd0bsm1444364qka.77.2023.02.09.06.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 06:29:37 -0800 (PST)
Message-ID: <eba2155a-b041-b82e-8d4d-5e1df05df4ee@gmail.com>
Date:   Thu, 9 Feb 2023 08:29:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] Add support for Logitech G923 Xbox Edition steering wheel
 in hid-logitech-hidpp. We get the same level of features as the regular G920.
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230207195051.16373-1-waltholman09@gmail.com>
 <20230209141022.oql7n52igjybh3km@mail.corp.redhat.com>
Content-Language: en-US
From:   Walt Holman <waltholman09@gmail.com>
In-Reply-To: <20230209141022.oql7n52igjybh3km@mail.corp.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 08:10, Benjamin Tissoires wrote:
> Hi Walt, we are almost there. I have applied the following to your patch
> (and will push upstream as soon as the CI says it's fine):
> 
> * subject must start with the subsystem: "HID: " in our case
> * in your commit description, you should add a blanck line between the
>    title of the commit and the description. Otherwise, git-format-patch
>    considers everything to be the title, which is a little bit long :)
> * the Signed-of-by line should be added in the commit description, so
>    right here, before the first '---' so that it gets included in the
>    commit itself
> * for future submissions, please try to keep them numbered. Here, it
>    should have been '[PATCH v2] HID: ...' and below the first '---' add
>    what changed between v1 and v2.
> 
> Again, I have fixed everything, so no need to send another version :)
> 
> Cheers,
> Benjamin
> 

Thanks Benjamin! I (obviously) don't submit often, but I'll try to keep these things in mind going forward. Thanks for helping to get this done!

-Walt


> On Feb 07 2023, Walt Holman wrote:
>> ---
>>   drivers/hid/hid-ids.h            | 1 +
>>   drivers/hid/hid-logitech-hidpp.c | 3 +++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 0f8c11842a3a..de1f385b0ecc 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -819,6 +819,7 @@
>>   #define USB_DEVICE_ID_LOGITECH_G510_USB_AUDIO	0xc22e
>>   #define USB_DEVICE_ID_LOGITECH_G29_WHEEL	0xc24f
>>   #define USB_DEVICE_ID_LOGITECH_G920_WHEEL	0xc262
>> +#define USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL	0xc26e
>>   #define USB_DEVICE_ID_LOGITECH_WINGMAN_F3D	0xc283
>>   #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO	0xc286
>>   #define USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940	0xc287
>> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
>> index abf2c95e4d0b..4dc833c8a44c 100644
>> --- a/drivers/hid/hid-logitech-hidpp.c
>> +++ b/drivers/hid/hid-logitech-hidpp.c
>> @@ -4347,6 +4347,9 @@ static const struct hid_device_id hidpp_devices[] = {
>>   	{ /* Logitech G920 Wheel over USB */
>>   	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
>>   		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
>> +	{ /* Logitech G923 Wheel (Xbox version) over USB */
>> +	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL),
>> +		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS },
>>   	{ /* Logitech G Pro Gaming Mouse over USB */
>>   	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
>>   
>> -- 
>> 2.37.2
>>
>> --signed-of-by: Walt Holman (waltholman09@gmail.com)
>>
> 

