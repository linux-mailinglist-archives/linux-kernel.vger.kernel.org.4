Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB985FCC18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJLUer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJLUeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:34:44 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F37726C6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:34:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l4so17311686plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RWLS2zNmieKOsxC1XL1cG5sTXnTxdPokhdiGwrdRjtI=;
        b=FUqh8yx3C7H1syIKJ+pei3UGKenBwTM/mUKJ/0IEkd64LGSIRtE07MDeUg1LV7sBV4
         AI2MD5ZhzXtMGW3WASwz1+0ScTpJtVarcrZQvK0ekGrHy9E1HkHKRl0I8F9snuPqAVmj
         c20lE+0cMBsMwPvuCiZPg2QzENg6Qu27AA8hT7zBiRoo7h55Y//A39emLtj0efUEDnIp
         Jg2SZKpE9esjKUCW0o9e/V/055mWBeL4mOuXxB3R0BALZYg0iCJBXvtQyA7HD9UpVK3n
         hz85Xmc6T1o/KZ4mbwtSlsEmc30p4Ju03XkOn/0OHqq2zEM/YJaUPTrQYjgyJgYRb739
         zqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWLS2zNmieKOsxC1XL1cG5sTXnTxdPokhdiGwrdRjtI=;
        b=A5rb3ikf/ZJovBknQYWWr+iCdCrGUpaxOY/ck967y3XXeVe+bAQ9UdgJBY0E4mLzE/
         t0OQ1ypGGM7198o/+X8O1/lqf3euSB3qkqiJWR3/cKeeVf/Edi7XPraAJzDyFe5grbyt
         yS/HcwEB24uqqKxO8LIjeZsJ0rVa+sRefULcVEToAIl0osjdeWd8uj2UomnANSPjP0dv
         M4yz9696ullCHAisyTtHvDItgRXMaGN9I++y6STCQR6xztWlEaXH8+YnIi7JR4ZZlLT1
         IfV/lvBhCG2lmds5CfCTakGAUCkJ443Fem45f9CLBUX5Flis+m5SBBbddqVnBepV3tXl
         T9UQ==
X-Gm-Message-State: ACrzQf2kAf3B24QgBT89ow6lJKT/ZmBTh0KuG+iJ3FnKFr3bYEt2w1UD
        qdXutvoTC4mwryciDd+Jrjk=
X-Google-Smtp-Source: AMsMyM49pT77A7mxwVaiZ8MDvAzJww6ZJoKyXbRP/NnV0qPP2O/r0zjhh9iHYT5DTObvxzzU91oNaw==
X-Received: by 2002:a17:902:c943:b0:182:f5af:40c5 with SMTP id i3-20020a170902c94300b00182f5af40c5mr14901508pla.72.1665606882732;
        Wed, 12 Oct 2022 13:34:42 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d4c1:686c:5489:5df9])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b00178acc7ef16sm10904901plk.253.2022.10.12.13.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 13:34:42 -0700 (PDT)
Date:   Wed, 12 Oct 2022 13:34:38 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC/PATCH] backlight: hx8357: prepare to conversion to gpiod API
Message-ID: <Y0ck3jopU+Z74xqn@google.com>
References: <YzN6A9Y20Ea1LdEz@google.com>
 <CACRpkdZF9TVA3+3pgjqm_cnhfPO6p0oOT=2jrqFafMCHe2cwDg@mail.gmail.com>
 <YzwtG8CT9sTCqQQk@maple.lan>
 <CACRpkdZ-DfZKgCOHaKn1UZ8vVwy1dEiFBBDNdxu6VNzrUdeEtA@mail.gmail.com>
 <YzyZJSwy9xsy69WL@google.com>
 <CACRpkdYecQPUd-evVpOpMLY1XUa87kP4i+E694QfTtDbEarJfQ@mail.gmail.com>
 <Yz6oS/zdNIOEtWxI@maple.lan>
 <CACRpkdYdZaxSGy+YiexKtffKvUEr5dcu3g=1zY3Tfhv5WMDtew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYdZaxSGy+YiexKtffKvUEr5dcu3g=1zY3Tfhv5WMDtew@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 10:36:00PM +0200, Linus Walleij wrote:
> On Thu, Oct 6, 2022 at 12:05 PM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > On Thu, Oct 06, 2022 at 11:03:15AM +0200, Linus Walleij wrote:
> > > On Tue, Oct 4, 2022 at 10:35 PM Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > > > Dmitry, could you fix this? Just patch away in gpiolib-of.c.
> > > >
> > > > Sure, I'll add a few quirks. I wonder what is the best way to merge
> > > > this? I can create a bunch of IBs to be pulled, or I can send quirks to
> > > > you/Bartosz and once they land send the patches to drivers...
> > >
> > > When I did it I was sufficiently convinced that I was the only one patching
> > > the quirks in gpiolib-of.c that merge window so I just included it as
> > > a hunk in the driver patch. If there will be some more patches to that
> > > file I guess some separate patch(es) for gpiolib-of.c is needed, maybe
> > > an immutable branch for those if it becomes a lot.
> >
> > Are renames likely to be a common quirk on the road to libgpiod
> > conversion?
> >
> > I admit I sort of expected it to be common enough that there would be
> > one rename quirk in the code supported by an alphabetized string table.
> > Such a table would certainly still provoke troublesome merges but ones
> > that are trivially resolved.
> 
> Dmitry added a table of sorts, the problems are usually a bit unique
> for each instance of nonstandard DT GPIO bindings, that's why I
> mostly solved it with open coding in gpiolib-of.c.

OK, so I sent out the patch adding "reset-gpios" -> "gpios-reset"
translation quirk to keep compatibility with the legacy names, but
we still need to figure out what to do with incorrect line polarity
in current DTses in tree. Unlike with names we have no indication
if out of tree DTSes specify correct polarity or not, so we can't
reasonably come up with workarounds that are guaranteed to work for
everyone. I see several options:

- the driver could continue ignoring line polarity specified in DTS
  (and use gpiod_set_value_raw()) and hope that they all/will be
  wired in the same way?

- we could fix up in-kernel DTSes, allow flexibility of connection
  in new designs and respect polarity specified in out of tree DTSes,
  but accept that there can be breakages with old DTSes not contributed
  to the mainline or DTSes that were "cached" from an older kernel
  release

- add another quirk forcing "active low" polarity for the legacy
  "gpios-reset" name, which will allow us respecting polarity in
  new "reset-gpios" name.

Thanks.

-- 
Dmitry
