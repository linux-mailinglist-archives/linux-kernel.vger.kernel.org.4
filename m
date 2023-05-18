Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E797082F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjERNk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjERNk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:40:57 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611E0125
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:40:55 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-456de5aa485so196390e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684417254; x=1687009254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO9iooI56FzY/iP176V5ICBpaJB4SK5RAZzxGCjOh+c=;
        b=cYCTE3RMNKJ6s8LWLrIFcvauLAHxZobqQtGDDDFDml0X54Sfu80Ki/h3ticIzyML9Z
         090jNF/AUQnUT62lJNWlPd/EvMztT9bes/p7Cy5oEZAdwf/h5Se8rcoh0DPpRNFEmHcQ
         76z8sqbNHk7m3TEYsuISLJxd2qCSMA0SFhuAPwC6aqAPwo0BZhMtdkBCWZrNSzfrbrHJ
         VZIZJKeiB4cxF+o7H3qwhE1yt8waTMM5P5A/wfNVOYNnhMVoQE5KqGEHDj2Ov9y0coYo
         dO9peHxxCzHwZ072HD/xnBXljbjoefKhO88rd9Wo7sepndfMV/wUNzjCArxhF7Cvh+vj
         7yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684417254; x=1687009254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tO9iooI56FzY/iP176V5ICBpaJB4SK5RAZzxGCjOh+c=;
        b=Dzl3vZRIJFaHcE/BDHKjaBO+GBFgiJr/X8qCPEBgBjpbwR911eUDGLBLGrcYY3/GZi
         QIl0Tf84T6+lVnmDWiWJ4d/agIq5kWFo1wsQWg3eSKtCYKiyKOa0OF8zLPufjTKQMYZ2
         74lebhDnfKoZk0reNRr7Wvmzmu7UbeUtPgOPh7VIek/U4n/Gm+m+Ciz40Cm8KRqSxMhg
         tHiuY879vnyEsUr9IobTEfgFqQlW2pVDHFm5NtyrJQtmnOa2Ift9+QJSPBItPKxcuScP
         wbE6aAS9Ua0VsH4M7VWTOZPqURcuu+CCP2NA/4HLz03NaG4x/s16HCYeeKJuNcdp6g9d
         cXjA==
X-Gm-Message-State: AC+VfDxCeG0EnBTRGiBpWKN+1X0BpeJVw156qpjB+pAMIowZN7iJmGM+
        jz0EzkagDHV7OTHghxyE+d2RusFNoKFSryPEzKDQcX6l0+WJnmiAPFQYQQ==
X-Google-Smtp-Source: ACHHUZ6MYat4STXZJsVwuZR4PYNh7+BmxG/S1f4+FO72tkacwa0bCowdG+yEUis8XEPl+y1Grq2Wuw7SQ1wmtWBl/qY=
X-Received: by 2002:a1f:45c8:0:b0:456:fc81:1db3 with SMTP id
 s191-20020a1f45c8000000b00456fc811db3mr197246vka.5.1684417254221; Thu, 18 May
 2023 06:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230517124201.441634-1-imagedong@tencent.com>
 <20230517124201.441634-4-imagedong@tencent.com> <CANn89iKLf=V664AsUYC52h_q-xjEq9xC3KqTq8q+t262T91qVQ@mail.gmail.com>
 <CADxym3a0gmzmD3Vwu_shoJnAHm-xjD5tJRuKwTvAXnVk_H55AA@mail.gmail.com>
In-Reply-To: <CADxym3a0gmzmD3Vwu_shoJnAHm-xjD5tJRuKwTvAXnVk_H55AA@mail.gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Thu, 18 May 2023 09:40:37 -0400
Message-ID: <CADVnQynZ67511+cKF=hyiaLx5-fqPGGmpyJ-5Lk6ge-ivmAf-w@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: tcp: handle window shrink properly
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>, kuba@kernel.org,
        davem@davemloft.net, pabeni@redhat.com, dsahern@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 10:35=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> On Wed, May 17, 2023 at 10:47=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Wed, May 17, 2023 at 2:42=E2=80=AFPM <menglong8.dong@gmail.com> wrot=
e:
> > >
> > > From: Menglong Dong <imagedong@tencent.com>
> > >
> > > Window shrink is not allowed and also not handled for now, but it's
> > > needed in some case.
> > >
> > > In the origin logic, 0 probe is triggered only when there is no any
> > > data in the retrans queue and the receive window can't hold the data
> > > of the 1th packet in the send queue.
> > >
> > > Now, let's change it and trigger the 0 probe in such cases:
> > >
> > > - if the retrans queue has data and the 1th packet in it is not withi=
n
> > > the receive window
> > > - no data in the retrans queue and the 1th packet in the send queue i=
s
> > > out of the end of the receive window
> >
> > Sorry, I do not understand.
> >
> > Please provide packetdrill tests for new behavior like that.
> >
>
> Yes. The problem can be reproduced easily.
>
> 1. choose a server machine, decrease it's tcp_mem with:
>     echo '1024 1500 2048' > /proc/sys/net/ipv4/tcp_mem
> 2. call listen() and accept() on a port, such as 8888. We call
>     accept() looply and without call recv() to make the data stay
>     in the receive queue.
> 3. choose a client machine, and create 100 TCP connection
>     to the 8888 port of the server. Then, every connection sends
>     data about 1M.
> 4. we can see that some of the connection enter the 0-probe
>     state, but some of them keep retrans again and again. As
>     the server is up to the tcp_mem[2] and skb is dropped before
>     the recv_buf full and the connection enter 0-probe state.
>     Finially, some of these connection will timeout and break.
>
> With this series, all the 100 connections will enter 0-probe
> status and connection break won't happen. And the data
> trans will recover if we increase tcp_mem or call 'recv()'
> on the sockets in the server.
>
> > Also, such fundamental change would need IETF discussion first.
> > We do not want linux to cause network collapses just because billions
> > of devices send more zero probes.
>
> I think it maybe a good idea to make the connection enter
> 0-probe, rather than drop the skb silently. What 0-probe
> meaning is to wait for space available when the buffer of the
> receive queue is full. And maybe we can also use 0-probe
> when the "buffer" of "TCP protocol" (which means tcp_mem)
> is full?
>
> Am I right?
>
> Thanks!
> Menglong Dong

Thanks for describing the scenario in more detail. (Some kind of
packetdrill script or other program to reproduce this issue would be
nice, too, as Eric noted.)

You mention in step (4.) above that some of the connections keep
retransmitting again and again. Are those connections receiving any
ACKs in response to their retransmissions? Perhaps they are receiving
dupacks? If so, then perhaps we could solve this problem without
depending on a violation of the TCP spec (which says the receive
window should not be retracted) in the following way: when a data
sender suffers a retransmission timeout, and retransmits the first
unacknowledged segment, and receives a dupack for SND.UNA instead of
an ACK covering the RTO-retransmitted segment, then the data sender
should estimate that the receiver doesn't have enough memory to buffer
the retransmitted packet. In that case, the data sender should enter
the 0-probe state and repeatedly set the ICSK_TIME_PROBE0 timer to
call tcp_probe_timer().

Basically we could try to enhance the sender-side logic to try to
distinguish between two kinds of problems:

(a) Repeated data packet loss caused by congestion, routing problems,
or connectivity problems. In this case, the data sender uses
ICSK_TIME_RETRANS and tcp_retransmit_timer(), and backs off and only
retries sysctl_tcp_retries2 times before timing out the connection

(b) A receiver that is repeatedly sending dupacks but not ACKing
retransmitted data because it doesn't have any memory. In this case,
the data sender uses ICSK_TIME_PROBE0 and tcp_probe_timer(), and backs
off but keeps retrying as long as the data sender receives ACKs.

AFAICT that would be another way to reach the happy state you mention:
"all the 100 connections will enter 0-probe status and connection
break won't happen", and we could reach that state without violating
the TCP protocol spec and without requiring changes on the receiver
side (so that this fix could help in scenarios where the
memory-constrained receiver is an older stack without special new
behavior).

Eric, Yuchung, Menglong: do you think something like that would work?

neal
