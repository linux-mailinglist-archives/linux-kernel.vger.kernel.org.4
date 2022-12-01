Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3745363F2B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiLAOXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiLAOXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:23:01 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AA42FA5C;
        Thu,  1 Dec 2022 06:22:57 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id c1so2720853lfi.7;
        Thu, 01 Dec 2022 06:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRvzQRHmIfpCS7wU0FBvw2pwnDRrKBpC2VMX4T8FuMQ=;
        b=glkvHACbXdIMkvWcRDLEgpDmtm5dySDXry66W8yZbqm9xPBcfjer9gmxAYkp2rP3x+
         KH33IO/wFg/y0vprvSwycUSRjs1g/GxGpxCk/H3xY9/OwCq0D3W4Or3Xy7G036KjSH5z
         pAm951cmeapgjtZuMzOMn51IkkLnQhz1UNdWklZm9UhEg2LzIkhPqrHFN+NTsBwTf4tS
         xYP6lz+5e8WTSShfwTRqpnsa2PBjF/a713MXhk4nq70tHnsx0HpQbm+cYbmdpLe0cbaF
         tZ1bhLAqlle7YqdIme9c/s76R1WNZqPCNT0/m3sO9U0lTZTvxZmIPXUkrRHgGNG93+tZ
         ZbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRvzQRHmIfpCS7wU0FBvw2pwnDRrKBpC2VMX4T8FuMQ=;
        b=bB43Vi6qwwIlof7ocTG5wZu5eLWDvlLET3au/9mrpHDqkhFTDY/QA6xz7CYrKw6ked
         zx+Ayg2nbBIL0DrbRKRQ1NZDCfp9gnnAoIPHmQmVLEuGJMKdx9qtGn1yFWLJdjz3T9zd
         nhwls6il8n5TfKXzOspmVe6EdUHkj6QQVwLhABf0oT9f28AWieIToMCL9tcOBhChRSJg
         k/00mRzT7o9z1O5L9NdesJoHlixeqPdGn5iv9uIyugjqYAV/xEyvLaA33skk8h90+efY
         G2FdMK6nshImr+/jSNOWO3I3oVl6lw+qR0vDujMBqxSyfqAAGpCgmu53v0XW/4pvHg3F
         Hmrg==
X-Gm-Message-State: ANoB5plMRz1UwowW+6nNElxuQyNrskhNiN2lwzITF8B0HxG+0xbdpxEP
        jkIxH8crU8YZYNSjQquRj+c=
X-Google-Smtp-Source: AA0mqf7yghnQdIU/jzPDqVl2Lk3losfW6ljH7NX2kalFPUP6CTeA9QJBgw+y8n+skFGRalE2ABv8Jg==
X-Received: by 2002:a05:6512:3a82:b0:4b5:42fd:c26e with SMTP id q2-20020a0565123a8200b004b542fdc26emr1091703lfu.52.1669904576127;
        Thu, 01 Dec 2022 06:22:56 -0800 (PST)
Received: from [192.168.50.20] (077222238151.warszawa.vectranet.pl. [77.222.238.151])
        by smtp.gmail.com with ESMTPSA id c25-20020a2ebf19000000b0026ddaf38b0fsm399396ljr.96.2022.12.01.06.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 06:22:55 -0800 (PST)
Message-ID: <abe0cc82-2fb8-2e29-e7b9-90fe6ae4d203@gmail.com>
Date:   Thu, 1 Dec 2022 15:22:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] Prevent buffer overflow in UVC Gadget setup handler
To:     Dan Scally <dan.scally@ideasonboard.com>,
        laurent.pinchart@ideasonboard.com
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221201122141.8739-1-szymon.heidrich@gmail.com>
 <780379d9-2331-cd7a-126d-cdaa8aec023d@ideasonboard.com>
Content-Language: en-US
From:   Szymon Heidrich <szymon.heidrich@gmail.com>
In-Reply-To: <780379d9-2331-cd7a-126d-cdaa8aec023d@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 14:49, Dan Scally wrote:
> Hello - thanks for the patch
> 
> On 01/12/2022 12:21, Szymon Heidrich wrote:
>> Setup function uvc_function_setup
> 
> 
> You've written uvc_function_setup here, but the code changes uvc_function_ep0_complete.

Yes, this was intentional as uvc_function_setup prevents handling of control
transfer requests with wLength grater than UVC_MAX_REQUEST_SIZE.
The uvc_function_ep0_complete function handles data phase thus was modified.

> 
>>   permits control transfer
>> requests with up to 64 bytes of payload (UVC_MAX_REQUEST_SIZE),
>> data stage handler for OUT transfer uses memcpy to copy req->actual
>> bytes to uvc_event->data.data array of size 60. This may result
>> in an overflow of 4 bytes.
>>
>> Signed-off-by: Szymon Heidrich <szymon.heidrich@gmail.com>
> 
> 
> Good catch
> 
>> ---
>>   drivers/usb/gadget/function/f_uvc.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
>> index 6e196e061..69c5eb3a3 100644
>> --- a/drivers/usb/gadget/function/f_uvc.c
>> +++ b/drivers/usb/gadget/function/f_uvc.c
>> @@ -216,8 +216,9 @@ uvc_function_ep0_complete(struct usb_ep *ep, struct usb_request *req)
>>             memset(&v4l2_event, 0, sizeof(v4l2_event));
>>           v4l2_event.type = UVC_EVENT_DATA;
>> -        uvc_event->data.length = req->actual;
>> -        memcpy(&uvc_event->data.data, req->buf, req->actual);
>> +        uvc_event->data.length = (req->actual > sizeof(uvc_event->data.data) ?
>> +            sizeof(uvc_event->data.data) : req->actual);
> 
> 
> There's a clamp() macro in f_uvc.c, can we use that?
> 
>> +        memcpy(&uvc_event->data.data, req->buf, uvc_event->data.length);
>>           v4l2_event_queue(&uvc->vdev, &v4l2_event);
>>       }
>>   }

If it is more appropriate I will use min_t(unsigned int, req->actual, sizeof(uvc_event->data.data)).

