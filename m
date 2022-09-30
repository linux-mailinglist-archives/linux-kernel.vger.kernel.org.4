Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA2C5F01D9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiI3Aia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiI3Ai0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:38:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77C21D9822;
        Thu, 29 Sep 2022 17:38:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A24D2B826C9;
        Fri, 30 Sep 2022 00:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2D7C433D6;
        Fri, 30 Sep 2022 00:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664498303;
        bh=eU4L7PpXX0M+N7vOLovMrw1kW+0pbNNaUk/kAugx0lY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=aXeY1/5QGh2ysUWtDRd/lqvuK9FocRnFmvZarKSN2qocsDdj2ypvk/uU3D7QENEJq
         ic6gnPLKyUZOqQKwe8cN/WQj10ldumfcGkY0r6FaClkvaYewby14wWqcvMeIPpJviN
         TYeiC9Wx7B9BVN8vBRtICsAnKrHO4hRHGegE48KE6g1+MuyziW/LwwzYMJkEC8/vrx
         JFdqS0qpTOdiVJsAUasxn3Wjo4eg4NeESOPkuecFloShpcG7TGLLrIbC+5YLh7yHQT
         TYj+Opohj+4VyXKgD6uO40E4E5IT/iAV4Qr+QJlGdn18sPaaYf+ppITocEsSWZupC0
         d1cruMiIrvYdg==
Message-ID: <140c7366-10e7-06a9-9a87-c6670a65e0d1@kernel.org>
Date:   Fri, 30 Sep 2022 10:38:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] m68k: update config files
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
References: <20220929101448.32177-1-lukas.bulwahn@gmail.com>
From:   Greg Ungerer <gerg@kernel.org>
In-Reply-To: <20220929101448.32177-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On 29/9/22 20:14, Lukas Bulwahn wrote:
> Clean up config files by:
>    - removing configs that were deleted in the past
>    - removing configs not in tree and without recently pending patches
>    - adding new configs that are replacements for old configs in the file
> 
> For some detailed information, see Link.
> 
> Link: https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks, looks good to me.
I have pushed this into the m68knommu git tree, for-next branch.

Regards
Greg


> ---
>   arch/m68k/configs/amcore_defconfig   | 4 ----
>   arch/m68k/configs/m5208evb_defconfig | 3 ---
>   arch/m68k/configs/m5249evb_defconfig | 3 ---
>   arch/m68k/configs/m5272c3_defconfig  | 3 ---
>   arch/m68k/configs/m5275evb_defconfig | 3 ---
>   arch/m68k/configs/m5307c3_defconfig  | 3 ---
>   arch/m68k/configs/m5407c3_defconfig  | 3 ---
>   7 files changed, 22 deletions(-)
> 
> diff --git a/arch/m68k/configs/amcore_defconfig b/arch/m68k/configs/amcore_defconfig
> index 6d9ed2198170..041adcf6ecfc 100644
> --- a/arch/m68k/configs/amcore_defconfig
> +++ b/arch/m68k/configs/amcore_defconfig
> @@ -27,9 +27,6 @@ CONFIG_PACKET=y
>   CONFIG_UNIX=y
>   CONFIG_INET=y
>   CONFIG_SYN_COOKIES=y
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
>   # CONFIG_IPV6 is not set
>   # CONFIG_WIRELESS is not set
>   # CONFIG_UEVENT_HELPER is not set
> @@ -85,7 +82,6 @@ CONFIG_ROMFS_FS=y
>   CONFIG_ROMFS_BACKED_BY_BOTH=y
>   # CONFIG_NETWORK_FILESYSTEMS is not set
>   CONFIG_PRINTK_TIME=y
> -# CONFIG_ENABLE_MUST_CHECK is not set
>   # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>   CONFIG_PANIC_ON_OOPS=y
>   # CONFIG_SCHED_DEBUG is not set
> diff --git a/arch/m68k/configs/m5208evb_defconfig b/arch/m68k/configs/m5208evb_defconfig
> index 0ee3079f6ca9..31035a0b9247 100644
> --- a/arch/m68k/configs/m5208evb_defconfig
> +++ b/arch/m68k/configs/m5208evb_defconfig
> @@ -21,9 +21,6 @@ CONFIG_NET=y
>   CONFIG_PACKET=y
>   CONFIG_UNIX=y
>   CONFIG_INET=y
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
>   # CONFIG_INET_DIAG is not set
>   # CONFIG_IPV6 is not set
>   # CONFIG_FW_LOADER is not set
> diff --git a/arch/m68k/configs/m5249evb_defconfig b/arch/m68k/configs/m5249evb_defconfig
> index f84f68c04065..5706d7a1daba 100644
> --- a/arch/m68k/configs/m5249evb_defconfig
> +++ b/arch/m68k/configs/m5249evb_defconfig
> @@ -22,9 +22,6 @@ CONFIG_NET=y
>   CONFIG_PACKET=y
>   CONFIG_UNIX=y
>   CONFIG_INET=y
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
>   # CONFIG_INET_DIAG is not set
>   # CONFIG_IPV6 is not set
>   # CONFIG_FW_LOADER is not set
> diff --git a/arch/m68k/configs/m5272c3_defconfig b/arch/m68k/configs/m5272c3_defconfig
> index eca65020aae3..f02fe144f4ad 100644
> --- a/arch/m68k/configs/m5272c3_defconfig
> +++ b/arch/m68k/configs/m5272c3_defconfig
> @@ -22,9 +22,6 @@ CONFIG_NET=y
>   CONFIG_PACKET=y
>   CONFIG_UNIX=y
>   CONFIG_INET=y
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
>   # CONFIG_INET_DIAG is not set
>   # CONFIG_IPV6 is not set
>   # CONFIG_FW_LOADER is not set
> diff --git a/arch/m68k/configs/m5275evb_defconfig b/arch/m68k/configs/m5275evb_defconfig
> index 9402c7a3e9c7..781f307ff330 100644
> --- a/arch/m68k/configs/m5275evb_defconfig
> +++ b/arch/m68k/configs/m5275evb_defconfig
> @@ -22,9 +22,6 @@ CONFIG_NET=y
>   CONFIG_PACKET=y
>   CONFIG_UNIX=y
>   CONFIG_INET=y
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
>   # CONFIG_INET_DIAG is not set
>   # CONFIG_IPV6 is not set
>   # CONFIG_FW_LOADER is not set
> diff --git a/arch/m68k/configs/m5307c3_defconfig b/arch/m68k/configs/m5307c3_defconfig
> index bb8b0eb4bdfc..6eac482356ca 100644
> --- a/arch/m68k/configs/m5307c3_defconfig
> +++ b/arch/m68k/configs/m5307c3_defconfig
> @@ -22,9 +22,6 @@ CONFIG_NET=y
>   CONFIG_PACKET=y
>   CONFIG_UNIX=y
>   CONFIG_INET=y
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
>   # CONFIG_INET_DIAG is not set
>   # CONFIG_IPV6 is not set
>   # CONFIG_FW_LOADER is not set
> diff --git a/arch/m68k/configs/m5407c3_defconfig b/arch/m68k/configs/m5407c3_defconfig
> index ce9ccf13c7c0..496dcccb1c18 100644
> --- a/arch/m68k/configs/m5407c3_defconfig
> +++ b/arch/m68k/configs/m5407c3_defconfig
> @@ -23,9 +23,6 @@ CONFIG_NET=y
>   CONFIG_PACKET=y
>   CONFIG_UNIX=y
>   CONFIG_INET=y
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
>   # CONFIG_INET_DIAG is not set
>   # CONFIG_IPV6 is not set
>   # CONFIG_FW_LOADER is not set
