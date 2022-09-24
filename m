Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDD55E872D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 03:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiIXB7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 21:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiIXB6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 21:58:43 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CAF109626;
        Fri, 23 Sep 2022 18:57:33 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id r20so1104505qtn.12;
        Fri, 23 Sep 2022 18:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=W7yXo6axyAl8z2FC6V/oq2jaZzURZ1wFtrSWVcqIkRg=;
        b=U4wGTsZYXeGP+7iZCTTz3iwPMpJP8JO/aAMrwsK2XBUU6K9ZPv0IRoU8/Sy/9+WS5y
         lW2EOYNpZ/gAMjQGR6wfCxa9+0c8S6hcaAYyjMSq7grz7QHyWPH6D7u4numlTAoS6oQp
         bq21SQ7E+CWNwkAtiLlDagl+oMr6zG2ULQMUZBIgElkUhKs/quDDkOwdKSHgG9N+1XvV
         QV2lwkMl5oAJx3HKM/4Wp0U9EJf/Z6FfjQ4iTC/fCR+6isNZE+B7LB6u4UGQW61AdH7I
         FEvz7E3X9AqIzfrOeCsHeRsIVnHPidMhN7PW/kuA+Yx/M9djmJu5KQKcLqZ4+FKyAzYs
         4DAQ==
X-Gm-Message-State: ACrzQf0Ugwq1WFvlQOdvjmS4nTJNdgXftjT1MD3JyWByNlZ5OPTkIgo/
        cggViBMr4IRTX36sYV41Rak=
X-Google-Smtp-Source: AMsMyM5RHaJGIIfU28oBEksoWlaUdk36kf87dnWHNDMwjsssQjqGItCdRBvROGY6WrKnw8Cfk9ghnA==
X-Received: by 2002:a05:622a:1189:b0:35b:b923:3667 with SMTP id m9-20020a05622a118900b0035bb9233667mr9476190qtk.165.1663984596797;
        Fri, 23 Sep 2022 18:56:36 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::2c58])
        by smtp.gmail.com with ESMTPSA id t3-20020a37ea03000000b006ce5ba64e30sm6812700qkj.136.2022.09.23.18.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 18:56:36 -0700 (PDT)
Date:   Fri, 23 Sep 2022 20:56:38 -0500
From:   David Vernet <void@manifault.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 0/4] Rewrite the top-level index.rst
Message-ID: <Yy5j1neMWtymRhIx@maniforge.dhcp.thefacebook.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <7f02143c-461f-268b-0f17-7fe20a7423d6@leemhuis.info>
 <875yhep5l1.fsf@meer.lwn.net>
 <aa35d204-3033-96f2-ed83-c5034067fe4b@leemhuis.info>
 <87r102nnef.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r102nnef.fsf@meer.lwn.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 09:03:36AM -0600, Jonathan Corbet wrote:
> >> I want to do it because it's a clear step forward and has already been
> >> pending for a month.  It is surely not perfect, and there will
> >> undoubtedly be changes, perhaps big ones, to come, but I cannot imagine
> >> a scenario where we want to go back to the mess we have now.
> >
> > I understand and yes, maybe it's the right thing to do; but OTOH that
> > page is a mess for quite a while already, so is it really a big problem
> > to just leave it like that for 9 or 10 more weeks while trying to bring
> > in a few more people that might be able to directly bring us on a good
> > long-term course?
> 
> I guess my feelings are that (1) I've had enough promises to help with
> documentation over the years to learn not to count on such until said
> help actually materializes, and (2) demonstrating what we can do can, I
> hope, only inspire people who know more than me to show what we *really*
> can do...

Just to throw my hat in the ring here for the discussion -- I think we
need to bear 2 things in mind:

1. Reorganizing the front page for docs is probably something that's
disproportionately susceptible to bikeshedding. I don't think that's
happening in this specific discussion, but rather, I think we have to be
cognizant to not let ourselves drown in getting 100% consensus on
something like this given that it's likely to garner a lot of subjective
opinions.  I am not trying to straw-man Thorsten's point here because I
don't think he's claiming this isn't true, but rather just point out
that it might be better to land something now that's strictly an
improvement, and then worry about perfecting it later, precisely because
otherwise we'll probably just spend forever livelocking on it.

2. I think we can all agree that what we have now, i.e. listing every
single link on the front page, is really bad. Having hundreds of links
on the front page is actively worse than having just a few, because none
of them have any meaning anymore.  Given that the index is easy to see
and click on if anyone wants to go back to "show me all the links" mode,
my perspective is that we should just land this as is, and worry about
perfecting the layout / specifics later.

Thanks,
David
