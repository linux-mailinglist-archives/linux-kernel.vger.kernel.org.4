Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8C3691DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjBJLNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjBJLN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:13:27 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD20C72DEE;
        Fri, 10 Feb 2023 03:12:56 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id g18so5265886qtb.6;
        Fri, 10 Feb 2023 03:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hyp8ZmbrcaG2ABsoThk0gEpJR9SiIpSS9II2WcwajGc=;
        b=f8QxVlEI4ckz8hH+Kkatx5E3WtW9JYGgmYgFj1GWpc1YkcBkPHER7me0S/MTAYqSFM
         ixsYKKg7nX4YBuQF9yDfrwZ6gEgxyu3y4vKYfwBGWBioawJqhfaS4bkyoMt7bN0rKF0A
         rxL4KAIRvRLe8iWu2HiJJt1TohtwJu8uM3BUoNuY2LYRpisj+iRH8sVS+3XzB94Tv2D+
         mIhIvCt2Lc1nbE1IYmZeFLGt446ZIDhNPUMojoSWYFMQBNAr0MQ15j6htFehCOn89fFy
         TNhl7H2QhkBA0G2ibkYjsBL2KN+cJPgPpJj84/Caa0VFD91yDwcMnClRHT5aEv4BluC4
         NdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyp8ZmbrcaG2ABsoThk0gEpJR9SiIpSS9II2WcwajGc=;
        b=RQr6eJ/2TBi9lP+Fu5h4euW8GwttFC3KvxD7pAZtDZ1pi99NucFNWTLY4V2tIBTau0
         jEKAF5UkEjUh+Wd6eFUm9hsmoiGAnqy37AHeHLu93kNSL+pdXUyEqQS6nvJjhAdv+KO6
         /wWv3h4u5UHQ3ujVukC99YYTXTslxUg5lhgUXeVU1VHnpWgtF1o9awSk5KtmvPYlPFOq
         XoQ+vwE1nTmW0YSbjANUrtAlY4HWBQehhMpcXxj7UJmAZg7rHDOcv/aMj+4qpmwsozQR
         peqjdK2LN7e7ylKud8aMICHRthsj2n/KQIKJgIn2W51XasTJSrZm4iPPwM8oGkJ9wIHR
         HmsQ==
X-Gm-Message-State: AO0yUKWV/u4RuAQABmjLk3lugqoiW4YrpgHBOGOBDBGj45AJOuRO7/dv
        AAvyix16HWe27NMrt5KRLGkr5cHOdW1Kd4WZQH8=
X-Google-Smtp-Source: AK7set/P6I/oQ7XCsnc8nl7vtWaYchdN/on5pNFGQ+JfZpvZcD5o+v20X+ZhePgHGyOUBRrrQpJpsE/fYjKyo8Y0XqQ=
X-Received: by 2002:a05:622a:1456:b0:3b9:a4ee:be1c with SMTP id
 v22-20020a05622a145600b003b9a4eebe1cmr2236798qtx.391.1676027562850; Fri, 10
 Feb 2023 03:12:42 -0800 (PST)
MIME-Version: 1.0
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <CAHp75VcPPDTmpx9jpu3ZoaVH_xBgtaEbDQcJJdqcaXi1J+_q0A@mail.gmail.com>
 <57D52CFB-228D-4071-94CB-D32883BF872A@live.com> <20230210214737.2ef942c6@redecorated-mbp>
In-Reply-To: <20230210214737.2ef942c6@redecorated-mbp>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Feb 2023 13:12:06 +0200
Message-ID: <CAHp75VcccQZb+HadJunXmtCR0j--rnkbe-_FW3DHeU+H5F92mg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Touch Bar and Keyboard backlight driver for Intel Macs
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     Aditya Garg <gargaditya08@live.com>,
        Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
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

On Fri, Feb 10, 2023 at 12:47 PM Orlando Chamberlain
<orlandoch.dev@gmail.com> wrote:
> On Fri, 10 Feb 2023 10:41:07 +0000
> Aditya Garg <gargaditya08@live.com> wrote:

...

> > > Quick observation. Do you miss the Co-developed-by: tags in the
> > > patches?
> >
> > Most of the changes are minor in the 1st and 2nd patch, we haven't
> > changed most of the code. The changes were written as per the
> > documentation given in
> > https://www.kernel.org/doc/html/latest/maintainer/modifying-patches.html
> >
> > Do you think a Co-developed-by is still required?
> >
> > The third patch was actually written by 2 people, so there is a
> > Co-developed-by there.
> >
>
> To add onto this, for patches 1 and 2, as we haven't been able to
> contact the original author (Ronald), I think the only ways we are
> allowed to make changes are either doing them in separate patches, or
> with the [name <email>: changes] tags. For the latter I thought you had
> to do a Signed-off-by after it, but given the changes aren't just to
> make the patch apply on a newer version, do you think the
> Co-developed-by tag is also needed?

I'm not insisting, just asking :-) So, if you think it's not needed, fine to me!

-- 
With Best Regards,
Andy Shevchenko
