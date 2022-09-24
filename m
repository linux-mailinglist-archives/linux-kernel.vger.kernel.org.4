Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1B05E86EB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 03:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiIXBHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 21:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiIXBH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 21:07:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1544132D4C;
        Fri, 23 Sep 2022 18:07:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v2so1379231edc.7;
        Fri, 23 Sep 2022 18:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xcDTvjZ0q27K7CTovDd27RZ5rVcQpUYfL5Oluu9qcWk=;
        b=ZHMM35zmDsoNcviYlaumSdDZ66s1ggrM42M2jAbkiXjURn+xZMQP0xB7lqAsAz/UMC
         iI0gEsnrYBsg/gTWf0sD9HBDcinPcCP34tUdJ09Lpd3EOnBUOliCsuruM7NBkfwwiYcd
         uRQblFg9bQgFczhbTw9NMHE8SxbLV1gndAclmItIJJ4lX03CXK+WrDLtR0OF/W3hpMCA
         P7Cs5Yld5yNwyfuf/UMyb5kE7ftBcvmFG3L2N7qoubjDsmGWAMbu09GoC0R4k8gwdQ2W
         qc6ahMhI9sBoGcp6sy1yhG530TCVJMUvtgslkiiBG3cDCPJwjLNVOlyzKK3AY4wfsJBI
         xqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xcDTvjZ0q27K7CTovDd27RZ5rVcQpUYfL5Oluu9qcWk=;
        b=pksj/x+mxOXwZ0SvbAE0YpOr8MXW4uBv2kwi32dAUKrIK9vZvMrhJWm2cp2IEaVUb5
         CrjHfcJED9Y/WdkNJAWoevquSKVfT+ZMo46P7PtZ2TSz/H6nL1MPYfKq3QRszMv/w9MB
         pssJ3BFZySJr7YRDeoV/rJM3GdKUeovBEMedXi3Ul+oRbR5tT20tWPItNr/VyE9Mzv9l
         ne6RoTiVpY5JMvv8KiRxwvFEsSTc+dysHv5cCBzhhsrpwTIkmZ6RilRtpaMW8T5cNzJv
         rWV9kfdrjrDiY42IoqgsPDo7ktn5TJKJnqHu8npzMAkvulrY8hypn16OTRbiXL7VsAg6
         Xd5A==
X-Gm-Message-State: ACrzQf0Kdkj3h+WE4L+8kTwcVr7/l7ff1R4rl1o5CNvTq7wE/WdUCH0Q
        wMirhY1I3xNONJ7SFxa5Sl+ENO9rwKKtvU2VkP8=
X-Google-Smtp-Source: AMsMyM6r+ddKU2IOMFiBvjgbAnyXFSkValEp0ui7PmPGKCBOeQQTfkBzFc5wo3uv6Vp5IHtFSvY3Bn82moqC3MdYIkk=
X-Received: by 2002:a05:6402:27ca:b0:451:7b58:1b01 with SMTP id
 c10-20020a05640227ca00b004517b581b01mr11476263ede.61.1663981644987; Fri, 23
 Sep 2022 18:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com> <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
 <Yy3iAHLlS2emAmWn@smile.fi.intel.com> <CAHQ1cqHWZeVHp6QmsDw5bjVq=nknRVG5iETB0n4fMMLWginbLg@mail.gmail.com>
 <ec9cc2c9-733c-4e72-b61f-d2ab3bf7a99b@app.fastmail.com> <Yy4Bw+jqDxshX4Dg@smile.fi.intel.com>
In-Reply-To: <Yy4Bw+jqDxshX4Dg@smile.fi.intel.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 23 Sep 2022 18:07:13 -0700
Message-ID: <CAHQ1cqHO+EWJP0TV2EQzrcqq=20dqagC-ThrTYQurKrWuZYnvQ@mail.gmail.com>
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon is present
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ferry Toth <fntoth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
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

On Fri, Sep 23, 2022 at 11:58 AM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> +Stephen to help to realize what the mess we have now...
>
> On Fri, Sep 23, 2022 at 08:35:13PM +0200, Sven Peter wrote:
> > On Fri, Sep 23, 2022, at 20:23, Andrey Smirnov wrote:
> > > On Fri, Sep 23, 2022 at 9:42 AM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > >>
> > >> On Thu, Sep 22, 2022 at 04:32:55PM -0700, Andrey Smirnov wrote:
> > >> > On Thu, Sep 22, 2022 at 3:23 AM Ferry Toth <fntoth@gmail.com> wrote:
> > >> > > On 22-09-2022 12:08, Andy Shevchenko wrote:
> > >> > > On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
> > >>
> > >> FYI: For now I sent a revert, but if we got a solution quicker we always
> > >> can choose the course of actions.
> > >>
> > >
> > > I think we have another problem. This patch happened in parallel to mine
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc6&id=ab7aa2866d295438dc60522f85c5421c6b4f1507
> > >
> > > so my changes didn't have that fix in mind and I think your revert
> > > will not preserve that fix. Can you update your revert to take care of
> > > that too, please?
> > >
> > > I'm really confused how the above commit could be followed up by:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/dwc3/drd.c?h=v6.0-rc6&id=0f01017191384e3962fa31520a9fd9846c3d352f
> > >
> > > the diffs in dwc3_drd_init seem contradictory
> >
> > I noticed this a while ago when I finally rebased the M1 USB3 PHY WIP branch
> > and have been meaning to send a fix. Then life unfortunately got in the way and
> > I completely forgot about it again.
> >
> > Both patches were sent at approximately the same time and I think got merged into
> > two separate branches. The conflict resolution [1] then went bad but I didn't notice
> > until weeks later :(
>
> Folks, I have no idea what you are talking about. Can you check that revert
> series [2] gets your change still in? Because I have no clue how it's involved at
> all into discussion.
>
> > [1] https://lore.kernel.org/lkml/20220426150842.473be40e@canb.auug.org.au/
>
> [2]: https://lore.kernel.org/linux-usb/20220923163051.36288-1-andriy.shevchenko@linux.intel.com/
>

Here's Sven's diff:

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index b60b5f7b6dff4..8cad9e7d33687 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -584,16 +584,15 @@ int dwc3_drd_init(struct dwc3 *dwc)
{
int ret, irq;
+ if (ROLE_SWITCH &&
+ device_property_read_bool(dwc->dev, "usb-role-switch"))
+ return dwc3_setup_role_switch(dwc);
+
dwc->edev = dwc3_get_extcon(dwc);
if (IS_ERR(dwc->edev))
return PTR_ERR(dwc->edev);
- if (ROLE_SWITCH &&
- device_property_read_bool(dwc->dev, "usb-role-switch")) {
- ret = dwc3_setup_role_switch(dwc);
- if (ret < 0)
- return ret;
- } else if (dwc->edev) {
+ if (dwc->edev) {


Here's your revert of my patch:

@@ -538,6 +584,10 @@ int dwc3_drd_init(struct dwc3 *dwc)
 {
        int ret, irq;

+       dwc->edev = dwc3_get_extcon(dwc);
+       if (IS_ERR(dwc->edev))
+               return PTR_ERR(dwc->edev);
+
        if (ROLE_SWITCH &&
            device_property_read_bool(dwc->dev, "usb-role-switch"))
                return dwc3_setup_role_switch(dwc);


There's an order of operations difference. Dwc3_get_extcon() Needs to
be happening after if (ROLE_SWITCH
