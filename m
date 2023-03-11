Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C8D6B5A4B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 11:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCKKGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 05:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCKKGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 05:06:37 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5243D11EE84
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 02:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7KNwoXgjRer5LKYzZD+EoOuJEliyMODElb5INc7gnKU=;
  b=dECo1LXl3XnDhsJ0hMJoaeu5Sz4QvB7AR2k2FQ/nPXzkKNU7sHQwEfBp
   y5zFd2rozPyg15HLCMsC3p1NZ+qcijF1U/Ujqo7xuNBObeZUufguemQds
   s1AZ89y/6QRajgik8I4etGB7TIkIN58JcJh3E11KINhdY+gfo116/J0R0
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,252,1673910000"; 
   d="scan'208";a="49873560"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 11:06:34 +0100
Date:   Sat, 11 Mar 2023 11:06:33 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: axis-fifo: remove tabs to align arguments
In-Reply-To: <ZAxNYw2rFQkrdtKl@khadija-virtual-machine>
Message-ID: <alpine.DEB.2.22.394.2303111104430.2802@hadrien>
References: <ZAxNYw2rFQkrdtKl@khadija-virtual-machine>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Mar 2023, Khadija Kamran wrote:

> In file drivers/staging/axis-fifo/axis-fifo.c, in line 386 and 529, last

last -> the last

> argument is indented as it were an argument of the second argument.

as it -> as if it

> Remove tabs to align the arguments.
>
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
> Changes in v2:
>  - Do not change the alignment of second argument
>  - Align arguments so last argument do not look like an argument of the
>    second argument.
>  - Fixed two instances of the same problem
>
>  drivers/staging/axis-fifo/axis-fifo.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index dfd2b357f484..fbb3ff59dc7c 100644
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
> @@ -527,10 +527,10 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
>  		mutex_lock(&fifo->write_lock);
>  		ret = wait_event_interruptible_timeout(fifo->write_queue,
>  			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
> -				 >= words_to_write,

There is no need to change the above line.  Maybe one could argue that it
should be on the line before, but it is not part of the last argument of
wait_event_interruptible_timeout, so it should not be changed in this
patch.

julia

> -				 (write_timeout >= 0) ?
> -				  msecs_to_jiffies(write_timeout) :
> -				  MAX_SCHEDULE_TIMEOUT);
> +			>= words_to_write,
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
