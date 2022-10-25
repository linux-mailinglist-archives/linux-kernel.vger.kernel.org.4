Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8060660D4E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiJYTsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiJYTsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:48:13 -0400
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.149.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22821F07FB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:48:10 -0700 (PDT)
Received: from atl1wswcm03.websitewelcome.com (unknown [50.6.129.164])
        by atl3wswob05.websitewelcome.com (Postfix) with ESMTP id 0A1CF1AF7D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 19:48:10 +0000 (UTC)
Received: from br984.hostgator.com.br ([162.241.203.37])
        by cmsmtp with ESMTP
        id nPuDouOZYPUI8nPuDo1c6m; Tue, 25 Oct 2022 19:48:09 +0000
X-Authority-Reason: nr=8
Received: from [200.168.210.66] (port=39217 helo=[10.10.85.164])
        by br984.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <pedro.guilherme@espectro.eng.br>)
        id 1onPuC-001nmw-N6;
        Tue, 25 Oct 2022 16:48:08 -0300
Message-ID: <01f80fd2-b869-fb1c-1e97-e4b73ab87605@espectro.eng.br>
Date:   Tue, 25 Oct 2022 16:48:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/3] media: uvc_driver: fix missing newline after
 declarations
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221025050450.1743072-1-pedro.guilherme@espectro.eng.br>
 <Y1gwETdTkfAMTB8E@pendragon.ideasonboard.com>
 <Y1gxfeHa5iOax8BD@pendragon.ideasonboard.com>
From:   Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
In-Reply-To: <Y1gxfeHa5iOax8BD@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br984.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - espectro.eng.br
X-BWhitelist: no
X-Source-IP: 200.168.210.66
X-Source-L: No
X-Exim-ID: 1onPuC-001nmw-N6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([10.10.85.164]) [200.168.210.66]:39217
X-Source-Auth: pedro.guilherme@espectro.eng.br
X-Email-Count: 1
X-Source-Cap: ZXNwZWN0ODU7ZXNwZWN0ODU7YnI5ODQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJsSvBAlmM8VB9X50HMJZbL2Sr4WkO7vfaqQpNqZmHEFMjpLWeARfgGZRuC61tHF3P0+OYZaIkvbGK/3xheWAPAWIXD2FoktB3HSKC/aLovHd2ht9JEm
 ks1gyi4jnoDrIFCt2qQfRZG/BSZ73ieleRsMAObExB36uF27U6DCS6cL4kB2UVG+0T4rI92yXiC41ulFFCCMojNtSUGvEFyo5qUqaVgpQfFc2hlkdkEySIa3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for the info and for accepting my patch!  I'll better revise 
the subject lines from now on.

On 25/10/2022 15:57, Laurent Pinchart wrote:
> I forgot to mention, the subject line should start with "media:
> uvcvideo:", not "media: uvc_driver:". You can have a look at the git log
> to see how subject lines are usually formatted for a driver or
> subsystem.
> 
> No need to send a v3, I'll change this in my tree, for all three patches
> in the series.
> 
> On Tue, Oct 25, 2022 at 09:51:03PM +0300, Laurent Pinchart wrote:
>> Hi Pedro,
>>
>> Thank you for the patch.
>>
>> On Tue, Oct 25, 2022 at 02:04:48AM -0300, Pedro Guilherme Siqueira Moreira wrote:
>>> Fixes 'Missing a blank line after declarations' warning issued by
>>> scripts/checkpatch.pl on drivers/media/usb/uvc/uvc_driver.c
>>>
>>> Signed-off-by: Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
>>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>>> ---
>>>   drivers/media/usb/uvc/uvc_driver.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
>>> index 215fb483efb0..b591ad823c66 100644
>>> --- a/drivers/media/usb/uvc/uvc_driver.c
>>> +++ b/drivers/media/usb/uvc/uvc_driver.c
>>> @@ -732,6 +732,7 @@ static int uvc_parse_streaming(struct uvc_device *dev,
>>>   	/* Parse the alternate settings to find the maximum bandwidth. */
>>>   	for (i = 0; i < intf->num_altsetting; ++i) {
>>>   		struct usb_host_endpoint *ep;
>>> +
>>>   		alts = &intf->altsetting[i];
>>>   		ep = uvc_find_endpoint(alts,
>>>   				streaming->header.bEndpointAddress);
>>> @@ -1859,12 +1860,14 @@ static void uvc_delete(struct kref *kref)
>>>   
>>>   	list_for_each_safe(p, n, &dev->chains) {
>>>   		struct uvc_video_chain *chain;
>>> +
>>>   		chain = list_entry(p, struct uvc_video_chain, list);
>>>   		kfree(chain);
>>>   	}
>>>   
>>>   	list_for_each_safe(p, n, &dev->entities) {
>>>   		struct uvc_entity *entity;
>>> +
>>>   		entity = list_entry(p, struct uvc_entity, list);
>>>   #ifdef CONFIG_MEDIA_CONTROLLER
>>>   		uvc_mc_cleanup_entity(entity);
>>> @@ -1874,6 +1877,7 @@ static void uvc_delete(struct kref *kref)
>>>   
>>>   	list_for_each_safe(p, n, &dev->streams) {
>>>   		struct uvc_streaming *streaming;
>>> +
>>>   		streaming = list_entry(p, struct uvc_streaming, list);
>>>   		usb_driver_release_interface(&uvc_driver.driver,
>>>   			streaming->intf);
> 

-- 
Regards,
Pedro
