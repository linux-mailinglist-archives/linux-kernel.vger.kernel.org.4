Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D4B61FF21
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiKGUHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiKGUHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:07:08 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21D321829
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:07:06 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id n191so9798311iod.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8hV5ZSh2seubDdRrNeUCchubOhAcqvi4PJAb4HdDdB0=;
        b=XFhq0Xs1jn9mlb/AMwxtrT0VkUmekAjemvzCWhPsc1Ud0+riFpyDUOqaiMwrJeA3Z6
         YwvXvpSGLpp5GbahQ7vv81j2ecpKUXWI0A0BSqH60uAjtpy68h6e/ejR+/LIKk93mcTa
         jO+VPdm7g7f7628BIvfrcFqI2yT5xKpz+qHCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hV5ZSh2seubDdRrNeUCchubOhAcqvi4PJAb4HdDdB0=;
        b=QLZZAS0Qe+9jOoT14tNa7Y/CrOPmo7/nOJv8Ses2BkbHMD86rfI8iLgq9CZUedgYT8
         zinevYMxf5iIF5lL2Q/tnr2vygRMCs2zsH+1SAOUWo78jet2/p5X3T3qPafvB0P9ftj8
         fXbzMoguP8UMjAQJJxXoWjSJoSRvdak8XPrAzZIUaU6RmkCF29Y8ZLPvtWJDOI1aF3aH
         kHgpzbIo6vnigGOgZKO4ikuUuiDv+ANwp7OY/Ay5rnZGVe4DIHtNDR0rnccqAoEVU2LP
         /G1B11dstKdcSdtSeJslshvgSG1k7bscxc3E3cDDuVDSJc4Py5dRpC09SBufjXfFJebQ
         f8EQ==
X-Gm-Message-State: ACrzQf1Eu8mnf69ydHwNs0PRFvy6nGBPMdcS6uTg+HySLxW0V09M64nQ
        71Z3HCWidd1TTAiTFl4Ute5kpnQov2Mzj4GM1uSX1w==
X-Google-Smtp-Source: AMsMyM766uk95+uCyh+ZkJmMUM61FCimR1/A3TW5Hx+jV3LnaGnqApC2gedZ+O3jgliaPdRUfL3HL1UMwKMghdeC55E=
X-Received: by 2002:a05:6638:e8a:b0:374:f6c5:cff6 with SMTP id
 p10-20020a0566380e8a00b00374f6c5cff6mr31358868jas.187.1667851626098; Mon, 07
 Nov 2022 12:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20221027104406.549734-1-daniel.vetter@ffwll.ch> <87tu3n6cb2.fsf@meer.lwn.net>
In-Reply-To: <87tu3n6cb2.fsf@meer.lwn.net>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 7 Nov 2022 21:06:54 +0100
Message-ID: <CAKMK7uHXz7kteQ_sckTQx=E9cWSqGXS_Y0_pLjX2CRcApOvKRQ@mail.gmail.com>
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

On Fri, 28 Oct 2022 at 20:19, Jonathan Corbet <corbet@lwn.net> wrote:
>
> Daniel Vetter <daniel.vetter@ffwll.ch> writes:
>
> > We love to nest our documenation for good structure, but that means
> > the table of contents needs to keep up or you can't navigate them.
> >
> > Realized this trying to find the drm property documentation, which
> > with some shuffling around disappeared. Why I didn't realize we can do
> > this earlier, no idea.
> >
> > Since the relevant parts of the toc are only loaded if you're in the
> > right .html file there's no harm in going all the way to unlimited.
> >
> > Note that this has no impact on the classic theme (which doesn't have
> > the sidebar) nor on the various :toctree: rendered inline in the
> > output.
> >
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org
> > ---
> >  Documentation/conf.py | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/conf.py b/Documentation/conf.py
> > index 934727e23e0e..5dc141c66726 100644
> > --- a/Documentation/conf.py
> > +++ b/Documentation/conf.py
> > @@ -240,6 +240,10 @@ if html_theme == 'sphinx_rtd_theme' or html_theme == 'sphinx_rtd_dark_mode':
> >                  # Add color-specific RTD normal mode
> >                  html_css_files.append('theme_rtd_colors.css')
> >
> > +        html_theme_options = {
> > +            'navigation_depth': -1,
> > +        }
> > +
> >      except ImportError:
> >          html_theme = 'classic'
>
> So this patch isn't against docs-next, and applies to the RTD theme,
> which is no longer the default.  I have no objection to it, but have you
> looked at how your docs come out with the alabaster theme?

[sorry took a bit longer to get back to this]

Hm looks pretty, but more in a print style than using it dynamically,
you can't really click through the sidebar toc at all to quickly find
something, and if you're wrong, navigate up a few levels again. It's
just the toc for exactly the local document, nothing else at all. rtd
theme always gives you the full toc all the way up, and if you have
epic patience could actually give you the full toc on every document
(but that's probably not a good idea for the kernel). Do you need me
to send the rebased version or can you smash this one in?

btw on today's linux-next the sphinx.rst page isn't updated with the
new default theme choice of alabaster. That seems to have been
forgotten.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
