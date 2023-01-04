Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612F065CEF8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjADJCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbjADJBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:01:40 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7E513F94;
        Wed,  4 Jan 2023 01:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672822851; bh=LLQeTnvNuZCdPg+E7Hbr+aQYgS8XCWQxD7iW+7QqbBY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=mf1vJ+9V0G/y85PujC+0RQeuHmVEKg0KbhD2ZRzibsziGPrJhkp77Ker8evTtf3T9
         rhNjx8Ei/9a4A0oR61B/Hi2oUGy7pdNHM06xJ2qVClIemBlerJjiCu5Vb0WkXZPUqU
         xJ0ocnKL6aQnJXISzbxHPjYwZGEdVNo7RS10BK7U=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed,  4 Jan 2023 10:00:51 +0100 (CET)
X-EA-Auth: /EDdEHgOuYMl2jkDd/7fB7flqOZUzBVHc0UeQJUETcM2XHO9lRxSq5Qo1WuH0wT4Lqgum8EJLwjsiulvrm0y8bRAPX7Ra2Sl
Date:   Wed, 4 Jan 2023 14:30:44 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH v4 2/2] tty: serial: dz: convert atomic_* to refcount_*
 APIs for irq_guard
Message-ID: <Y7VAPI7Y5tfVUdvR@qemulion>
References: <cover.1671898144.git.drv@mailo.com>
 <51ef854f77779c82010379420139993e12c38776.1671898144.git.drv@mailo.com>
 <3c4e744f-c313-e195-af93-a22382c81bb6@kernel.org>
 <Y7P+zZEF09YWs5yW@qemulion>
 <Y7U4wiLM/z+H/rOc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7U4wiLM/z+H/rOc@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 09:28:50AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 03, 2023 at 03:39:17PM +0530, Deepak R Varma wrote:
> > On Tue, Jan 03, 2023 at 10:00:48AM +0100, Jiri Slaby wrote:
> > > On 26. 12. 22, 7:21, Deepak R Varma wrote:
> > > > +	ret = request_irq(dport->port.irq, dz_interrupt, IRQF_SHARED, "dz", mux);
> > >
> > > How is this related to the above described change?
> >
> > No, it is not. My apologies. I must have joined the lines for improved readability
> > and forgot to revert. I will restore this in next revision based on the feedback
> > on the other patch of this series. OR I can include this change in the current
> > change log as a "while at it..." statement. Would you advise me?
>
> NEVER have a "while at it..." change as part of a commit unless it is
> relevant to the main change being made.  You know better...

Sounds very good. Thank you for the advise. I will revert the change in the next
revision.

Thank you,
./drv

>
> thanks,
>
> greg k-h


