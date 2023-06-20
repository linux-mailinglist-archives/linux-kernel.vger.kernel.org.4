Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECDF73714B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjFTQQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjFTQQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:16:56 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B40695;
        Tue, 20 Jun 2023 09:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AeL+ePUG2U+gtbaPVRNCeIftvITy04qZEoWPXivPMGM=; b=gSvQNHy5jmJwaB8fkE8RCWcVzk
        awSwFgQ72MtyCwUP4Dt2Rs+U5WnsTVmsOT6G9l2RkOoIIRZO4rtnEuCKa3EhPMJ3GrVLAWZp/pasI
        xk8m3QGZP1vUmPW1ovtBts1TiQchVrP/l2gkZjUpwaoUipbyRHWM8eroglEx3wWmT4Vk=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:49610 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qBe29-0001IH-PZ; Tue, 20 Jun 2023 12:16:46 -0400
Date:   Tue, 20 Jun 2023 12:16:45 -0400
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
Message-Id: <20230620121645.512b31a872306b43a276bbac@hugovil.com>
In-Reply-To: <CAHp75VcieuYqxWrO7rknx2ROYz=rnWnKV6s9eXZ5Zd1BKc6YMg@mail.gmail.com>
References: <20230602152626.284324-1-hugo@hugovil.com>
        <20230602152626.284324-6-hugo@hugovil.com>
        <2023060454-cotton-paramount-e33e@gregkh>
        <CAHp75Ve6W-hcB4YAeKukgv-uOEzBY7Tx5Sdf3doTRYKzNPcVGw@mail.gmail.com>
        <20230604134459.3c3844012e9714fa2a61e642@hugovil.com>
        <CAHp75VeWFPBmsD8zsSAaQGNNXtfgLtQuM9AMGfLPk-6p0VW=Pg@mail.gmail.com>
        <20230620100846.d58436efc061fb91074fa7e5@hugovil.com>
        <CAHp75VcWSVgA8LFLo0-b5TfKWdHb2GfLpXV-V3PZvthTv1Xc4A@mail.gmail.com>
        <20230620113312.882d8f0c7d5603b1c93f33fb@hugovil.com>
        <CAHp75VfGm6=ULW6kMjsg2OgB1z1T0YdmzvCTa3DFXXX-q_RnfA@mail.gmail.com>
        <20230620114209.fb5272ad8cf5c5e2895d68b1@hugovil.com>
        <CAHp75VcieuYqxWrO7rknx2ROYz=rnWnKV6s9eXZ5Zd1BKc6YMg@mail.gmail.com>
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

On Tue, 20 Jun 2023 18:45:51 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jun 20, 2023 at 6:42 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > On Tue, 20 Jun 2023 18:35:48 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Jun 20, 2023 at 6:33 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > > On Tue, 20 Jun 2023 18:18:12 +0300
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > On Tue, Jun 20, 2023 at 5:08 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > > > > On Sun, 4 Jun 2023 22:31:04 +0300
> > > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> ...
> 
> > > > > > did you have a chance to look at V8 (sent two weks ago) which fixed all
> > > > > > of what we discussed?
> > > > >
> > > > > The patch 6 already has my tag, anything specific you want me to do?
> > > >
> > > > Hi Andy,
> > > > I forgot to remove your "Reviewed-by: Andy..." tag before sending V8
> > > > since there were some changes involved in patch 6 and I wanted you to
> > > > review them. Can you confirm if the changes are correct?
> > > >
> > > > I also added a new patch "remove obsolete out_thread label". It has no
> > > > real impact on the code generation itself, but maybe you can review and
> > > > confirm if tags are ok or not, based on commit message and also
> > > > additional commit message.
> > >
> > > Both are fine to me.
> >
> > Hi,
> > Ok, thank you for reviewing this.
> >
> > I guess now we are good to go with this series if the stable tags and
> > patches order are good after Greg's review?
> 
> Taking into account that we are at rc7, and even with Fixes tags in
> your series I think Greg might take this after v6.5-0rc1 is out. It's
> up to him how to proceed with that. Note, he usually has thousands of
> patches in backlog, you might need to respin it after the above
> mentioned rc1.

Ok, understood.

Let's wait then.

Thank you.
Hugo.
