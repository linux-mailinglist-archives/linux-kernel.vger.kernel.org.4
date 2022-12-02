Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB836406FD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiLBMlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiLBMk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:40:56 -0500
X-Greylist: delayed 316 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Dec 2022 04:40:53 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE8C91C16;
        Fri,  2 Dec 2022 04:40:53 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.27]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MuUWi-1ojpcj28mI-00rWFS; Fri, 02 Dec 2022 13:35:19 +0100
Message-ID: <d44a4819-1d4c-255e-212d-70abcf9fbb05@i2se.com>
Date:   Fri, 2 Dec 2022 13:35:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/14] staging: vc04_services: bcm2835-isp support
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Naushir Patuck <naush@raspberrypi.com>,
        David Plowman <david.plowman@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        "Ivan T. Ivanov" <iivanov@suse.de>
References: <20221121214722.22563-1-umang.jain@ideasonboard.com>
 <fc2fb888-7742-123c-69c9-cdb156ff2d9f@i2se.com>
 <a56d7687-ee44-629c-1a9d-fa34e65e847f@ideasonboard.com>
 <bb16004f-8d5b-5794-8445-aa7e1a758ffa@i2se.com>
 <c73f7261-ec33-ec88-df3e-a34cf9b8015c@ideasonboard.com>
 <0f683076-43e6-3f65-e5e1-052059ce7c86@i2se.com>
 <910dbd8f-85f2-4979-49ee-6d760e89af84@ideasonboard.com>
 <Y4nCnEwqs69QezPn@pendragon.ideasonboard.com>
 <CAPY8ntAK9yh6ZQkuOrZqUn2GC2=qGaJrcxEjWyGep7KcWvxkhQ@mail.gmail.com>
 <Y4nrPuq0OjWKCzfS@pendragon.ideasonboard.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <Y4nrPuq0OjWKCzfS@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:G3bNdCF9NfdRZxvP//LZQ/peuodgZ2ios5536nOU0JmXGDwmg3n
 KX8j0Suxmrz8Zcr6Daoo7h9HZspILwoeBvdM6Ue4JB67YLkMn5Bqh/DuLQI4g1iluKKrL/J
 sdpNL5PDZB92owIcdH4JPFc8lZvtLR6UU6YDwKppfg9Xc8iVquXm1wmRAkVjEP33OtVPdjF
 5bL1rrcSrR4j17WBg+HLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8nxra/ts3vM=:GQzXrNqxmtys5pVopjkZ8C
 ElOpdlgFag7++3DVgbW4JcmVWeJcyVX0UnZMoaYNSNY88YLeVxN/kxjY+IUNT5YUYxxxJ3qZc
 +JcXMX+ujjLyMyNRZr0x50KLZR9vl/2kcB7zdrBsSC0jebQ7cRtzctaQyyPtzBSCZmSh+mw7v
 ThuOc+/8pqHbzipx7OCjV3zhSZLZqQfTzQA4Xv2UkMd7TfJ+t7F7X/ucNn56lthjjVxerv8Ob
 brqYvDJVfVOp5gagESDPGl9EA9ccD1yiOXr8blXxgnJcyyh7+gZqC7RMlo2G0Y8pxirW3F/ll
 qeyvSIgWBiI2ffnCYjBxyFqPyR3jTqb8VFL0VSDPRn5cIkf+IhJgG4Chi/mwpAL6O9+w0cJ/k
 IhlxT6KmSHu9t8GY6ubgsgGoJoGruVkZICu3pueLkUa8VkbrootWIY3Z2/5age/wdCZEabo/n
 PDSKvhSaSxsyq/t/MCw5Az0niK6BzlymvxKqfLfk0mpJS+fn6dBwFM+D9jysXhK6Mr+WMqi7n
 gRPAXSPcYF2h1jCVzpIyqUUBiiBQHL4dl8vJafBJNJMLW8bXadwezz/0hBrUBx825MfqafS+G
 ihVoW5yp9ZGkYUXRa1QAOMcbvFz5NVJ4mPPXHlqBx5DNe7uSgcE9r+KYwPpq/e8wghcBwkASH
 RcVh5bWqPTiO6Tbs6qQcTj+zskgL13FKTxZUtQv5X/UnlEmSgTdeHwcBOEszjFPAa8kyBa95d
 wtw0//LlPoQMz3SU9OzBOvtYBXFchJEtxCW4KR1dTUiI3Mb+/323JzNi6iGRk/DJ82hTKNfov
 Ju1e8quo0aajCUfCbwc28opAJl0Dg==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Am 02.12.22 um 13:10 schrieb Laurent Pinchart:
> Hi Dave,
>
> On Fri, Dec 02, 2022 at 11:23:29AM +0000, Dave Stevenson wrote:
>> Dropping anything prior to those points would be rather premature in my book.
> Something I forgot to mention is that there should be no issue at all
> keeping bcm2835-camera fully supported in the Raspberry Pi downstream
> kernel for a longer period of time. It's in upstream that I don't think
> it should be destaged, as it's already considered legacy and should be
> phased out. Do you know if there are users of that driver with a
> mainline kernel ?
>
In Fedora there seems to be no official support [1], but openSuSE seems 
to mention it [2].

[1] - 
https://docs.fedoraproject.org/en-US/quick-docs/raspberry-pi/#_does_the_add_on_camera_work

[2] - https://en.opensuse.org/HCL:Raspberry_Pi_Camera_Modules

