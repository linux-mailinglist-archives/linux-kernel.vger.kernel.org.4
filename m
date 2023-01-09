Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72ED661FB5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbjAIIJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjAIIJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:09:46 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4A7BA6;
        Mon,  9 Jan 2023 00:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673251771; bh=GxDODv7BjGsfs4UAFxGX3mj/eF5LAXF1ugZSN5fTNBU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BgkPkVdg9HQSMxcOIvS6oP/h0Qf/vBH22A+GKwFu6/SAly2Ly2a++D3tlEXV1nhZ8
         PyqfcpBiHCI+c3GEkmXCdDuzV2FuYKYqRVYg33l7xripETOq8vr0gpr018dOu4VipF
         pd7SAYeoSVW8bSbxmunYFoHC0eabFCKzDQ40Sg4Kgb/i2Cb9NtyWRpHCzVLRs7P7BV
         nB17OfBZiYdJwAWqPdMIXb5l0Si+wqBKx7NFP30BskMxJ0sb+NtDpiJLkkICYnpYJE
         J/BxqXR0K0kIjI6Kps9NxZkCc5D28adK18M8SX3pXXvBZl02nJ1O5EHnz0nViIC+lO
         IwrI4vLmyKQvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.168.5]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUowb-1pNHY20uxt-00QgAb; Mon, 09
 Jan 2023 09:09:31 +0100
Message-ID: <7c36c161-ca51-244c-5705-e01337a85e40@gmx.de>
Date:   Mon, 9 Jan 2023 09:09:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fbdev/g364fb: Fix a compilation issue
Content-Language: en-US
To:     xurui <xurui@kylinos.cn>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
References: <20230105094039.1474255-1-xurui@kylinos.cn>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230105094039.1474255-1-xurui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5IcJLkdvLQuK5DfKSf6gmAjsCKhgghZj27t+ydMPAr5WqPyW8E7
 z+l2owR5Kkue1tXpGCO0yxpZNPMBmGJS2n0ejMTnr+vWcP9Z1XcILbLHSdyaP6F686TorRQ
 8PYx2r16oEeqeeoeTRSgOpMZee+XgdSJjBv/Rqgfz4Y3hH/4/JmGJyRzhpWLInjrFXqvk76
 NRdo6RMpAGBA3t49Tn61w==
UI-OutboundReport: notjunk:1;M01:P0:uAZtrF6HuhM=;Oqrnpf6YAHbNofOuuJB7jNa9Zxb
 PFaQT7wWviPw7M8iWjIuDH7JJX7zvXhebOZ/kjlNCyPpTaeuOgoqL8bhlh4IOGBk/gwwwkvMU
 V+NSoPEbivMwmgX0tfp0/OIairOaRiPYf2PPa46i/2BYLPR4VqXzYFPhXnIj6As2qKqzy+B+z
 2QkUvG/UxEHIMkL6hlm7mb3H4SSHmT3q6boNDqI6GwdJ0O7YXRTqeI1EJwklPDTDGW1dZakNL
 zgkemwEyD399hobzQK7BSliJP4a8+BbCMz3jzfFENVg3Tk/fDNHDtzk6zd16zaUxDLsznPwfD
 vuZlH3gFX3FfF+WzdmiqhIADBFCkKngkwhqs5Q/aHQd/QswR0dS1BfJiKBiJ6dAizCINwU0wc
 giP0m6xtE/h8xdV4PJ+7hU1+o6b1rkJ2dgzRjGM9t4DSC+8/KPGjbdgDi1gLYT64yr8VdqloY
 hPkP9/q4He5jFR5Duy/DIYxCynPn5hoYzq9/Z+BQxONLjkFK+jNH66dVTbRzHa4C5tMjSIND3
 T6y/y2vDU6XMuf1M2yUww7Zokb8ylg/bpVw5y2f9Zo2jfEOkOAwvCg8DM4L320ECFj6cUOGWn
 73IYdcn0gOKuZtOcvXJObNqoYyqZGTVuyDMHQmQv8o1P+wFuzdy36gHexq7QHnyVNKppeBOSm
 6GgBGkg/TojkhXLMn0XG//poBW6Fwqig2g0DAct4n0CX2b3+0vS6R69ZDOxgFotcLagA/3SaL
 P84vEvhr8nnfW8oSi/tf7gDxvw34rjelYlEQh2rj7YGBb3fJLZl8i2EQLSyV1rrIjEBHppiXG
 NJBNOTkpQ9cxTfMPxFU1GIJKCCxVhjPT7vwsoPkqXCa+On7gQBs02XCu51zZfHi5XAISiOt0F
 gSovIpcot48nqhCpildZW3IscCauVk5amU0AgMQ69ozuwKF/HdKyWjV5rwGtRe3rTDI+Rlj08
 sTsHhhpvE3emi6HozA/C4O9MLHc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/23 10:40, xurui wrote:
> drivers/video/fbdev/g364fb.c:202:4: error: cast to pointer from integer =
of different size [-Werror=3Dint-to-pointer-cast]
>
> Signed-off-by: xurui <xurui@kylinos.cn>

applied.

Thanks!
Helge

> ---
>   drivers/video/fbdev/g364fb.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/g364fb.c b/drivers/video/fbdev/g364fb.c
> index 05837a3b985c..beef4bcec3c5 100644
> --- a/drivers/video/fbdev/g364fb.c
> +++ b/drivers/video/fbdev/g364fb.c
> @@ -175,7 +175,8 @@ int __init g364fb_init(void)
>   {
>   	volatile unsigned int *curs_pal_ptr =3D
>   	    (volatile unsigned int *) CURS_PAL_REG;
> -	int mem, i;
> +	int mem;
> +	uintptr_t i;
>
>   	if (fb_get_options("g364fb", NULL))
>   		return -ENODEV;

