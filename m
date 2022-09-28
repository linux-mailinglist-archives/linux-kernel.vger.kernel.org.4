Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA255ED56E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiI1Gx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbiI1Gx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:53:28 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFAC1F7EDF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:51:30 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id e22so342774uar.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=iwJUBnrn5tDREi3DDlfw4s0KLtXFldwy4ed5ZI3vWW4=;
        b=Ws/GTYWqUQYbCFXcIomD1ALcZMDjjXFJRUzIey1WzlB+CadeA358bEdXg0Y26Lq/Ce
         lMxm6YXaA9QE76o6xvMLx6liB7EBzcVN+HBXfD/7QFwMvdKOHvd7zmHalg2D0gC43Gzl
         49wOpVFuv+aGA69CTIUy1aGPpknKZQ6LGYN+2bxk+QkvzgS+SlwPDvu1N/9fnqAeZ7e+
         jiNiq14yn7gXcBx0H5n/JOp/lONnUusEtW89/RBZhwGl/6NH3l9liHoAfPj8PE5WCSd4
         Rpitx6aEKThCOn5om/3KcQkBaZ/iHlnjppykS+sMOYkOj5EyCLilg6R+3Z9zs20Bu1oA
         aC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=iwJUBnrn5tDREi3DDlfw4s0KLtXFldwy4ed5ZI3vWW4=;
        b=f90/1EziRKfWhG1fMP1Z7is2OfwWrq/jSMTScdhL/BqOturVBJB+JHVOKGL58kRJih
         seZHtqXlsv8rjPBvOz3Q36sTQscS85e/pew4ZwuIcXefrlGn971JTsgq9+FYUqud7LwH
         tFZp4Abvi0XG3bhOvIaDlhelmxZnQkr7+UhSyxU1ST/4760RJg38TokfuOKo4VrLt+Gh
         dbyCzvwgVKnWG1777RsEKZW7BTtH+hAlNUOYPraMnjqWrQW9rSmp8RUiS8lgbrSww6ga
         uwREq1mB+IL8hxytCmDIcHJ/gtYmIrNrJaPKEgTeiiXgw1HqdeWL3tt17QEWt+OEpZdT
         dYpQ==
X-Gm-Message-State: ACrzQf0dzc5BgWHiTRHo2qNzIMFI+jwBNyyDnkn43d0g4vjNmSk8Ootp
        dtKwQqjOa4CNn7d4bjI+k7Eco4eA/1yFlyTTfNo/Pfl6fdi7IQ==
X-Google-Smtp-Source: AMsMyM6VtkOeYlTXyhXASCv125A4HkhZNW5Pw2yUyfwQ3Fzr07m9faqyJ0KhvP38w8axeJbK9tL1x+t6NlkqMMZiy+s=
X-Received: by 2002:ab0:7a5b:0:b0:3b3:8eb9:5a25 with SMTP id
 a27-20020ab07a5b000000b003b38eb95a25mr13186139uat.55.1664347889574; Tue, 27
 Sep 2022 23:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220927063524.493591-1-sean.hong@quanta.corp-partner.google.com> <CAD=FV=WQXOTJu-YUWyBjdoq4wPrwQYoo68FCJBF7EJfdf+9SrA@mail.gmail.com>
In-Reply-To: <CAD=FV=WQXOTJu-YUWyBjdoq4wPrwQYoo68FCJBF7EJfdf+9SrA@mail.gmail.com>
From:   Sean Hong <sean.hong@quanta.corp-partner.google.com>
Date:   Wed, 28 Sep 2022 14:51:18 +0800
Message-ID: <CAP19T+6SWu_siXom4EANarqSRGif7qnkUPwhfKgjASnFnYG+cQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add BOE NT116WHM-N4C (HW: V8.1)
To:     Doug Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 11:27 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Sep 26, 2022 at 11:35 PM Sean Hong
> <sean.hong@quanta.corp-partner.google.com> wrote:
> >
> > Add support for the BOE - NT116WHM-N4C (HW: V8.1) panel.
> >
> > Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Wow, another panel?!?
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> Pushed to drm-misc:
>
> 2f24fe8c54cc drm/panel-edp: Add BOE NT116WHM-N4C (HW: V8.1)

Hi Anderson,

I found some mistakes on this commit. I typed the wrong model name on
title and content.
The correct model name is NV116WHM-N4C and the code is correct.

How can I fix it? Do I need to revert this commit and then submit a
new patch upstream?

Sean
