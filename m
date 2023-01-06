Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AA065FE4D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjAFJtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjAFJsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:48:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066183E84D;
        Fri,  6 Jan 2023 01:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672998455; bh=X5XGAIPvr22MI0eLf6jR3JeaxkhbXLyZMnU47GJOnEw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=bhp4kWHBiZ062LakSuGlAeI1jKBq0geouwPhOVoA4z6A9Nvu2f5Vbkf+3u5Li+LdH
         jKuMf77iV+neeDKMYPWVsJaXt99T9wcPsrQ2Nsn5ghGvjy7t+HxHT2AM/63qkdJUR5
         27wRTyg50u5FawL3/ByCzivIkh8lr9/suzZ23VTZY8uNxy4LmvNuAKLIEJIsHZP841
         3YMMg40GvU432j92jKuE3raVH85yxR9YCCOgUFwAePYpQ2brS0Qebf9yk6how3UoIr
         MyU86ora954Uw3ppQdFmm5BthcjOqoFNHAMnX1/1QghE5K2bbH2ldKH30YBLpzVHrh
         rs0qc/Y014QAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.174.87]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4b1o-1pC4cz1nPy-001iw7; Fri, 06
 Jan 2023 10:47:35 +0100
Message-ID: <3bbd5135-a556-6097-9ca3-aef3399b2990@gmx.de>
Date:   Fri, 6 Jan 2023 10:47:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 22/27] fbdev: remove tmiofb driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-23-arnd@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230105134622.254560-23-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Jq4oXtpeY5Zcp1vcmNdwRjg473SuDv8Fg8XziQ3y3xhHgj1BhB
 LtDuFYRvQMmEUsp9ISNAP6vkXlOh6GIRvM3Rf3h/v2tF82uX6xAbObBZ++2D5xbrISu02AF
 R9wbH8quUF6r/jTu2gM/8zJlQzcnAz1ThizbL3hKsJi57YuNYopB4bkZizTAD69ebdLZuDB
 ij3zeuLgUN9lvqAxZaRyA==
UI-OutboundReport: notjunk:1;M01:P0:0Z2ibuAUW7Q=;awQLBEyBJDhrp6pjDcs9iUmevu+
 mSndKtwGgR6c9ubgsoaW+3gtipfaVYf8t9Yag8lKbeBk4dwJBDELWNhx1jZARg9jgJa8bqBD7
 evV4ddefTFVRHKMCNR8DUs0sqAYZpct3Q1wpfEs/OH3QU4Yy2bMHY1Decqh1jRriyzrMjxR9R
 qYZKO8YI8ibbx0JUEefBEixfpLRm+hbBYmNK1UkQonUXMfvI9u16PSnLZvL9n6Vy/Z6c6ZQ9e
 DiKPsBMXcowuK6KbfdBqTVeVX/PT7bEJaUPmuUp3Ohe8OS+kC1QzFCKVgiprzqwVpHUaxRvVL
 XTfI/9pY8L1Y2LGI68mkJJFzllOFQ35C2laqe8m7CVDpzYD4/Li34u5Ag9v+QfMgMgeUbcH/Q
 Mvtj7UVZ+NSRxrcURZxf7wG+yzn5S41uPJcmDwl2d4qEE8utm5efj+v0d17zt7fNHf7fcHCbU
 B9BDZfkRsCmDDBfWHOzXlIlu1FLhPzu9Jg2silzLGGSKlMWIfze4XKV/kRr+hphgJ3KDorT91
 jhItr5mARaaGUPsz+c8XXqQ+5F2kFxjfAuqFmz8hhBNIVXhyoVi2IOMRriEr5eMVITrnnQF6O
 k9jPMjFDkBKP8/oBrVIsMZrjFVa5NvFWgm8U+/p7cpX1Lz37/Xbs1inL57G8b5nHIGmMo7VQS
 688jqnCUTJbtBcviakG48A1+dmRwiomoLHmUMNUihS3WvRJyp95qygjejCrf5Qz/THiGGJgef
 ztAKAIKMpHnUh/SGyFTcLVLM1/JqBF68aeAtziSEUelC5IhT0S+hGJbZMfCrFnbQrg7xS/erz
 znxGAHw0accUORxOc7rFnkjOp/bW+zCLuSu2dvROt1pXuu5J/WpjFwwxiyoxenkYwy+NpPRSs
 c4GC95tzvQBfaX+7WfrN3wS6+sQBAE5PVfct2vnlTsNaJwhBF0KF/SNJAirIHvo6wKSXeA0qt
 POLI2UKtigOAILmXtBEnjDxIhaw=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/23 14:46, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> With the TMIO MFD support removed, the framebuffer driver can be
> removed as well.
>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Helge Deller <deller@gmx.de>

Arnd, I assume you will push the whole series through the ARM tree
(which I'd prefer) ?

Helge


> ---
>   drivers/video/fbdev/Kconfig  |   22 -
>   drivers/video/fbdev/Makefile |    1 -
>   drivers/video/fbdev/tmiofb.c | 1040 ----------------------------------
>   3 files changed, 1063 deletions(-)
>   delete mode 100644 drivers/video/fbdev/tmiofb.c
>
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 28febf400666..3152f1a06a39 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1871,28 +1871,6 @@ config FB_SH_MOBILE_LCDC
>   	help
>   	  Frame buffer driver for the on-chip SH-Mobile LCD controller.
>
> -config FB_TMIO
> -	tristate "Toshiba Mobile IO FrameBuffer support"
> -	depends on FB && (MFD_TMIO || COMPILE_TEST)
> -	select FB_CFB_FILLRECT
> -	select FB_CFB_COPYAREA
> -	select FB_CFB_IMAGEBLIT
> -	help
> -	  Frame buffer driver for the Toshiba Mobile IO integrated as found
> -	  on the Sharp SL-6000 series
> -
> -	  This driver is also available as a module ( =3D code which can be
> -	  inserted and removed from the running kernel whenever you want). The
> -	  module will be called tmiofb. If you want to compile it as a module,
> -	  say M here and read <file:Documentation/kbuild/modules.rst>.
> -
> -	  If unsure, say N.
> -
> -config FB_TMIO_ACCELL
> -	bool "tmiofb acceleration"
> -	depends on FB_TMIO
> -	default y
> -
>   config FB_S3C
>   	tristate "Samsung S3C framebuffer support"
>   	depends on FB && HAVE_CLK && HAS_IOMEM
> diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
> index 1bb870b98848..e5206c3331d6 100644
> --- a/drivers/video/fbdev/Makefile
> +++ b/drivers/video/fbdev/Makefile
> @@ -85,7 +85,6 @@ obj-$(CONFIG_FB_PXA168)		  +=3D pxa168fb.o
>   obj-$(CONFIG_PXA3XX_GCU)	  +=3D pxa3xx-gcu.o
>   obj-$(CONFIG_MMP_DISP)           +=3D mmp/
>   obj-$(CONFIG_FB_W100)		  +=3D w100fb.o
> -obj-$(CONFIG_FB_TMIO)		  +=3D tmiofb.o
>   obj-$(CONFIG_FB_AU1100)		  +=3D au1100fb.o
>   obj-$(CONFIG_FB_AU1200)		  +=3D au1200fb.o
>   obj-$(CONFIG_FB_VT8500)		  +=3D vt8500lcdfb.o
> diff --git a/drivers/video/fbdev/tmiofb.c b/drivers/video/fbdev/tmiofb.c
> deleted file mode 100644
> index 50111966c981..000000000000

