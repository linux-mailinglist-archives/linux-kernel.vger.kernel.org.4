Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AACA6D0B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjC3Qfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjC3Qfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:35:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E3EC167
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:35:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cn12so78855285edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680194138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbVykd7P0KOAsf7dHIZrva8Lt+kHAzGPSxzhfnmT8wY=;
        b=f3dBuOEk50IsW5+fUjg1518XHn9e+bByiN8J+xhyhgvBe5BRe3EzKpbOFku8PGNtrK
         ruEXDvwiPZ6p6l+AuMX+PiOppsC3edqKpiPYJEcs0IPQ1nAIXpvgPVaHldLoZt+Mqiqt
         7vd8ZVcXZU7HYM1DYM8xffDUjfLr7g9woxaDrLRT33S/RMAxNmTnW2FqhBdkaDbJzJYs
         be1crXIdnNejRuBcOb3oL6W8TjDpQwceZfpW3ROuvPoRNnb+dQnf5KAPvW0HBzkqP+I7
         AEYxRT5SlPh8BwEq3KIK5zX/y76qynl8gxfbhF8J0wJJmfIEZqSr/NDJc8PmDULMQIhz
         pyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbVykd7P0KOAsf7dHIZrva8Lt+kHAzGPSxzhfnmT8wY=;
        b=1xMS+54GuwDDps+2PujCIa0t+xFyeXWoFf4d44Dcd7HChqgMk17Sl0YM1jH49XE2q5
         1/mXx379XPmPApwhgEiUw9Ox7Gx+VbzvhXD+sfmg911TO3Pg8HywDjeiST2hh4f4d0kB
         PABq/ktU42lNNiRYc+y/c84Y/2cfSTEQnUHONBYrhmGYDdfktRBCZuITQD6ypBVWjIpI
         EF6rjC6faeuPx0vnAIRLUSnaNBpkwlGAq+Bhv1S32Ff8Y3BmT3tJVGLSv8ALTQ0p7iO8
         jZJH+cCyAtnbS7HTSpK1CZcHp1CYu53zf4+x4EO3NKmBVLGArKLtVij8dpkHHSA+Ai/6
         HkTw==
X-Gm-Message-State: AAQBX9eSegfMT8VE8f7Y2GBNxjnEw1JI5+/cbkAlc5qaNokwsJsjU6Ih
        A/n7RNRpfn7Ngai52Voz7egYjoD1zbJKbvec0I1smUjJ6NY=
X-Google-Smtp-Source: AKy350bvIqR8/tgsdeT4OTZUGBgy+sBEsgIHTG2ELi9c/ri1Yh5Xs2RooG9Z6Fyijz5TLqh4Q0wpqOV571y/6hBU3e4=
X-Received: by 2002:a50:9fef:0:b0:4fc:1608:68c8 with SMTP id
 c102-20020a509fef000000b004fc160868c8mr11813080edf.1.1680194137852; Thu, 30
 Mar 2023 09:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st>
 <CABb+yY2=B2p5JhZiBE_mZLe3y16EUgVsUHK62LnRgaKa1-ptLg@mail.gmail.com> <f12bafa5-1589-5bcb-5f92-edb7be54efef@marcan.st>
In-Reply-To: <f12bafa5-1589-5bcb-5f92-edb7be54efef@marcan.st>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 30 Mar 2023 11:35:26 -0500
Message-ID: <CABb+yY1k9LSFb5kVe7bGhiubJ0jTDkFqYsGjobP=KjywXk_yuA@mail.gmail.com>
Subject: Re: [PATCH 0/5] mailbox: apple: Move driver into soc/apple and stop
 using the subsystem
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 5:53=E2=80=AFPM Hector Martin <marcan@marcan.st> wr=
ote:
> On 30/03/2023 01.04, Jassi Brar wrote:

> >> On top of this, the mailbox subsystem makes design
> >>    decisions unsuitable for our use case. Its queuing implementation
> >>    has a fixed queue size and fails sends when full instead of pushing
> >>    back by blocking, which is completely unsuitable for high-traffic
> >>    mailboxes with hard reliability requirements, such as ours. We've
> >>    also run into multiple issues around using mailbox in an atomic
> >>    context (required for SMC reboot/shutdown requests).
> >>
> > I don't think you ever shared the issues you were struggling with.
>
> I did try to send a patch clarifying/cleaning up inconsistent usage of
> the atomic codepath in other drivers, and you rejected it. At that point
> I gave up in trying to contribute to cleaning up the existing mess,
> because you're clearly not interested.
>
You mean  https://lore.kernel.org/lkml/20220502090225.26478-6-marcan@marcan=
.st/
Now I see where this code-rage comes from.

But let me clarify even more...
 You do not kill some api just because you don't need that and/or you
think that is "stupid" because you can't see past your own use-case.
   Peek'ing is a valid usecase. If you need Polling, that does not
mean other platforms are broken to need to Peek. You can not declare
all platforms must be able to fetch data from remote in atomic
context. Think of a platform that must do some sleepy calls to fetch
data ? Or a large buffer copy is involved.
  If your platform can read and pass-on data in atomic context, you
can still implement that around the existing peek api (ok a few extra
loc involved). Even if we see that the api must provide polling, we
may add a new callback or 'overload' peek.... but still you can not
kill peek. If you do, I am sure another revolutionary will arise in
few months finding the atomic-read requirement "stupid" and either
revert poll or reintroduce peek :)

>
> As for the other issue, there's a giant comment around the queue length
> define:
>
> > /*
> >  * The length of circular buffer for queuing messages from a client.
> >  * 'msg_count' tracks the number of buffered messages while 'msg_free'
> >  * is the index where the next message would be buffered.
> >  * We shouldn't need it too big because every transfer is interrupt
> >  * triggered and if we have lots of data to transfer, the interrupt
> >  * latencies are going to be the bottleneck, not the buffer length.
> >  * Besides, mbox_send_message could be called from atomic context and
> >  * the client could also queue another message from the notifier 'tx_do=
ne'
> >  * of the last transfer done.
> >  * REVISIT: If too many platforms see the "Try increasing MBOX_TX_QUEUE=
_LEN"
> >  * print, it needs to be taken from config option or somesuch.
> >  */
> > #define MBOX_TX_QUEUE_LEN       20
>
> This issue is clearly known, and it doesn't take a lot of thinking to
> realize that *any* queue length limit coupled with hard-fails on message
> sends instead of pushback is just unsuitable for many use cases. Maybe
> all existing mailbox users have intrinsically synchronous use cases that
> keep the queue idle enough, or maybe they're just broken only in corner
> cases that haven't come back to the mailbox subsystem yet. Either way,
> as far as I'm concerned this is broken by design in the general case.
>
You may be surprised but I do understand hardcoding limits on buffer
size is taboo.... unless benefits outweigh fingerpointing :)

1) Using an array here greatly simplifies the code by avoiding code to
dynamically shrink/expand the linked list while constrained by the
atomic context. Using array with head and tail indices is a fast and
simplest way to implement a ring buffer. I also intented the api to
have least footprint on the throughput and resources (my own initial
usecase was high speed 4k image transfer).

2) The api relies on last_tx_done() to make sure we submit data only
when we have an all-clear ... which is a platform specific way to
ensure signal will physically reach the remote (whether data is
accepted or not is upto the upper layer protocol and that's why it is
recommended to pass pointer to data, rather than data as the signal).
The way api is recommended (not required) to be used,  the limit on
TX_QUEUE_LEN(20), is not impactful beyond the fifo size of the
controller. Though I am open to idea of seeing if tx failure should be
considered a possiblity even after last_tx_done.

 Iirc on lkml, people have reported using 1000s tx calls per second
within this queue limit. I don't know how you tried to interpret that
limit but would have helped to know your issue.

>
> > But if redoing mailbox overall saves you complexity, I am ok with it.
>
> Is that an ack? :-)
>
You sound like being trapped in a bad marriage with mailbox :)    And
I really don't want you to stay in a rewardless situation --- I have
actually asked some platforms during RFCs if mailbox is really useful
for them (usually SMC/HVC based useage), but they found use.
Please make sure it is not just code-rage of your patchset being
rejected, and indeed there are things you can't do with the api.
Because the api can not have Zero impact on any platform's
implementation and my ack here could be used as a precedent for every
platform to implement their own tx/rx queues and dt handling and move
into drivers/soc/.  A couple years later someone will see it doesn't
make sense every platform is doing the same thing in driver/soc/ and
maybe it s a good idea to have some drivers/mailbox/ to hold the
common code.
  I am also aware I am just a volunteer at mailbox and can not dictate
what you do with your platform. So, is there anything like
Neither-acked-nor-objected-but-left-to-soc-by ?  ;)

cheers.
