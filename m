Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1523B644E26
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 22:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiLFVnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 16:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiLFVnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 16:43:24 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03513DF6;
        Tue,  6 Dec 2022 13:43:23 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id x6so18759970lji.10;
        Tue, 06 Dec 2022 13:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=edth7XwGVSsSHqeKh06p/w9XIxDSRCDRVwRU0nsn6AE=;
        b=WKwzxpW/0G1PwzjYAF8a+EVrTr6fh+G3BOQei9P7+KiRjgiNVpYFLcg9gwXtHbGv8+
         +Vn4wvq0KHIdlpBXqP66OZNNp5IzCWdefbabFN3+YCvIgbmI/4csmccnAxoVrtR3sDCu
         q4krFeaIsCBr33mHHQD1e65cphMeaZ/jx8xHTX8UD2H261EeGNKmBrSjFnUGIM10akKt
         W0xDzAGMymUvy/NJKtbVZJCjl6ML8l3IbSCISFJyEwqzPzfWlqvHyVl+oF2yGrCjJuKR
         HOwGKrCOYjsquRaSQkeEUK5RvhJzCLIykcHWFk4yJd0IxFXsXxWJ4NVe7H4q+dZXGPMc
         m1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=edth7XwGVSsSHqeKh06p/w9XIxDSRCDRVwRU0nsn6AE=;
        b=vPiwVPbMWoZ6nAq6Z3C5IH9UFJOZdi5zKExvLsjOCVFWY/sfdlbchUFGSNGWELMADW
         43yXFSEEX7uAeYvxpo2DaggYrJKEnxUXMsQENFJBlZRwpcH1aFOb7bgusHm8cblrsCJ2
         WbsPB9+95J9G+L/yGfJGndzlwc5vaA2G5MuFWR+b3qLhGcN0Yl2lRQdiqVfBwqon0Q+f
         pZAtJ3Qj73LJq2RDvptzNT8ZjoXMHbD3x5ZlSaAeUxtN5Vuyxz6prEvu2vKA5YfiOi+/
         sqvUwdt6lkbviIq03g8Pf5ezXxrED/Z2YIdFMG2lHTiudaCrXLw2IQcBA2eR0HKt0a39
         7wHQ==
X-Gm-Message-State: ANoB5pkckKJwmLFF0pR7qdGtXvTt6DAZnPmbkqP5u97PEvjS3sHy+LeH
        EV9ArDCqwlmkNUCDWTbuIp8=
X-Google-Smtp-Source: AA0mqf4hmOhNqYw1IrXq7MEIAfQyvOYLbUR0OYkzhO3U4bzPyxwTvn7GIOncqwVxLJFs6rc0v/i07A==
X-Received: by 2002:a2e:b8d0:0:b0:277:4ce4:bb44 with SMTP id s16-20020a2eb8d0000000b002774ce4bb44mr27382300ljp.55.1670363001230;
        Tue, 06 Dec 2022 13:43:21 -0800 (PST)
Received: from [192.168.50.20] (077222238151.warszawa.vectranet.pl. [77.222.238.151])
        by smtp.gmail.com with ESMTPSA id v7-20020ac25927000000b004ab4ebb5d92sm2623862lfi.5.2022.12.06.13.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 13:43:19 -0800 (PST)
Message-ID: <e06f4b2e-93a4-c231-3972-0b30382ddfbc@gmail.com>
Date:   Tue, 6 Dec 2022 22:43:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v3] usb: gadget: uvc: Prevent buffer overflow in setup
 handler
To:     dan.scally@ideasonboard.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9ffc4812-ab45-d7f9-7d93-fcacf629a754@ideasonboard.com>
 <20221206141301.51305-1-szymon.heidrich@gmail.com>
 <Y4+ybPL2uUO4SCJJ@pendragon.ideasonboard.com>
Content-Language: en-US
From:   Szymon Heidrich <szymon.heidrich@gmail.com>
In-Reply-To: <Y4+ybPL2uUO4SCJJ@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2022 22:21, Laurent Pinchart wrote:
> Hi Szymon,
> 
> Thank you for the patch.
> 
> On Tue, Dec 06, 2022 at 03:13:01PM +0100, Szymon Heidrich wrote:
>> Setup function uvc_function_setup permits control transfer
>> requests with up to 64 bytes of payload (UVC_MAX_REQUEST_SIZE),
>> data stage handler for OUT transfer uses memcpy to copy req->actual
>> bytes to uvc_event->data.data array of size 60. This may result
>> in an overflow of 4 bytes.
>>
>> Fixes: cdda479f15cd ("USB gadget: video class function driver")
>> Signed-off-by: Szymon Heidrich <szymon.heidrich@gmail.com>
> 
> Good catch.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
>> ---
>> V1 -> V2: Corrected commit message and changed ?: in favor of min_t
>> V2 -> V3: Added fixes tag
>>
>>  drivers/usb/gadget/function/f_uvc.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
>> index 6e196e061..4419b7972 100644
>> --- a/drivers/usb/gadget/function/f_uvc.c
>> +++ b/drivers/usb/gadget/function/f_uvc.c
>> @@ -216,8 +216,9 @@ uvc_function_ep0_complete(struct usb_ep *ep, struct usb_request *req)
>>  
>>  		memset(&v4l2_event, 0, sizeof(v4l2_event));
>>  		v4l2_event.type = UVC_EVENT_DATA;
>> -		uvc_event->data.length = req->actual;
>> -		memcpy(&uvc_event->data.data, req->buf, req->actual);
>> +		uvc_event->data.length = min_t(unsigned int, req->actual,
>> +			sizeof(uvc_event->data.data));
>> +		memcpy(&uvc_event->data.data, req->buf, uvc_event->data.length);
>>  		v4l2_event_queue(&uvc->vdev, &v4l2_event);
>>  	}
>>  }
> 

Hello Dan and Laurent,

Thank you very much for your time, review and accurate remarks.

Best regards,
Szymon
