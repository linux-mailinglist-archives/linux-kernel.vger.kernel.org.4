Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D6362E232
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbiKQQo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiKQQoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:44:25 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DE32F65E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:44:24 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id t14so2095927vsr.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WBFWV6bJTjR54bCf66QrQ4IGcYOkIHSW11fHj/DCmJQ=;
        b=bEg0NyqvTO5C9GT3UhrmRML4hA67vSwaOw3rVSCMtYca6qiMhYT+Jse7iR4MaGeozr
         Hw1/JxxT/r/Z5NlJtx6r1j2zBQ6Ya9K7IhXsc5NDelIKzEuumFDEbOTcDeu8FcAtRIYm
         B3RL2s3JauD6EQW1qSQzROdidjWDKhR1/rmlKNBGC+ehwWGRgFzpmUw+xdiHku0mH2TY
         gEqIfiQljSxs7YQr7gSjylgeYG0NKdY7LHirz5Y9C2zbphBWvXlhtPUulHT6wEz1V8dR
         6ezlAnygA5yyrbHktqr+oIGylcdhZwLXe/cUUl2PuvaF7sZXt4xl1rvQP7c7Kp90RnuW
         gssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBFWV6bJTjR54bCf66QrQ4IGcYOkIHSW11fHj/DCmJQ=;
        b=pmL/qjdOexm84AQmJ7e9DERdnuNDrCqlJYKpYtr5o+l6uETz6pctj+J7fTK4jNeKuK
         qy7+0gtLdnqN1RZL92DP6TRtQZdEjXllDyYUHnzn6Mea2jxCAJ02lcM65Ew0sRTrZWtl
         noWsQWh+M1RMY3M9BZ18sOJ53rq+BtBQsksvxuxqFfSpNefuerimrsHs9AagZ0BzP979
         kFFsrQRSKprTRVVfkrLMuEiHeNhAL6sjerQj2iZRx+mFOXvbHVJB4uC1eOgtE4DyhYGw
         SGtEYJ0h1WDWmdeaoPwODLH74ifwSdEOZgh0lfFLNrEPMJinpo7xQ/ixcJ2uuRrbQlRl
         +44A==
X-Gm-Message-State: ANoB5pkwkeCgXzJ5O5yQaJSvDmFN9gK0vnA0rshnpT93lvakm7XQheFS
        sMan5Q/fXVi0oZPjMf0fEWGawk0qUPOtGWmjUaCFBL7RiQKgqg==
X-Google-Smtp-Source: AA0mqf6lm3kdCV6xaP/UO+zCdWXHkz1ZN8535dZaMbLkneJ8flM9oAqRqaGVAlp+esdMhYweh+g7uakcw3qAQ/+Usf4=
X-Received: by 2002:a05:6102:240e:b0:3aa:fc1:ad40 with SMTP id
 j14-20020a056102240e00b003aa0fc1ad40mr2260496vsi.23.1668703463666; Thu, 17
 Nov 2022 08:44:23 -0800 (PST)
MIME-Version: 1.0
References: <Y20+PqtF+dFAe7hX@kroah.com> <20221117002022.860237-1-jim.cromie@gmail.com>
 <20221117002022.860237-2-jim.cromie@gmail.com> <Y3XU59mj80wvTD6Y@kroah.com>
In-Reply-To: <Y3XU59mj80wvTD6Y@kroah.com>
From:   jim.cromie@gmail.com
Date:   Thu, 17 Nov 2022 09:43:57 -0700
Message-ID: <CAJfuBxzPGL2dP6fSV9XGLS=+yqu0YxJXUS+SAmjwKfm+6WkbyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vmlinux.lds.h: fix BOUNDED_SECTION_(PRE|POST)_LABEL macros
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org
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

On Wed, Nov 16, 2022 at 11:30 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 16, 2022 at 05:20:21PM -0700, Jim Cromie wrote:
> > commit foo added BOUNDED_SECTION_(PRE|POST)_LABEL macros,
> > encapsulating the basic boilerplate to: KEEP/pack records into a
> > section, and to mark the begin and end of the section with
> > linker-symbols.
> >
> > But it tried to do extra, adding KEEP(*(.gnu.linkonce.##_sec_)) to
> > optionally reserve a header record in front of the data.  It wrongly
> > placed the KEEP after the linker-symbol starting the section,
> > so if a header was added, it would wind up in the data.
> >
> > Putting the KEEP in the "correct" place proved brittle, and too clever
> > by half.  The obvious safe fix is to remove the KEEP, and provide
> > separate macros to do the extra work.
> >
> > While here, the macro var-names: _s_, _e_ are nearly invisible, change
> > them to more obvious names: _BEGIN_, _END_
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
>
> This change fails to apply to my driver-core-next tree.  Are you sure it
> is correct?
>

meh - it seems I missed a failure of a  git commit --amend,
since im sure I edited a fixes: tag into this commit-msg
or something :-/

I'll send an update shortly,  heres the HEAD of it:

b8b7f5a7a624 (HEAD -> bounded-5) vmlinux.lds.h: add HEADERED_SECTION_* macros
d712ed004b64 vmlinux.lds.h: fix BOUNDED_SECTION_(PRE|POST)_LABEL macros
f613facc82cf (driver-core/driver-core-testing,
driver-core/driver-core-next) mfd: vexpress-sysreg: Fix resource
compound literal assignments
2f465b921bb8 vmlinux.lds.h: place optional header space in BOUNDED_SECTION
9b351be25360 vmlinux.lds.h: add BOUNDED_SECTION* macros


> confused,
>
> greg k-h
