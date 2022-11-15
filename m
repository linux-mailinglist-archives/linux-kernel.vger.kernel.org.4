Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F7362919D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 06:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiKOFlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 00:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiKOFlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 00:41:37 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5561E72C;
        Mon, 14 Nov 2022 21:41:36 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b21so12175150plc.9;
        Mon, 14 Nov 2022 21:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uQqRcNAhAHU0MAvKQcalM3RhDD2z13gHm2Bk2z14Kqk=;
        b=Yl2cAdhASFvQ+i7S/0GXfWmFFAtErap+Ahnjq6U5qiEBlY2F3G4GfUSfkz64Itn3Pf
         HgMHmuwQcqz8SE0fNmQSA25iISSEW3/UBgDcfwZEaY7f/CKOIvCdE6ql8fLfgKCA+bRv
         PiJ0Zqh29x4/wcLoZkulGZzzWcUXNbuO0O6L0aCuz2hiqDN3YE8A2foEcYN5sPxy19da
         Innx1z+OHUCmfbagjWYP1I3dV0Gd3bIVrGqlSuD4SCGixplofbWlxcTabaNd2tdlNitA
         CtKRBvWLHdj/FgW7DW+JxpRr69FY+sfokw4J1kaMWheDqDSN/v6YAPwnCbM36eGcU/VC
         TElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQqRcNAhAHU0MAvKQcalM3RhDD2z13gHm2Bk2z14Kqk=;
        b=VZYkgc5lMGAtxWTK4MfJhwvv8qgE8MxsHmK20NVMFaKhcYLCXqUNy65Qm7uUL96zrf
         ISZQHMV2fj87By5L4DvoneBs36JX/aHI4kKUhm6N6jlIc0+e0Mw4WWwwRLej+uYX75eS
         bsJqD/FKxo49mxf+NR383bcBR9SGdZYh/L9OZTzhxiJergcyjZMFt9TXcesj5Ln4VH8F
         59NuU+QYIELB5k2U4vcU1PUrziSLoq3FHHyInVIRVGQi7N+uviQ+SSlXY87g1YruvwvE
         vy2G5WrAzttY2ETz36TGv56e2ggt6Zyt3ZGyimIqrsgKykyYfuKvBUcNmlPr9/h9CmtM
         VDsw==
X-Gm-Message-State: ANoB5pkWwBfCedhx6P+KhWQOet2WLI9U7AowRfwRnSQS9+De8XB89GBc
        YLeC/JcKqBRjKyjk6cUo3jg=
X-Google-Smtp-Source: AA0mqf44rycjoWi/rDRu5nf/JiahIhO0HTP/5BpbvCgK2TCfeX27ZgnLEHxyPZ9x4v8DU2zEQAA93A==
X-Received: by 2002:a17:903:1306:b0:17f:7771:dde1 with SMTP id iy6-20020a170903130600b0017f7771dde1mr2574608plb.125.1668490895736;
        Mon, 14 Nov 2022 21:41:35 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:718:95ee:2678:497])
        by smtp.gmail.com with ESMTPSA id sc17-20020a17090b511100b0021828120643sm4897281pjb.45.2022.11.14.21.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 21:41:35 -0800 (PST)
Date:   Mon, 14 Nov 2022 21:41:31 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linux-input@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macintosh/mac_hid.c: don't load by default
Message-ID: <Y3Mmi8wm62c7+0zv@google.com>
References: <20221113033022.2639-1-linux@weissschuh.net>
 <Y3KJ6SOD5PEwj1oe@google.com>
 <9255deb3-6c66-444d-940d-77e721d950e5@t-8ch.de>
 <Y3LaTeMxTa/7Rv7H@google.com>
 <cf4c9402-189f-4ff7-a130-c61ccfc99a08@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf4c9402-189f-4ff7-a130-c61ccfc99a08@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 04:07:53AM +0100, Thomas Weißschuh wrote:
> On 2022-11-14 16:16-0800, Dmitry Torokhov wrote:
> > On Tue, Nov 15, 2022 at 12:54:41AM +0100, Thomas Weißschuh wrote:
> >> Cc Franz who wrote the driver originally.
> >> (I hope I got the correct one)
> >> 
> >> Hi Dmitry,
> >> 
> >> On 2022-11-14 10:33-0800, Dmitry Torokhov wrote:
> >>> On Sun, Nov 13, 2022 at 04:30:22AM +0100, Thomas Weißschuh wrote:
> >>>> There should be no need to automatically load this driver on *all*
> >>>> machines with a keyboard.
> >>>> 
> >>>> This driver is of very limited utility and has to be enabled by the user
> >>>> explicitly anyway.
> >>>> Furthermore its own header comment has deprecated it for 17 years.
> >>> 
> >>> I think if someone does not need a driver they can either not enable it
> >>> or blacklist it in /etc/modprobe.d/... There is no need to break
> >>> module loading in the kernel.
> >> 
> >> But nobody needs the driver as it is autoloaded in its current state.
> >> Without manual configuration after loading the driver does not provide any
> >> functionality.
> >> 
> >> Furthermore the autoloading should load the driver for a specific
> >> hardware/resource that it can provide additional functionality for.
> >> Right now the driver loads automatically for any system that has an input
> >> device with a key and then just does nothing.
> >> 
> >> It only wastes memory and confuses users why it is loaded.
> >> 
> >> If somebody really needs this (fringe) driver it should be on them to load it
> >> it instead of everybody else having to disable it.
> > 
> > The driver is not enabled by default, so somebody has to enable it in
> > the first place. How did you end up with it?
> 
> My distro kernel configured it to be enabled as module.

Maybe you should talk to them? Which one is this? Not all distributions
seem to enable it (Debian for example does not).

> So people who want to use it can do so. It would be nice if the rest of us
> wouldn't have to care about it.
> 
> >> Furthermore the file has the following comment since the beginning of the git
> >> history in 2005:
> >> 
> >>     Copyright (C) 2000 Franz Sirl
> >> 
> >>     This file will soon be removed in favor of an uinput userspace tool.
> > 
> > OK, that is a separate topic, if there are no users we can remove the
> > driver. Do we know if this tool ever came into existence?
> 
> One interpretation of it is attached as "mac_hid_userspace.c".
> 
> > What I do not want is to break the autoload for one single driver
> > because somebody enabled it without intending to use and now tries to
> > implement a one-off.
> 
> Is an autoloaded driver that then does not (ever) automatically provide any
> functionality not broken by definition?

No because it does not result in any regression in behavior.

> It was enabled by the distro. Which seems correct, because maybe somebody will
> use it.
> 
> Taken to an illogical extreme: If it is fine for modules to load automatically
> even if they are not useful, why not just always load all available modules?

Well, take for example a driver for a NIC. It is not really useful until
you configure it by assigning an address to the interface, etc. Should
we not automatically load drivers for NICs?

> 
> 
> Maybe we can take the removal of the autoload as a first step of deprecation
> and finally removal of the module.
> To quote you:
> 
>     "I'd rather we did not promote from drivers/macintosh to other platforms,
>      but rather removed it. The same functionality can be done from
>      userspace." [0]

I think if you talk to your distro and see if they stop enabling it and
offer your userspace utility as a replacement if they indeed need the
functionality would be the best way of deprecating the driver.

Thanks.

-- 
Dmitry
