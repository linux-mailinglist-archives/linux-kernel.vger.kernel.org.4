Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F58C736342
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjFTFnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjFTFnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:43:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A06910DC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BED960F38
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C11C433C0;
        Tue, 20 Jun 2023 05:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687239824;
        bh=75N5G3M2CZw6SVHZejD4tHXAEXo8tYI2ZQMYV/7xnAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d4+/7AnfP74LGc2x/Uu67j7zjkPgYUJgtBxEQrokQnFKUvrCn+7nEmK4xzQj5DZ9D
         hsIVfkxrgURjc5HljnCsZxIBDVwXZbQthVrwRw5BXw7s8We+VgTldYVksIw94DKGRm
         RE+Hg0w4kOf6W/5PlcIm0fblDvABqGPVB8oopM7k=
Date:   Tue, 20 Jun 2023 07:43:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     philipp.g.hortmann@gmail.com, t4rmin@zohomail.com,
        colin.i.king@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/rtl8192e Fix camelcased function name
Message-ID: <2023062027-marine-culprit-7baa@gregkh>
References: <ZJDnetEcwdG1ffrK@tacos.darkphysics>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJDnetEcwdG1ffrK@tacos.darkphysics>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 04:40:42PM -0700, Tree Davies wrote:

> >From b66f420d2129bb45e0dc79128e517524607cf3b3 Mon Sep 17 00:00:00 2001
> From: Tree Davies <tdavies@darkphysics.net>
> Date: Mon, 19 Jun 2023 14:06:33 -0700
> Subject: [PATCH] drivers/staging/rtl8192e Fix camelcased function name
> 
> This fixes style issue for function name
> HTUpdateDefaultSetting -> ht_update_default_setting
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
>  drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
>  drivers/staging/rtl8192e/rtllib.h         | 2 +-
>  drivers/staging/rtl8192e/rtllib_module.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index fe30a291e64c..117b675a210d 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -67,7 +67,7 @@ static u8 CISCO_BROADCOM[3] = {0x00, 0x17, 0x94};
>  
>  static u8 LINKSYS_MARVELL_4400N[3] = {0x00, 0x14, 0xa4};
>  
> -void HTUpdateDefaultSetting(struct rtllib_device *ieee)
> +void ht_update_default_setting(struct rtllib_device *ieee)
>  {
>  	struct rt_hi_throughput *ht_info = ieee->ht_info;
>  
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index 6e665e866f1f..48b3c832affa 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -2037,7 +2037,7 @@ int rtllib_wx_get_rts(struct rtllib_device *ieee, struct iw_request_info *info,
>  void HTSetConnectBwMode(struct rtllib_device *ieee,
>  			enum ht_channel_width bandwidth,
>  			enum ht_extchnl_offset Offset);
> -void HTUpdateDefaultSetting(struct rtllib_device *ieee);
> +void ht_update_default_setting(struct rtllib_device *ieee);
>  void HTConstructCapabilityElement(struct rtllib_device *ieee,
>  				  u8 *posHTCap, u8 *len,
>  				  u8 isEncrypt, bool bAssoc);
> diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
> index d6a4d6b4ec57..841300e3a8bc 100644
> --- a/drivers/staging/rtl8192e/rtllib_module.c
> +++ b/drivers/staging/rtl8192e/rtllib_module.c
> @@ -129,7 +129,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
>  	if (!ieee->ht_info)
>  		goto free_softmac;
>  
> -	HTUpdateDefaultSetting(ieee);
> +	ht_update_default_setting(ieee);
>  	HTInitializeHTInfo(ieee);
>  	TSInitialize(ieee);
>  	for (i = 0; i < IEEE_IBSS_MAC_HASH_SIZE; i++)
> -- 
> 2.39.2
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
