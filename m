Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F661FDC9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiKGSne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiKGSnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:43:31 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2161103
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:43:28 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 136so7362619pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/yoRrsDL4rjZUsiXxqy6NkYQLHd5ebMM1o8RAy5KU7k=;
        b=Esfsrl296DK0gl8bWsolF/ZyGX0HPlftAEWIoja/4VX/5Q6Kcx1dlwnI5YXcw55HQP
         RXXZ9jJcIW+a7KYCQyZ9OE8qexU2K0Rz/STr7a0eVefP+Uhg6arVNVzfK17vesBxIsZf
         9xVhEy4I+4Gm4qroCe+CNKqgak+NCJAvddY8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yoRrsDL4rjZUsiXxqy6NkYQLHd5ebMM1o8RAy5KU7k=;
        b=7PedQwCey0HRDGkY5EzgjHDpwsCiOR/mw8P59szdhEccLrT4qs2TP9HetHM9fIA1T0
         Lbgp4rjDuebou7hUlzW/ry10Pqaqx6Ja64EbljSkR0SACczwgSOMHMsW8TKie3e9rInT
         iaZlmFZSfDHdj4ogmiED3ECRoLKmZAEpsHRwbo71G0/78M+OZTXYEettDkGndcA9b+q5
         H0X5HiQg4fqEsu9ehkD30RY/uYD1NGlQlw6WxUDehcLOae39Cbga/TJN9jo2mVDXtPbA
         K0EsLTCRLmzkjevnpBfGVoYfxGCSBewWIpbNOQdPYN/ehvx52Wj8nBlFEgMuWNIukDBz
         dK3Q==
X-Gm-Message-State: ACrzQf3C0UtiF99vAMFifYTxdoQb4tM8sSIpkxNysXB/0NE9amFSSa3x
        XrdGlGNl/wdxEBYKXZf5xLUuF94P+VmmFQ==
X-Google-Smtp-Source: AMsMyM6yChQWYKpAtbO+7zeewKfoDFVnyGxrSjwIQdBDQSRkdNEgjBuzANqV1JdZxPpYLgulSyxraw==
X-Received: by 2002:a65:5a8b:0:b0:470:2ecd:ea02 with SMTP id c11-20020a655a8b000000b004702ecdea02mr18896335pgt.83.1667846607613;
        Mon, 07 Nov 2022 10:43:27 -0800 (PST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com. [209.85.210.176])
        by smtp.gmail.com with ESMTPSA id ij22-20020a170902ab5600b0017f36638010sm5259437plb.276.2022.11.07.10.43.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 10:43:27 -0800 (PST)
Received: by mail-pf1-f176.google.com with SMTP id i3so11436098pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:43:27 -0800 (PST)
X-Received: by 2002:aa7:8d17:0:b0:560:485a:e242 with SMTP id
 j23-20020aa78d17000000b00560485ae242mr51617419pfe.31.1667846178911; Mon, 07
 Nov 2022 10:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20220929161917.2348231-1-rrangel@chromium.org>
 <20220929093200.v6.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
 <CAJZ5v0izHjb8vE0ALyYo9yMOExdpCzG8f7-d5SpQnftqJfTEig@mail.gmail.com>
 <CAHQZ30CJyhPK-OriZ5NZ=GjwNbofaCW6GZ_CvPsL0WiJGsxs-Q@mail.gmail.com>
 <CAJZ5v0gcJRoMSODbTevRdK1zaEZHJcPxvG6XMy9-T_jvwxPFBw@mail.gmail.com>
 <CAHQZ30CQd-0YnQgYG_OJVWn9_aUjvDAuT_DRGsxQF-q+bjr5BA@mail.gmail.com>
 <YzYowYJpRTImmg4m@google.com> <CAJZ5v0i+QYcMuqsK9y6qy9qzJdUp503Sidr1e4V_ROyumLKCsw@mail.gmail.com>
 <YzcqdTxLMF5028yz@smile.fi.intel.com> <YzcthIfnpi8E6XVk@google.com>
 <CAJZ5v0iKXWBGYPmmg9__g3oHK2GhY+xFMnSA6c5KctOv2kTfNQ@mail.gmail.com> <CAHQZ30D0NmVytkmiVYYZdGMEOChsO93hYRrG6SNbFiRO4S=YGA@mail.gmail.com>
In-Reply-To: <CAHQZ30D0NmVytkmiVYYZdGMEOChsO93hYRrG6SNbFiRO4S=YGA@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 7 Nov 2022 11:36:07 -0700
X-Gmail-Original-Message-ID: <CAHQZ30D-vBHQG9tDXy_upKHzfFMA9ttUT72K4hqKNS+CtEek3w@mail.gmail.com>
Message-ID: <CAHQZ30D-vBHQG9tDXy_upKHzfFMA9ttUT72K4hqKNS+CtEek3w@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] ACPI: resources: Add wake_capable parameter to acpi_dev_irq_flags
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Terry Bowman <terry.bowman@amd.com>, Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Alexis Savery <asavery@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 8:53 AM Raul Rangel <rrangel@chromium.org> wrote:
>
> On Sat, Oct 15, 2022 at 10:56 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Sep 30, 2022 at 7:55 PM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > On Fri, Sep 30, 2022 at 08:42:13PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Sep 30, 2022 at 07:13:37PM +0200, Rafael J. Wysocki wrote:
> > > > > On Fri, Sep 30, 2022 at 1:22 AM Dmitry Torokhov
> > > > > <dmitry.torokhov@gmail.com> wrote:
> > > >
> > > > ...
> > > >
> > > > > I think that patches [5-8/13] from this series are significant
> > > > > framework changes, so it would make sense to route them via the ACPI
> > > > > tree.
> > > > >
> > > > > If this is fine with everybody, I will queue them up for merging into
> > > > > 6.1 (probably in the second half of the upcoming merge window).
> > > >
> > > > I believe it's fine from GPIO ACPI perspective (there shouldn't be conflict,
> > > > but if you wish you always may take this PR [1] to your tree (it's already in
> > > > GPIO tree pending v6.1), it may be considered as immutable tag.
> > > >
> > > > [1]: https://lore.kernel.org/linux-gpio/Yym%2Fj+Y9MBOIhWtK@black.fi.intel.com/
> > >
> > > Yeah, having an immutable branch hanging off 6.0-rcN would be awesome -
> > > I could pull it and this would avoid any potential conflicts later.
> >
> > This material is in the mainline now, but the branch is still there in
> > case you need it:
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  acpi-wakeup
> >
> > It won't be necessary any more after 6.1-rc1 is out, though, I suppose.
>

>
> Awesome, thanks for merging in the ACPI patches!

Dmitry,
 What are the next steps to getting the I2C patches landed? Should I
push out a new series that's rebased on 6.1-rc1?
