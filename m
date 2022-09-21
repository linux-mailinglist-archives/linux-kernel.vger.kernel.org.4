Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C1C5BFD6A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIUL6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiIUL6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:58:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66D48990E;
        Wed, 21 Sep 2022 04:58:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g3so9421431wrq.13;
        Wed, 21 Sep 2022 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=P27Y5lUNfZ7QZWtRCwkrTDcmKMqlHIANJ0MotPQjiEs=;
        b=dgr6YCQwcHeXd5iOWWBIqorY8wBjMJ0gzw33j3doaIWGrQBASdWXZHT2fkgGBW4TUm
         EdE1isctHm3GpVBqcedYVW2tyxIv8H+mptnvwBpLYZ+MQzVeEEhV5jBS4YIR7aUvnrCe
         gRgwEpFyyHm04rc6WlP2aKwNmMtLpN+m6IN3YNV5iYLWciyBkE0rsUfwiA9WSwi+WmVU
         SoQ1A2elh49ooEVMlguZXPAlBKuVDYdH7gX8EVfFgQMdXCw2/d3N0+jAiMvp6U0VpPpa
         bTCLGiWLSVLw9tMU6zpaJsU6JL07+h4PQZf6+hDnzMzq5/zbAwGWRqANEQ25Ur4HEPPl
         CPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=P27Y5lUNfZ7QZWtRCwkrTDcmKMqlHIANJ0MotPQjiEs=;
        b=ix+8yq3S2dzQPKrZW81lmCGdaM8fLT5NQP3e2ItW0Njrqn/3EISHBPYcvC5rnQVude
         V8IdRHfvUVzFCImKsfujdskyTTacjd/HjxCWhGQRCe88A71wDRWfebvmw4ovwI72B1Fi
         BeqUl7pSqXHRcj8yOb3NpZnVXGvQNgIOSChcYM53sPUzOJR+lkFgafKU4+ZzrbBXZFaW
         YbS5Y+gpVZTLph3BTcbzbF6mPMgf7O4xKjGWgOaXsF1+x8rY6IKI/Qnz71rVlimHU63O
         VtfQqgRniRxXlg+3dV3+doASEdwuSu0Z81oKgdTQZRZ+w3qF42hbghBj/UY/jDGluKjf
         to6w==
X-Gm-Message-State: ACrzQf1Zb2uB9kSQ+AlZ55INj56HuujrHr3a+7OzA04pw8BOnuqkIvqa
        iVFXOfufcG7ie+xR+YadbA==
X-Google-Smtp-Source: AMsMyM4InPsyXgV58TSSswAvBZC8zzNmUpb2iU3z6Xux8JNeV3UtYQ1s0xOGEQeVXBEkqwkNVKlUNg==
X-Received: by 2002:a5d:65ce:0:b0:228:d8b6:d1 with SMTP id e14-20020a5d65ce000000b00228d8b600d1mr16875565wrw.486.1663761513228;
        Wed, 21 Sep 2022 04:58:33 -0700 (PDT)
Received: from octinomon ([2a00:23c8:8808:201:d598:e127:5cb:e430])
        by smtp.gmail.com with ESMTPSA id v130-20020a1cac88000000b003a63a3b55c3sm2646145wme.14.2022.09.21.04.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:58:32 -0700 (PDT)
Date:   Wed, 21 Sep 2022 12:58:28 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Elana.Copperman@mobileye.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Subject: Re: [tip: perf/core] perf/core: Convert snprintf() to scnprintf()
Message-ID: <Yyr8ZHxjXddYbHhj@octinomon>
References: <166374773592.401.16831946846027095231.tip-bot2@tip-bot2>
 <YyrMmyUPk+4t6OLm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyrMmyUPk+4t6OLm@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 10:34:35AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 21, 2022 at 08:08:55AM -0000, tip-bot2 for Jules Irenge wrote:
> > The following commit has been merged into the perf/core branch of tip:
> > 
> > Commit-ID:     678739d622ae7b75b62d550858b6bf104c43e2df
> > Gitweb:        https://git.kernel.org/tip/678739d622ae7b75b62d550858b6bf104c43e2df
> > Author:        Jules Irenge <jbi.octave@gmail.com>
> > AuthorDate:    Sun, 18 Sep 2022 00:41:08 +01:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Wed, 21 Sep 2022 10:01:20 +02:00
> > 
> > perf/core: Convert snprintf() to scnprintf()
> > 
> > Coccinelle reports a warning:
> > 
> >     WARNING: use scnprintf or sprintf
> > 
> > Adding to that, there has also been some slow migration from snprintf to scnprintf.
> > 
> > This LWN article explains the rationale for this change:
> > 
> >     https: //lwn.net/Articles/69419/
> > 
> > No change in behavior.
> > 
> > [ mingo: Improved the changelog. ]
> 
> And yet, at this point I still have no clue what's wrong with
> snprintf(). So not much improvement :/
> 
> As such I'm still very much against this patch.

Hi Peter,

Thanks for the feedback,

My bad, I am still a newbie. I will try to improve on my changelog next time.

But I have learned that the difference is as Ingo pointed out:

snprintf return the length of the buffer to be written with assumption it all fits in the destination array
while scnprintf return the actual length that fit in the destination array(eg. buf below).

This is just by precaution or safety in mind in case the PAGE - 1 is
overun.

I did some digging and came up with a code like this for the corner
case.

#define BUFSIZE 4
static int __init my_init(void)
{
        char buf[BUFSIZE];
        int x,y;
        
	x = snprintf(buf, BUFSIZE, "Linux"); // length is 5 here : return length of expected to be written when the BUFFSIZE is 4
        pr_info(" With length %d, The string is %s\n", x, buf);

        y = scnprintf(buf, BUFSIZE, "Linux"); //length is 3 : return length of what is actually written to buff
	pr_info(" With length %d, The string is %s\n", y, buf);

        return 0;
}


I appreciate any comment as I am on learning journey.

Thank you,
Jules



