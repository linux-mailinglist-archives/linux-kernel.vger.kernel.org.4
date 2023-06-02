Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7D072029A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbjFBNGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbjFBNGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:06:43 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B721AB;
        Fri,  2 Jun 2023 06:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Y84qRq7gqEl7quzGwy5z/2wXIR5WfX6BYU6q3+lFVsw=; b=ekr1xkFlnN0XWid3TIelC3SBQJ
        lAtTjZp4XsGIxiSvI4FTOCgobli6ncdzPLWXuzuWdpw0ySppH56lLwSrLFod1KU9F1RbZ8t6r3gAf
        i1X+IfJgK/cYjG7eRhE88hJljwoAjMddvhJl5RMuIVErG6JtQ7nHKua3XdaGS2lEZpYM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:35388 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q54U9-0006m5-MG; Fri, 02 Jun 2023 09:06:30 -0400
Date:   Fri, 2 Jun 2023 09:06:29 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org
Message-Id: <20230602090629.aa1bee802aafae76ce4e1e60@hugovil.com>
In-Reply-To: <CAHp75VcLNRQyeo4H-auDvk+CxZ0hz+2pysqP3bBgW-uZB_2vPw@mail.gmail.com>
References: <20230601201844.3739926-1-hugo@hugovil.com>
        <20230601201844.3739926-6-hugo@hugovil.com>
        <ZHkN5kEa6yqHdDeL@surfacebook>
        <20230601204140.3b45c9b97efb36431d058ba7@hugovil.com>
        <20230601212514.28914aee77ae9a513904ee6b@hugovil.com>
        <CAHp75VcLNRQyeo4H-auDvk+CxZ0hz+2pysqP3bBgW-uZB_2vPw@mail.gmail.com>
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
Subject: Re: [PATCH v6 5/9] serial: sc16is7xx: fix regression with GPIO
 configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2023 15:58:43 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jun 2, 2023 at 4:25 AM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > On Thu, 1 Jun 2023 20:41:40 -0400
> > Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > On Fri, 2 Jun 2023 00:30:14 +0300
> > > andy.shevchenko@gmail.com wrote:
> > > > Thu, Jun 01, 2023 at 04:18:40PM -0400, Hugo Villeneuve kirjoitti:
> 
> ...
> 
> > > > Maybe positive one?
> > > >     if (mctrl_mask)
> > > >             regmap_update_bits(...);
> > >
> > > I used negative to save on indentation, but it also fits by converting it to positive, so done.
> 
> I understand, but in this case it is slightly more weird to have
> negative conditional and in either case return the value of the local
> variable.

Yes.

> > Greg did not yet respond to my email about the proposed tags, but if the new order of the patches and the stable tags I added seems ok to you, I will resend V7. It will then probably easier for Greg to comment directly on V7 for the stable tags (Cc:).
> 
> They look fine to me, but Greg is the maintainer, he decides if it's
> really okay or not.

Then I will submit V7 now.

Thank you,
Hugo.
