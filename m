Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AD260B684
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiJXTCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiJXTCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:02:18 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398443FEF9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:41:35 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so4021231pji.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=42l8GlCfA9iGJtCuGhT5diZhsv8hho9/+oKxoJF8BqA=;
        b=M4eNdEZqfsAWZP20s1RqjyI+G3rxg8KHHJQXaslNHrsXm/F/k7yc+sKZlIZXxGAqEk
         pDxpy+DeEL1W3TMjSiAPBHqgFjkH52LSbGWj97b2z0RdUc7SSJql6fe4uU5/vgu8ewYT
         8dtX68KJTPbRGRJ6AEJXMEJj65W283Bv5Ojrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42l8GlCfA9iGJtCuGhT5diZhsv8hho9/+oKxoJF8BqA=;
        b=i9RNC7NJFyiFa7hHK63xzBStwmWUQXj0nYB8Mu6mD2C4UoiW9W42jRcTepI0UYNbYR
         VSSOe4K/MYOya/TwSdHRZBVNYzcuAr06dM7mvWKoVQtpoLcFocRqRnfOtmlrwLCfFPzD
         8zDQe5BUbDZCywtSSrWGYyn+1TFuCt1AeCL+UJDezMcSiR7tdNczYnFiQYbX6nhPKzXT
         tqLr5JIa9y/4eNnT8XEEdXL1uLetprEOzoeTdmgTMNGS6UUumOk4pmS8b33cIcZOvfYr
         Zc1o+Y3IuRGf3E8uOB1tn6F+eii9IF1sCACcxzBkj3WzDUuZFE4O1492OxUbiI0FsksW
         K5Ow==
X-Gm-Message-State: ACrzQf3VDL1MzdYc9rR+/ghN9xYT5DSxhbtKTDOkBQkz+UGuYWdkHVTI
        HGhRHJlxx0GqRGzD+lYrlW3GPg==
X-Google-Smtp-Source: AMsMyM40mB2G+1zkBnYLRksCl+oOuDMFr/mvetkvE6fQbzpdNEH5zR3TOhyfP+m+TfQ5UNeEpngPiQ==
X-Received: by 2002:a17:902:f54f:b0:186:a437:f4d1 with SMTP id h15-20020a170902f54f00b00186a437f4d1mr6871161plf.168.1666633145337;
        Mon, 24 Oct 2022 10:39:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090341c600b001754e086eb3sm5174ple.302.2022.10.24.10.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 10:39:04 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:39:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Message-ID: <202210241035.1487F523@keescook>
References: <20221024082610.74990-1-sakari.ailus@linux.intel.com>
 <Y1ZQSEMLkybFCadS@kroah.com>
 <Y1ZQpcdK4sdy+5QZ@kroah.com>
 <Y1ZUIEYcjQZMdSfp@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ZUIEYcjQZMdSfp@smile.fi.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 12:00:16PM +0300, Andy Shevchenko wrote:
> + Kees
> 
> On Mon, Oct 24, 2022 at 10:45:25AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Oct 24, 2022 at 10:43:52AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Oct 24, 2022 at 11:26:10AM +0300, Sakari Ailus wrote:
> > > > container_of() casts the original type to another which leads to the loss
> > > > of the const qualifier if it is not specified in the caller-provided type.
> > > > This easily leads to container_of() returning a non-const pointer to a
> > > > const struct which the C compiler does not warn about.
> 
> ...
> 
> > > >   * @type:	the type of the container struct this is embedded in.
> > > >   * @member:	the name of the member within the struct.
> > > >   *
> > > > + * WARNING: as container_of() casts the given struct to another, also the
> > 
> > Wrong function name here.
> > 
> > > > + * possible const qualifier of @ptr is lost unless it is also specified in
> > > > + * @type. This is not a problem if the containing object is not const. Use with
> > > > + * care.
> > > 
> > > Same comments here.
> > 
> > Wait, no one uses this macro, so why not just remove it entirely?
> 
> Kees, do you know why and what for we have container_of_safe()?

It looks like it was designed to handle the cases where the pointer was
ERR_OR_NULL:

       IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) : \
               ((type *)(__mptr - offsetof(type, member))); })

i.e. just pass through the NULL/ERR instead of attempting the cast,
which would fail spectacularly. :)

It seems like this version should actually be used everywhere instead of
nowhere... (i.e. just drop container_of() and rename container_of_safe()
to container_of())

-- 
Kees Cook
