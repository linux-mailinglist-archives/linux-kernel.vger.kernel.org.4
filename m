Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA8468AE85
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 07:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBEG2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 01:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBEG17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 01:27:59 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65335FFB
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 22:27:54 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id r8so9192807pls.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 22:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w5uhpcMM1cFhPo+XgCsUpJVUPPR6aW7pgEp9reAaVU8=;
        b=AynH3mL+FV8+h6KaIJjFdI8qpck5IDz+rpwSGr4b4ttYaUENp7lKIo2Dr1d0mHv+/3
         5Z2jMYohASKwSF9UuuLTJxIERb6RU+cjR3OXBDj59+CxBm8VIQUw1xopgVqjnXBTLYxJ
         bAECeywrxHN0jcjnVVbIEmH6fmToMoKuF/RRjYGHmZBT3fBXYa/7dG7ex1yuwzjyiuwc
         eoUMdjhWTns9zC2yaG+7rjxB+gLL58L3QA8+DD9iDhWxcYJIL8kamolCdoNuZEXg8WIq
         u+t6Wfvbi/ALo7b8Q6mvrnKYNRITOGnLqvf0gyaK5sZzNv/M/gE6bpUqfs6iGYgm3alU
         xiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5uhpcMM1cFhPo+XgCsUpJVUPPR6aW7pgEp9reAaVU8=;
        b=adtSHNb74RpFAUoT+0F66IX7fYgUgEEuSRpulbUkX8n1NXb8YmFuq1dtI9Mn1k3ENR
         2d7+qNfKNUg8+QGvy4N0pd8Mlxg5T9OVkGU2shfPEWfz53IrzAoI8/s6QMPCWm/0wtLs
         Rh90lru3t644XhKlGr9j80Oz/b/AVZ0Jj4lXeeYC4IGKEy57y4NzTYAw0fsSqZRnhC3g
         FcJQt/82xYOu2sWylL5xz+ui79wFNrCzXLnAFi9tGIG84D1aCF1FQeQbGpPd7peZN5pn
         Lf+d9yzRJZ9LMVFzgSEN1x1mTfC4I+5sQ+Jbrc3vG70t0T6vpLxfE+QCqH/BZn0vGEMw
         EJxw==
X-Gm-Message-State: AO0yUKXCwsgpNJxccgE5mhsgac+2sXvwQPm9cuupdzewry3Z9QiAd0ic
        68O9j9CiT1LZxxEc+oFmoMAI9rObU6TLt/X+Hgc=
X-Google-Smtp-Source: AK7set+8L7fjL9SpblBdOh9YhbnuXshulzQmopTEsFohzmZAk93SllAf2dQYneXMCiJ8KSVSU/hRB1/2EfB+s5P0JFU=
X-Received: by 2002:a17:902:e74c:b0:196:1951:3fb7 with SMTP id
 p12-20020a170902e74c00b0019619513fb7mr3665353plf.1.1675578473894; Sat, 04 Feb
 2023 22:27:53 -0800 (PST)
MIME-Version: 1.0
References: <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com> <c6c4787f-f0c6-7285-f782-d36bd86b1e01@amd.com>
 <96e41e6d-bec9-f8cf-22ed-1fa5d9022238@amd.com> <Y8FAFAwB9gBzQXQG@kroah.com>
 <314489f6-cb54-fb3b-6557-d69b1284fa4d@amd.com> <Y8GFYEnIy0Wbh/n6@kroah.com>
 <Y8HPw2t+TbdXa83C@mit.edu> <20230114071412.GB5088@1wt.eu> <Y8JnHyKNTHMjsHSb@kroah.com>
In-Reply-To: <Y8JnHyKNTHMjsHSb@kroah.com>
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date:   Sun, 5 Feb 2023 01:27:42 -0500
Message-ID: <CAB=otbS2uwfm0+YHMXXY3TM94V82LtxgcBXGZq1Zxbvd36Wkug@mail.gmail.com>
Subject: Re: Reg the next LTS kernel (6.1?)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, "Theodore Ts'o" <tytso@mit.edu>,
        Michal Simek <michal.simek@amd.com>,
        Kris Chaplin <kris.chaplin@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 3:31 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jan 14, 2023 at 08:14:12AM +0100, Willy Tarreau wrote:
> > On Fri, Jan 13, 2023 at 04:40:19PM -0500, Theodore Ts'o wrote:
> > > On Fri, Jan 13, 2023 at 05:22:56PM +0100, Greg KH wrote:
> > > > > I am just saying that developers/driver owners can simple do calculation to
> > > > > identify LTS version. When they know it they also know time when their
> > > > > deadline is for upstreaming work. It means if patch is accepted between
> > > > > 6.0-r1 and 6.0-rc5/6 they know that it will get to 6.1 merge window.
> > > >
> > > > That is what I am afraid of and if it causes problems I will purposfully
> > > > pick the previous release.  This has happened in the past and is never
> > > > an excuse to get anything merged.  Code gets merged when it is ready,
> > > > not based on a LTS release.
> > >
> > > This is probably the best reason not to preannounce when the LTS
> > > release will be ahead of time --- because it can be abused by
> > > developers who try to get not-ready-for-prime-time features into what
> > > they think will be the LTS kernel, with the result that the last
> > > release of the year could be utterly unsitable for that perpose.
> >
> > We know this risk exists but since Greg never makes promises on any
> > version, it remains reasonable.
>
> I have to _not_ make promises because in the past when I did, people
> threw crap into the kernel with the "justification" that they had to get
> it in this specific kernel because it was going to be the LTS one.
>
> We can't have nice things, because people abuse it :(

So, is there a final decision taken on what will be our next LTS?
Went through https://kernel.org/category/releases.html but it still shows
v5.15 as the latest LTS version.

Thanks,
Ruslan
