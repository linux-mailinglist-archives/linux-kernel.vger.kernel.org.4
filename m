Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FB7652C55
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 06:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiLUFS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 00:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUFSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 00:18:25 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A951FCCA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:18:23 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d3so14439675plr.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SjjAILO76gwFJzalKA7C4W/3VdOviisk5FdZMxKgrAI=;
        b=XmMwTMS89CWS2BNg+zuT2zxeKpu+7qb/BqAozrzZ68VD1g+fX0BH77Z1bLBJdCFbEc
         mjrpxnMSp0tFAXcMASrKlqoiNLEiK8I90f4W4/a2PREBpBPFDrFyx8sFsW9BdcM4MuvN
         GEkXUYV+6oTd5RqPyPMwzVPLZJTxWrdloOYUaLiY0ZR7eeMKHblrA5ROnE1npa8MOido
         fTMmH39C0POyFDoV5hof4DgLk8zRt/sgh6JlM8Di+ui2x80M3uwPohfETAPKeVFUIYR8
         h6yRHxm1yL+fYvE47flJ3ceCcN5Is94heacsl4ssCpnd2booZAqntG3zCK0UahP4V3+2
         lyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjjAILO76gwFJzalKA7C4W/3VdOviisk5FdZMxKgrAI=;
        b=0+Jx+x+Uocu+DUXbhufnU3xnOeTEGBEXRLgT2q34403TChWGsH1JhA35NYK7ZkJReC
         SEQ32cXlcA75MuYAiILJqI5MGkFEW1NhZawaqXbcQ2DsifMKGVFQrvqAr3jUnadoqaLn
         8Rx72xAhBc+6YpimS+JT6RPPtJToy2NrpmEu/MsgPbBUOQX8RLsje4o/4dNVjKhKTZpV
         jlOiSN8YtQHAQR9AVBOJG6URn7yBP7PqlawbVkGEBrP3msLVqaEisKZwHAH9pE4W07H+
         zV1Wp5P9bvUF5vB2ta03xC4dLvz++rWpCRhqWlFNNTdktXdRM+cBiOpeFeq4QqCo0VwZ
         64fw==
X-Gm-Message-State: AFqh2koEm78yI4L3gpuHA4mpDxLEnvlCtJTZfUGE/tPtHRwSGsDA7xF+
        Fdw0g2wtWePz0q9WSMBVj3k=
X-Google-Smtp-Source: AMrXdXu2dESGcqpW7Q2T6BQy1ZlnHjdCa5+s4KGihXxODCx7UmJTKyb7w34ncGfoL1xYeiP85R/q7w==
X-Received: by 2002:a17:903:3307:b0:191:1fc4:5c19 with SMTP id jk7-20020a170903330700b001911fc45c19mr645584plb.48.1671599902621;
        Tue, 20 Dec 2022 21:18:22 -0800 (PST)
Received: from vernon-pc ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id bc13-20020a656d8d000000b0043c732e1536sm8973300pgb.45.2022.12.20.21.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 21:18:21 -0800 (PST)
Date:   Wed, 21 Dec 2022 13:18:10 +0800
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] maple_tree: refine mab_calc_split function
Message-ID: <Y6KWzfPrFIBh8kAj@vernon-pc>
References: <20221220142606.1698836-2-vernon2gm@gmail.com>
 <20221220142606.1698836-9-vernon2gm@gmail.com>
 <20221220150550.y5kknqwjc7q5bv75@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221220150550.y5kknqwjc7q5bv75@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 03:05:52PM +0000, Liam Howlett wrote:
> * Vernon Yang <vernon2gm@gmail.com> [221220 09:26]:
> > Invert the conditional judgment of the mid_split, to focus
> > the return statement in the last statement, which is easier
> > to understand and for better readability.
> >
> > Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
> > ---
> >  lib/maple_tree.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 16cdcf309e97..d147669fb99c 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -1882,10 +1882,9 @@ static inline int mab_calc_split(struct ma_state *mas,
> >
> >  	/* Avoid ending a node on a NULL entry */
> >  	split = mab_no_null_split(bn, split, slot_count);
> > -	if (!(*mid_split))
> > -		return split;
> >
> > -	*mid_split = mab_no_null_split(bn, *mid_split, slot_count);
> > +	if (*mid_split)
> > +		*mid_split = mab_no_null_split(bn, *mid_split, slot_count);
>
> The function is written this way because mid_split is almost always
> zero.  If you want to change this, then we should add an unlikely() to
> the if statement.
Okay，thank you very much for the suggestion, I will add
an unlikely() to the if statement.

>
> >
> >  	return split;
> >  }
> > --
> > 2.34.1
> >
> >
