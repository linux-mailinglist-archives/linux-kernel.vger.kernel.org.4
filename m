Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A166773F75B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjF0Iee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjF0IeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:34:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4722712;
        Tue, 27 Jun 2023 01:33:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40B9661050;
        Tue, 27 Jun 2023 08:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54803C433C0;
        Tue, 27 Jun 2023 08:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687854828;
        bh=WmLl6k9cHJle5T+r62rsZWv3KQASy4LUyl3o/GZ4PA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nver0MxOVifvJXjI7iAMWUIDTAkgkeApPVSrrhKYmTczdDMzKzgcxYW72dqzdiVMu
         ZPOhaN8GkNbd5xz7Hm/33mXgdIEsXVr3MJO50yElcYTz52XGrtz1JDhBY+jFgCNTqa
         iFdegBqID/rbKN/AEmnPyYcyFkhBKz2bPe02aH1o=
Date:   Tue, 27 Jun 2023 10:33:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     baomingtong001@208suo.com
Cc:     heikki.krogerus@linux.intel.com, neil.armstrong@linaro.org,
        minhuadotchen@gmail.com, andersson@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: ucsi_glink: Remove unneeded semicolon
Message-ID: <2023062754-undivided-shallow-b634@gregkh>
References: <1aeccd98845a7dac584c08578b43a6c0@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aeccd98845a7dac584c08578b43a6c0@208suo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 04:24:59PM +0800, baomingtong001@208suo.com wrote:
> ./drivers/usb/typec/ucsi/ucsi_glink.c:258:2-3: Unneeded semicolon
> 
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c
> b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 1fe9cb5b6bd9..9b9685199d1a 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -255,7 +255,7 @@ static void pmic_glink_ucsi_callback(const void *data,
> size_t len, void *priv)
>  	case UC_UCSI_USBC_NOTIFY_IND:
>  		schedule_work(&ucsi->notify_work);
>  		break;
> -	};
> +	}
>  }
> 
>  static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
> -- 
> 2.40.1
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

- It looks like the From: line did not match the Signed-off-by: line.
  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
