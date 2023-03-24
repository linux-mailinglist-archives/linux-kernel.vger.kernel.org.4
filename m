Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2CF6C7DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjCXMQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjCXMQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:16:49 -0400
X-Greylist: delayed 392 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Mar 2023 05:16:47 PDT
Received: from smtp109.ord1d.emailsrvr.com (smtp109.ord1d.emailsrvr.com [184.106.54.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9350510AA3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1679659814;
        bh=fYRW0os9c4N0u7AOFMXwl1twmx1keRkaHb8vXUU58ac=;
        h=Date:Subject:To:From:From;
        b=zwmRc++Xk2utQFn4UXPFBJD+WvPchTQcqenifi7aBsgeTt9Jntufbu4MbyeM8oSKG
         46bi7fNThLoOX/j4C/s+J6jIgW3fcP+PVPB+aicw/bwTxQmvQgRQzML5Lxn2osTpF9
         SWHhLJGFh8UqisZBcUc1XR3dFnMF+MWJfwwM+J8E=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp14.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id B4C2A400AD;
        Fri, 24 Mar 2023 08:10:13 -0400 (EDT)
Message-ID: <f3e94902-3e0c-5857-bf44-0e2c42de30a6@mev.co.uk>
Date:   Fri, 24 Mar 2023 12:10:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: comedi
Content-Language: en-GB
To:     Gary Rookard <garyrookard@linuxmail.org>,
        "greg@kroah.com" <greg@kroah.com>
Cc:     "hsweeten@visionengravers.com" <hsweeten@visionengravers.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <B0081165-3F00-46D9-BD46-CB5A07D988BB@getmailspring.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <B0081165-3F00-46D9-BD46-CB5A07D988BB@getmailspring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Classification-ID: 7e4ac079-e1c3-4353-9b54-236773271378-1-1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 11:51, Gary Rookard wrote:
>  From ff0a68124526ea1ac003fbfdd4de47e347881dfe Mon Sep 17 00:00:00 2001
> From: Gary Rookard <garyrookard@linuxmail.org>
> Date: Thu, 23 Mar 2023 16:10:12 -0400
> Subject: [PATCH] Staging: comedi: comedi_fops: fixed missing blank line 
> coding
>   style issues
> 
> Fixed/added 3 blank lines to resolve  issues, comedi_fops is checkpatch 
> clean.
> 
> Signed-off-by: Gary Rookard <garyrookard@linuxmail.org>
> ---
>   drivers/staging/comedi/comedi_fops.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/comedi/comedi_fops.c 
> b/drivers/staging/comedi/comedi_fops.c
> index e85a99b68f31..3f70e5dfac39 100644
> --- a/drivers/staging/comedi/comedi_fops.c
> +++ b/drivers/staging/comedi/comedi_fops.c
> @@ -2169,6 +2169,7 @@ static long comedi_unlocked_ioctl(struct file 
> *file, unsigned int cmd,
>                  break;
>          case COMEDI_CHANINFO: {
>                  struct comedi_chaninfo it;
> +
>                  if (copy_from_user(&it, (void __user *)arg, sizeof(it)))
>                          rc = -EFAULT;
>                  else
> @@ -2177,6 +2178,7 @@ static long comedi_unlocked_ioctl(struct file 
> *file, unsigned int cmd,
>          }
>          case COMEDI_RANGEINFO: {
>                  struct comedi_rangeinfo it;
> +
>                  if (copy_from_user(&it, (void __user *)arg, sizeof(it)))
>                          rc = -EFAULT;
>                  else
> @@ -2249,6 +2251,7 @@ static long comedi_unlocked_ioctl(struct file 
> *file, unsigned int cmd,
>          }
>          case COMEDI_INSN: {
>                  struct comedi_insn insn;
> +
>                  if (copy_from_user(&insn, (void __user *)arg, 
> sizeof(insn)))
>                          rc = -EFAULT;
>                  else
> -- 
> 2.34.1
> 
> Sent from Mailspring

This is already resolved by commit 76cd0c7cc20f ("Staging: comedi: Added 
blank lines to fix coding style issue") in the 5.10 kernel (from the 
year 2020):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=76cd0c7cc20f3ca71f1be38bfc0c9d3c0807e7ca

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

