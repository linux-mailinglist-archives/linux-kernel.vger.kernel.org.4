Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73577184B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbjEaOUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbjEaOUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:20:33 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769CC1987;
        Wed, 31 May 2023 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WMBpRHwWtTgWaFnCUH7r3dh40eaL8Z8t/6W3Qgru8Bc=; b=BKAsBA9af9V7EjGyFevCIcvY1h
        vKSLNRIBLYUFkrTZSIZSDm2q6sz7YMIJkpn7g0226maMn7fXNKYdLyZE8LETc/yrMd9kKSmrz/uhM
        VovV2aa7Or04RVslfqZeQIBClbFzG2OFJGM2m7O+vM2heJrRJrr+Tki72/+zQN/RBSuk=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:46714 helo=debian-acer)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q4MKB-0000Ek-DT; Wed, 31 May 2023 09:57:15 -0400
Date:   Wed, 31 May 2023 09:57:14 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230531095714.2428a41369cd7509bc321bf7@hugovil.com>
In-Reply-To: <CAHp75Vf35rN93sXFBU0nRZQLpUgQHR2caGC8BmHkEgPZqF=dQg@mail.gmail.com>
References: <20230529140711.896830-1-hugo@hugovil.com>
        <20230529140711.896830-8-hugo@hugovil.com>
        <ZHUpWQafRPHW1RJQ@surfacebook>
        <20230530113649.73f28b9f6ba91f17ace1e12f@hugovil.com>
        <CAHp75Vf35rN93sXFBU0nRZQLpUgQHR2caGC8BmHkEgPZqF=dQg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v4 7/9] serial: sc16is7xx: fix regression with GPIO
 configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 00:56:57 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, May 30, 2023 at 6:36 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > On Tue, 30 May 2023 01:38:17 +0300
> > andy.shevchenko@gmail.com wrote:
> > > Mon, May 29, 2023 at 10:07:09AM -0400, Hugo Villeneuve kirjoitti:
> 
> ...
> 
> > > GENMASK()
> >
> > Ok done, altough even if in general I like the bit manipulation macros because they make the code easier to read/understand, I find it less obvious by using GENMASK in this case IMMO.
> 
> GENMASK() was introduced to increase code robustness:
> 1) to make sure the bits mentioned are correct
> 2) to check the bit boundary.
> 
> ...
> 
> > > > +           of_property_for_each_u32(dev->of_node, "nxp,modem-control-line-ports",
> > > > +                                    prop, p, u) {
> > > > +                   if (u >= devtype->nr_uart)
> > > > +                           continue;
> > > > +
> > > > +                   /* Use GPIO lines as modem control lines */
> > > > +                   if (u == 0)
> > > > +                           mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_A_BIT;
> > > > +                   else if (u == 1)
> > > > +                           mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_B_BIT;
> > > > +           }
> > >
> > > Can we use device properties, please?
> >
> > I have converted this section to use device_property_count_u32() and device_property_read_u32_array(). Is that Ok?
> 
> Yes, thank you!
> 
> > > If you think about backporting to the earlier kernels (w/o properties in use in
> > > this driver), perhaps an additional followup for that?
> >
> > I am not sure what you mean by this?
> 
> If the device property API was not yet available for this fix being
> backported to the old enough kernel we have to use old OF stuff. In
> that case the device property conversion needs to be done in a
> separate change.

Hi,.
ok, now I see.

Thank you,
Hugo.
