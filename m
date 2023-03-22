Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66EC6C4C77
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCVNxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjCVNxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:53:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BAF24C80;
        Wed, 22 Mar 2023 06:53:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o7so17177523wrg.5;
        Wed, 22 Mar 2023 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679493214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQVFHuyH8bqksm7egwpleGiof9quLA2zV0qAKcfEvoE=;
        b=nryTjrIoq64MvPu4FvpYw8IcQruR1AV/DTo8VvMQ2mv2mAut9LivZXJAq1+yFFY8QO
         UjUrzDcIBYcQmVsqltN/c4AQZC6NONZVrgtQ7B5ujc1FcK4wt0P7OFR9ek4eyE2JGpc7
         ijEkOPrROUufza/QmMKIAbACmjiQdwIOKBcRB53ptuzXgoBGLavpQOXr/njeGJ+zXpyn
         Ki5wF+AVD/CWFOKLwdIZoEavJus/6DsiH3rhYLREI5DneUyQ+6MMooJPO4yl3CGItjWb
         rX8JvpI3OSh95MBwjR3aeCOLavTcTdJmltuBXKVV/Po2XJX+YRSOlzshCbJKMqsqM0aW
         kDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQVFHuyH8bqksm7egwpleGiof9quLA2zV0qAKcfEvoE=;
        b=kZwTapFQmd7PJ7PiNGgRZwXUbNUTUfQkzSx+A9RKP00ui8chyj2fjHrv6TZgK+eZfS
         r1fCKCbyfH99JDffSXUH7Kt2c8+ALE2SgOONR6GgMOeNmw7NAtb7/oN1BCikcWD8geDB
         hxXoCUin6SDsHjS0THdRiQAxfbzGk+lTU4xPCIdgAmwAcyefejNnoxJjHCSaRrCIIJIX
         OaEflBRUuWiJgQP+zo+UISRwnzyIMuqlT79DRKMN2E68eUMqfVxBhZ2Aem5mm2pFrJ44
         mxo/vEjEUGrjTYrYwh6LCMzzj894TeVxFMgaNAh5buD1XjeRUbwLkQzY7TQGYdf+7vYy
         L+Ow==
X-Gm-Message-State: AO0yUKXqNy8Bc4QvW/MbsHwf2/pmTnq32M25B00C3ESV7CzoZ0YE5A7w
        WbBnBLE8ulyVoOkdtC5Uauw=
X-Google-Smtp-Source: AK7set/fs9hcgx5GGhGGzXKvL8FklXES9AEwsi2C5PQmy+np6mk+7Oy+1pmLHYkJnfurvgT3VEdVWA==
X-Received: by 2002:adf:e386:0:b0:2d6:5afe:7b91 with SMTP id e6-20020adfe386000000b002d65afe7b91mr1724185wrm.30.1679493214046;
        Wed, 22 Mar 2023 06:53:34 -0700 (PDT)
Received: from [10.0.0.215] (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id c15-20020adfef4f000000b002c7066a6f77sm13877204wrp.31.2023.03.22.06.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 06:53:33 -0700 (PDT)
Message-ID: <a1969260-5033-3765-bd94-76cb40dd1729@gmail.com>
Date:   Wed, 22 Mar 2023 14:53:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] media: i2c: ov5640: Implement get_mbus_config
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Marco Felsch <m.felsch@pengutronix.de>
References: <20230306063649.7387-1-marcel@ziswiler.com>
 <ZBBk+h3EMSsacZ6v@valkosipuli.retiisi.eu>
 <ZBBpUAhis8L5Dtuz@francesco-nb.int.toradex.com>
 <ZBBsgW75Gc2FmuQ0@valkosipuli.retiisi.eu>
 <ZBBvmjUZIn/g0/Nv@francesco-nb.int.toradex.com>
 <20230320084844.tdjiv6kaxcosiwm2@uno.localdomain>
 <ZBg/4gkKWBMtw5a9@francesco-nb.int.toradex.com>
From:   Aishwarya Kothari <aishwaryakothari75@gmail.com>
In-Reply-To: <ZBg/4gkKWBMtw5a9@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.23 12:13, Francesco Dolcini wrote:
> On Mon, Mar 20, 2023 at 09:48:44AM +0100, Jacopo Mondi wrote:
>> On Tue, Mar 14, 2023 at 01:59:06PM +0100, Francesco Dolcini wrote:
>>> On Tue, Mar 14, 2023 at 02:45:53PM +0200, Sakari Ailus wrote:
>>>> On Tue, Mar 14, 2023 at 01:32:16PM +0100, Francesco Dolcini wrote:
>>>>> On Tue, Mar 14, 2023 at 02:13:46PM +0200, Sakari Ailus wrote:
>>>>>> On Mon, Mar 06, 2023 at 07:36:49AM +0100, Marcel Ziswiler wrote:
>>>>>>> From: Aishwarya Kothari <aishwarya.kothari@toradex.com>
>>>>>>>
>>>>>>> Implement the introduced get_mbus_config operation to report the
>>>>>>> config of the MIPI CSI-2, BT.656 and Parallel interface.
>>>>>>>
>>>>>>> Signed-off-by: Aishwarya Kothari <aishwarya.kothari@toradex.com>
>>>>>>> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>>>>>
>>>>>> What's the reasoning for this patch?
>>>>>
>>>>> Without this it's not possible to use it on i.MX6,
>>>>> drivers/staging/media/imx/imx6-mipi-csi2.c requires it, some more
>>>>> details from Jacopo here [0].
>>>>>
>>>>> Everything used to work fine up to v5.18, after that kernel version
>>>>> various changes broke it [1][2] (I assume you are pretty much aware of
>>>>> the history here, you commented on a few emails).
>>>>>
>>>>> [0] https://lore.kernel.org/all/20230128100611.7ulsfqqqgscg54gy@uno.localdomain/
>>>>> [1] https://lore.kernel.org/all/081cc2d3-1f3a-6c14-6dc7-53f976be7b2b@gmail.com/
>>>>> [2] https://lore.kernel.org/all/cacfe146-101b-35b3-5f66-1a1cabfd342f@gmail.com/
>>>>>
>>>>>> Drivers that don't have e.g. dynamic lane configuration shouldn't need to
>>>>>> implement get_mbus_config.
>>>>
>>>> Not even for staging drivers. The driver should be fixed to get that
>>>> information from the endpoint instead.
>>>
>>> This seems exactly the opposite of what commit
>>> 7318abface48 ("media: imx: Use get_mbus_config instead of parsing upstream DT endpoints")
>>> did.
>>>
>>> Given that I am somehow confused, but I am not that familiar with this
>>> subsystem, so I guess this is expected :-). Can someone provide some
>>> additional hint here?
>>>
>> To be honest my understanding is that this patch has always been
>> needed to work on imx6 and this is not a regression but something that
>> was kept as an out-of-tree patch downstream. Is this correct or is
>> this a regression ?
> 
> I confirm that v5.18 was/is fine.  Aishwarya: correct? In the end you
> tested it, not me :-)
> 
> Francesco
> 
> 
It worked on the v5.18 without this patch.

Aishwarya

