Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E181651F41
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiLTKwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiLTKv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:51:56 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4609186C1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:51:54 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id m4so11880975pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3J2t6zleCgSaKLgdwsyrOWk3vUr6ggb3hDwqkO8Hsk8=;
        b=yhJTjcPyEVStYIqzGKgu5LXSn6WS+0vwVkXG5oR+b5ML6XrciGesuHKBApFAUcmCJu
         txkw4JXcbHCIoLUnNMFU2YIdYzn5/KFH1sb8CCCqkUon43LmuU5k2pSPdezzgcJwlweU
         4W6Kw1T9xr4KiyydwA0f5BpuH/neWa8SYEi+ko/Ggm5qkaJSRYcilX/d4sSFHgDw/fkx
         wb5jwMoypxD2HdtVZQYt/2AjuOgKZ9HKoK6H2hUOcRD+kROH+DryZzmyHAGTsjTdw/0Y
         MMxiZvZoQzyT0tTZk/S6MBKHavCvMM2AAAny+UkoJ7hxBSx6Ju/x/tS9qerbsTGm6fz3
         NhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3J2t6zleCgSaKLgdwsyrOWk3vUr6ggb3hDwqkO8Hsk8=;
        b=KXif6RuqwvumhRwy86KiN2o2IzuVznBA3bJFl/xqHiHT1LmzMsPiAP7PoPtKqsrXuo
         DitwBMo6wimG+FS2P7eZpiQaIZtsXU95Jy0JRCzdztvZPzwjU8uJGhmDxHsogN1K4a+Y
         FxwAJ7LvLKZ2I+JvioPAlhwnfkfHZRVX34kPYgM3pdHPIGwQseRz8RBwCVBwVzaVRovw
         Ad7WJqAZdUcENIcpmvUKH4ACECKiOvoD4xBjEGfqzPonv9g0pri5n5WdMe+DDA3ZTF9R
         kJFalQrZywszQIDmiuPYyd4iSqFNWCmM4bMQQMiU+OsuB24UoS8KjlWBpn6d6UousmIc
         ys7g==
X-Gm-Message-State: AFqh2kp+8C2WefaBB0SMesbkit4D7HSx/8EyyY1qeFQGRGLfi0cr6mHE
        O9Cu8d2qG+o9LXiz7fyGIpIc/epCBu72+Q3j3kt19A==
X-Google-Smtp-Source: AMrXdXsbMmZ+abZvthKeUcE6S5KJ0Nw21C9lu75JjjhYsXq0C550qP+sb4SA09XW0kDvRbpGa0qljFkuavCHYUa5urw=
X-Received: by 2002:a17:903:25c5:b0:191:4149:2800 with SMTP id
 jc5-20020a17090325c500b0019141492800mr208plb.3.1671533514185; Tue, 20 Dec
 2022 02:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20221024094853.2877441-1-yulei.sh@bytedance.com>
 <HK0PR06MB32022348EA65805C7109B7D080329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <CAGm54UExHOBw61DJNqxvW67OSr60fQ+Q247t63RzymiMOmHmFg@mail.gmail.com>
 <HK0PR06MB320203EF8E3AD14C34359B0580329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Y1ueEYJk2epT/g4J@kroah.com> <HK0PR06MB32024F58191E17DC5ABC99F380329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Y1uyssu84kl1INSR@kroah.com>
In-Reply-To: <Y1uyssu84kl1INSR@kroah.com>
From:   Lei Yu <yulei.sh@bytedance.com>
Date:   Tue, 20 Dec 2022 18:51:42 +0800
Message-ID: <CAGm54UGmp=kTKGLhEfENF4SqkvRt_GcpuGH_g5PjtQiBkwtOsA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: aspeed: fix buffer overflow
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neal Liu <neal_liu@aspeedtech.com>
Cc:     Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Henry Tian <tianxiaofeng@bytedance.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 6:45 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 28, 2022 at 09:55:57AM +0000, Neal Liu wrote:
> > > > > > Thanks for your feedback.
> > > > > > I tried to reproduce it on my side, and it cannot be reproduce it.
> > > > > > Here are my test sequences:
> > > > > > 1. emulate one of the vhub port to usb ethernet through Linux
> > > > > > gadget
> > > > > > (ncm)
> > > > >
> > > > > We are using rndis instead of ncm.
> > > > >
> > > > > > 2. connect BMC vhub to Host
> > > > > > 3. BMC & Host can ping each other (both usb eth dev default mtu is
> > > > > > 1500) 4. Set BMC mtu to 1000 (Host OS cannot set usb eth dev mtu
> > > > > > to 2000, it's maxmtu is 1500)
> > > > >
> > > > > Not sure if it's related, but in my case (USB rndis, Debian 10 OS)
> > > > > it should be able to set MTU to 2000.
> > > >
> > > > Using rndis is able to set MTU to 2000, and the issue can be reproduced.

USB ecm is also tested and it is possible to set MTU to 2000, and
could reproduce the issue.
So I think this patch is needed anyway.

@Neal Liu Could you kindly help to verify the USB ECM case?

> > >
> > > Please NEVER use rndis anymore.  I need to go just delete that driver from
> > > the tree.
> > >
> > > It is insecure-by-design and will cause any system that runs it to be instantly
> > > compromised and it can not be fixed.  Never trust it.
> > >
> > > Even for data throughput tests, I wouldn't trust it as it does odd things with
> > > packet sizes as you show here.
> >
> > Thanks for the info, Greg.
> > If rndis will no longer be supported, how to use usb-ethernet on Windows OS?
> > For my understanding, ncm/ecm cannot work on Windows OS.
>
> rndis should ONLY be there for Windows XP, which is long out-of-support.
> Newer versions of windows have more sane usb protocols built into it and
> this driver is not needed.
>
> As proof of this, Android devices removed this from their kernel
> configuration a few years ago and no one has complained :)
>
> thanks,
>
> greg k-h
