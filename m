Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E39601AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJQVFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJQVFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:05:47 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA4CB86;
        Mon, 17 Oct 2022 14:05:46 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id de14so8177223qvb.5;
        Mon, 17 Oct 2022 14:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZIfFpGkauhTnKeNqdjUDkdgeHP4CsD1t9wtzFiEz+CU=;
        b=UuDRoaumXWTrg9S3NA7ybnCHXcyLC/hJ3DMzxjh8IKOjFGe5Xb8zu7ExcjZZRqtR8Q
         ORbj+pIQfO4VPD73ZN18AsNJBT1/Yz63PQ0o99x/OehaFWlLbdXSbS01Qfhn1b5hYm+i
         83dCPbg/1W3S2yPnOZoAdJpA5BcGQj3uocIrpBNHG/LU4QsXTIRmj3CbWe4uuLigKptu
         vGLv+wHijyLJKYnh2g110aLSM61nS59Meq2wqAlHcFcq2SNFA3xibZkBDYXTGv4Sjv0p
         c4T9xVJ/pLsooS9jPLRk+jKk2OMwpX4Iu56mjBvxrFqhz466rCyMJeGUA5aOK94JiuVy
         o5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIfFpGkauhTnKeNqdjUDkdgeHP4CsD1t9wtzFiEz+CU=;
        b=FLL0LEc6aEemI7ypbKVK7N0mt+btUMy6SYXiqF3aEZBsC7oEgCYgRvazofRX0OetRq
         3f+Wv0TdmLPbuEIkpdeeVYSIf7LZOVOTiLi4fpiMvitkZYcSRNr9raaVAXOGdLB+7FiB
         PU7y+9a1IQYkwU9U1CfwYxz+KQiPgoodz8iO1NXC8HEpxGADFSJIHJFq3y9k6WS+tawb
         g7Tk6qDvlsvu/yZDAF0snjLd5FY53jXvpI0RwimCDFQziggEaRR2NCMUv4bDD7lpKae7
         SCEVhuScEjXyWDrcrlR8kTPiuu0pj7ns+iOaPFQ6J78dXBtukxDIGJBLVBZn+A0XTQZ/
         fsQA==
X-Gm-Message-State: ACrzQf2r/tflRzkiOR5YT8dNQ6omSNZC2gf0gXn5IbiJihOtA6ehRKKi
        T3HgXw6yWopwRKPWYkXi2YY=
X-Google-Smtp-Source: AMsMyM4wH5J2caEt2m0PMGuip+PiSZqV+n8bn35+4ItyjNaEpFF96V8nD/vWawF0cLl9aOc/gRcYXA==
X-Received: by 2002:a05:6214:1c0c:b0:4b1:d2fe:7ad4 with SMTP id u12-20020a0562141c0c00b004b1d2fe7ad4mr9947091qvc.128.1666040745855;
        Mon, 17 Oct 2022 14:05:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j5-20020ac874c5000000b0039ccd7a0e10sm553055qtr.62.2022.10.17.14.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 14:05:45 -0700 (PDT)
Message-ID: <81528485-fa80-55ab-16ce-84de520f5262@gmail.com>
Date:   Mon, 17 Oct 2022 14:05:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] usb: bdc: change state when port disconnected
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>, justinpopo6@gmail.com
Cc:     alcooperx@gmail.com, balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, justin.chen@broadcom.com
References: <1664997235-18198-1-git-send-email-justinpopo6@gmail.com>
 <Y0Gax8SUoq59hdoF@kroah.com> <f0706380-94f9-ed7d-1033-8da51aab6b01@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <f0706380-94f9-ed7d-1033-8da51aab6b01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 07:58, Florian Fainelli wrote:
> 
> 
> On 10/8/2022 8:44 AM, Greg KH wrote:
>> On Wed, Oct 05, 2022 at 12:13:55PM -0700, justinpopo6@gmail.com wrote:
>>> From: Justin Chen <justinpopo6@gmail.com>
>>>
>>> When port is connected and then disconnected, the state stays as
>>> configured. Which is incorrect as the port is no longer configured,
>>> but in a not attached state.
>>>
>>> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
>>> ---
>>>   drivers/usb/gadget/udc/bdc/bdc_udc.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>
>> What commit id does this fix?  Should it go to older kernels?  If so,
>> how far back?
> 
> This would be:
> 
> Fixes: efed421a94e6 ("usb: gadget: Add UDC driver for Broadcom USB3.0 
> device controller IP BDC")
> 
> that issue was present since the driver was included in Linux with the 
> commit above, we did not really consider it to be a serious enough bug, 
> but I suppose it would not hurt to affix the said Fixes tag.

Greg, are you picking up the patch as-is, or do you need Justin to 
resusbmit with the Fixes: tag added?
-- 
Florian
