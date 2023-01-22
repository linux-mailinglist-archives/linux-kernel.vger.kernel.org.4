Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E316E676DA8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjAVO0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjAVO0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:26:38 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B7714EAF;
        Sun, 22 Jan 2023 06:26:37 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MAfQk-1pQF462FnU-00B3OM; Sun, 22 Jan 2023 15:21:06 +0100
Message-ID: <d5363f85-44e1-eee1-f7a5-61102637ef53@i2se.com>
Date:   Sun, 22 Jan 2023 15:21:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 0/4] Drop custom logging
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>
References: <20230118115810.21979-1-umang.jain@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230118115810.21979-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+K/hkG18/sgKmBAu93VyhrzGjSGV8+eUMDqkYyeM/O8q/ypb3jq
 G0J6OJ5W4OgwFC1Z3QH2Tq3deTqESekn8J17woustOqbuxJPAVauE12Go7VpPdjUhK2fug7
 SHFDwhJdOgFB0+r1mEI66LkQIP/71vVxRM5pE1oO9EiIi1zUuNNrFbtp54u6wPLC2N0aoig
 3KMX4IKC8uVH3qhLg28CA==
UI-OutboundReport: notjunk:1;M01:P0:vwI63V1V3WM=;SxYw6lsSCKLJWlC8TWM51b41N/C
 46arB08+ShlPWqVQDGi50NtNc2kz/xfyUqQqfQPz8lPluLEic7k4FXonR+ncXvizb4jxNAlel
 F35rCJR5aKPbBpfRz6ULY+E8BAhpnrom+zjW1UUyv3TIB/5c15/XzLjVeSvKe0+bRfYNNd/W3
 4Tze5zdWg/2UWbe6kUaAHPDfK2KjbSB2+aGlo9VdSf8CTaBLHgKO/TxxnE2/qoMLOYiQGnC3s
 AoHEMlqwhAQt/6wWJUzS5PfLS+dbFQdBkXCrCkxiwQqERALPbkZ82Ml9i1jM72AzbxKlQk02x
 kkYYlHm0sKRIGgyfgzualUedCKKlWrAYAN+y14zruaz5855r1+8kBmLVsGvvJ/PZg5xk0vPZR
 LJPxxuRJhLxiDS0W4YTwrKMOLuwfIWCHSAfQoDf+8B8rPFB6giGrg58lH5KD5yu/62WiZexxI
 4uuReKS6Aru2ieVIxgyelr7/XO0vBGHpGdCz/045R3aIY+QV4Lvp6yFPEBusOJgK6rAyDLN1Z
 7E2DjBCZeZtb7ckvYrrhIXxozIIexL3Gdk8htOc6RMdl9fGeOjlqNU4wMwFVKeJ98uahcgn58
 gfzn6mcmiAfoll8vCBywItbmbwQ215yedZbbNw5F1JCs+m9hHtTTs2GoF3hFEFamHI/qxMpWk
 stTFPHJErEDGFPyVnNBRW0+H11cofJ6egF1cwgnqyg==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 18.01.23 um 12:58 schrieb Umang Jain:
> Drop custom logging from the vchiq interface.
> Mostly of them are replaced with dev_dbg and friends
> and/or pr_info and friends.
>
> The debugfs log levels (in 4/4) are mapped to kernel
> logs levels (coming from include/linux/kern_levels.h)
> Would like some thoughts on it as I am not sure (hence
> marking this is RFC)
>
>  From drivers/staging/vc04_services/interface/TODO:
>
> """
> * Cleanup logging mechanism
>
> The driver should probably be using the standard kernel logging mechanisms
> such as dev_info, dev_dbg, and friends.
> """

at first i want to thank you for the work on vchiq so far.

There is something which is not directly related to this series, but it 
is also about debugging. The driver has a buffer which is accessed by 
it's own DEBUG_* macros. The content of this debug buffer can be dumped 
via the /dev/vchiq which is also used by ioctl. I would appreciate to 
move this dump feature into a new debugfs entry.

Best regards

