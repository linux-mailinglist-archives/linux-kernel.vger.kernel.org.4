Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C11736E52
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjFTOJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjFTOJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:09:05 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37560E58;
        Tue, 20 Jun 2023 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ekPPUQAmVVrrWr1qBlhGGDjUTFbwDIDMgk2nEuBhZRY=; b=Pttv+VUNGuJ461RzDONyDnw806
        3P6etPgLo+dBFcM7lIC85HVrvF4fc6w8YNDyVGDJDd4ZRBCRvfkjELMfeB2A8vlZth6N6mUZff1de
        5wAZPsiPO+EBdkG4Be0uG2WjiUtH28SSGNHd4tLUi2/Cu9h5jyKQy5504K1fBFJ2vXuE=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:48278 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qBc2J-0000F2-9L; Tue, 20 Jun 2023 10:08:48 -0400
Date:   Tue, 20 Jun 2023 10:08:46 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org
Message-Id: <20230620100846.d58436efc061fb91074fa7e5@hugovil.com>
In-Reply-To: <CAHp75VeWFPBmsD8zsSAaQGNNXtfgLtQuM9AMGfLPk-6p0VW=Pg@mail.gmail.com>
References: <20230602152626.284324-1-hugo@hugovil.com>
        <20230602152626.284324-6-hugo@hugovil.com>
        <2023060454-cotton-paramount-e33e@gregkh>
        <CAHp75Ve6W-hcB4YAeKukgv-uOEzBY7Tx5Sdf3doTRYKzNPcVGw@mail.gmail.com>
        <20230604134459.3c3844012e9714fa2a61e642@hugovil.com>
        <CAHp75VeWFPBmsD8zsSAaQGNNXtfgLtQuM9AMGfLPk-6p0VW=Pg@mail.gmail.com>
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
Subject: Re: [PATCH v7 5/9] serial: sc16is7xx: fix regression with GPIO
 configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2023 22:31:04 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 4, 2023 at 8:45 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > On Sun, 4 Jun 2023 14:57:31 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> > > On Sun, Jun 4, 2023 at 10:47 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > On Fri, Jun 02, 2023 at 11:26:21AM -0400, Hugo Villeneuve wrote:
> > >
> > > ...
> > >
> > > > > +static u8 sc16is7xx_setup_mctrl_ports(struct device *dev)
> > > >
> > > > This returns what, mctrl?  If so, please document that, it doesn't look
> > > > obvious.
> > >
> > > Good suggestion. Because I also stumbled over the returned type.
> > >
> > > >  And as the kernel test robot reported, you do nothing with the
> > > > return value so why compute it?
> > >
> > > It seems that the entire function and respective call has to be moved
> > > under #ifdef CONFIG_GPIOLIB.
> >
> > Hi,
> > it cannot. See my explanations in response to Greg's comments.
> 
> Then as Greg suggested, store in the structure and make this function
> to return an error code (with int), with this amendment you don't need
> to add a comment about the returned variable anymore.

Hi Andy,
did you have a chance to look at V8 (sent two weks ago) which fixed all
of what we discussed?

Thank you,
Hugo.
