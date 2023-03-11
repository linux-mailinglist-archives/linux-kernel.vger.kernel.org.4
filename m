Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613E76B5B85
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCKMPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCKMPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:15:03 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059661A97E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=b03HwkZ2a14zZdvvpOUvIPLLqWM5o2fF6Q3gk4QF67E=;
  b=LvsWNL8+mYwmo77wwIfzoxbddMcnYN4LdHna9xQ/3E7Y/i/fJbzQ3W1Q
   AqI9hCxh1qf5kdPbgNHxb3hVIBpn0gn4p2AujPO4YAeWdiSsXnfFiZiSt
   cZGUSoHJnncIYOXQc2CZVVUunZajr8nyNmPFn86/bE4NdC4mCCcwfTL4d
   g=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,252,1673910000"; 
   d="scan'208";a="96640212"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 13:15:00 +0100
Date:   Sat, 11 Mar 2023 13:15:00 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: axis-fifo: remove tabs to align arguments
In-Reply-To: <ZAxsyX8n7G92nlJh@khadija-virtual-machine>
Message-ID: <alpine.DEB.2.22.394.2303111312540.2802@hadrien>
References: <ZAxsyX8n7G92nlJh@khadija-virtual-machine>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Mar 2023, Khadija Kamran wrote:

> In file drivers/staging/axis-fifo/axis-fifo.c, in line 386 and 529, the
> last argument is indented as if it were an argument of the second
> argument. Remove tabs to align the arguments.

You don't need the file name or the line numbers.  That information is
sufficiently obvious in the patch itself.  On the other hand, it could be
helpful rto point out that these are calls to
wait_event_interruptible_timeout and indeed that it is the timeout
argument that is misplaced.  That would help the reader know what to look
for in reading the patch.

julia

>
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
> Changes in v3:
>  - Do not align the line 530 since it is not part of the last argument.

You can keep the entire history here.

julia

>  drivers/staging/axis-fifo/axis-fifo.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index dfd2b357f484..b119cec25a60 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -384,9 +384,9 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
>  		mutex_lock(&fifo->read_lock);
>  		ret = wait_event_interruptible_timeout(fifo->read_queue,
>  			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> -				 (read_timeout >= 0) ?
> -				  msecs_to_jiffies(read_timeout) :
> -				  MAX_SCHEDULE_TIMEOUT);
> +			(read_timeout >= 0) ?
> +			msecs_to_jiffies(read_timeout) :
> +			MAX_SCHEDULE_TIMEOUT);
>
>  		if (ret <= 0) {
>  			if (ret == 0) {
> @@ -528,9 +528,9 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
>  		ret = wait_event_interruptible_timeout(fifo->write_queue,
>  			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
>  				 >= words_to_write,
> -				 (write_timeout >= 0) ?
> -				  msecs_to_jiffies(write_timeout) :
> -				  MAX_SCHEDULE_TIMEOUT);
> +			(write_timeout >= 0) ?
> +			msecs_to_jiffies(write_timeout) :
> +			MAX_SCHEDULE_TIMEOUT);
>
>  		if (ret <= 0) {
>  			if (ret == 0) {
> --
> 2.34.1
>
>
>
