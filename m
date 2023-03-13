Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DC56B7AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCMOtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCMOtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:49:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93991D508
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:48:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h14so11587206wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678718927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OC4qmyG6g1A7okZrF0ddKzxpXP8qdE3lMwHPw3wEBSI=;
        b=VXzMnqWupLPRT1hCjJjI1b7Y6hTsdzSsgGbw+sel0lZiemwL/YhxyT7Cc53dZDdcO+
         HdnfaBrzSsQ5Zj84M2h5xO/iBR2Hu00r77qBgSfkSKS5LAFHXJdkRsWNaJ9PdBkvBMwH
         Q43+17MikTk/NZvluYXKF4d85ZfJZvIC6xbvjywQvo/NYCCLH0ez4ytx54u5VFPUDdCd
         ymqrwWYPmBHlucr/X+7LCdKTRfUX7U4BkC/0c0Zq5xdG26sC/9qKoSYaG4ocQLLbIuOj
         NLTtl6/kLRt6PwHsINtx/YIwAbI5QEsubsx4lswEYnniQh0ULClpyrA+yoYlyGpeWkz8
         FSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678718927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OC4qmyG6g1A7okZrF0ddKzxpXP8qdE3lMwHPw3wEBSI=;
        b=xs9GF7Tkc1B82lVqHC0/zuaz0+NIgO+iT4TgpZei06kJXJxFyZGBsWkEHBr+m2hAkn
         NGZPYiE0FW2BJBZOS84VJ2o34XXrknJS6s6BAcypuK+I8qvp7WhgyGW137WEtL2YBO9U
         KIVW/gcSkSzg7r+HuQyxE08S8ZM4lEOmfFjUXX7B7MR99bQDU9Gf53XowVJa82CFTJms
         c9h+NKTRujdAoOVANt5wK6C1a0BG4lTRwbuKIq4cN4P/zuYB4FdkSLpwiDQehDgHwHys
         FmeAUqpLGClpmAsofkJeKaCPbC1qcbENX3P3GveHBJAnWVXnuFuG7iQK52RhVvqteLLJ
         jkBQ==
X-Gm-Message-State: AO0yUKUgCFzpk+vEU8X7yg5OyaKlxXaKBqOckZmn9qf6AmIz3RYz8Tv4
        iDS0/bgrnqzmMMC5RlGNNqglJ0Dka9iEfJsb
X-Google-Smtp-Source: AK7set/t+m87UsAPQdttnXrcdRRIwn5mONFsFczNYU9L8nIkv0Il7v9Zv/KMKO/7vWI8uw1LkD6kRw==
X-Received: by 2002:adf:ef84:0:b0:2ce:b781:b1e5 with SMTP id d4-20020adfef84000000b002ceb781b1e5mr2291713wro.19.1678718926695;
        Mon, 13 Mar 2023 07:48:46 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.45.115])
        by smtp.gmail.com with ESMTPSA id x1-20020adff641000000b002c70c99db74sm8149250wrp.86.2023.03.13.07.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 07:48:46 -0700 (PDT)
Date:   Mon, 13 Mar 2023 19:48:43 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: axis-fifo: initialize read_timeout and
 write_timeout once in probe function
Message-ID: <ZA83yzPTq+nQF9Dd@khadija-virtual-machine>
References: <ZA4M3+ZeB1Rl2fbs@khadija-virtual-machine>
 <9938109.ZD9C4EEAuf@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9938109.ZD9C4EEAuf@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 03:13:01PM +0100, Fabio M. De Francesco wrote:
> On domenica 12 marzo 2023 18:33:19 CET Khadija Kamran wrote:
> > Module parameter, read_timeout, can only be set at loading time. As it
> > can only be modified once, initialize read_timeout once in the probe
> > function.
> > As a result, only use read_timeout as the last argument in
> > wait_event_interruptible_timeout() call.
> > 
> > Same goes for write_timeout.
> > 
> 
> Nice idea... But it's not yours :-)
> 
> Therefore, you should give credit to Greg with the following tag:
> 
> Suggested-by: Greg Kroah-Hartman <...> 
> 
> Place the above-mentioned tag a line before the "Signed-off-by:" (which is 
> always the last line, whatever other tags you might need to add).
>

Hey Fabio!
Thank you for letting me know. I was confused as to where should I
mention that this change was recommended by Greg.

> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> 
> If this patch was a v4 you should have put a log right here, after the three 
> dashes, explaining what changed from one release to another, release after 
> release. Please read some other well formatted and accepted patches for real 
> world examples of how to write version logs.
> 

Okay, got it! I shouldn't have missed it.

> However, this patch is _not_ a v4 (so no version log is needed after the three 
> dashes). This is your _first_ patch that addresses Greg's suggested 
> refactoring. Therefore, just put [PATCH] in the subject line.
> 
> That inappropriate "v4" seems to explain the second error showed by the patch-
> bot. Thus, read carefully its message and ask for further explanations if 
> something is still unclear.
> 

Thank you! It is clear. I will send this again as first_patch. 

> Thanks,
> 
> Fabio
> 
> P.S.: The code looks good but I could not apply it in mainline tree. I don't 
> know whether this patch is somehow broken or the driver's files differ between 
> the most recent staging tree and mainline.
> 
> However, does it work for you on the most recent staging tree? Did you run 
> checkpatch on your own patch? (I'm also asking this question because of the 
> first error showed by the patch-bot). Can you git-reset to a previous state 
> and reapply your own patches to your local work branch?
> 

Yes,  I did run checkpatch on my patch as suggested by Dan before. It
showed errors regarding trailing white spaces. Sorry, I ignored them
thinking that they were present before in the code. I will correct them
in the next patch submission.

Also, I had one question. Is it okay to write a long subject as I have
used in this patch? 

Regards,
Khadija

> >  drivers/staging/axis-fifo/axis-fifo.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> 
> 
