Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C6162E394
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbiKQR4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240109AbiKQR4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:56:03 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9261B2EF0A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:56:00 -0800 (PST)
Received: from [192.168.1.102] (unknown [103.251.226.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0BDCA929;
        Thu, 17 Nov 2022 18:55:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668707758;
        bh=GdPOoKRqrG2ufeGG/2SH9V/fWXWoBKC38Aw9FoNcfyA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=RFMPyXfbOKxmZOwkcsSeCt9YujWgYk8Et2/ySAHb5YtjlkpdkeZt8KCS07tioUone
         Pf4qq9KsOr2zL9mk99Wyfftk73nFOpuRKrbD0JTstUCgDzCYRA1SNi1sCG9YXM4F0N
         2mhNLN+zB1z7Q5h0G1XbczuO1E+iSrbuV6BNp+lI=
Message-ID: <c718624a-bb6f-5474-5cc3-4319b1fdb282@ideasonboard.com>
Date:   Thu, 17 Nov 2022 23:25:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/3] Revert "staging: mmal-vchiq: Avoid use of bool in
 structures"
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-staging@lists.linux.dev
References: <20221117160015.344528-1-umang.jain@ideasonboard.com>
 <20221117160015.344528-2-umang.jain@ideasonboard.com>
 <166870135963.50677.14827688186331561108@Monstersaurus>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <166870135963.50677.14827688186331561108@Monstersaurus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On 11/17/22 9:39 PM, Kieran Bingham wrote:
> Quoting Umang Jain (2022-11-17 16:00:13)
>> This reverts commit 640e77466e69d9c28de227bc76881f5501f532ca.
>>
>> In commit 7967656ffbfa ("coding-style: Clarify the expectations around
>> bool") the check to dis-allow bool structure members was removed from
>> checkpatch.pl. It promotes bool structure members to store boolean
>> values. This enhances code readability.
>>
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> ---
>>   .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c    | 12 ++++++------
>>   .../staging/vc04_services/vchiq-mmal/mmal-vchiq.h    |  4 ++--
>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
>> index cb921c94996a..4abb6178cb9f 100644
>> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
>> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
>> @@ -863,9 +863,9 @@ static int port_info_get(struct vchiq_mmal_instance *instance,
>>                  goto release_msg;
>>   
>>          if (rmsg->u.port_info_get_reply.port.is_enabled == 0)
>> -               port->enabled = 0;
>> +               port->enabled = false;
>>          else
>> -               port->enabled = 1;
>> +               port->enabled = true;
>>   
>>          /* copy the values out of the message */
>>          port->handle = rmsg->u.port_info_get_reply.port_handle;
>> @@ -1304,7 +1304,7 @@ static int port_disable(struct vchiq_mmal_instance *instance,
>>          if (!port->enabled)
>>                  return 0;
>>   
>> -       port->enabled = 0;
>> +       port->enabled = false;
>>   
>>          ret = port_action_port(instance, port,
>>                                 MMAL_MSG_PORT_ACTION_TYPE_DISABLE);
>> @@ -1359,7 +1359,7 @@ static int port_enable(struct vchiq_mmal_instance *instance,
>>          if (ret)
>>                  goto done;
>>   
>> -       port->enabled = 1;
>> +       port->enabled = true;
>>   
>>          if (port->buffer_cb) {
>>                  /* send buffer headers to videocore */
>> @@ -1531,7 +1531,7 @@ int vchiq_mmal_port_connect_tunnel(struct vchiq_mmal_instance *instance,
>>                          pr_err("failed disconnecting src port\n");
>>                          goto release_unlock;
>>                  }
>> -               src->connected->enabled = 0;
>> +               src->connected->enabled = false;
>>                  src->connected = NULL;
>>          }
>>   
>> @@ -1799,7 +1799,7 @@ int vchiq_mmal_component_disable(struct vchiq_mmal_instance *instance,
>>   
>>          ret = disable_component(instance, component);
>>          if (ret == 0)
>> -               component->enabled = 0;
>> +               component->enabled = false;
>>   
>>          mutex_unlock(&instance->vchiq_mutex);
>>   
>> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
>> index 6006e29232b3..70eda6cac1c6 100644
>> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
>> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
>> @@ -48,7 +48,7 @@ typedef void (*vchiq_mmal_buffer_cb)(
>>                  int status, struct mmal_buffer *buffer);
>>   
>>   struct vchiq_mmal_port {
>> -       u32 enabled:1;
>> +       bool enabled:1;
> Is this a direct revert with 'git revert' ?


No. It had conflicts plus I added the ':1' initialization to keep the 
logic same (in case 'enabled' gets used directly). Similar pattern come 
up with:
     ($) git grep 'bool' -- '*.[h]' | grep '\:1'

So it shouldn't be an issue.

>
> I would expect this to be
> 	bool enabled;


True but it won't functionally not be the same in matter of 
initialization. Should the initialization be split to separate patch?

>
>
>>          u32 handle;
>>          u32 type; /* port type, cached to use on port info set */
>>          u32 index; /* port index, cached to use on port info set */
>> @@ -83,7 +83,7 @@ struct vchiq_mmal_port {
>>   
>>   struct vchiq_mmal_component {
>>          u32 in_use:1;
>> -       u32 enabled:1;
>> +       bool enabled:1;
> Same here of course.
>
>>          u32 handle;  /* VideoCore handle for component */
>>          u32 inputs;  /* Number of input ports */
>>          u32 outputs; /* Number of output ports */
>> -- 
>> 2.38.1
>>
