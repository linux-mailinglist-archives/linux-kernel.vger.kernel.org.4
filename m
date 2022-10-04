Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E0A5F4919
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJDSN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 14:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJDSNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:13:55 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89644F672
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 11:13:54 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id e20so8500676qts.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=fO/JpHdHbnnGpQX04F/Oau78NLCRz1vfsBMEmZ0J96s=;
        b=BW6Bo4ze8wD19cbDxt8TiUs9VLD1QqH9rpg3o/xgk1nPXJNcmTYJ64Rd6cDFQywsTL
         9tGXIi++p5a+JHI0WzU183a9PAyucjUtwyfM2w6CJuW3Ek28NYppARmlAE5D3+6SdDhp
         TNuq+7V6DGg/ZMrezLHgoUCs9CGAMXQ1iy/Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=fO/JpHdHbnnGpQX04F/Oau78NLCRz1vfsBMEmZ0J96s=;
        b=fM4atZpFxo2uaixIefgxBuiqPnhmlVk9rwE/yOeSK9X+T/Zo5NZfjeJ2xGDCmxvF9F
         qhnDw/9wT/KNHwZEtJAixDfqdewzvS3ifN3J2ipe3ijtW9X0dOQz/B2ugJXW9P1KTDJP
         q30RAgUWas/aGmmU/4XO+6LvxmVy64c+TOFRqVNKsHsX6QNqmfodFZu8dOA2XKuzp15S
         QyKdXG6mOaIGE4pXCHiJPX7SdCZeQytlwmABZ9B8ijQIEgB7lErOOEBeXfqfECktbBVf
         EYTIj9h2njGNq4zIpwAw2oWqCv7dR/r4Vwig6yTkjitzGA4GkvSPLUCjey8m0Y6Grpwj
         cfFQ==
X-Gm-Message-State: ACrzQf3qTRM4PVhSdjYleg4ODXww1U25Icy7eX8HMnIjDxI3eLe3yMXk
        PdMx13vLix+pODYUtnvvbT0BQw==
X-Google-Smtp-Source: AMsMyM5JEAqaJhIKfRWcIEj6aYLtImfVjjElMtuKTwbwOWUWhsy7eLLseBrc+agUN30m1MLSUppbdQ==
X-Received: by 2002:a05:622a:1146:b0:35b:afe8:5c9c with SMTP id f6-20020a05622a114600b0035bafe85c9cmr20301900qty.54.1664907233859;
        Tue, 04 Oct 2022 11:13:53 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id x188-20020a3795c5000000b006bad7a2964fsm14192403qkd.78.2022.10.04.11.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 11:13:53 -0700 (PDT)
Date:   Tue, 4 Oct 2022 14:13:51 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        ksummit <ksummit@lists.linux.dev>, workflows@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <20221004181351.qyvu42ytkka3ep3m@meerkat.local>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <20221004175354.bfvg3vhfqch35ib5@meerkat.local>
 <Yzx1T05Ut0of55KY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yzx1T05Ut0of55KY@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 08:02:55PM +0200, Greg KH wrote:
> On Tue, Oct 04, 2022 at 01:53:54PM -0400, Konstantin Ryabitsev wrote:
> > As I have stated multiple times, the hard part will be keeping a team of
> > people who are willing to do the bug triage work, but maybe we can start with
> > Greg KH using his intern funds to hire someone (assuming he's not already
> > using these funds for someone to help him with all the other tasks).
> 
> I have no interns anymore, and the ones that the LF does have in the
> kernel program are using all of the remaining budget that we have, so
> much so that we have a whole bunch of unpaid ones at the same time as we
> have so many people applying for the process.
> 
> So I don't think you can use those funds, they are all spoken for,
> sorry.


Yeah, I wasn't actually serious about the interns. An effort like this needs
to have a separate fund allocation that can't be cannibalized for any other
purpose.

-K
[Fixing the ksummit address]
