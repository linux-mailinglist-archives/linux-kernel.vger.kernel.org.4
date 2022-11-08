Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5757620FAA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiKHL7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiKHL7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:59:52 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9371E3E3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:59:51 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 63so11233796iov.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CXsk1mCcDSCxO8pZyOxPVPpi8Y+w18c1q2hqTt7a5PE=;
        b=WIpcMn/mwq0TzQFxTxKZt3DD2TtjK3CkAqgjRCkGCIfFkWecUeRQ5Iyv4BNNfpp/KS
         RIDQgo7f/xiAsG5wtV2nSeEQ3RYI6fv6k4Ju0dKGhl7W+IA3ZutcczXbL65E7kwFI7AK
         5yTh32v5DWwGsGdv1MPlmV/YLv3D1I5Bpp7p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXsk1mCcDSCxO8pZyOxPVPpi8Y+w18c1q2hqTt7a5PE=;
        b=xvsdLjFpJC2Ve2XGlvxNaH/LuDhX3zejGQB5jifcPMQcjWyoOasqnz/FEEDs77IoHl
         OjLBWFb5j916DJcF/7OflxarReB4KymVD9lCA7CCjIG0m8t5WsOGlxum0LY/ZD9SFNHI
         doeI2YgucLDtNJ1t280huYq4WWsd6d76ewmoH0OeS/TyV+C1KMr0JOyYk9R3fL/k2A4K
         SqmoDpFBKZc4UfvFiV0JKk9cVQuxyfhpGo84m29iojvrXwTrTrYnuNfNJ8/wzYm3S0w9
         8e/N2BZTIhLdYLUo1Nu9Rcxfae+G0CaNF2n2+ybZ6/iWTJJGxtwkrbiILqpK3M7G6Lzp
         i2OA==
X-Gm-Message-State: ACrzQf2pV2wBWuAaz4cZfAkHvpJX0IAerR1BI+DsjhDQuMoQjxAEWPhx
        eYAwGVBqOXuQJpc5Iq6kul/oU/j925vzABADWeKnhw==
X-Google-Smtp-Source: AMsMyM49MEe3AzoIi+i4+4PvEOiz9LC0kpaCPJ2sRyWMyS+fkN3Tjxe5zRXlxuOemyOSM1zOTozUqYa/WYkaU33SrHA=
X-Received: by 2002:a6b:b882:0:b0:6b7:56c3:b602 with SMTP id
 i124-20020a6bb882000000b006b756c3b602mr32443363iof.5.1667908791200; Tue, 08
 Nov 2022 03:59:51 -0800 (PST)
MIME-Version: 1.0
References: <20221027104406.549734-1-daniel.vetter@ffwll.ch>
 <87tu3n6cb2.fsf@meer.lwn.net> <CAKMK7uHXz7kteQ_sckTQx=E9cWSqGXS_Y0_pLjX2CRcApOvKRQ@mail.gmail.com>
In-Reply-To: <CAKMK7uHXz7kteQ_sckTQx=E9cWSqGXS_Y0_pLjX2CRcApOvKRQ@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 8 Nov 2022 12:59:39 +0100
Message-ID: <CAKMK7uF7riJszvbVNA2PGAxndVkA-TmzBx0uVVfYZ4L_BLaEgA@mail.gmail.com>
Subject: Re: [PATCH] docs/sphinx: More depth in the rtd sidebar toc
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 at 21:06, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Fri, 28 Oct 2022 at 20:19, Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > Daniel Vetter <daniel.vetter@ffwll.ch> writes:
> >
> > > We love to nest our documenation for good structure, but that means
> > > the table of contents needs to keep up or you can't navigate them.
> > >
> > > Realized this trying to find the drm property documentation, which
> > > with some shuffling around disappeared. Why I didn't realize we can do
> > > this earlier, no idea.
> > >
> > > Since the relevant parts of the toc are only loaded if you're in the
> > > right .html file there's no harm in going all the way to unlimited.
> > >
> > > Note that this has no impact on the classic theme (which doesn't have
> > > the sidebar) nor on the various :toctree: rendered inline in the
> > > output.
> > >
> > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: linux-doc@vger.kernel.org
> > > ---
> > >  Documentation/conf.py | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Documentation/conf.py b/Documentation/conf.py
> > > index 934727e23e0e..5dc141c66726 100644
> > > --- a/Documentation/conf.py
> > > +++ b/Documentation/conf.py
> > > @@ -240,6 +240,10 @@ if html_theme == 'sphinx_rtd_theme' or html_theme == 'sphinx_rtd_dark_mode':
> > >                  # Add color-specific RTD normal mode
> > >                  html_css_files.append('theme_rtd_colors.css')
> > >
> > > +        html_theme_options = {
> > > +            'navigation_depth': -1,
> > > +        }
> > > +
> > >      except ImportError:
> > >          html_theme = 'classic'
> >
> > So this patch isn't against docs-next, and applies to the RTD theme,
> > which is no longer the default.  I have no objection to it, but have you
> > looked at how your docs come out with the alabaster theme?
>
> [sorry took a bit longer to get back to this]
>
> Hm looks pretty, but more in a print style than using it dynamically,
> you can't really click through the sidebar toc at all to quickly find
> something, and if you're wrong, navigate up a few levels again. It's
> just the toc for exactly the local document, nothing else at all. rtd
> theme always gives you the full toc all the way up, and if you have
> epic patience could actually give you the full toc on every document
> (but that's probably not a good idea for the kernel). Do you need me
> to send the rebased version or can you smash this one in?
>
> btw on today's linux-next the sphinx.rst page isn't updated with the
> new default theme choice of alabaster. That seems to have been
> forgotten.

Sorry got confused on this and looked at the wrong tab/build output
locally, it's good. Anyway I sent out a rebased version of the rtd
patch, I do like that sidebar a lot more for navigating the docs :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
