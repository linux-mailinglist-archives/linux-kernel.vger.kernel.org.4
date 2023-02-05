Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB668B14E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 20:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBETMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 14:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBETMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 14:12:42 -0500
Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1FF11179
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 11:12:38 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id OkRHpob81a0qgOkRHpwFuQ; Sun, 05 Feb 2023 20:12:36 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 05 Feb 2023 20:12:36 +0100
X-ME-IP: 86.243.2.178
Message-ID: <3cb45313-209a-8190-12f8-6a2d49e4173b@wanadoo.fr>
Date:   Sun, 5 Feb 2023 20:12:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] staging: vt6655: Macro with braces issue change to
 inline function
To:     Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Y9/xXHvOAwfqoDxn@combine-ThinkPad-S1-Yoga>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Y9/xXHvOAwfqoDxn@combine-ThinkPad-S1-Yoga>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 05/02/2023 à 19:11, Guru Mehar Rachaputi a écrit :
> This patch is to fix checkpatch warning: "Macro argument 'iobase' may be better
> as '(iobase)' to avoid precedence issues" changed to inline function. In
> relation to this, names of the callers of macro are also modified to call
> this function.
> 
> Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>

Hi,

this patch should be v4.
You re-sent it with a modified commit message (the position of your S-o-b)

The idea behind patch versions is to help maintainer. With the way you 
did, now 2 patches stating v3 are available.
Which one is the correct one?
The maintainer would need to look at both, search for differences, maybe 
look at the date of the mails.
A v4 would be much easier for him.


Also, when you send an updated version of a patch, it should always be 
"complete". I mean that the patch below seems to need v2, and maybe even 
v1 (which is apparently not on the linux-kernel mailing list).

A maintainer can't know by himself what is needed and what is not.

So you should resend a new patch.
It should be a v4, and it should include what is needed from (v1?), v2 
and v3 all together.

CJ


> ---
> Changes in v3:
> 	- Whitespace error from checkpatch fixed
> 
> Changes in v2:
> 	- Macros with one statement that is to call 'iowrite8' function changed
> 	to inline function as reviewed by gregkh@linuxfoundation.org.
> 	In relation to this, names of the callers of macro are also modified
> 	to call this function.
> ---
>   drivers/staging/vt6655/card.c    | 3 +--
>   drivers/staging/vt6655/channel.c | 2 +-
>   drivers/staging/vt6655/mac.h     | 4 ++--
>   3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> index a6ff496b01b6..d2d122dc16d8 100644
> --- a/drivers/staging/vt6655/card.c
> +++ b/drivers/staging/vt6655/card.c
> @@ -643,8 +643,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
>   				   &byRsvTime);
>   	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_72);
>   	/* Set to Page0 */
> -        vt6655_mac_select_page0(priv->port_offset);
> -
> +	vt6655_mac_select_page0(priv->port_offset);
>   
>   	spin_unlock_irqrestore(&priv->lock, flags);
>   }
> diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
> index e9a44bcebe32..60b445c38424 100644
> --- a/drivers/staging/vt6655/channel.c
> +++ b/drivers/staging/vt6655/channel.c
> @@ -121,7 +121,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
>   		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWRCCK);
>   		RFbSetPower(priv, RATE_6M, priv->byCurrentCh);
>   		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWROFDM);
> -	        vt6655_mac_select_page0(priv->port_offset);
> +		vt6655_mac_select_page0(priv->port_offset);
>   
>   		spin_unlock_irqrestore(&priv->lock, flags);
>   	}
> diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
> index b9a7ca0fe604..ae3064303691 100644
> --- a/drivers/staging/vt6655/mac.h
> +++ b/drivers/staging/vt6655/mac.h
> @@ -539,12 +539,12 @@
>   
>   static inline void vt6655_mac_select_page0(void __iomem *iobase)
>   {
> -        iowrite8(0, iobase + MAC_REG_PAGE1SEL);
> +	iowrite8(0, iobase + MAC_REG_PAGE1SEL);
>   }
>   
>   static inline void  vt6655_mac_select_page1(void __iomem *iobase)
>   {
> -        iowrite8(1, iobase + MAC_REG_PAGE1SEL);
> +	iowrite8(1, iobase + MAC_REG_PAGE1SEL);
>   }
>   
>   #define MAKEWORD(lb, hb) \

