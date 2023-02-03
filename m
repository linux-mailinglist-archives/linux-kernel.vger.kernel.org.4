Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83594689DAA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjBCPNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjBCPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:12:57 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1577AF0E6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 07:10:40 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id g2so6572041ybk.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 07:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oM1VZ26VMzyeaMXfXCF0KI1F+A9gkfxg4J5wcG7w8r4=;
        b=PDTZr0Lmh+qWPPwlNmv4VOIgyBqx1VQi+ZkI5uG6OWcbQGP2AgOzV4u7oDRHOxP9Ax
         u1pQqumqmr6KpA8bUcJ0rRaLAKaqc49hbGagDvVeFLKFzgtLRzmVyzLYHHT1W/dg/uh1
         gT3CoSnUgiPCEiw6CXjVJAsjL1HzYZ8qswinkvnY85vuKVXqfB4U4jJA7/UUIJGFzWyA
         QI2Dj4znYFYWgE+KKRvucqYbNT93BI/RbRxpZ8vEuEcTRV/gqAoaRmWnrHZxlOwjj/4z
         whyyV4xSoNGZ2n0NmAemrTywt+7eeRAjh2/3HYa1pgq60lMme4o9B0BXmpPhEj2vK15g
         O8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oM1VZ26VMzyeaMXfXCF0KI1F+A9gkfxg4J5wcG7w8r4=;
        b=npU0lbhHB3QtKRiBSghJUwmhwQb0YokuebRLirX15UY7Ls52X0hF1Qa2pJBjQzUd1o
         my2dndoXlgkUmeehzudFgdjsux6Zo9ZQOUzlyUFMWDh+bePk9Ntu/aOVeZr08YHRrt+Y
         lQoq7IcfZhTcPlgckTC3b65emRqQXbalgkZhbhlm5+lFzhnvIYCy+Dj7Rh8wpvVuhOOC
         EJft8EgDWNPhzoqnRAPgk+mdG+/elBqSrdIy3UToUhfY3geW3x5yQ2y+bAHq5Wx4ZYSn
         EtwGLKYpIT6PUyopOOj69EvHbj2daZY50qTFxh3DbUHW7OVQS0O9CBCJ22bPnzocToVu
         ZwwQ==
X-Gm-Message-State: AO0yUKWPRCY8gwiJ3mO4Fc9CxLDxV+beCxAwCKzoJvO2aHf7jmvEuMxg
        dngpjWDLbFTvydKF/vYHRvmvKOzPX5cYKf+tYmUoVw==
X-Google-Smtp-Source: AK7set+EroEX00FdhlN+nDb0LqTCzvNmLfRjuN9I3dELplssEf9m3RiTPxBm3aoR7QT3/ZyX00mwYd2X5rE/UFjUt5U=
X-Received: by 2002:a25:2f47:0:b0:860:c986:cea1 with SMTP id
 v68-20020a252f47000000b00860c986cea1mr526344ybv.532.1675436963817; Fri, 03
 Feb 2023 07:09:23 -0800 (PST)
MIME-Version: 1.0
References: <Y9q8Ec1CJILZz7dj@ip-172-31-38-16.us-west-2.compute.internal>
 <20230202014810.744-1-hdanton@sina.com> <Y9wVNF5IBCYVz5jU@ip-172-31-38-16.us-west-2.compute.internal>
 <CANn89iLWZb-Uf_9a41ofBtVsHjBwHzbOVn+V_QrksnB9y80m6w@mail.gmail.com> <Y9xOQPPGDrSN0IBu@ip-172-31-38-16.us-west-2.compute.internal>
In-Reply-To: <Y9xOQPPGDrSN0IBu@ip-172-31-38-16.us-west-2.compute.internal>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 3 Feb 2023 16:09:12 +0100
Message-ID: <CANn89iL-RtzMdVuBeM_c4PPqZxk28hVwNhs9vMhwTyJwVhqS9A@mail.gmail.com>
Subject: Re: [RFC] net: add new socket option SO_SETNETNS
To:     Alok Tiagi <aloktiagi@gmail.com>
Cc:     Hillf Danton <hdanton@sina.com>, ebiederm@xmission.com,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 12:59 AM Alok Tiagi <aloktiagi@gmail.com> wrote:
>
> On Thu, Feb 02, 2023 at 09:10:23PM +0100, Eric Dumazet wrote:
> > On Thu, Feb 2, 2023 at 8:55 PM Alok Tiagi <aloktiagi@gmail.com> wrote:
> > >
> > > On Thu, Feb 02, 2023 at 09:48:10AM +0800, Hillf Danton wrote:
> > > > On Wed, 1 Feb 2023 19:22:57 +0000 aloktiagi <aloktiagi@gmail.com>
> > > > > @@ -1535,6 +1535,52 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
> > > > >             WRITE_ONCE(sk->sk_txrehash, (u8)val);
> > > > >             break;
> > > > >
> > > > > +   case SO_SETNETNS:
> > > > > +   {
> > > > > +           struct net *other_ns, *my_ns;
> > > > > +
> > > > > +           if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6) {
> > > > > +                   ret = -EOPNOTSUPP;
> > > > > +                   break;
> > > > > +           }
> > > > > +
> > > > > +           if (sk->sk_type != SOCK_STREAM && sk->sk_type != SOCK_DGRAM) {
> > > > > +                   ret = -EOPNOTSUPP;
> > > > > +                   break;
> > > > > +           }
> > > > > +
> > > > > +           other_ns = get_net_ns_by_fd(val);
> > > > > +           if (IS_ERR(other_ns)) {
> > > > > +                   ret = PTR_ERR(other_ns);
> > > > > +                   break;
> > > > > +           }
> > > > > +
> > > > > +           if (!ns_capable(other_ns->user_ns, CAP_NET_ADMIN)) {
> > > > > +                   ret = -EPERM;
> > > > > +                   goto out_err;
> > > > > +           }
> > > > > +
> > > > > +           /* check that the socket has never been connected or recently disconnected */
> > > > > +           if (sk->sk_state != TCP_CLOSE || sk->sk_shutdown & SHUTDOWN_MASK) {
> > > > > +                   ret = -EOPNOTSUPP;
> > > > > +                   goto out_err;
> > > > > +           }
> > > > > +
> > > > > +           /* check that the socket is not bound to an interface*/
> > > > > +           if (sk->sk_bound_dev_if != 0) {
> > > > > +                   ret = -EOPNOTSUPP;
> > > > > +                   goto out_err;
> > > > > +           }
> > > > > +
> > > > > +           my_ns = sock_net(sk);
> > > > > +           sock_net_set(sk, other_ns);
> > > > > +           put_net(my_ns);
> > > > > +           break;
> > > >
> > > >               cpu 0                           cpu 2
> > > >               ---                             ---
> > > >                                               ns = sock_net(sk);
> > > >               my_ns = sock_net(sk);
> > > >               sock_net_set(sk, other_ns);
> > > >               put_net(my_ns);
> > > >                                               ns is invalid ?
> > >
> > > That is the reason we want the socket to be in an un-connected state. That
> > > should help us avoid this situation.
> >
> > This is not enough....
> >
> > Another thread might look at sock_net(sk), for example from inet_diag
> > or tcp timers
> > (which can be fired even in un-connected state)
> >
> > Even UDP sockets can receive packets while being un-connected,
> > and they need to deref the net pointer.
> >
> > Currently there is no protection about sock_net(sk) being changed on the fly,
> > and the struct net could disappear and be freed.
> >
> > There are ~1500 uses of sock_net(sk) in the kernel, I do not think
> > you/we want to audit all
> > of them to check what could go wrong...
>
> I agree, auditing all the uses of sock_net(sk) is not a feasible option. From my
> exploration of the usage of sock_net(sk) it appeared that it might be safe to
> swap a sockets net ns if it had never been connected but I looked at only a
> subset of such uses.
>
> Introducing a ref counting logic to every access of sock_net(sk) may help get
> around this but invovles a bigger change to increment and decrement the count at
> every use of sock_net().
>
> Any suggestions if this could be achieved in another way much close to the
> socket creation time or any comments on our workaround for injecting sockets using
> seccomp addfd?

Maybe the existing BPF hook in inet_create() could be used ?

err = BPF_CGROUP_RUN_PROG_INET_SOCK(sk);

The BPF program might be able to switch the netns, because at this
time the new socket is not
yet visible from external threads.

Although it is not going to catch dual stack uses (open a V6 socket,
then use a v4mapped address at bind()/connect()/...
