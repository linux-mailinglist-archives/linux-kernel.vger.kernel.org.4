Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA8E68AFE2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 14:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBENN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 08:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBENNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 08:13:55 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319011E9C4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 05:13:52 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id lu11so27300025ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 05:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aAV86lpCX+u26K5XZAjhYf5FiCuKhNuED87tlvkY6Tg=;
        b=b/vokj8lDb3c4dYSm34QdRQG2RPQZQjO0O1B5Qibthn028/GLvPdh3OAbqdFIxuCdp
         Oo5H7+oIRI3pNXZKTzNL2iOrLH2mWIAqPeFh9BAZg1VJf4ek9uecaYvrXFZM8ar6rwtB
         7ZfWvyAMjt+cmggSxVC4HFnbacYGQE07ggcjSoRomkHXzL8TBVBwfKUPRQRU/ozBFqzT
         lAAwa7tl8ryE1XnIQ9GEmjfay+fgo6y0hthL46Shp3FD1iEFvaIQ9Gtgcu3D05lAbMp0
         8JtpwhRVwDKJnOcA5nO4Qn5dRNedvzDHZFHOY6Sn0RSHCdWXj07EWcZWRJaggPu5+GZg
         joTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAV86lpCX+u26K5XZAjhYf5FiCuKhNuED87tlvkY6Tg=;
        b=ea8KygK7ZX/2h7y1KZtIoFZDp7DrqCWRmCbGKqzZPW+XDNbmL1A9yiROEhhYXU4Qwq
         woR/YYzy0PIV84EDjiqeI8ZH1ZUXKNzssv8131A6cmoXHwl7EIhUrnq86PCfP1iSJTZ+
         ECyS0RVVACBHutlgfT/0E2R8fQMI4nXurS6rxGKJVB3O09LZ8IW/khQhvbUvxLqBdj++
         xUaJdQhJZkk5097RhtFmo5WwdlqCmuJJE/yvxWA7dWCVJ3N5V+jyRrSB2m07HrEbQIMP
         Vsfa8diVf1Wjc56UaNFjamrb0Pzhjt/UXf2AmmjZC9+UwQhEwcGISSkLYkjepI9lFx6V
         woCA==
X-Gm-Message-State: AO0yUKWXn+BMn5st0mUMZXW1ULfxQDRmWn0MA263IxSUZGHu4xLHscfk
        U5bWKzO3HGFzsqKAGgvoHX4=
X-Google-Smtp-Source: AK7set8xhGaxIXS/MfoUZ2h0ybw9PMBFgrb5iXsBqeFtDZNMoa42se2Syk14SRIKcsmhMYg29fn+eQ==
X-Received: by 2002:a17:907:2c49:b0:887:2248:efd5 with SMTP id hf9-20020a1709072c4900b008872248efd5mr17932986ejc.77.1675602830806;
        Sun, 05 Feb 2023 05:13:50 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id t13-20020a170906268d00b00888fddc4eb2sm4054438ejc.164.2023.02.05.05.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 05:13:50 -0800 (PST)
Date:   Sun, 5 Feb 2023 14:13:48 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Regarding checkpatch camelcase issues
Message-ID: <Y9+rjLfHsKvcUi5l@combine-ThinkPad-S1-Yoga>
References: <Y93eQqaYdL146Z65@combine-ThinkPad-S1-Yoga>
 <Y94L+WNGGfvrg6Mg@debian.me>
 <Y97uUeB6OfO469SY@combine-ThinkPad-S1-Yoga>
 <Y98wHhGMY1eSaWG1@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y98wHhGMY1eSaWG1@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 09:57:10AM +0530, Deepak R Varma wrote:
> On Sun, Feb 05, 2023 at 12:46:25AM +0100, Guru Mehar Rachaputi wrote:
> > On Sat, Feb 04, 2023 at 02:40:41PM +0700, Bagas Sanjaya wrote:
> > > On Sat, Feb 04, 2023 at 05:25:38AM +0100, Guru Mehar Rachaputi wrote:
> > > > Thanks for your support.
> > > > 
> > > > I wanted to confirm if each checkpatch encounter for camelcase issue should
> > > > be fixed in a new patch?
> > > > 
> > > > For example: If the issue is with same variable, then multiple
> > > > modifications can be made in one patch.
> > > > 
> > > >   -> above example is OK
> > > > 
> > > > 
> > > > For example: If the issue is with multiple variables, then multiple
> > > > modifications can be made in one patch.
> > > > 
> > > >   -> above example is NOT OK / NG
> > > > 
> > > > 
> > > > Please confirm me if my understanding is correct?
> > > > 
> > > 
> > > I guess you have generated a patch series, then check it through
> > > checkpatch.
> > > 
> > > Indeed, if checkpatch complains at a particular patch, you need to do
> > > interactive rebase. Make sure that rebase todo list contains "edit"
> > > lines on commit you want to fix up. After that, fix these complaints.
> > > 
> > > When you're done, regenerate the patch series and make sure that there
> > > are no checkpatch complains on it.
> > > 
> > > Thanks.
> > > 
> > > -- 
> > > An old man doll... just what I always wanted! - Clara
> > 
> > Thanks for the reply
> > I guess I was not clear. When I run checkpatch on a driver there
> > were so many camelcase issues in each file. So I wanted to know if I
> > proceed to fix them, should I submit each change as a patch or each file
> > as a patch?
> > Since each file has many camelcase issue and the driver has morethan one
> > such file.
> 
> Hi Guru,
> You can look at similar change proposals from other developers here[1]. That should help
> you understand how it was done previously. This resource is very useful to
> determine if the change you are proposing was already submit by another
> developer and the feedback on it. In general, it is a great resource to learn.
> 
> You should also look at the guidelines on how to design your patch, number of
> changes, when to use a patch set etc at this location[2]. This page has more
> additional links to resources that are useful to understand how to submit
> patches. Check these links [3] & [4].
> 
> 
> [1] https://lore.kernel.org/?q=&a=search+all+inboxes
> [2] https://kernelnewbies.org/Outreachyfirstpatch
> [3] https://kernelnewbies.org/PatchPhilosophy
> [4] https://elixir.bootlin.com/linux/latest/source/Documentation/process/coding-style.rst
> 
> Hope this helps.
> 
> Regards,
> deepak
> 
> > 
> > -- 
> > Thanks & Regards,
> > Guru
> > 
> 
> 

Thanks for the references deepak.
This should help.

-- 
Thanks & Regards,
Guru
