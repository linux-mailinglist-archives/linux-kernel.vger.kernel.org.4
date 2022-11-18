Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D2E62F0B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbiKRJNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241792AbiKRJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:13:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7474C64F9;
        Fri, 18 Nov 2022 01:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668762759; bh=eKtJWiPpgSifp4dBJaDSkL5sqHrBEh+fk4begN3cTGM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QQdIoYkdv7fAqcKxznKql80UxqQqvLwoCdJXXKczFwaYw6nSNxqGjV3XXjg44Ufgm
         DQqhbIrWxmFDtcD1/UtWgejcX2zZx12hKkfRxfptU/8OGgTiK31xaRVGaGWni0jHXK
         fx1FefJBl1ccCTP8OBEeQa3ug4r5qBJDdsvJpr05XthVgMFQXZFUfLnRxjXPxa7Eh7
         wzslW5SfyRSMi5viHgeUUe/AqFcpC3DBx/ytRiTZr34dAJHpSqfDdety6rYbnID2dv
         KVH2GQXDc8VGyUBBRhn3Av0kk3l+PoaBd3Qt5x/m6YR/rg8ZMypjh0BM3GnMK+bv4P
         42Z6+rtHS/+xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.164.156]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGRA-1ocdcX1xl0-00JNsO; Fri, 18
 Nov 2022 10:12:39 +0100
Message-ID: <9a32a234-b0a0-036d-86cc-f9942e165adc@gmx.de>
Date:   Fri, 18 Nov 2022 10:12:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] video: fbdev: fix spelling mistake
 "paramaters"->"parameters"
Content-Language: en-US
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com
References: <20221118090050.22148-1-yuzhe@nfschina.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221118090050.22148-1-yuzhe@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qfIlyXIDHqaMAPZu9uHYkCd2oiFTvgPIJHWKLO9du0KUtLNE/2m
 Qzk2OqSoz1Lb0es4i/CykSc+OajTd50HnyUFkQzuelz5HW3aIWEBQy8Dk5zb90YSPH9ZGYh
 9CT9UHjKTNHTYpUCWyCcSQ2BpG7Jx/O28VfIL5eWVS+1St+fYQI62OimfoGlWe7J8DrQ2Sf
 ma7iSzENejpn3jVPXnV2Q==
UI-OutboundReport: notjunk:1;M01:P0:4MMYiyYALVU=;0s3UI9q7gh6NlMHW3ScnT+zMsEh
 YxFm1x/91bP1UjpfA4w7HsxhGwnSVkytLBItMdtfYZI1hhjHqQp9iqfBj0zz1QYVW/YNaR0sr
 xsmypNg3dyicDohMtOgwm0LJnz0fHOmY1IGYKcYCCkislAM1nYuKPde6XRzOMEbXgyJc+AWb2
 MaV6qwJyi4OvWhmmxnvYK5UJhQ89Oigao3q03tU9mwS6i35HXtJY6Qwq3uxCCGRCcNDu6/0u+
 Ulv7TXCA6z0RaINaGl2xsXrs3frdJ07AzN5RhiLFaO/leFse8OWC0EJZEMdrMfBWyHVZM+34r
 HgWIYOHGvHsoC7ugU34TFQTwRr2tgTm35mt/bBCp2QCeCdz94scZJfWXB3MY9/TO+9GkIr2mU
 RID51dkRyBET6GkgHljmpbcJbq9w4CDGixAPx3/jvSqIQO0NUU7LzY+JtPKwFjMCoLWNnNFh8
 RYLjVjimmVkF/AVHwsQNSgS8+VBjh2nVrMOLOmgkTerD3eiKvLPjdLW8hcKc9spTKz6v71D1J
 ZiOG+YGCAEr14jl7MdRLx1SYizM5nlbKJvvKJKQrOToDUvKAyaaLt+w9h4fLYTGBOsEPPRa3E
 Opln0X+n9MFIN7wLFhc1AI3Ik4IxZWaH8ZsS+9493yWn480SPrkx59xGwQywEDMNFQCXz9Xte
 TaZWBiR4KnFYcrtCdp/ae3/Pw+9T2KNycULx2+McNDAjQ5vJB5++xaEahRC8dIWZwvMND4cO4
 FHcFchrdWxxug0kJh8MPtdGQy9MI9wfK+h62KxmbpQ2DV6Bcfbh4S2LnQpf8WnW0gTtN5LfCP
 sd/yVeDHImW6+lxDAop06+KHHwHis0yXZ+AwStvMAZPYaiY4keu2/jfv/IWvIHKfeQo1oN/7x
 EHLhadKC8WSpHNR0Fx0r8Ca2ulhG0fDWYko0MSGVKRi52rnRfIqJgw+/RxtlPAhrFvaRN51Jm
 p6f9DA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/22 10:00, Yu Zhe wrote:
> There is a spelling mistake in comment. Fix it.
>
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>

applied.

Thanks!
Helge

> ---
>   drivers/video/fbdev/controlfb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/contr=
olfb.c
> index 6bbcd9fc864e..77dbf94aae5f 100644
> --- a/drivers/video/fbdev/controlfb.c
> +++ b/drivers/video/fbdev/controlfb.c
> @@ -376,7 +376,7 @@ static int read_control_sense(struct fb_info_control=
 *p)
>   #define CONTROL_PIXCLOCK_MIN	5000	/* ~ 200 MHz dot clock */
>
>   /*
> - * calculate the clock paramaters to be sent to CUDA according to given
> + * calculate the clock parameters to be sent to CUDA according to given
>    * pixclock in pico second.
>    */
>   static int calc_clock_params(unsigned long clk, unsigned char *param)

