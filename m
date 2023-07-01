Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3281745037
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjGBTHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjGBTHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:07:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E16BD;
        Sun,  2 Jul 2023 12:07:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3143493728dso696154f8f.1;
        Sun, 02 Jul 2023 12:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688324864; x=1690916864;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2g9N0be71kU2aOWwVpMKrcdoyfkU7tm18XjUKrhTHcM=;
        b=M8OFA14XwdlPNsrVHzU2GxVS/5Ktf1Nyqg6wyYN9bxzasvevzs2kam48y0Y854pZGU
         x4up2HvciUXDpIRJSt/+Abo1bQ1xY8v0zobnHWgDg5k7paIx0E2+XUit49Xiu9g2cRvr
         2c8IGLG1EUFGZ1WVFLVuz+1Rn0O7YEnFyahsTgS8J3fQyIFRZJ8OWNfvDAlMzB1GDK9O
         qg8KPwf0xtk99SEcOBMfy0jTN5HsXHHRLEz+N7Lk+sAxDPxu86sZpPYJWETdxovOJk+f
         WBa1eGnbmxVVEX/rvkV8Q4Sz++ochAgjHyCbPUSS1YhTyTCRCmcgcEZzdgZ/rJgrovfz
         +EWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688324864; x=1690916864;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2g9N0be71kU2aOWwVpMKrcdoyfkU7tm18XjUKrhTHcM=;
        b=iUyhh4dhsq9pMpAfemN2J8C9Tc+ERgpf+Dbd2w1hG6poZ2cdNwk4JNcZ3K/fDSF02y
         5vpVeLhntgCdLz8kvhJauu+Is1cKZU8k1DGapWbJK08Do7XiXnh/NtuDJA5A2zBUN7RC
         bwJEQ5e+/4NSSrMMd5uBR+d7+gAZu5XqTnvaqkuI3v2ZnV+Ult9bggGpzmxk/yW/6W0s
         Xl8/zB7e20AARpuJBH0lxQ/jFnAGP6Ouj3/GI5WdFLPss8fl5swWrMIo3nAZrHBIL1q8
         tEJiFGaEkHxb+HQKIfJNlxr7GOcuWwzzC+MNd6vYgJhTvzl1IX/DxjfxBrklohrusn7f
         sTEw==
X-Gm-Message-State: ABy/qLZeaSwLGljlCh3/jwLc7+gml1qLLHl4bh74BYjOX8oMQKNmQMxm
        xKt61XlbTRUQn3wtUS/7Tr8=
X-Google-Smtp-Source: APBJJlFtkZS2gj17J3kaFAkhrXtjuXVfp/XfWui8yWOiYN1MYh17map8xtbuJkXGAd9g+L3FBbr6/g==
X-Received: by 2002:a5d:4989:0:b0:313:f61c:42b2 with SMTP id r9-20020a5d4989000000b00313f61c42b2mr6900899wrq.69.1688324863694;
        Sun, 02 Jul 2023 12:07:43 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id c1-20020a056000104100b003140039f318sm14799760wrx.69.2023.07.02.12.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 12:07:43 -0700 (PDT)
Message-ID: <64a1caff.050a0220.561f4.7316@mx.google.com>
X-Google-Original-Message-ID: <ZKBvh9ExU7oi7Yf5@Ansuel-xps.>
Date:   Sat, 1 Jul 2023 20:25:11 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Atin Bainada <hi@atinb.me>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH RFC] net: dsa: qca8k: make learning configurable
 and keep off if standalone
References: <20230623114005.9680-1-ansuelsmth@gmail.com>
 <20230623114005.9680-1-ansuelsmth@gmail.com>
 <20230625115803.6xykp4wiqqdwwzv4@skbuf>
 <6499c31c.df0a0220.e2acb.5549@mx.google.com>
 <20230626173056.zq77nilzrr5djns5@skbuf>
 <6499d3f5.050a0220.3becf.7296@mx.google.com>
 <20230627094916.maywojwztzdek5y2@skbuf>
 <649c3931.df0a0220.136ab.2fb7@mx.google.com>
 <20230629123954.jjcz2rfygwnxa6pq@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629123954.jjcz2rfygwnxa6pq@skbuf>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 03:39:54PM +0300, Vladimir Oltean wrote:
> On Wed, Jun 28, 2023 at 02:49:53AM +0200, Christian Marangi wrote:
> > Hi, I wasted a day to only notice that the problem was in busybox not
> > supporting 0.x value and that is what selfttest script use. Another
> > thing to check. Also the confusing part of this is that we don't check
> > if ping_do return error and the test just fails (while in reality the
> > ping command was never executed)
> 
> Interesting. Not sure how you'll check for the specific busybox
> implementation. Does it help if you add "check_err $?" after ping_do()
> in send_uc_ipv4(), like ping_test() has?
>

I think it's better to implement some simple tests before the test is
done. Similar to tools missing tests...

So something like "ping -i 0.1" and reading the output if it does match
a specific error. Or at least add some comments that that option is
required. But I guess check_err should be added anyway since it'd the
current pattern used in lib.sh

> > Anyway I'm fixing all kind of bugs and I even found an even hw
> > limitation with the FDB table with mgmt packet...
> > 
> > Also I implemented fdb_insolation following the implementation done on
> > felix with reserving VID at the end...
> > About this I wonder if it might be a good idea to expose some generic
> > API from DSA?
> > 
> > qca8k require a reserved VID for VLAN unaware port and with
> > fdb_isolation even more VID are reserved. DSA have no idea about this so
> > I wonder if there is a chance of VID clash? I feel like we need
> > something to declare a range of reserved VID so that they gets rejected
> > when applied. (about this I think I should return -EINVAL if fdb/mbd
> > insert are asked with a reserved VID)
> 
> I don't think that it's possible to get a port_fdb_add() or port_mdb_add()
> call for a VID that wasn't accepted through port_vlan_add() first.
> At least I don't see how. The VLAN-aware FDB entries come from the
> bridge through SWITCHDEV_OBJ_ID_PORT_VLAN and from DSA's private
> .ndo_vlan_rx_add_vid() / .ndo_vlan_rx_kill_vid() implementations for
> VLAN filters (those that land in dp->user_vlans; refresh your net.git
> tree if you don't find those).
> 

Ok so in theory it should be reserved and a check should be added in
port_valn_add to return an error if a reserved VID is used.

> If we reject VLANs at those layers, then:
> # through the bridge
> [root@mox:~] # bridge fdb add 00:01:02:03:04:05 vlan 2000 dev lan21 master static
> [ 7611.225227] bridge: RTM_NEWNEIGH with unconfigured vlan 2000 on lan21
> RTNETLINK answers: Invalid argument
> # bridge bypass, should go through ndo_fdb_add() if DSA had one
> [root@mox:~] # bridge fdb add 00:01:02:03:04:05 vlan 2000 dev lan21 self static
> [ 7855.532615] mv88e6085 d0032004.mdio-mii:12 lan21: default FDB implementation only supports local addresses
> RTNETLINK answers: Invalid argument
> 
> So, while we could probably add some API in core DSA for a reserved VID
> range, I'm not sure that it will be that useful.
> 
> And regarding whether there is a chance of VID class? I guess there is.
> I have a board where the felix driver (reserved range 4000-4095) is a
> DSA master for the sja1105 driver (reserved range 3072-4095 for tag_8021q).
> Since any dsa_tag_8021q_port_setup() call does a vlan_vid_add() call
> towards the master, then there's a chance that felix could reject the
> tag_8021q setup of the sja1105 ports for tag_8021q VIDs 4000 and upwards.
> 
> VID 4000 = 0xfa0 = bitwise 0b1111_1010_0000
> 
> Comparing with net/dsa/tag_8021q.c:
> 
>  * | 11  | 10  |  9  |  8  |  7  |  6  |  5  |  4  |  3  |  2  |  1  |  0  |
>  * +-----------+-----+-----------------+-----------+-----------------------+
>  * |    RSV    | VBID|    SWITCH_ID    |   VBID    |          PORT         |
>  * +-----------+-----+-----------------+-----------+-----------------------+
> 
> So it would be problematic for VBID >= 6, whenever SWITCH_ID >= 6.
> However, practical applications of tag_8021q with the sja1105 boards
> that I'm aware of do not have 7 switches, so it's a theoretical problem
> only.
> 
> Though we would need to be rather careful when calculating and enforcing
> the reserved ranges in the DSA core, to not cause false positive errors.
> 

Was just an idea since I see only felix using fdb_isolation and it seems
reserving VID is the current way to handle it.

> > 
> > Anyway by fixing that interval problem (enabling support in busybox as
> > it's disabled by default in a OpenWRT system)
> > This is the new output of the local_termination.sh 
> > 
> > TAP version 13
> > 1..1
> > # selftests: drivers/net/dsa: local_termination.sh
> > # TEST: lan1: Unicast IPv4 to primary MAC address                     [ OK ]
> > # TEST: lan1: Unicast IPv4 to macvlan MAC address                     [ OK ]
> > # TEST: lan1: Unicast IPv4 to unknown MAC address                     [FAIL]
> > #       reception succeeded, but should have failed
> > # TEST: lan1: Unicast IPv4 to unknown MAC address, promisc            [ OK ]
> > # TEST: lan1: Unicast IPv4 to unknown MAC address, allmulti           [FAIL]
> > #       reception succeeded, but should have failed
> > # TEST: lan1: Multicast IPv4 to joined group                          [ OK ]
> > # TEST: lan1: Multicast IPv4 to unknown group                         [FAIL]
> > #       reception succeeded, but should have failed
> > # TEST: lan1: Multicast IPv4 to unknown group, promisc                [ OK ]
> > # TEST: lan1: Multicast IPv4 to unknown group, allmulti               [ OK ]
> > # TEST: lan1: Multicast IPv6 to joined group                          [ OK ]
> > # TEST: lan1: Multicast IPv6 to unknown group                         [FAIL]
> > #       reception succeeded, but should have failed
> > # TEST: lan1: Multicast IPv6 to unknown group, promisc                [ OK ]
> > # TEST: lan1: Multicast IPv6 to unknown group, allmulti               [ OK ]
> > # TEST: br0: Unicast IPv4 to primary MAC address                      [ OK ]
> > # TEST: br0: Unicast IPv4 to macvlan MAC address                      [ OK ]
> > # TEST: br0: Unicast IPv4 to unknown MAC address                      [FAIL]
> > #       reception succeeded, but should have failed
> > # TEST: br0: Unicast IPv4 to unknown MAC address, promisc             [ OK ]
> > # TEST: br0: Unicast IPv4 to unknown MAC address, allmulti            [FAIL]
> > #       reception succeeded, but should have failed
> > # TEST: br0: Multicast IPv4 to joined group                           [ OK ]
> > # TEST: br0: Multicast IPv4 to unknown group                          [FAIL]
> > #       reception succeeded, but should have failed
> > # TEST: br0: Multicast IPv4 to unknown group, promisc                 [ OK ]
> > # TEST: br0: Multicast IPv4 to unknown group, allmulti                [ OK ]
> > # TEST: br0: Multicast IPv6 to joined group                           [ OK ]
> > # TEST: br0: Multicast IPv6 to unknown group                          [FAIL]
> > #       reception succeeded, but should have failed
> > # TEST: br0: Multicast IPv6 to unknown group, promisc                 [ OK ]
> > # TEST: br0: Multicast IPv6 to unknown group, allmulti                [ OK ]
> > not ok 1 selftests: drivers/net/dsa: local_termination.sh # exit=1
> > 
> > Seems good aside from the reception secceeded that I think the kernel
> > just drops right?
> 
> Looks good. If you've implemented FDB isolation, then it means that you
> get port_fdb_add() and port_mdb_add() calls on the CPU port(s), and you
> can now also implement .port_set_host_flood() and that should also make
> the following tests pass:
> 
> * TEST: lan1: Unicast IPv4 to unknown MAC address                     [FAIL]
> * TEST: lan1: Unicast IPv4 to unknown MAC address, allmulti           [FAIL]
> * TEST: lan1: Multicast IPv4 to unknown group                         [FAIL]
> * TEST: lan1: Multicast IPv6 to unknown group                         [FAIL]
> 
> The bridge tests to an unknown address will always fail with the message
> "reception succeeded, but should have failed", so it's not you, it's the
> test there.
> 
> Once you're there, you can re-do these tests with:
> - all user ports to CPU port 0
> - all user ports to CPU port 6
> - user ports statically split between CPU ports 0 and 6
> - all user ports to LAG composed of CPU ports 0 and 6
> 

I have bad and good news about this... Bad news is that it seems to be
qca8k handle flooding in a very interesting and broken way.
Due to DSA implementation we expect every packet to be flooded to the
CPU port by default and this is problematic with how the switch works.

It seems that enabling flood bit for the CPU results in packet always be
directed there... The switch tagger have a way to comunicate that the
packet is flooded to the cpu.

With some code in the tagger I manage to reach this state from
local_termination.sh

root@OpenWrt:~# /ktests/run_kselftest.sh -t drivers/net/dsa:local_termination.sh
TAP version 13
1..1
# selftests: drivers/net/dsa: local_termination.sh
# TEST: lan1: Unicast IPv4 to primary MAC address                     [ OK ]
# TEST: lan1: Unicast IPv4 to macvlan MAC address                     [ OK ]
# TEST: lan1: Unicast IPv4 to unknown MAC address                     [ OK ]
# TEST: lan1: Unicast IPv4 to unknown MAC address, promisc            [ OK ]
# TEST: lan1: Unicast IPv4 to unknown MAC address, allmulti           [ OK ]
# TEST: lan1: Multicast IPv4 to joined group                          [ OK ]
# TEST: lan1: Multicast IPv4 to unknown group                         [ OK ]
# TEST: lan1: Multicast IPv4 to unknown group, promisc                [ OK ]
# TEST: lan1: Multicast IPv4 to unknown group, allmulti               [ OK ]
# TEST: lan1: Multicast IPv6 to joined group                          [ OK ]
# TEST: lan1: Multicast IPv6 to unknown group                         [ OK ]
# TEST: lan1: Multicast IPv6 to unknown group, promisc                [ OK ]
# TEST: lan1: Multicast IPv6 to unknown group, allmulti               [ OK ]
# TEST: br0: Unicast IPv4 to primary MAC address                      [ OK ]
# TEST: br0: Unicast IPv4 to macvlan MAC address                      [ OK ]
# TEST: br0: Unicast IPv4 to unknown MAC address                      [FAIL]
#       reception succeeded, but should have failed
# TEST: br0: Unicast IPv4 to unknown MAC address, promisc             [ OK ]
# TEST: br0: Unicast IPv4 to unknown MAC address, allmulti            [FAIL]
#       reception succeeded, but should have failed
# TEST: br0: Multicast IPv4 to joined group                           [ OK ]
# TEST: br0: Multicast IPv4 to unknown group                          [FAIL]
#       reception succeeded, but should have failed
# TEST: br0: Multicast IPv4 to unknown group, promisc                 [ OK ]
# TEST: br0: Multicast IPv4 to unknown group, allmulti                [ OK ]
# TEST: br0: Multicast IPv6 to joined group                           [ OK ]
# TEST: br0: Multicast IPv6 to unknown group                          [FAIL]
#       reception succeeded, but should have failed
# TEST: br0: Multicast IPv6 to unknown group, promisc                 [ OK ]
# TEST: br0: Multicast IPv6 to unknown group, allmulti                [ OK ]
not ok 1 selftests: drivers/net/dsa: local_termination.sh # exit=1

The tagger check if the packet type is a flood kind and drop the packet
(return NULL) if the interface is not promisc or allmulti. If the port
if bridge type this check is skipped...

My concern is... Is it ok to implement host_set_flood this way? I tried
many variant and I wasn't able to make flood work by using those bits...

With the current implementation, host_set_flood will return always zero
and everything will be handled in the tagger by dropping packet but I'm
not sure it's ok to do it.

> > The switch have a way to control FLOOD per port but maybe the correct
> > feature to use is the VLAN leaky? Where the setting can be set by both
> > FDB/MBD and per port.
> 
> I'm not sure why would the leaky VLAN feature be useful ("enable
> specific frames to be forwarded across VLAN boundary"). I really don't
> know what you're thinking about.
> 

Yes sorry, just me wasting way too much time on this and searching for
alternative solution... Switch documentation doesn't describe these case
very well sadly...

> > Sorry if I described some fix and implementation without proposing the
> > patch but I would like some comments on what the tool returned.
> > 

-- 
	Ansuel
