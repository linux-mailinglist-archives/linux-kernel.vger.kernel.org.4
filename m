Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8E4652C52
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 06:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiLUFO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 00:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLUFOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 00:14:55 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B811AF1D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:14:54 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v23so9374631pju.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=58KPHzr5CDwAEkwIK5uh0Ypn+WKmBYyNXwDDK5i4gXQ=;
        b=M1Oddl2gOUYbTrW4XB8DG47MMPushgPON4TF1M7LHhxcESU1HF6DYc3ehQ9/sSZYb4
         VJ6SWVm06ro9wP7cEsBDXRC9m3FU7SBGVrn5gavydEyoJcl6m6NXVkOatc7KqNSBlPtp
         sDucdUbphnxPNxzzfWLfhCihtg43VQ++VhRjPBbCIS4AuZb5oe3kt/At9Xi80pOiTGsj
         Lu8BPcdD/cCXGOQictIf5oSN9Ch4rnDb/IwWqgUD1O/JzScQuaxspiK4xEOa7UBOi091
         o/pRllQj1H+Pz1BN7DTn4Ylh4B91Wm0TOdDxUmNpb1ckscS/gLu6ERYXTCniMra8VqgS
         HmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58KPHzr5CDwAEkwIK5uh0Ypn+WKmBYyNXwDDK5i4gXQ=;
        b=fY+gB7DBbhKIjt7XR5NmFRqiT2p01nD+oi+RPN5rendKlXi7VbVvp0Eq6SRkN2GbWk
         RwKBHigx6r7pJxUUvtOa9obtbM0t6sZ1NaUjnJZM89EQBGFAAwByL65B/fiRQkkxHaCW
         YEB7fW/+I5i+AG+ndPcbZnZzuNc/+sfqSl7NtCkppyxOZQOwOWoPgfdl+Mdnm9Y64oKK
         G2mc7CvW0aAh9lMvvvgvd4p45b0yuu5cRRc5rvGCiMZ0ypnj517t48edLbvGk/6sFBRi
         DNiWGnXCHRO410l1tlDK62xrOYksx4AJKyrenDe1Pvjt55YTbVrCIuw5GNfOIuQ3+Mes
         quQA==
X-Gm-Message-State: AFqh2koLjnXxaZ9TMuTE7FZMHCNoDZABSsT+eN/ZLQLqUrIePWUBy3iN
        ooxE/1rWpoiQfqy/JrtMXdOtVn8f4XjYLNKR
X-Google-Smtp-Source: AMrXdXvv4OT1+XTFELG23gnsrUFM3riOp0HUS6LR7fuyRYoEazUkZB3ssZV2lapXKDi8/9vURCYC1A==
X-Received: by 2002:a05:6a20:cb44:b0:af:e129:cc4 with SMTP id hd4-20020a056a20cb4400b000afe1290cc4mr991565pzb.41.1671599693593;
        Tue, 20 Dec 2022 21:14:53 -0800 (PST)
Received: from vernon-pc ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id b3-20020a636703000000b004768b74f208sm9248045pgc.4.2022.12.20.21.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 21:14:53 -0800 (PST)
Date:   Wed, 21 Dec 2022 13:14:48 +0800
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] maple_tree: change return type of mas_commit_b_node()
Message-ID: <Y6KWSLm2AqpqqfW7@vernon-pc>
References: <20221220142606.1698836-2-vernon2gm@gmail.com>
 <20221220142606.1698836-7-vernon2gm@gmail.com>
 <20221220150310.kfzx5paymtaepbxk@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220150310.kfzx5paymtaepbxk@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 03:03:36PM +0000, Liam Howlett wrote:
> * Vernon Yang <vernon2gm@gmail.com> [221220 09:26]:
> > The return value of mas_commit_b_node() function represents whether
> > the submit b_node is successful, and can only be false and true, so
> > the return value type is bool is more appropriate and for better
> > readability.
> >
> > Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
> > ---
> >  lib/maple_tree.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index b3a215dd961e..e7dde4a1d6cb 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -3578,7 +3578,7 @@ static inline bool mas_reuse_node(struct ma_wr_state *wr_mas,
> >   * @b_node: The maple big node
> >   * @end: The end of the data.
> >   */
> > -static inline int mas_commit_b_node(struct ma_wr_state *wr_mas,
> > +static inline bool mas_commit_b_node(struct ma_wr_state *wr_mas,
> >  			    struct maple_big_node *b_node, unsigned char end)
>
> mas_commit_b_node() can also return the ints from mas_split() and
> mas_rebalance().  I'm fine with changing the return, but it seems odd to
> only half-change it?
Oh, sorry, I forgot to changes the return value type of the mas_split()
and mas_rebalance()

>
> Initially I had a different intention for the return type of int, but it
> seems the return isn't used at all from this function.  We should
> just change mas_commit_b_node(), mas_split(), and mas_rebalance() to
> return type void if we're going to clean it up.
Yes, the return isn't used at all from this function, have noticed.

Initially, I also wanted to change the return type void, but these
functions have an error condition that returns early, so I'm more
inclined to have an error value return so that it's clearer and
for better readable.

en... I temporarily remove this patch 6

>
> >  {
> >  	struct maple_node *node;
> > @@ -3598,7 +3598,7 @@ static inline int mas_commit_b_node(struct ma_wr_state *wr_mas,
> >
> >  	mas_node_count(wr_mas->mas, 1);
> >  	if (mas_is_err(wr_mas->mas))
> > -		return 0;
> > +		return false;
> >
> >  	node = mas_pop_node(wr_mas->mas);
> >  	node->parent = mas_mn(wr_mas->mas)->parent;
> > @@ -3607,7 +3607,7 @@ static inline int mas_commit_b_node(struct ma_wr_state *wr_mas,
> >  	mas_replace(wr_mas->mas, false);
> >  reuse_node:
> >  	mas_update_gap(wr_mas->mas);
> > -	return 1;
> > +	return true;
> >  }
> >
> >  /*
> > --
> > 2.34.1
> >
> >
