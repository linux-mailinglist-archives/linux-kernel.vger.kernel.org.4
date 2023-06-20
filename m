Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755247382B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjFULaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjFULaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:30:03 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D34E72;
        Wed, 21 Jun 2023 04:30:02 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f900cd3f96so46052065e9.2;
        Wed, 21 Jun 2023 04:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687347000; x=1689939000;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dNYM1xDNj8qXOAJl8G0SV3ajmO0s2cTjxjuJEO6+NZ8=;
        b=Rg8cq3+ialIqpiGV776GWWCrvhlrWrwfypNC0N2/1hU7UrEcY8QvWb6N7bqX//jbwK
         QetVCLSeUHI9gLHM6o/HgZDtp2M5QUjgFRKkI+UqwwaV+c8n4r3kZ0DQBDoG+2TiWhD8
         YHt6SGzwWoiQ1jZTm13flc+8J7f1BvESoa126frYnI6WP2O6ITTd1UdGDMxTuHUjTorb
         p88cHu/FP9YhVI0FDelNQVbVWtrhPMMAUrD/cVN4dafbXu/8TTbvcO/7rMJrQ6drHO7k
         B4WUj4Q2RyK3JG8EFAiO3Nzb9kdzo51i4jbeuhNh9A694VSc0/9K5RC+IXGC6Gpwn7gf
         N+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687347000; x=1689939000;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNYM1xDNj8qXOAJl8G0SV3ajmO0s2cTjxjuJEO6+NZ8=;
        b=ToIhUdUd7eeN7ABrNeGbUiJ64NMOY+kX1soMQEQCQFYvkbZKO7eMzs5hae3SWaF2bU
         FU7SqTZf3vy7KApT2b3f3l9qcGToOvhpon31srMjxYkmbkhNF4Gs3FUPyM2h9kpYazYr
         BB0cPqiLOBWHD3nLLKhLg7Qzx7jVtLJhr7vD6qofdCaOrOT1rUv1ierAsUtyc+NwXIaa
         SgpPAhBKuAlC84TyyNy4diRlcS4/pRn8BEShZfYDBJYoMq6Z6HUnK7xdXFNNXcnLwdmw
         0yDTm+x7aKK/YYlYbqltMHgkD5H717GukVZwfj48ysi0AYYiIXAv3eQiTQWVGFaWYWAr
         J8xg==
X-Gm-Message-State: AC+VfDxGWeCCpSJNatrEFk3zDR4YALAO8iimKgAwEIEGqgqiFrsPITgc
        7gS3eZOgDAhbEeIMJJ+0SsE=
X-Google-Smtp-Source: ACHHUZ6OxfJCGOtXeIp6uUYGHHlUpRiDMpJCG7swWbQhcp3thXjvtLjA0I9e0tjNKaaIDpKaBo2Yyg==
X-Received: by 2002:a05:600c:295:b0:3f9:c8b2:dfbd with SMTP id 21-20020a05600c029500b003f9c8b2dfbdmr484988wmk.19.1687347000004;
        Wed, 21 Jun 2023 04:30:00 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bc8c9000000b003f9b0f640b1sm4712216wml.22.2023.06.21.04.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 04:29:59 -0700 (PDT)
Message-ID: <6492df37.7b0a0220.2a67f.9cd7@mx.google.com>
X-Google-Original-Message-ID: <ZJH1azjleKH/mr9Z@Ansuel-xps.>
Date:   Tue, 20 Jun 2023 20:52:27 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: dsa: qca8k: add support for
 port_change_master
References: <20230620063747.19175-1-ansuelsmth@gmail.com>
 <20230620063747.19175-1-ansuelsmth@gmail.com>
 <20230620201227.7sdb3zmwutwtmt2e@skbuf>
 <64921dee.df0a0220.f64e1.72c7@mx.google.com>
 <20230621102527.f47kmwminkhe7ttt@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621102527.f47kmwminkhe7ttt@skbuf>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 01:25:27PM +0300, Vladimir Oltean wrote:
> On Tue, Jun 20, 2023 at 03:04:28PM +0200, Christian Marangi wrote:
> > > > +			if (dsa_port_is_cpu(dp))
> > > > +				cpu_port_mask |= BIT(dp->index);
> > > > +	} else {
> > > > +		dp = dsa_port_from_netdev(master);
> > > 
> > > dsa_port_from_netdev() is implemented by calling:
> > > 
> > > static inline struct dsa_port *dsa_slave_to_port(const struct net_device *dev)
> > > {
> > > 	struct dsa_slave_priv *p = netdev_priv(dev);
> > > 
> > > 	return p->dp;
> > > }
> > > 
> > > The "struct net_device *master" does not have a netdev_priv() of the
> > > type "struct dsa_slave_priv *". So, this function does not do what you
> > > want, but instead it messes through the guts of an unrelated private
> > > structure, treating whatever it finds at offset 16 as a pointer, and
> > > dereferincing that as a struct dsa_port *. I'm surprised it didn't
> > > crash, to be frank.
> > > 
> > > To find the cpu_dp behind the master, you need to dereference
> > > master->dsa_ptr (for which we don't have a helper).
> > > 
> > 
> > I was searching for an helper but no luck. Is it safe to access
> > master->dsa_ptr? In theory the caller of port_change_master should
> > already check that the passed master is a dsa port?
> 
> *that the passed network interface is a master - netdev_uses_dsa()
> 
> What is attached to the DSA master through dev->dsa_ptr is the CPU port.
> 
> what makes a net_device be a DSA master is dsa_master_setup(), and what
> makes it stop being that is dsa_master_teardown(). Both are called under
> rtnl_lock(), so as long as you are in a calling context where that lock
> is held, you can be sure that the value of netdev_uses_dsa() does not
> change for a device - and thus the value of dev->dsa_ptr.
>
> > I see in other context that master->dsa_ptr is checked if not NULL.
> > Should I do the same check here?
> 
> Nope. DSA takes care of passing a fully set up DSA master as the
> "master" argument, and the calling convention is that rtnl_lock() is held.
>

Thanks for both clarification!

> > > > +	/* Assign the new CPU port in LOOKUP MEMBER */
> > > > +	val |= cpu_port_mask;
> > > > +
> > > > +	ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
> > > > +			QCA8K_PORT_LOOKUP_MEMBER,
> > > > +			val);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/* Fast Age the port to flush FDB table */
> > > > +	qca8k_port_fast_age(ds, port);
> > > 
> > > Why do you have to fast age the (user) port?
> > > 
> > 
> > The 2 CPU port have a different mac address, is it a problem?
> 
> But fast ageing the user port (which is what "port" is, here) gets rid
> of the FDB entries learned on that port as part of the bridging service,
> and which have it as a *destination*. So I'm not sure how that operation
> would help. The MAC address of the DSA masters, if learned at all, would
> not point towards any user port but towards CPU ports.
> 
> FWIW, dsa_port_change_master() takes care of migrating/replaying a lot of
> configuration, including the MAC addresses for local address filtering -
> dsa_slave_unsync_ha() and dsa_slave_sync_ha().
> 

I notice that I require assisted_learning_on_cpu_port to make this
actually work.

Wth this false, bridge fdb show still had entry with the MAC of the old
master. With assisted, they gets correctly updated.

> That being said, those 2 functions are dead code for your switch,
> because dsa_switch_supports_uc_filtering() and dsa_switch_supports_mc_filtering()
> both return false.
> 
> It would be good to hear from you how do you plan the qca8k driver to
> send and receive packets. From looking at the code (learning on the CPU
> port isn't enabled), I guess that the MAC addresses of the ports are
> never programmed in the FDB and thus, they reach the CPU by flooding,
> with the usual drawbacks that come with that - packets destined for
> local termination will also be flooded to other stations in the bridging
> domain. Getting rid of the reliance on flooding will have its own
> challenges. You can't enable automatic address learning [ on the CPU
> ports ] with multiple active CPU ports, because one FDB entry could ping
> pong from one CPU port to the other, leading to packet loss from certain
> user ports when the FDB entry points to the CPU port that isn't affine
> to the inbound port. So you'd probably need to program some sort of
> "multicast" FDB entries that target all CPU ports, and rely on the
> PORT_VID_MEMBER field to restrict forwarding to only one of those CPU
> ports at a time.
> 

Eh I really think this is not trivial at all and I would love some help.

With further testing, to make this actually work I had to operate on the
GLOBAL_FW_CTRL1 regs that handle how to treat unknown frames of all
kind.
They are classified as unknown when the DA is not contained in the ARL
table and are split in IGMP, BROAD (broadcast), MULTI (multicast) and
UNI (unicast) and just are just the FLOOD option.
Saddly in the current configuration to make the secondary CPU port work,
I had to set the flooding to both CPU port and I guess this is extremely
wrong since I assume linux would receive double the packet for each
unknown frame.

And this match what you have theorized about the need of a multicast FDB
entry I guess? Main problem is that I have some fear the switch doesn't
support controlling flooding with ARL or ACL (but I have to check this
better)

Just for reference this is the current fdb table 

01:00:5e:00:00:01 dev eth0 self permanent
33:33:00:00:00:02 dev eth0 self permanent
33:33:00:00:00:01 dev eth0 self permanent
33:33:ff:f2:5d:50 dev eth0 self permanent
33:33:ff:00:00:00 dev eth0 self permanent
dc:ef:09:f2:5d:4f dev eth1 self permanent
33:33:00:00:00:01 dev eth1 self permanent
33:33:00:00:00:02 dev eth1 self permanent
01:00:5e:00:00:01 dev eth1 self permanent
33:33:ff:f2:5d:4f dev eth1 self permanent
33:33:ff:00:00:00 dev eth1 self permanent
c0:3e:ba:c1:d7:47 dev lan1 master br-lan
dc:ef:09:f2:5d:4f dev lan1 vlan 1 master br-lan permanent
dc:ef:09:f2:5d:4f dev lan1 master br-lan permanent
c0:3e:ba:c1:d7:47 dev lan1 vlan 1 self
33:33:00:00:00:01 dev wlan0 self permanent
33:33:00:00:00:02 dev wlan0 self permanent
33:33:00:00:00:01 dev wlan1 self permanent
33:33:00:00:00:02 dev wlan1 self permanent
33:33:00:00:00:01 dev br-lan self permanent
33:33:00:00:00:02 dev br-lan self permanent
01:00:5e:00:00:01 dev br-lan self permanent
33:33:ff:00:00:01 dev br-lan self permanent
33:33:ff:f2:5d:4f dev br-lan self permanent
33:33:00:01:00:02 dev br-lan self permanent
33:33:00:01:00:03 dev br-lan self permanent
33:33:ff:00:00:00 dev br-lan self permanent

> > > > +
> > > > +	/* Reenable port */
> > > > +	qca8k_port_set_status(priv, port, 1);
> > > 
> > > or disable/enable it, for that matter?
> > > 
> > 
> > The idea is sto stop any traffic flowing to one CPU to another before
> > doing the change.
> 
> Both DSA masters are prepared to handle traffic when port_change_master()
> is called, so unless there's some limitation in the qca8k driver, there
> shouldn't be any in DSA.
> 

This is nice, I will drop all the bloat.

> > > From my notes in commit eca70102cfb1 ("net: dsa: felix: add support for
> > > changing DSA master"), I recall this:
> > > 
> > >     When we change the DSA master to a LAG device, DSA guarantees us that
> > >     the LAG has at least one lower interface as a physical DSA master.
> > >     But DSA masters can come and go as lowers of that LAG, and
> > >     ds->ops->port_change_master() will not get called, because the DSA
> > >     master is still the same (the LAG). So we need to hook into the
> > >     ds->ops->port_lag_{join,leave} calls on the CPU ports and update the
> > >     logical port ID of the LAG that user ports are assigned to.
> > > 
> > > Otherwise said:
> > > 
> > > $ ip link add bond0 type bond mode balance-xor && ip link set bond0 up
> > > $ ip link set eth0 down && ip link set eth0 master bond0 # .port_change_master() gets called
> > > $ ip link set eth1 down && ip link set eth1 master bond0 # .port_change_master() does not get called
> > > $ ip link set eth0 nomaster # .port_change_master() does not get called
> > > 
> > > Unless something has changed, I believe that you need to handle these as well,
> > > and update the QCA8K_PORT_LOOKUP_MEMBER field. In the case above, your
> > > CPU port association would remain towards eth0, but the bond's lower interface
> > > is eth1.
> > > 
> > 
> > Can you better describe this case?
> > 
> > In theory from the switch view, with a LAG we just set that an user port
> > can receive packet from both CPU port.
> > 
> > Or you are saying that when an additional memeber is added to the LAG,
> > port_change_master is not called and we could face a scenario where:
> > 
> > - dsa master is LAG
> > - LAG have the 2 CPU port
> > - user port have LAG as master but QCA8K_PORT_LOOKUP_MEMBER with only
> >   one CPU?
> > 
> > If I got this right, then I get what you mean with the fact that I
> > should update the lag_join/leave definition and refresh each
> > configuration.
> 
> In Documentation/networking/dsa/configuration.rst I gave 2 examples of
> changing the DSA master to be a LAG.
> 
> In the list of 4 commands I posted in the previous reply, I assumed that
> eth0 is the original DSA master, and eth1 is the second (initially inactive)
> DSA master.
> 
> When eth0 joins a LAG, DSA notices that and implicitly migrates all user
> ports affine to eth0 towards bond0 as the new DSA master. At that time,
> .port_change_master() will be called for all user ports under eth0, to
> be notified that the new DSA master is bond0.
> 
> Once all user ports have bond0 as a DSA master, .port_change_master()
> will no longer be called as long as bond0 remains their DSA master.
> But the lower port configuration of bond0 can still change.
> 
> During the command where eth1 also becomes a lower port of bond0, DSA
> just calls .port_lag_join() for the CPU port attached to eth1, and you
> need to handle that and update the CPU port mask. Same thing when eth0
> leaves bond0.

Ok thanks for the clarification, I will implement refresh function in
lag join and leave.

-- 
	Ansuel
