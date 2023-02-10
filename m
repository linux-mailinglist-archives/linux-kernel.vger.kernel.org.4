Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FCA6928EB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjBJVHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjBJVHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:07:32 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA667CC92
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:07:32 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id c2so7338306qtw.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V8uBq1ZauDk7QYH9jbR4OgSbivcLQSOg6mx25pZOGUA=;
        b=h5+vogX+yVY1368kGDybI1xNnLGCQvGWlDcQ98ck2YVr6Sm0HNNdhdKsptyX9xWtiu
         ZZevfmvPemHKVXeYYBaiciYgZevaeExd27dpmfoeoaRftyFJgA1IcISDC+PmZqx8ijGP
         VDmQ3pt1PE1dfHdkrriv5DlfG4yt3cmvRTj94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8uBq1ZauDk7QYH9jbR4OgSbivcLQSOg6mx25pZOGUA=;
        b=oJ5j7joyPfQ3JjIUgdOkKwMoMcSJe0H2G5fdgDAefrlWPn/p8qLyhu+mJgpEfq22fh
         GEqfYi2HZQZ/Su7sgrmfoFulr30WCuAImKRdEkDy+79tTeyGkMm/P20ZtuUaBNa948Kv
         Fhz8NAPlCowiBobTqhzualZBBv0EpQa6ReKmnlVHuYasMrXCm6mglDcDXI3arrJzyqTM
         /Rj0gAxg3jlYXL/iDWSVdJRw2Nevh2n5cj6Eg1nsegXLVw45llWCdt/ZrnRf3sUtmM0m
         EbvFvb2yMeC7IKiaCdn7h3MMLYALJW3fL09E/9FFVxWzZQnMsnnoEGUG7wkXzXVy6sMG
         91NA==
X-Gm-Message-State: AO0yUKU0kXgElwM2BSm/HqsjtR1M+aEIVWF0bs5XRK0TKOvIR8jyW5Ks
        5DKIzbdOoKRcfEK0J5Os3wb4v5yXdBe6FVqU
X-Google-Smtp-Source: AK7set9bqw4f3N9X7w+83larwtCUiNA29Ni5P5++h6aVoFLLp70sK1gVioWYL3Ab/XoPTAgQi30hUw==
X-Received: by 2002:a05:622a:12:b0:3bb:801b:c3cc with SMTP id x18-20020a05622a001200b003bb801bc3ccmr14832431qtw.1.1676063251116;
        Fri, 10 Feb 2023 13:07:31 -0800 (PST)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id q185-20020ae9dcc2000000b0073a37f5d496sm20112qkf.128.2023.02.10.13.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 13:07:30 -0800 (PST)
Date:   Fri, 10 Feb 2023 16:07:28 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "elana.copperman@mobileye.com" <elana.copperman@mobileye.com>
Subject: Re: Removing the deprecated htmldocs for good?
Message-ID: <20230210210728.5zontxigmtqippta@nitro.local>
References: <CAKXUXMw-Tg7WcfVHaWZ-sK+WFnedL+S-jA_UnsdTR=HFwxAXSw@mail.gmail.com>
 <87wnjm9iba.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wnjm9iba.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 09:19:21AM -0700, Jonathan Corbet wrote:
> > While scanning through the internet for kernel documentation, I
> > stumbled upon the old deprecated htmldocs under
> > https://www.kernel.org/doc/htmldocs/. I see that on
> > https://www.kernel.org/doc/, we already point out that 'htmldocs -
> > Kernel Documentation in docbook format (deprecated).' is deprecated.
> > If I am not mistaken, all the content from htmldocs has now been
> > transformed into .rst and has potentially evolved further and hence
> > all relevant information should also already be available somewhere in
> > https://www.kernel.org/doc/html/latest/.
> >
> > Is it now time to delete the content under
> > https://www.kernel.org/doc/htmldocs/ for good?
> 
> I think that time may have come, yes; perhaps just have it redirect to
> https://www.kernel.org/doc/html/latest/ instead?

I'm going through my backlog (of which I have lots) and I finally got around
to making this change. Requesting https://www.kernel.org/doc/htmldocs/ should
now send you to the archives site, and it's gone from the listing in
www.kernel.org/doc.

-K
