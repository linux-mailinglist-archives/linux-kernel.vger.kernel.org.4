Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B7162DCB9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbiKQN1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbiKQN1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:27:20 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C892C18B1E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:27:19 -0800 (PST)
Received: from [192.168.1.104] (unknown [103.251.226.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E6365929;
        Thu, 17 Nov 2022 14:27:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668691636;
        bh=ksqVn1M+K1UPnIgTVAJW3Motav4KyH3E0VO3VHEyo3I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Fh/yu3+PaERnKVO0zP0zvkr7mnGBIfr3P1363lnM+XTNh9X+U/4XhSVu1t/Vp8TCR
         zoLLxelzj00eMk5CGkZ1yGFVSGXDwiEvNgUl+sr0i0q5CUNwrHd/C1WuyQLaUv6IVq
         LUrocBTf+aCZVJaHICZEJYR+P8eDfA791DSqcAbk=
Message-ID: <5f139eeb-24cc-85c1-34b6-f1334313839f@ideasonboard.com>
Date:   Thu, 17 Nov 2022 18:57:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/2] staging: vc04_services: mmal-vchiq: Do not assign
 bool to u32
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kieran.bingham@ideasonboard.com
References: <20221117125953.88441-1-umang.jain@ideasonboard.com>
 <20221117125953.88441-2-umang.jain@ideasonboard.com>
 <Y3Yziqaj9majJlNl@kroah.com>
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <Y3Yziqaj9majJlNl@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for the comment,

On 11/17/22 6:43 PM, Greg Kroah-Hartman wrote:
> On Thu, Nov 17, 2022 at 06:29:52PM +0530, Umang Jain wrote:
>> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>>
>> struct vchiq_mmal_component.enabled is a u32 type. Do not assign
>> it a bool.
>>
>> Fixes: 640e77466e69 ("staging: mmal-vchiq: Avoid use of bool in structures")
>> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> ---
>>   drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
>> index cb921c94996a..17f8ceda87ca 100644
>> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
>> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
>> @@ -1773,7 +1773,7 @@ int vchiq_mmal_component_enable(struct vchiq_mmal_instance *instance,
>>   
>>   	ret = enable_component(instance, component);
>>   	if (ret == 0)
>> -		component->enabled = true;
>> +		component->enabled = 1;
> Why not make enabled a bool instead?

Makes sense. It would probably require reverting the 640e77466e69 
("staging: mmal-vchiq: Avoid use of bool in structures")

I'll also find other occurances in vchiq-mmal (if any). Also for other 
reviewers, I found the context at:

7967656ffbfa ("coding-style: Clarify the expectations around bool")

Thanks,

uajain

>
> thanks,
>
> greg k-h

