Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4B16A2B19
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 18:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBYRYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 12:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBYRYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 12:24:00 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4281310277;
        Sat, 25 Feb 2023 09:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677345829; i=deller@gmx.de;
        bh=ydbPDJcHWeZTcYVlzmYYqStnw+/P96AIc5NwdbKyn40=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=eD66dsiB0azJNfyuQ4auBfz9Bcaf2Yx9V0k55fZCjHxvk7d6hyK5K8FK60K/IIlP8
         luzW0erF9YPtvwaYtm9Kg/JEXA2rcBdbZyxgE8ci9ya+MximYiKhzTvFp6713JIxRZ
         yT3Lmz1g+Tnh6EpJQ7EeoHwTkVGGFOYcHPE4gQDvnIBnRXLFQ4IRLEDTMOqN0VVahX
         Cd7LLvG2oAeI8h8aPr16RE43SYPuL0xhRZ6EiFdWf4GIGrNPducWkCImo0tVlV3n8n
         THCgzOazZN8PSr+0QPyCgoJQrxI9zsplr5YtUD4Tobk3Hqieo78pGJx5M7tkpWuEAc
         9GAePEVFC2tdQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.139.251]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2nK-1ojDS30LI2-00nAWR; Sat, 25
 Feb 2023 18:23:49 +0100
Message-ID: <eb6900d5-148f-85cb-eebc-c20d99802c75@gmx.de>
Date:   Sat, 25 Feb 2023 18:23:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     Lucy Mielke <mielkesteven@icloud.com>, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de
References: <20230207100630.11644-1-mielkesteven@icloud.com>
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] fbdev: omapfb: cleanup inconsistent indentation
In-Reply-To: <20230207100630.11644-1-mielkesteven@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qIG4lpqWeR7O/1JJ/i5c5OuLExiquuoNnoBBFoR/goYZhYz6ASu
 J46WSrD3h8hcBp+bUVxTN2ZG9FWJJOxYkKR7ZMOFUzdoustA8L5toWMxKWbh60u2WO770Mp
 Eu+GXwCDZVW2RY1Lfg8NlAm9Md5UYls9XkSJT+5W0H6TzsQDmEM2LYkMw4GN68e956hd9rz
 ZNhh2OW+ZSUa3OGzMFk1w==
UI-OutboundReport: notjunk:1;M01:P0:+nerpTkWZA4=;4WVBWKdsfeKYxjmXLx1UHf3Tiw5
 bBjjK3b1xY36R7kL4nIpF4UOc3Vtw574UDmGeZfZJ7v2Cd8c/1RkQ1r/GxtWgT7P/xiRX6Lw+
 RFkIdxd4CenGF19hlOqfEHQMgahSf5xRwAlsJKwoOQ15s1a9yfkXns1Ub/xo0BiTQRqhqsias
 wAR23/XW2yGO8snG9Pi3OPMEGtaOH/OSiFsreb0dLXyy/c+/RndBYCRDRzINvPlQ2Rm5AroA+
 3gMPSkIk7lbIFsSLy1zv9T7wxkzk5QFDyIzZQ6N/Hq75BbGjhoocaEuimftyC1VRPT9XYkeE7
 subazo7rw46xyLdz1CqemGCEcz3wOeMVDroEqQDCzsrScnu9SYC6vl2LgdH/oD8QW5AIwXPoY
 Zxh6FrDPCI9JHAODjYfug+Arv4dyEe6qHcq23w/j7NbLEsrdBCLeqFsf9aRDL2pBSHYkmNnNm
 CT35t2bM9dSNIkmol6ID3jdbCQaGTbcvwjZA79gvVFZcGnL+T4moxiQ2VUMKqpApNPrVvght+
 zubT6tKi8lkz+Tux0hzfFRojKQK49Gw2NaaKv6+P4iRd6oGxuICymtpgzWQH2tAm3rZraaBDY
 ZnLsVatE3TQIOn1SGixaSuT1SiqKN3FcX4JKHU3roiir6Uahn113AU121a43VAJMgIdsywJhY
 66tKAHNcIbbd3RG1F94K33SkAFVoLJR2/5s7Qk5Mk2hsFw3zA/7wzJWfPO4eeSmzQ0ERIldge
 hRU5eKiS+cgPwWVFoRUibIma6aQuCvUhEe+3ZgbxicZ2WjM3V3KYH2t0cGkr18f9Ui5OKWpGN
 MqufO3xth5TtFFPuiEt1uH7jJe8mlzx8V/IeGaJ/sEFmrhC+byzD6zmnSbRrdbfn0rK18UYzH
 1d+n1oRcPztDYzdvxw43xk6xgnOdNPHSRe4JcB43wSEFeBBnxeV7Px1Ddwhh47TcA+K9syYDa
 UJ1KN1M+rMpIn1yxPvyyKybUqSE=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucy,

On 2/7/23 11:06, Lucy Mielke wrote:
> This cleans up the indentation according to the Linux kernel coding
> style, and should fix the warning created by the kernel test robot.
>
> Fixes: 8b08cf2b64f5a60594b07795b2ad518c6d044566 ("OMAP: add TI OMAP
> 	framebuffer driver")
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Lucy Mielke <mielkesteven@icloud.com>
> ---
>   drivers/video/fbdev/omap/omapfb_main.c | 32 +++++++++++++++-----------
>   1 file changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbde=
v/omap/omapfb_main.c
> index 1f3df2055ff0..4b673daa32cb 100644
> --- a/drivers/video/fbdev/omap/omapfb_main.c
> +++ b/drivers/video/fbdev/omap/omapfb_main.c
> @@ -78,7 +78,7 @@ static struct platform_device omapdss_device =3D {
>   	.name		=3D "omapdss_dss",
>   	.id		=3D -1,
>   	.dev            =3D {
> -		.release =3D omapdss_release,
> +	.release	=3D omapdss_release,>   	},

This is wrong. "release" belongs inside the .dev
variable, so the previous indenting is correct.

The changes below seem correct.

Helge

>   };
>
> @@ -544,19 +544,25 @@ static int set_fb_var(struct fb_info *fbi,
>   		var->yoffset =3D var->yres_virtual - var->yres;
>
>   	if (plane->color_mode =3D=3D OMAPFB_COLOR_RGB444) {
> -		var->red.offset	  =3D 8; var->red.length	 =3D 4;
> -						var->red.msb_right   =3D 0;
> -		var->green.offset =3D 4; var->green.length =3D 4;
> -						var->green.msb_right =3D 0;
> -		var->blue.offset  =3D 0; var->blue.length  =3D 4;
> -						var->blue.msb_right  =3D 0;
> +		var->red.offset		=3D 8;
> +		var->red.length		=3D 4;
> +		var->red.msb_right	=3D 0;
> +		var->green.offset	=3D 4;
> +		var->green.length	=3D 4;
> +		var->green.msb_right	=3D 0;
> +		var->blue.offset	=3D 0;
> +		var->blue.length	=3D 4;
> +		var->blue.msb_right	=3D 0;
>   	} else {
> -		var->red.offset	 =3D 11; var->red.length	 =3D 5;
> -						var->red.msb_right   =3D 0;
> -		var->green.offset =3D 5;  var->green.length =3D 6;
> -						var->green.msb_right =3D 0;
> -		var->blue.offset =3D 0;  var->blue.length  =3D 5;
> -						var->blue.msb_right  =3D 0;
> +		var->red.offset		=3D 11;
> +		var->red.length		=3D 5;
> +		var->red.msb_right	=3D 0;
> +		var->green.offset	=3D 5;
> +		var->green.length	=3D 6;
> +		var->green.msb_right	=3D 0;
> +		var->blue.offset	=3D 0;
> +		var->blue.length	=3D 5;
> +		var->blue.msb_right	=3D 0;
>   	}
>
>   	var->height		=3D -1;

