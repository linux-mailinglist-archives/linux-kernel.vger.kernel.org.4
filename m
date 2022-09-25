Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2891E5E92B5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 13:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiIYLZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 07:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiIYLZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 07:25:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBB22F3B9;
        Sun, 25 Sep 2022 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664105101;
        bh=UWqhMQp6ZxdK7nN3F7WhJnrk5n9DdR2COrjRGDFJtmg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gn7cl1qvgjQmfsGQT3kz/hP3pdXTE+/0JNg2efoaiVGr0b67L6hD4n4yAU5FJlZql
         TZYKTWrV2VPLamveMuvMQExSHCuujj0Sni6hhLi6NaOh7UWykPwt7lFKohd0BBZlUp
         eFzBa3Prdeu6mnuxh3vjFmScy9OkpSWOeCt+ws+A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.188.118]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGz1f-1oPzIs1AbT-00E1iV; Sun, 25
 Sep 2022 13:25:01 +0200
Message-ID: <d57755de-44dc-e39c-6f79-1c139a77525f@gmx.de>
Date:   Sun, 25 Sep 2022 13:24:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] video: fbdev: gbefb: Remove unproper information
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, broonie@kernel.org,
        maarten.lankhorst@linux.intel.com, daniel.vetter@ffwll.ch
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220902025612.3833972-1-jiasheng@iscas.ac.cn>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220902025612.3833972-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NWo9unw0v52ZFh0r2dGQYyZpghQUKrtzka/hso5b+yrA2j3vu+E
 qYiZ1qOmdwDM46N1xr8Ne6oZQC+FP0Js6RaF7lEIERXTnqLs6oFkD9FSWt1OAaNsavE0kWv
 K+PT4Jf4HGLG8EE/ZnlppmveezN1u6oiDlfV/UfHf35tk70LBL1MhdimNvo2n8NLItI58Fc
 M+DvRUTVNzwrjoDyX5IGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lvvGcYDw70o=:e9E8067rY2u8n0gK4OGbxV
 1BygFJt4LIrgwOC7gLlDUNHWK777hhq+FUckuGx/yYKQ7A2yVPDTiInKCDBOfguhZv36VfvfL
 CLa341Rmv7VcAzlt6mRjUtTyWzzYr6rxCayaIb0xbh4xya854ZOcfE9ARy6ALotgCh/IFJLcv
 nGcR7WUtp562CuPM0gecUPHi6cuCLHxyOXx1vrM20o+LWMCIX99kCUV56t7L/HIgm+F8EjFDn
 /+WIJAidTbL59eZErg8rROMx9PkpuSeCqNwtWWUGRD3m99pDIBJkgAY+P02tKu9zbzqb9dDH8
 C4OQevn6pjkadV+p7EK4jB5Axaym+cUOmcKkucfzHU6Pam+zjFaFFTzeMPgrLcexfEhTdDF2V
 2cToD8+r+SFkS8GcT20UlRUWBK+wWKZoVd0Z1Sjlvkq6HuTyYdf5vEzM3Ltw7jqNGibSeUtHz
 c8H5fwnuezv+wYKhQkK39b6hLeM84Y5gR7wmQQjCjUmz4Kzkmxi9eahe910SBg2Bm3xLoydEv
 /+bHLjTikV0obqWOX0R8r8qIRj+xb1imqjVrsIKiKLXLmm4Yam6cCkFRKrqHneH13RsXMfNW8
 nxTvyGmyY/M1ZRgMknJfNp/ZwJYGQdwBEC7fXGzKFQ7hojiSvgCquK4SMgd8FCkv43hWI0Fre
 PCo6O+k/zmZS5eVuUwuJmkyGTfxU++Lu+4IGK32BOiMcAYw0U2nZo57WA7h3QWtHch8onRYfq
 v6YGI5bf7WKyBYaWypgJI652tX7F7/gu80IebRzGJ9xDGWzQsxWOqxPslz7aCLORo9w1GYH7G
 fkR9RpzXNvZgHyPuG5ov6CL0U+9Qpg7dR0HxiqonPWGzeta+l2DI7I8upZscZ9KLTSawceg+H
 mFE7CztJkLkd7jCgGcBDpF7Xd6rkpRmd64T6PtgVl+C3kFf6POxxSTH8AwCbgzna9gWm5xH8Y
 aFaod9KiUeWCtKxnoULIwtviKu4POUESbGbo9YJ7nSTJXP/3uKt0vXotA9HM4zvj5qtTrW+TW
 Bk+lErEK5Z1U3n+eXO0GRwlwp4R/GMKwVyUM91W7BbXgZA80PcKRpayafHjvk5ecZhzn4SgqI
 jDoh0tZI0tenpdD/FIs9ebQOnfQ/4EmDqhwgMqlrZemgnnN3xhFuA7p/ssDmjXfG6VWsWO3Ha
 u6vimqD2StUIqSluEMXPWMC/Cn
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 04:56, Jiasheng Jiang wrote:
> When drivers are working properly, they are quiet.
> Therefore, the fb_info() should be removed.

NAK.
This seems to be useful info about the detected card and it's only
printed once.

Helge

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/video/fbdev/gbefb.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
> index 1582c718329c..7e39ab939691 100644
> --- a/drivers/video/fbdev/gbefb.c
> +++ b/drivers/video/fbdev/gbefb.c
> @@ -1217,10 +1217,6 @@ static int gbefb_probe(struct platform_device *p_=
dev)
>
>   	platform_set_drvdata(p_dev, info);
>
> -	fb_info(info, "%s rev %d @ 0x%08x using %dkB memory\n",
> -		info->fix.id, gbe_revision, (unsigned)GBE_BASE,
> -		gbe_mem_size >> 10);
> -
>   	return 0;
>
>   out_gbe_unmap:

