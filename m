Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A324661F9A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjAIIDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjAIIDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:03:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D850DFCDA;
        Mon,  9 Jan 2023 00:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673251383; bh=qozjcx4hTpr3jaYdT2eKjDnLhPkqHFw+E4wFsV+KjBo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=smzHY8PNV3Owc520Tr9p8IXQNBB9KKe4GYCYgmoeCwe6bz71EZc4DA6nOyUvP8bVf
         1nT6FchfvuH/idf4w/pYs8IYRPsRNvPTCdbsk9RdPZr164FKH5gvVOJPredv5RruCz
         1uYcoj1ypJRVK3w3dvdktbAe6C+XMQmY87PTaG2jIvQZGpDB8R7v/3mqwsdPJLEtZU
         B9YI4MPAm0O1F8NJYMp+FwU9rrftW/l1QQIMiUnnfykkiniFWe8dLCN2xFlKAOkdYT
         IcPvik70XX9eKiXjk1dF0+VAJ30kRtHcZbaPXO2K1rRgRBBxXsjD13WvxRV9Evn2BE
         4fwlcf4j0NiDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.168.5]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwfWU-1opqNY4Aig-00y8zI; Mon, 09
 Jan 2023 09:03:03 +0100
Message-ID: <b1ba214d-f3e1-4f6e-5226-2ab7761c4366@gmx.de>
Date:   Mon, 9 Jan 2023 09:03:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fbdev: Replace 0-length array with flexible array
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230105192034.never.249-kees@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230105192034.never.249-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9YTJmsZjsjckd6I9le8J645mr0N28l3SdIAvOuyOXzXTuxHoKTG
 qoIQNW6zyu1FP5X6N850VSLQj1Yw9UebNucTTQJta3AtHaS+teEAiFne08YoJwisaVxSDKz
 N0oYml7bDnzZQ1yhL5GdZ+k+Rw41aEnT0J2GsXeJAIU8XqYi2nstRW8BFge+4dsNu52nJl+
 EE9Lx6dmVlu166rTDsPCA==
UI-OutboundReport: notjunk:1;M01:P0:UMFGxlVWvYY=;5AI8Fz86dVux/6X6Zo26d4ofLkC
 Mn+YuXFtnpca4uzGQr10jGyFUg4BvKVTFjgjCPtpHp+9t+TvPxS1H2Odj2prQlE/FQ3V9eEwH
 xxb+uWK5yADaZddzuMIVkgqJWW7A2oWr7pF28RTRhGpqJoRmsh6ygXWO+RcoI29/M6QLaptlv
 8pcFmo6+6CqJZ0zD+1hf+KY/w0KMqnEMSPNq1X1ASYHssCDwwjtRtDHzfkeLkj3DFPt5LQCq3
 0eO+7duchHK0eZVEYULvCHQIv80zsVW518lnz0nsKBKSTg8nCTINjNjV3SPsJM9qariCEB0gJ
 yDLg0G9L88CTjZqj018fr5yj5xb0UfRa/9qJ/IoeALU04WRyKVcLeggi2jPGzfkMSq38MauOs
 trLH8xBQP1+fNv8n2BBGHzpqaHPwDcmUYQmmnZyvw2mWz3RtiyzNXv41Ni7/obCPxnjrvNuSF
 OpjiBhrKaV5tWj1FmXWLhGAb7SOn+K1bioeZA7uZpDwNnL97VNxz1CujfD6OlnYbHmEYtLOIe
 j/Mm223Cvc4wFGQsQca3aV3X0ZGP5WnC/YU+euHqNvO0XVFM0YNIt+noJKjFRgET/MOB7oJdY
 D9rrUCL31P4PRPMax3YRU9pNEg8tqVj6Zijn1frN2hZ59Gwx+9FIvmoZ/XPXc+c0gQyJ2rB+F
 C90+bAPSObZ8ctryBCfK+CBe8R2lStLhnvwpPQrOjsLaus/5vRp/vHj8Y3s3A6ynDvzFgQbgQ
 Tu56CTwE4PHumDWLoIuhhJV0irXMDCtmXGuoDbb0ZWRD10A+5hldW9orqblk/fN7eeoXNm+rM
 HijCdlGagKbAYRZeAgSga65k0N470YFnFz3shIyUXLsXI185uPoTKSwu05UkMoURZCGc9xm2n
 fTuwX9wN5JthviOzrR6vHxUnFHofAx/v5LHDLzaKCOlX7SLbaJLH1KJI5FzdZfI1biLpG8jS8
 5zHJ/A==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/23 20:20, Kees Cook wrote:
> Zero-length arrays are deprecated[1]. Replace struct aperture's "ranges"
> 0-length array with a flexible array. (How is the size of this array
> verified?) Detected with GCC 13, using -fstrict-flex-arrays=3D3:
>
> samples/vfio-mdev/mdpy-fb.c: In function 'mdpy_fb_probe':
> samples/vfio-mdev/mdpy-fb.c:169:32: warning: array subscript 0 is outsid=
e array bounds of 'struct aperture[0]' [-Warray-bounds=3D]
>    169 |         info->apertures->ranges[0].base =3D info->fix.smem_star=
t;
>        |         ~~~~~~~~~~~~~~~~~~~~~~~^~~
> In file included from samples/vfio-mdev/mdpy-fb.c:21:
> include/linux/fb.h:510:19: note: while referencing 'ranges'
>    510 |                 } ranges[0];
>        |                   ^~~~~~
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-=
length-and-one-element-arrays
>
> Cc: Helge Deller <deller@gmx.de>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

applied to the fbdev git tree.

Thanks!
Helge

> ---
>   include/linux/fb.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 96b96323e9cb..bf59d6a3590f 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -507,7 +507,7 @@ struct fb_info {
>   		struct aperture {
>   			resource_size_t base;
>   			resource_size_t size;
> -		} ranges[0];
> +		} ranges[];
>   	} *apertures;
>
>   	bool skip_vt_switch; /* no VT switch on suspend/resume required */

