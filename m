Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119866AD819
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 08:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjCGHNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 02:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCGHNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:13:13 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B63D326
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 23:13:11 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id j11so28945011edq.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 23:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678173189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Zm7VLfvc/LZ8fV8dJrpBs77JoX+4gvTkNsNk9slxrA=;
        b=f4ifeYFN1uE/+TmGqxxuUenoNBn9IeERD8SLLTgBAF/C+jQH3ykMn/4cgpuvXEH8sJ
         bkVWamV8aUqpDS6poCRCpCariL99xSw2hs9mz9uPwsjetAF6CqoODdivbykNXmYN8OsY
         TJCbVKCpHJGUdqSmNCdAB3uB7/Q2PmrDU9TdEwmUTEXLmrwNMNFqF3RFhGpYv2pW1LVC
         MErp6U7lFAsAcaVGjUuhUgIwDHw6l4diT6v6hk9f0P2VmN1JD4PUbrqDNj0OWdOr4r40
         jRsMQy822hJlCx+rPcIVEECYJS5TJNuuTK14qBL4pRzGfNVs7d2vi7tvXKehhU11Fxku
         d9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678173189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Zm7VLfvc/LZ8fV8dJrpBs77JoX+4gvTkNsNk9slxrA=;
        b=pCXcCfMr0/4FBtj/QvWJZJBIXAuDZ5g3oFwVYc0xsQMUdRCDqDu+fjDl826/ne4GkN
         L4ub/tRpXCgZXpakVZrVZiVa8ArNWoI2xsSC1VLryXCiikeg0A95+TMvqD4k41j4JwSH
         mmOww97OBytQOlNzwX49x+3I8648uEmQXn42ct5hXZOq1e3ZTKkZ2TZQ96KUF2Wno9p8
         xZOTgRIRlJjp/nOPAG69pyKSlNHchpP2gYekhyHLj78TcrZ1RnmUQWjoMV5I9oaSACli
         T+tBr3KPxUbrA3J8Tz/zVjJt9oVr05EzXL/WQOnMmEjvurg/HwQy5v6UGArpgP78yFgv
         Y6TA==
X-Gm-Message-State: AO0yUKVpDgyMTLXGEylG3bRt7ktcPfFj1UVktdWQIGHrO0Vpt41587fR
        BXe8ZQ7YsAjQ84kgl80V5X2is8IF5iQ=
X-Google-Smtp-Source: AK7set/ZkaXxcAzXMmAJWtfYqKGZ2dGkYPmnrtMIvCs5sfPgVAkTtx7KDiXFMPFHCsiv0tf+PB6eyA==
X-Received: by 2002:a17:906:6a1e:b0:8b1:fc58:a4ad with SMTP id qw30-20020a1709066a1e00b008b1fc58a4admr18342715ejc.11.1678173189660;
        Mon, 06 Mar 2023 23:13:09 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id ot18-20020a170906ccd200b008e40853a712sm5626807ejb.97.2023.03.06.23.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 23:13:09 -0800 (PST)
Date:   Tue, 7 Mar 2023 10:13:05 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: alignment should match opening
 parenthesis in axis-fifo.c
Message-ID: <9543f943-759f-4e87-8f88-4eba7c1e4785@kili.mountain>
References: <ZAZSmPpB6fcozGa4@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAZSmPpB6fcozGa4@khadija-virtual-machine>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 01:52:40AM +0500, Khadija Kamran wrote:
> In file drivers/staging/axis-fifo/axis-fifo.c the alignment did not match the opening parenthesis. So, a few tabs were added to match the alignment to exactly where the parenthesis started.
> 

Run checkpatch on your patches.  ;)

> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/axis-fifo/axis-fifo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index dfd2b357f484..6e959224add0 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -383,7 +383,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
>  		 */
>  		mutex_lock(&fifo->read_lock);
>  		ret = wait_event_interruptible_timeout(fifo->read_queue,
> -			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> +						       ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
>  				 (read_timeout >= 0) ?
>  				  msecs_to_jiffies(read_timeout) :
>  				  MAX_SCHEDULE_TIMEOUT);

Checkpatch is just guidelines not rules.  wait_event_interruptible_timeout()
is a very long name so sometimes aligning it up with the parentheses
doesn't work very well.  The most important thing is not checkpatch but
how the code looks to humans.

regards,
dan carpenter

