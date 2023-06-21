Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FF0739300
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 01:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjFUX0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 19:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFUX0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:26:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A0B1997;
        Wed, 21 Jun 2023 16:26:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f9b4bf99c2so33752265e9.3;
        Wed, 21 Jun 2023 16:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687390002; x=1689982002;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/6a8fDPnvSzKH7JJrMTTQOKDw1Lym+OsAc6FRrik8BE=;
        b=oRPbW3oIX6AncXsL0H+CdC3kg2fWfcYqjFCTUdYEYORN+RaIiW/UDLro3erTuShe4e
         mb1emZ3YWFnXfb709rgPu4UcJNqh0okh3EZYrPIKxEviRreJzyos9Idc9qKEhq7jMHSq
         XQD8DHT0aQv9ti0IqY6Rs67MIRlwNkHFEANou77YaL2gvUVQjfLEXcLT940ICVa5bPjU
         mQm6UNh9SJVIm1NGqDwSYZkgRxSRGKRFKP2MIA9GqdFRNpeXsZUyr0orvBqYP/TXSvuK
         23Ga8qt9LxZK9QKbX7Z8z2eB3Tzy03H0q+2ys6SkmfZC7hpBtebXJ6GrFYQ7EbVkmBiZ
         K5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687390002; x=1689982002;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6a8fDPnvSzKH7JJrMTTQOKDw1Lym+OsAc6FRrik8BE=;
        b=BSyajOQjqwxF+4TLJJsV7ONSmz8KwRoAnN1ZeKRW5gltj6lMFTbWb2joIncTJxw++9
         AIFXXgCxCA93NPsEApLLorVZVvdbfw+aZ8it87wqhFuslRmuDCImEweAOQN/z45+Kdps
         34H2BEgfpoKSPU5nI3ab2saZ6rW2U9/l1tWyWdYLP8UgZ3s9BZTFBcprfAtYx38s7sa5
         LBEfLKezsqSKyQe5F08lX2G3zrCV/SPw7WT0pYIyQHf711xOHcLu7+WyZM0yQge1NAug
         xx8m4SbBHbQzpLcp+QOe1LX0tFiT/Nl5MHKtBsMQsT8Xgn0alLABRR/onROUXM81M+JV
         gp2w==
X-Gm-Message-State: AC+VfDxDfVV1AMFLjtSsW81lU1JeUVdHqvCZcvUukczUyvnM3NRZ88TD
        AWdDKVxEX81wxKI3eG9NMk8=
X-Google-Smtp-Source: ACHHUZ6sV2tFKt7L1MdOrDeCh0ASFYUNlpE/GWF9FEERc77oyDv41rrPNl14TlyuibX6PFKag7q1UA==
X-Received: by 2002:a1c:7703:0:b0:3f9:ba03:e87c with SMTP id t3-20020a1c7703000000b003f9ba03e87cmr3856751wmi.2.1687390001515;
        Wed, 21 Jun 2023 16:26:41 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id d22-20020a1c7316000000b003f80946116dsm17229830wmb.45.2023.06.21.16.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 16:26:41 -0700 (PDT)
Message-ID: <64938731.1c0a0220.bfc7f.37da@mx.google.com>
X-Google-Original-Message-ID: <ZJJ3q7GDwiTXsshQ@Ansuel-xps.>
Date:   Wed, 21 Jun 2023 06:08:11 +0200
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
References: <64921dee.df0a0220.f64e1.72c7@mx.google.com>
 <20230621102527.f47kmwminkhe7ttt@skbuf>
 <20230620063747.19175-1-ansuelsmth@gmail.com>
 <20230620063747.19175-1-ansuelsmth@gmail.com>
 <20230620201227.7sdb3zmwutwtmt2e@skbuf>
 <64921dee.df0a0220.f64e1.72c7@mx.google.com>
 <20230621102527.f47kmwminkhe7ttt@skbuf>
 <6492df37.7b0a0220.2a67f.9cd7@mx.google.com>
 <6492df37.7b0a0220.2a67f.9cd7@mx.google.com>
 <20230621121742.bsjtvpjz67bnevoq@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230621121742.bsjtvpjz67bnevoq@skbuf>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 03:17:42PM +0300, Vladimir Oltean wrote:
> On Tue, Jun 20, 2023 at 08:52:27PM +0200, Christian Marangi wrote:
> > On Wed, Jun 21, 2023 at 01:25:27PM +0300, Vladimir Oltean wrote:
> > > > > Why do you have to fast age the (user) port?
> > > > > 
> > > > 
> > > > The 2 CPU port have a different mac address, is it a problem?
> > > 
> > > But fast ageing the user port (which is what "port" is, here) gets rid
> > > of the FDB entries learned on that port as part of the bridging service,
> > > and which have it as a *destination*. So I'm not sure how that operation
> > > would help. The MAC address of the DSA masters, if learned at all, would
> > > not point towards any user port but towards CPU ports.
> > > 
> > > FWIW, dsa_port_change_master() takes care of migrating/replaying a lot of
> > > configuration, including the MAC addresses for local address filtering -
> > > dsa_slave_unsync_ha() and dsa_slave_sync_ha().
> > > 
> > 
> > I notice that I require assisted_learning_on_cpu_port to make this
> > actually work.
> > 
> > Wth this false, bridge fdb show still had entry with the MAC of the old
> > master. With assisted, they gets correctly updated.
> 
> The behavior you're describing does not ring a bell to me.
> 
> What assisted_learning_on_cpu_port does is, when DSA is in a bridge with
> a foreign device like wlan0, and wlan0 learns (in software, through the
> bridge driver) a MAC address from a connected station, DSA calls
> port_fdb_add() for that MAC address on the CPU ports associated with all
> user ports from that bridge.
> 
> So it has nothing to do with the MAC address of the DSA master (100% sure).
> 
> Nonetheless, if you implement port_change_master(), you need to make
> sure that port_fdb_add() on the CPU port does something sensible in the
> presence of multiple simultaneously active CPU ports. Reading some
> commit messages from the development of this feature on the felix driver
> may give you some ideas.
>

I will search them.

> > > It would be good to hear from you how do you plan the qca8k driver to
> > > send and receive packets. From looking at the code (learning on the CPU
> > > port isn't enabled), I guess that the MAC addresses of the ports are
> > > never programmed in the FDB and thus, they reach the CPU by flooding,
> > > with the usual drawbacks that come with that - packets destined for
> > > local termination will also be flooded to other stations in the bridging
> > > domain. Getting rid of the reliance on flooding will have its own
> > > challenges. You can't enable automatic address learning [ on the CPU
> > > ports ] with multiple active CPU ports, because one FDB entry could ping
> > > pong from one CPU port to the other, leading to packet loss from certain
> > > user ports when the FDB entry points to the CPU port that isn't affine
> > > to the inbound port. So you'd probably need to program some sort of
> > > "multicast" FDB entries that target all CPU ports, and rely on the
> > > PORT_VID_MEMBER field to restrict forwarding to only one of those CPU
> > > ports at a time.
> > > 
> > 
> > Eh I really think this is not trivial at all and I would love some help.
> > 
> > With further testing, to make this actually work I had to operate on the
> > GLOBAL_FW_CTRL1 regs that handle how to treat unknown frames of all
> > kind.
> > They are classified as unknown when the DA is not contained in the ARL
> > table and are split in IGMP, BROAD (broadcast), MULTI (multicast) and
> > UNI (unicast) and just are just the FLOOD option.
> 
> The qca8k driver lags a bit (more) behind when it comes to implementing
> the bridge offload API efficiently (and correctly).
> 

I'm pushing to finally use it on every ipq806x device we have on OpenWRT
hoping to get more traction in the use... Also ipq40xx should receive
support sometimes this year...

> Namely, it floods everything to the single (first) CPU port and does not
> implement any autonomous flooding to other user ports in the same
> bridging domain. So it relies on software flooding - tag_qca.c does not
> set skb->offload_fwd_mark = true for any kind of packet. Here, I'm
> assuming that there isn't any inherent limitation that prevents
> autonomous flooding from working, and this would offload some tasks from
> the CPU.

I would love to do that, I need to check if I can find some example on
other driver and see if the thing can be handled with the ACL table or
the ARL. The thing is very flexible but maybe too much and hard to
understand for the task we need to accomplish.

>
> In terms of correctness, it enables address learning on all user ports
> by default, which is incorrect because user ports should only learn if
> they are under a bridge *and* that bridge has learning enabled on that
> port. Standalone ports should have address learning disabled, otherwise
> learning will lead to packet loss when connecting two standalone user
> ports to the same LAN. Commit 15f7cfae912e ("net: dsa: microchip: make
> learning configurable and keep it off while standalone") comes to mind
> as an example.

I should have a commit ready for this but I wonder if there is more to
fix looking at the fdb dump.

> 
> I would consider implementing .port_pre_bridge_flags() and .port_bridge_flags()
> before jumping straight ahead to such advanced topics like .port_change_master().
> 
> In general, see what else there is in Documentation/networking/dsa/dsa.rst,
> because the API documentation has been overhauled relatively recently.
> 
> > Saddly in the current configuration to make the secondary CPU port work,
> > I had to set the flooding to both CPU port and I guess this is extremely
> > wrong since I assume linux would receive double the packet for each
> > unknown frame.
> 
> Not sure if it's "extremely wrong", maybe it isn't. A civilized hardware
> implementation would probably restrict the flooding destinations with the
> QCA8K_PORT_LOOKUP_MEMBER mask of the inbound port. So as long as a single
> CPU port is present in that, then even when the flooding destination masks
> contain multiple bits set, each packet goes to a single destination.
> 
> With LAG it should be similar, except that the destination mask is further
> restricted by a port mask indexed by a hash calculated from packet headers.
> 
> It just needs serious testing. Arınç ÜNAL did similar work with mausezahn
> and tcpdump for testing flooding, trapping etc on the mt7530 driver,
> while adding support for multiple CPU ports.
> 

A testing way is to check if packet received to the CPU port are
actually dpulicated on flooding right?

> > And this match what you have theorized about the need of a multicast FDB
> > entry I guess? Main problem is that I have some fear the switch doesn't
> > support controlling flooding with ARL or ACL (but I have to check this
> > better)
> 
> Not sure that I understand what you're saying here.
> 
> > Just for reference this is the current fdb table 
> > 
> > 01:00:5e:00:00:01 dev eth0 self permanent
> > 33:33:00:00:00:02 dev eth0 self permanent
> > 33:33:00:00:00:01 dev eth0 self permanent
> > 33:33:ff:f2:5d:50 dev eth0 self permanent
> > 33:33:ff:00:00:00 dev eth0 self permanent
> > dc:ef:09:f2:5d:4f dev eth1 self permanent
> > 33:33:00:00:00:01 dev eth1 self permanent
> > 33:33:00:00:00:02 dev eth1 self permanent
> > 01:00:5e:00:00:01 dev eth1 self permanent
> > 33:33:ff:f2:5d:4f dev eth1 self permanent
> > 33:33:ff:00:00:00 dev eth1 self permanent
> > c0:3e:ba:c1:d7:47 dev lan1 master br-lan
> 
> The entries with "master" are present in the software bridge database.
> 
> > dc:ef:09:f2:5d:4f dev lan1 vlan 1 master br-lan permanent
> 
> The entries with "permanent" (synonym is "local", BR_FDB_LOCAL in the code)
> are FDB entries that are intended for local termination. They are
> present on a bridge port, but they really mean that packets should go to
> software (the CPU) for local termination, not towards that bridge port.
> 
> > dc:ef:09:f2:5d:4f dev lan1 master br-lan permanent
> > c0:3e:ba:c1:d7:47 dev lan1 vlan 1 self
> 
> The entries with "self" are present in the hardware bridge database.
> 
> > 33:33:00:00:00:01 dev wlan0 self permanent
> > 33:33:00:00:00:02 dev wlan0 self permanent
> > 33:33:00:00:00:01 dev wlan1 self permanent
> > 33:33:00:00:00:02 dev wlan1 self permanent
> > 33:33:00:00:00:01 dev br-lan self permanent
> > 33:33:00:00:00:02 dev br-lan self permanent
> > 01:00:5e:00:00:01 dev br-lan self permanent
> > 33:33:ff:00:00:01 dev br-lan self permanent
> > 33:33:ff:f2:5d:4f dev br-lan self permanent
> > 33:33:00:01:00:02 dev br-lan self permanent
> > 33:33:00:01:00:03 dev br-lan self permanent
> > 33:33:ff:00:00:00 dev br-lan self permanent
> 
> So I would guess that dc:ef:09:f2:5d:4f is the MAC address of br-lan,
> inherited from the MAC address of the first bridge port (DSA switch
> port). In turn, if there is no MAC address for ports in the device tree,
> DSA inherits the MAC address from the master. So that's a plausible
> avenue for the DSA master's MAC address to reach the bridge FDB.
> 
> The bridge notifies local addresses on the switchdev chain with the
> fdb_info->is_local bit set, and DSA calls port_fdb_add() on the CPU
> ports for them. So that's how they might reach the hardware FDB.
> But again, port_fdb_add() programs static FDB entries, and fast ageing
> doesn't remove those.

Did you notice anything wrong in this dump? Entry that should have been
deleted but they aren't?

-- 
	Ansuel
