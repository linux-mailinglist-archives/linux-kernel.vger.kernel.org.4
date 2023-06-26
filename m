Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6573E108
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjFZNus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjFZNup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:50:45 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45B710C9;
        Mon, 26 Jun 2023 06:50:43 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 3f1490d57ef6-c1aad78d5b2so2327109276.0;
        Mon, 26 Jun 2023 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687787443; x=1690379443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tgyqv8EYIym1+xnR4IokMMKVxRsw76bwo23lVBaAtjE=;
        b=r+MLhxlZPkVLsRQO6HVrZ5AU0SoNM+fylAXfhYB3oF6k2zfCbKFeEMAU2dGvaeu3PY
         eNIAy9eRzfDdqg12lMsYe0i6MHS+U7FRpEwbWvpW9qS/MAmZnG9RS/DaC4PeI24m8Kp0
         FhatC8dCE/q8gn7Htf4r/R+exMF438GIMGiKEML6sIy2B7ulqGVMLiWE3gQaaXFe89Mb
         CX/qnC35Ld1DlV53Bezso8u+36qZr2AYLbRzlu2nBrPGCZY6cLit/Lx6RG9X+QdwPp+5
         FgxINPKpbuAUztak2FMwkeYLUh2dutMSri5pP4VjeUpyDBYnApiLMynuetZjcj84Yw1e
         m73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687787443; x=1690379443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tgyqv8EYIym1+xnR4IokMMKVxRsw76bwo23lVBaAtjE=;
        b=c7o+Ae3wq+4mAwJjIhTyTNkxHh6LedaRGXtCyB2p4X5++RyqWZf2wIH8APWMfA1Fv+
         RVyct4kiyF32qqt+mkA0dvzQ9dZkfdH6gHXums1O36E5vfUz4xMHk8ARBtn1I6Prw3eL
         bVpU3CLIto88WPe6Hf5pUBOSKvEB75bDbvuk4Rs7KY07OzFL/c8ziXUrh7U58ZppNkeG
         jP0MELf/o6eC2qK0Fox1Wos9Iw+UxAgiLk+loZ1lu74o/oQ7a8+rkVpVZDSmWHjvxpiF
         dB3BIxEIhrm6XLYtLhRh9DyUQ0DmF6Zs2gEuVxyEKnFL/3LrYyFLCH0u0dUd04qZ+B15
         ovsg==
X-Gm-Message-State: AC+VfDziYkrGKphRroNvw8oMcjb0AVi+9CExwXjViYarT7spMZRMD/aW
        WaR8Gtmo6ZkAc2MX19SbUM9lj+S9qyBxbM+gBjE=
X-Google-Smtp-Source: ACHHUZ65bRZ34LgfKJzbhpp8jgyY/NZMkCzMmydTAWLNYN0oDE7VQpt/cPo6RqYUPmTIExX2C81NR5iNDazYtXIwsa8=
X-Received: by 2002:a25:418d:0:b0:bff:2a29:5981 with SMTP id
 o135-20020a25418d000000b00bff2a295981mr18450156yba.5.1687787442918; Mon, 26
 Jun 2023 06:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230626100107.4102329-1-imagedong@tencent.com> <CANn89iKHfAWj_e6aqWiNQJfe2LOeaX3-Grx3w0LpxoKH9i86Cg@mail.gmail.com>
In-Reply-To: <CANn89iKHfAWj_e6aqWiNQJfe2LOeaX3-Grx3w0LpxoKH9i86Cg@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Mon, 26 Jun 2023 21:50:31 +0800
Message-ID: <CADxym3axi_eNtZyP_+6NbxgHaKinBr+=rGvn-LmXnuCxEaHNuA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tcp: support to probe tcp receiver OOM
To:     Eric Dumazet <edumazet@google.com>
Cc:     ncardwell@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, dsahern@kernel.org,
        kuniyu@amazon.com, morleyd@google.com, imagedong@tencent.com,
        mfreemon@cloudflare.com, mubashirq@google.com,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 9:27=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Jun 26, 2023 at 12:01=E2=80=AFPM <menglong8.dong@gmail.com> wrote=
:
> >
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > For now, skb will be dropped directly if rmem schedule fails, which mea=
ns
> > tcp_try_rmem_schedule() returns an error. This can happen on following
> > cases:
> >
> > 1. The total memory allocated for TCP protocol is up to tcp_mem[2], and
> >    the receive queue of the tcp socket is not empty.
> > 2. The receive buffer of the tcp socket is full, which can happen on sm=
all
> >    packet cases.
> >
> > If the user hangs and doesn't take away the packet in the receive queue
> > with recv() or read() for a long time, the sender will keep
> > retransmitting until timeout, and the tcp connection will break.
> >
> > In order to handle such case, we introduce the tcp protocol OOM detecti=
on
> > in following steps, as Neal Cardwell suggested:
>
> net-next is closed.
>
> I think I suggested something much simpler, and not intrusive like your p=
atch.
> (Your patch adds code in the fast path, and yet another sysctl)
>
> If we can not queue an incoming packet because we are under memory stress=
,
> simply send an ACK with WIN 0

I tested that simply sending an ACK with WIN 0 does not work.
That's what the commit
b650d953cd39("tcp: enforce receive buffer memory limits by allowing
the tcp window to shrink")
do.

There are 2 reasons:
1. The win in the ACK will be ignored. In the tcp_may_update_window(),
it will check if this ACK can update the window. If the ACK doesn't
acknowledge new data, and doesn't contain data, and doesn't
expand the window, it will be ignored.

2. The window update can't work if the retransmission queue is
not empty, as zero-window probe only happen when the rtx queue
empty. So if the rtx queue is not empty, RTO retransmission can still
happen and timeout.

That commit is similar to the series I sent before:
https://lore.kernel.org/netdev/20230517124201.441634-1-imagedong@tencent.co=
m/

But it seems that it only handles the receiver of the window shrink,
and the sender is not handled yet?

As we already accepted the window shrink, maybe we
handle the sender side and use the previous solution?

Thanks!

Following is the script that I used to reproduce the problem.
On the server side, run:

echo '1024 1500 2048' > /proc/sys/net/ipv4/tcp_mem
./proto-mem-exhaust.py -s -r 1024000

and on the client, run:

./proto-mem-exhaust.py -c -t server_ip -m 100 --data 128

-------------------------------------- proto-mem-exhaust.py
----------------------

#!/bin/python3

import socket
import argparse
import time

parser =3D argparse.ArgumentParser()
parser.add_argument('-c', '--client', action=3D'store_true',
                    help=3D'run as client')
parser.add_argument('-s', '--server', action=3D'store_true',
                    help=3D'run as server')
parser.add_argument('-t', '--target', help=3D'host address')
parser.add_argument('-m', '--max', type=3Dint, help=3D'max connect count')
parser.add_argument('--data', type=3Dint, help=3D'data in kb a connect send=
')
parser.add_argument('-r', '--rbuff', type=3Dint, help=3D'receive buff size'=
)
args =3D parser.parse_args()


def do_client():
    clients =3D []
    for i in range(0, args.max):
        c =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        c.connect((args.target, 9999))
        clients.append(c)
        try:
            data_len =3D args.data * 1024
            print(f'send {data_len} data in {i} socket')
            c.sendall(bytes(data_len))
        except Exception as e:
            print('error happened: %s' % e)
            time.sleep(60*60*24)


def do_server():
    clients =3D []
    s =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind(('0.0.0.0', 9999))
    s.listen()
    while True:
        (c, addr) =3D s.accept()
        c.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, args.rbuff)
        clients.append(c)


if args.client:
    do_client()
elif args.server:
    do_server()


Following is another script to reproduce the problem. On the
server side, run: ./tcp-small.py -s -r 2048
client side, run: ./tcp-small.py -c -t server_ip --data 8

------------------------------------ tcp-small.py -------------------------=
--

#!/bin/python3

import socket
import argparse
import time

parser =3D argparse.ArgumentParser()
parser.add_argument('-c', '--client', action=3D'store_true',
                    help=3D'run as client')
parser.add_argument('-s', '--server', action=3D'store_true',
                    help=3D'run as server')
parser.add_argument('-t', '--target', help=3D'host address')
parser.add_argument('--data', type=3Dint, help=3D'data in byte send once')
parser.add_argument('-r', '--rbuff', type=3Dint, help=3D'receive buff size'=
)
args =3D parser.parse_args()


def do_client():
    c =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    c.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
    c.connect((args.target, 9999))
    try:
        while True:
            data_len =3D args.data
            c.sendall(bytes(data_len))
            time.sleep(0.01)
    except Exception as e:
        print('error happened: %s' % e)
        time.sleep(60*60*24)


def do_server():
    clients =3D []
    s =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, args.rbuff)
    s.bind(('0.0.0.0', 9999))
    s.listen()
    while True:
        (c, addr) =3D s.accept()
        clients.append(c)


if args.client:
    do_client()
elif args.server:
    do_server()
