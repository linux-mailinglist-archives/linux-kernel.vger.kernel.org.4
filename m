Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE0F710D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241167AbjEYNkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241390AbjEYNj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:39:56 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11541A8;
        Thu, 25 May 2023 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=W+USy6ZGPp8IPbp5FM+pZpBNuBUlS21T021RTvaoLFA=; b=EAgWp6toXJH3bL9zL8xioTndpb
        JqBLZcKt+6hURf5om4beCEu8ZrebHRsCvv19WGVtx7IeT5Kn4CNIu8Y9tNB7pUVkWyNHrhJuxVu+J
        atN6x0jBNX9F5jdvzWR8aUMA6owL2NZ3HimxylEE8M6CcZ7XL7eO9ezLKKSRvtJPjhL4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48718 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q2BBq-0007rR-G7; Thu, 25 May 2023 09:39:39 -0400
Date:   Thu, 25 May 2023 09:39:37 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230525093937.95a5554f99f60ae022e0bf60@hugovil.com>
In-Reply-To: <CAHp75VenvvkC1evsmhSBNT5=V=D92RX1JXnwZWAtsJ2TrADvRA@mail.gmail.com>
References: <20230525040324.3773741-1-hugo@hugovil.com>
        <ZG84KCeMIINFVTMh@surfacebook>
        <20230525092627.edf4f7f9df4b9b1cf7b568a4@hugovil.com>
        <CAHp75VenvvkC1evsmhSBNT5=V=D92RX1JXnwZWAtsJ2TrADvRA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 00/11] serial: sc16is7xx: fix GPIO regression and
 rs485 improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 16:37:17 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, May 25, 2023 at 4:26 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > On Thu, 25 May 2023 13:27:52 +0300
> > andy.shevchenko@gmail.com wrote:
> > > Thu, May 25, 2023 at 12:03:13AM -0400, Hugo Villeneuve kirjoitti:
> > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > >
> > > > Hello,
> > > > this patch series mainly fixes a GPIO regression and improve RS485 flags and properties
> > > > detection from DT.
> > > >
> > > > It now also includes various small fixes and improvements that were previously
> > > > sent as separate patches, but that made testing everything difficult.
> > >
> > > > Patches 1 and 2 are simple comments fix/improvements.
> > >
> > > Usually we put fixes at the beginning of the series, but these patches are
> > > missing Fixed tag. Are they really fixes or can be simply moved to the end of
> > > the series?
> >
> > these are not code fixes, they are comments improvements. I was not aware that you need to put a Fixes tag for correcting syntax errors in comments, or adding comments to improve clarity.
> >
> > I often submit such comments patches but was never asked to put a Fixes tag before. Seems strange to me...
> 
> In this case there are probably no conflicts, but the usual grouping
> of patches is following
> 1) fixes that may be backported;
> 2) cleanups / refactoring /etc;
> 3) new features.
> 4) additional light-weit cleanups, such as whitespace cleaning (it's a
> radical, we probably do not accept pure whitespace cleaning patches,
> but you got the idea).
> 
> Seems patches 1 and 2 fall into category 4).

Ok, I changed the order to put these two patches at the end.

Hugo.
