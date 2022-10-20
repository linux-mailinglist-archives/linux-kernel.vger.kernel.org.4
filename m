Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D29606179
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiJTNXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiJTNXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:23:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25E019634A;
        Thu, 20 Oct 2022 06:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8017061B33;
        Thu, 20 Oct 2022 13:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF451C433B5;
        Thu, 20 Oct 2022 13:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666271732;
        bh=IScp8MGBm9uoFQg4S2EpobrVU50THT1MSKOXcEFHkSU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k/Nir49M09ZU/CG7Q6L7m9YW4JARFAM1YN9bSlXmSaOSaWq8o9mNOCWEl+pXoxX64
         GB+SIIP2Taoz2PzpUEFqAaIYqDxxucQtLACyX3ra8WVQ8HtUW1NFDTtQdZDw3YclyM
         VFS21uUcCCN+GyJxj9CTZPw3xq1SIak6krx8FGLk6RJfW59W6Czigcz3L6KfJRERHN
         JFr8xGiNz93rvuOYlghhb4VvNVeTA02gcnQ3SpCtKPY/pMT7V2KWKYAcI1AcOXbBzL
         S7UEpzNeIzlTnHaqtUWWmA4Ap+u8MtzjtbZS56d51sMEduxouWQvgSAsaQ/mIUjnT2
         v1mYEeF3lC+tg==
Received: by mail-ua1-f50.google.com with SMTP id n5so684403uap.2;
        Thu, 20 Oct 2022 06:15:32 -0700 (PDT)
X-Gm-Message-State: ACrzQf30EJUDaBGpCn8f6pv9NoiyByNKI9Ndhnfbc0DXjM2SJhFpgD8O
        Q54lTXTl7+DvalF/htrvWLMv73xvqSqSDpW0cg==
X-Google-Smtp-Source: AMsMyM5IcnXVMGk7tBvM2Wt+JK7prp1EjA6Y62+pK4TUqA61tUKTNQZUcYgH5QyYcRKRmy1esYnKvKk8f/uoN6CtDaQ=
X-Received: by 2002:a05:6102:cd0:b0:3a9:6788:8ecc with SMTP id
 g16-20020a0561020cd000b003a967888eccmr6710540vst.0.1666271731788; Thu, 20 Oct
 2022 06:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221019130200.60460-1-yuanjilin@cdjrlc.com> <9fb4c010-b465-e908-6868-d9e493a9688f@infradead.org>
 <Y1Cm2Hvf7W7NxVzk@mit.edu>
In-Reply-To: <Y1Cm2Hvf7W7NxVzk@mit.edu>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 20 Oct 2022 08:15:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLypcBCOVZ8yYWK0J_xc2Vcr+ANrX_3v4vN55Srp4RknQ@mail.gmail.com>
Message-ID: <CAL_JsqLypcBCOVZ8yYWK0J_xc2Vcr+ANrX_3v4vN55Srp4RknQ@mail.gmail.com>
Subject: Re: [PATCH] of: fix repeated words in comments
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jilin Yuan <yuanjilin@cdjrlc.com>, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 8:39 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Oct 19, 2022 at 11:53:54AM -0700, Randy Dunlap wrote:
> >
> > On 10/19/22 06:02, Jilin Yuan wrote:
> > > Delete the redundant word 'of'.
> > >
> > > Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> > > ---
> > >  drivers/of/device.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > > index 8cefe5a7d04e..16c7e5a2a868 100644
> > > --- a/drivers/of/device.c
> > > +++ b/drivers/of/device.c
> > > @@ -19,7 +19,7 @@
> > >
> > >  /**
> > >   * of_match_device - Tell if a struct device matches an of_device_id list
> > > - * @matches: array of of device match structures to search in
> > > + * @matches: array of device match structures to search in
> >
> > Hi,
> > Rob has already explained this at least 2 times.
> >
> > The second "of" is "open firmware".
> > I would write it
> >               array of OF device match structures to search in
> > :)
>
> Actually, I'd probably do something like
>
>              array of Open Firmware (OF) device match structures...

Or just put the struct name in there: of_device_id

But at this point I prefer to just leave it alone for the
entertainment factor of how many times can I get this patch from
send-only email accts.

Rob
