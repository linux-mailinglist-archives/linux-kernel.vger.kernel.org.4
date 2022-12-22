Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE996540FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiLVM2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiLVM2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:28:09 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7351262A;
        Thu, 22 Dec 2022 04:28:06 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.22]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MV5rK-1pGXru0n2c-00S7vG; Thu, 22 Dec 2022 13:27:48 +0100
Message-ID: <d18a1db5-0ad5-cb64-0764-d1d162657ad6@i2se.com>
Date:   Thu, 22 Dec 2022 13:27:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 5/7] vc04_services: vchiq_arm: Drop VCHIQ_RETRY usage
 on disconnect
Content-Language: en-US
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20221219115725.11992-1-umang.jain@ideasonboard.com>
 <20221219115725.11992-6-umang.jain@ideasonboard.com>
 <8fcbdf54-98ae-6a06-ecaf-591a43b863a1@i2se.com>
 <6baffa7c-ea7c-aaa6-361a-1a043b065f29@ideasonboard.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <6baffa7c-ea7c-aaa6-361a-1a043b065f29@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5oBNFdIcHUEPZ/hOt0ymzZuBbo6GdsY9Z6EySt2vT1rAp2FKeH1
 UybcYyne99UKNbSqy4Xty9GvJ9IKFJU1D0gg4+m2wXx2ByO+5LkHY9sbbRRfVrMySfDK/Ag
 QYyF7Tv2952oe9ho9lLXe80TsPSyuPbI+hq3neC/6REdzpAxry4GDBLX2xulqvAkGGrO3PC
 sLSwSCQezjDqSY2NWWaig==
UI-OutboundReport: notjunk:1;M01:P0:2tCdS9YoLF4=;jzmIj6Fk5M0bjP+NWwjRWXVG6jT
 SgQVzXtJiWgBUGN7YvjzgnWJvGI5MIJBaTHkXIfoVFxkQkiRP0IAs7fpSdnCTsKq0FJREjPCn
 kMyIMBchE1BRmoZfc/S65OvHW43Wbb2mvcELjKAd0XG04kGEHzdW4OMLtWcwS9aLWyg96NZiD
 Zhhfcfc2+/NCuaedgdVcviXgpYUUzLpFLyRL570TkB2kZfsuMGjKeKg+qoE2ZoSD0FTXZVefN
 3IWcWzGM3ZCf2cHgeHsIsKdoMvcurXET5GzLOjYOjbkLVkLYEuopGJt0NzAeYHwGQtOKZyr5l
 0qCC3Czvd6sWguGodw4IjkYir50OmYF0SitFC3z5lv+TAQ6JZT5yhYpZ4s5KSTa1ty/82fAWn
 h6zSjQ4wb7cvlKhqda7gIdHuffCwShJBdlsieyJEUp5NVGB2X7Hz9YPddSe19p9khN/UKQ6+h
 qix7k7IBcPQTbF7kiuFBi9yfHL+LLicQwjs7n83Ny98ok1CjemvM3k+GCxt7GM8Ebj5ugv7IA
 rltwAz0M9cwhDOcRgmgdiWq+vt6EVLITcJ9wDFM76hstNpuRafT5lavbk16O9nG25T3gPvkG+
 P4UGCU8qy5umsBW3nYYEU8OeJfUHJLM/Q0MjFfPdt6D3QNZ+jbblHVvl5888sfBpwP1WDaOR2
 PvrXk9wKOdv1fnb1nDkCd5bsIjCAcrniMFWDYqtRlQ==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 22.12.22 um 13:04 schrieb Umang Jain:
> Hi Stefan,
>
> On 12/22/22 4:37 PM, Stefan Wahren wrote:
>> Hi Umang,
>>
>> Am 19.12.22 um 12:57 schrieb Umang Jain:
>>> Drop the usage of VCHIQ_RETRY when the vchiq has connection status
>>> VCHIQ_CONNSTATE_DISCONNECTED. Disconnected status will not be valid to
>>> carry on a retry, replace the VCHIQ_RETRY with -ENOTCONN.
>>>
>>> This patch removes the usage of vCHIQ_RETRY completely and act as
>>> intermediatory to address the TODO item:
>>>     * Get rid of custom function return values
>>> for vc04_services/interface.
>>>
>>> Fixes: 71bad7f08641 ("staging: add bcm2708 vchiq driver")
>> please drop this fixes tag since this commit doesn't fix a real issue 
>> and also shouldn't be applied to stable.
>
> Should I send a v3 of the series with updated commit message or can 
> you drop the tag while applying?

Greg is the maintainer of staging, so i cannot decide. But i would 
prefer a v3 with my tested tag added and this fixes tag dropped.

Best regards

>
> Other option would be to send v2.1  --in-reply-to this patch. I am 
> fine with anything as long as it aligns with the merging workflow.
>
> Thanks,
> Umang
>>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>>> ---
>>>   .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git 
>>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c 
>>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>>> index 9c64d5de810e..ddb6d0f4daed 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>>> @@ -3641,7 +3641,7 @@ vchiq_loud_error_footer(void)
>>>   int vchiq_send_remote_use(struct vchiq_state *state)
>>>   {
>>>       if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED)
>>> -        return VCHIQ_RETRY;
>>> +        return -ENOTCONN;
>>>         return queue_message(state, NULL, MAKE_REMOTE_USE, NULL, 
>>> NULL, 0, 0);
>>>   }
>>> @@ -3649,7 +3649,7 @@ int vchiq_send_remote_use(struct vchiq_state 
>>> *state)
>>>   int vchiq_send_remote_use_active(struct vchiq_state *state)
>>>   {
>>>       if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED)
>>> -        return VCHIQ_RETRY;
>>> +        return -ENOTCONN;
>>>         return queue_message(state, NULL, MAKE_REMOTE_USE_ACTIVE,
>>>                    NULL, NULL, 0, 0);
>
