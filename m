Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD136B14B4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCHWDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCHWDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:03:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E382ED46;
        Wed,  8 Mar 2023 14:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678312981; i=deller@gmx.de;
        bh=URLRtCYvCA2OfgePK0dWq7nXnf4urDizzWJ5/29Hrz8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WP8JmQN1foHTYW81fe2J8bKqCKZZ0E3SuwAPCuk9mCCQ1EOBOitwYn2waiV/lhM+Y
         HkjWCkWVMHsqWVkMICOWJKG+/GVQ5vv7PUrND0/FuQ/f++uuohdua7obODUxWIJ6Xk
         gBqRbpByUTVEuCKjwLThbudN6kZPCh7y4P3oe3vNOQus1W4TkKSM40ywb4/mDfANE+
         ASG4vHH8Wxitbfz8uqRjVVUSsEGFnlgSB5NN/9tgTrMhQHyVScrH00B3orSgZRITJp
         l+3stHKU1C7p4rCL4MItI5G3GQ2ZGlbldxvC29QPZ5w83eE8hJqDiB8VQKrIrh75KL
         3zIK2oZffpHZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.151.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNNo-1q5UnP0E54-00VU3c; Wed, 08
 Mar 2023 23:03:01 +0100
Message-ID: <53d85de3-3072-50e2-9ce8-1fd48a2cfd69@gmx.de>
Date:   Wed, 8 Mar 2023 23:03:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] MAINTAINERS: orphan SIS FRAMEBUFFER DRIVER
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308071921.10963-1-lukas.bulwahn@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230308071921.10963-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YAJsaXgvOu0OB9fOwoTOiZ/2PC23B/DNDuSZiQLGjU07wjsxQAl
 qd03dqtJO4F5q0zf2FXWuptrt4RJpXMT8Vv1EEogkxZ3n/nbynNOH3TxJzMdh+MlXKYuBzE
 2DxQsF8p6tjUoC3Hhgm15bW3puUSfVeGj3PRwGMk2/Dpve6F3/dWQkvnPd59HUFH6F5R1Do
 Pi9Tq/HT/NiT9ybm37e3Q==
UI-OutboundReport: notjunk:1;M01:P0:/hk/TkyoQ98=;e5NDFwsJ3f7fGsOUSw2qIsKpg+k
 yJM5wYNEbIUAePkbQ876OyFBHJu+NpvPto3JPqpjgHIAd5qf/e7GjRFRA/NnJCZAqXpdui4wW
 2WvTRC7QQOhreRFsPIGqskl2bZp2AGRU2ItKrlK+jAlBx21gkLYKsaOtndQJzrjCfHe/zR7ed
 5GEGL5OsA+h1NZfBfKwBaeu0JYy77W7IWOL5Td62Ry5/wAE+94MGa4vQVrggL0Qzhmn8DFGHS
 3fz6w6SP/9gx7aW1/MAQPhqPkZkhtk/7BvmiwPFDg5LoqsW1esPv0VrvGEnHETae5JgWrGuoc
 zXiKPjtkzudN4zUGJ8o7+qrDZBSRl8oJMfkmIz0HEoBKPSVKHgKaUss+ZHvU6/i7d8HbrcabC
 Bis3RxmYGybOPqlp5K8Qok+KbqsdsRGmcMOp8aBGF+YX8Vh1T8Lh3MPOfuxOns65KsiS/MR11
 qBiFd+wgVpRkSiFP0KNiWwG80ba9C2b2g7fcEoAjNnvIvt3le8sGaDw/n4tKDkjXYmuSp0heC
 i+Lr/socogqSjdZ/rwrglN1jpoazN2UltdyMDIwIxY5EnvildsqG5qZgaHbrve3np+8IvNolg
 /lQSL9HatYpA2l+xqcPZNGLo/5UG0EZtfzPqACCDd0Af25mLr/1w0p055gDKXIz36AYoqQSfh
 R/cBLeo4L51faCiteXZFeip+EnBu/ryyy470Or+CiBirVmGewHfjVzRpNXxMvaJ7pLpOhSsEi
 jTps5QXABvCsZwaNgfvg6hmMMxEJLSm8dQCx1ym41RSdk7pHXgb7r71wO/Zg3O8GYpj3U9uYD
 qPjY7B/w8CzfjuyRqSjScLiXyavsytvJrTXfXP2tmai0q6Yr8OUKmBTitOvR8f/Jc0VyIjTr1
 iE4hq6gyKOFpZe9mV7HHcnfcUEjnOG0E9O0E71osoC2qaOjew9vjn7oNZ4L067lIRdY2FFfRQ
 2tg+W3BvGr9lIpikmTge6TtvPAo=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 08:19, Lukas Bulwahn wrote:
> This was triggered by the fact that the webpage:
>
>    http://www.winischhofer.net/linuxsisvga.shtml
>
> cannot be reached anymore.
>
> Thomas Winischhofer is still reachable at the given email address, but h=
e
> has not been active since 2005.
>
> Mark the SIS FRAMEBUFFER DRIVER as orphan to reflect the current state.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

applied to fbdev git tree.

Thanks!
Helge



> ---
>   MAINTAINERS | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d8f46f35aa4..354577534aef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19191,9 +19191,7 @@ W:	http://www.brownhat.org/sis900.html
>   F:	drivers/net/ethernet/sis/sis900.*
>
>   SIS FRAMEBUFFER DRIVER
> -M:	Thomas Winischhofer <thomas@winischhofer.net>
> -S:	Maintained
> -W:	http://www.winischhofer.net/linuxsisvga.shtml
> +S:	Orphan
>   F:	Documentation/fb/sisfb.rst
>   F:	drivers/video/fbdev/sis/
>   F:	include/video/sisfb.h

