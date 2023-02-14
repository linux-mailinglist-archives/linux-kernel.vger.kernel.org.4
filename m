Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422F069599F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjBNHGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjBNHGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:06:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA86E1E2A7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:05:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C3E861466
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F71C433EF;
        Tue, 14 Feb 2023 07:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676358317;
        bh=eqOvV8wVPsEHvnsCL1V0U6V8uErmD2pRmb2xPEvZkI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBVRj/Om0t6l9F7HvTBQXvohF41iofScdDWiibcD0nuHqoKcTSZIlrBEXaoq/Q8uj
         QaKr+XkzeNFW9mJX4gQNkyDEdWszZYBeLnzuI9TQ6nfJXGyPdxlD3jvdljD4/yAtWc
         wBbRhRtC0/RHN/Lbxg/qRa8MgpRSomeu+Z1ZeCbk=
Date:   Tue, 14 Feb 2023 08:05:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH v3 5/6] sign-file: use const with a global string constant
Message-ID: <Y+syqvtRmxk5GaPV@kroah.com>
References: <20230213190034.57097-1-sshedi@vmware.com>
 <20230213190034.57097-5-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213190034.57097-5-sshedi@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 12:30:33AM +0530, Shreenidhi Shedi wrote:
> Fix a space issue (cosmetic)
> Both reported by checkpatch.
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  scripts/sign-file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index b48832d54f45..0729d8df5660 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -71,7 +71,7 @@ struct module_signature {
>  
>  #define PKEY_ID_PKCS7 2
>  
> -static char magic_number[] = "~Module signature appended~\n";
> +static const char magic_number[] = "~Module signature appended~\n";
>  
>  static __attribute__((noreturn))
>  void format(void)
> @@ -116,7 +116,7 @@ static void drain_openssl_errors(void)
>  		if (__cond) {				\
>  			errx(1, fmt, ## __VA_ARGS__);	\
>  		}					\
> -	} while(0)
> +	} while (0)
>  
>  static const char *key_pass;
>  
> -- 
> 2.39.1
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
