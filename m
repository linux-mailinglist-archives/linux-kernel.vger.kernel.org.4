Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ABB73E5DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFZQ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFZQ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:56:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96908106;
        Mon, 26 Jun 2023 09:55:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-313e68e99c7so3126113f8f.1;
        Mon, 26 Jun 2023 09:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687798558; x=1690390558;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0CtVdh2bwPFXtiAqHseNgU5XOV2yXb7WFSKHepKg2d4=;
        b=pEJDYN8s1S8dExgQ7NWUS9zN8Pbf6tPi+3W1BAwGWRGU3oTJYz9wLSTTyJjrlcXdoX
         JV7zKuK76UpropGMCOh2LPt67oEGsPUzK6YSIlVNzrWq+a2vn5fm5vmvF2wPUtOuDTBw
         yRh04sqLx5R/DFSUPDSROvwdJgAmor/iThGguJiJi3DtWYVoTf21/VjAe3JnDcN9AhKr
         FhZ2y6cAZj7A/QjInmYOgvhnrTE7R9CfKGEKqC4Uss1EQhh447Vld3d6+goS4A3cTGqb
         ZI8mKM6D+V6W2Idv3TcLnSSxzhBtngNvFVl7sjQpSkeoRtIkkluXYYR4/5iWTAqNHC/e
         9XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687798558; x=1690390558;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CtVdh2bwPFXtiAqHseNgU5XOV2yXb7WFSKHepKg2d4=;
        b=Gh5SPRyVHkjsZX6OOcCvqg7kFWohEYi4YloSIPRlleRlrW8doBWk6z02Zub3BLkLW9
         /H4TaT/hyglyLCPgYC2r7bxW680rztdoDZLAXelJt+dxVZjbNaW5PDYeRTH0crA1awo1
         6gU1pmCIdUy2mp33yIALferSsFBrc+f1JJf5YAAtOSxENnW1so9gaV45DeSMAQeG8WBk
         oU8cpBPiJKlr/mnTXhL6BCGtLf7E3/K1MVAYWA8Acu8SCgWwSVlVpKtJ7WVGOvT18XDg
         0yZahEtw1NFsKpGLjKw4yFi4yUyf75vlx0BEtaJv8QzcnnFXRh53gVONMJamB+wUZhJx
         C03g==
X-Gm-Message-State: AC+VfDwGSjiCsTxw9w54VmCbnI5FxOfCe5FtyWbRHseEnLUsMTqUUTG+
        DSQZByf2nK/ahXcuAOT7y6c=
X-Google-Smtp-Source: ACHHUZ43DPrPTsrlrF8irzur6WjGZ1XZG78XmUz8rfvgGUE1gkIAEVOZLOuKtOXIHB4XjyJqDW28ow==
X-Received: by 2002:a5d:4c49:0:b0:307:9702:dfc8 with SMTP id n9-20020a5d4c49000000b003079702dfc8mr26178001wrt.48.1687798557521;
        Mon, 26 Jun 2023 09:55:57 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id i6-20020adff306000000b00311339f5b06sm7846269wro.57.2023.06.26.09.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:55:56 -0700 (PDT)
Message-ID: <6499c31c.df0a0220.e2acb.5549@mx.google.com>
X-Google-Original-Message-ID: <ZJm/zq4Lw9PmN2Lo@Ansuel-xps.>
Date:   Mon, 26 Jun 2023 18:41:50 +0200
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625115803.6xykp4wiqqdwwzv4@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 02:58:03PM +0300, Vladimir Oltean wrote:
> On Fri, Jun 23, 2023 at 01:40:05PM +0200, Christian Marangi wrote:
> > Address learning should initially be turned off by the driver for port
> > operation in standalone mode, then the DSA core handles changes to it
> > via ds->ops->port_bridge_flags().
> > 
> > Currently this is not the case for qca8k where learning is enabled
> > unconditionally in qca8k_setup for every user port.
> > 
> > Handle ports configured in standalone mode by making the learning
> > configurable and not enabling it by default.
> > 
> > Implement .port_pre_bridge_flags and .port_bridge_flags dsa ops to
> > enable learning for bridge that request it and tweak
> > .port_stp_state_set to correctly disable learning when port is
> > configured in standalone mode.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > 
> > Posting as RFC as I would love some comments from Vladimir for correct
> > implementation of this. This was suggested to be on par with offload
> > bridge API and I used as example [1] (commit that does the same thing
> > with a microchip switch)
> > 
> > I didn't want to bloat the priv struct with additional info with the
> > port state and from what I can see it seems using dp->learning is enough
> > to understand if learning is currently enabled for the port or not but I
> > would love to have some confirmation about this. (from what I notice
> > when port is set in standalone mode, flags are cleared so it should be
> > correct)
> 
> In principle you can use dp->learning, but in this case you are using it
> incorrectly (more below).
>

Hi, thanks a lot for the response and for catching the stupid mistake.

> > 
> > I also verified this working by dumping the fdb in a bridge
> > configuration and in a standalone configuration. Traffic works in both
> > configuration.
> > 
> > Dump WITH BRIDGE CONFIGURATION:
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
> > dc:ef:09:f2:5d:4f dev lan1 vlan 1 master br-lan permanent
> > dc:ef:09:f2:5d:4f dev lan1 master br-lan permanent
> > c0:3e:ba:c1:d7:47 dev lan1 vlan 1 self
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
> > 
> > Dump WITH STANDALONE CONFIGURATION:
> > 01:00:5e:00:00:01 dev eth0 self permanent
> > 33:33:00:00:00:02 dev eth0 self permanent
> > 33:33:00:00:00:01 dev eth0 self permanent
> > 33:33:ff:f2:5d:50 dev eth0 self permanent
> > 33:33:ff:00:00:00 dev eth0 self permanent
> > 33:33:00:00:00:01 dev eth1 self permanent
> > 33:33:00:00:00:02 dev eth1 self permanent
> > 01:00:5e:00:00:01 dev eth1 self permanent
> > 33:33:ff:f2:5d:4f dev eth1 self permanent
> > 33:33:ff:00:00:01 dev eth1 self permanent
> > 33:33:ff:00:00:00 dev eth1 self permanent
> > 33:33:00:01:00:02 dev eth1 self permanent
> > 33:33:00:01:00:03 dev eth1 self permanent
> > 33:33:00:00:00:01 dev wlan0 self permanent
> > 33:33:00:00:00:02 dev wlan0 self permanent
> > 33:33:00:00:00:01 dev wlan1 self permanent
> > 33:33:00:00:00:02 dev wlan1 self permanent
> 
> The information from these dumps is pretty much irrelevant.
> 
> > From what I can see there isn't any self entry with the MAC address of
> > the connected device and this should confirm that learning is actually
> > disabled.
> > 
> > Hope this is enough to test this feature and I would ask what would be
> > the next step to reach a point where port_change_master can be
> > implemented.
> 
> The way to test this patch would be to connect in loopback 2 standalone
> qca8k ports having the same MAC address, and ping from one to the other.
> 
> ip netns add ns0
> ip link set lan1 netns ns0 && ip -n ns0 link set lan1 up
> ip -n ns0 addr add 192.168.100.1/24 dev lan1
> ip link set lan2 up && ip addr add 192.168.100.2/24 dev lan2
> ping 192.168.100.1
> 
> Before, it shouldn't have worked, now it should.

I can confirm this works.

> 
> Once that basic precondition passes, you should be able to start looking
> at tools/testing/selftests/drivers/net/dsa/ and run those one by one.
> An interesting one would be local_termination.sh, which monitors the way
> in which frames reach the CPU. Though be aware that some sub-tests from
> that suite will fail on misconfigurations that are non-fatal (and don't
> impact functionality), just sub-optimal (affecting performance). Like
> sending unknown packets to the CPU when the port is non-promiscuous and
> software would drop those packets anyway.
> 

Lots of difficult to run the selftests on a light fw but step at times
I'm managing to make use of them (could be helpfull to add some comments
in the .config saying that the testing port needs to be declared in the
struct) (and maybe some additional checks on the kind of device type are
required for the test to actually work (vrf, dummy, macvlan...)

Anyway a run of local_termination.sh produce the following output.
# selftests: drivers/net/dsa: local_termination.sh
# TEST: lan1: Unicast IPv4 to primary MAC address                     [FAIL]
#       reception failed
# TEST: lan1: Unicast IPv4 to macvlan MAC address                     [FAIL]
#       reception failed
# TEST: lan1: Unicast IPv4 to unknown MAC address                     [ OK ]
# TEST: lan1: Unicast IPv4 to unknown MAC address, promisc            [FAIL]
#       reception failed
# TEST: lan1: Unicast IPv4 to unknown MAC address, allmulti           [ OK ]
# TEST: lan1: Multicast IPv4 to joined group                          [ OK ]
# TEST: lan1: Multicast IPv4 to unknown group                         [FAIL]
#       reception succeeded, but should have failed
# TEST: lan1: Multicast IPv4 to unknown group, promisc                [FAIL]
#       reception failed
# TEST: lan1: Multicast IPv4 to unknown group, allmulti               [ OK ]
# TEST: lan1: Multicast IPv6 to joined group                          [ OK ]
# TEST: lan1: Multicast IPv6 to unknown group                         [FAIL]
#       reception succeeded, but should have failed
# TEST: lan1: Multicast IPv6 to unknown group, promisc                [FAIL]
#       reception failed
# TEST: lan1: Multicast IPv6 to unknown group, allmulti               [ OK ]
# TEST: br0: Unicast IPv4 to primary MAC address                      [FAIL]
#       reception failed
# TEST: br0: Unicast IPv4 to macvlan MAC address                      [FAIL]
#       reception failed
# TEST: br0: Unicast IPv4 to unknown MAC address                      [ OK ]
# TEST: br0: Unicast IPv4 to unknown MAC address, promisc             [FAIL]
#       reception failed
# TEST: br0: Unicast IPv4 to unknown MAC address, allmulti            [ OK ]
# TEST: br0: Multicast IPv4 to joined group                           [ OK ]
# TEST: br0: Multicast IPv4 to unknown group                          [FAIL]
#       reception succeeded, but should have failed
# TEST: br0: Multicast IPv4 to unknown group, promisc                 [FAIL]
#       reception failed
# TEST: br0: Multicast IPv4 to unknown group, allmulti                [ OK ]
# TEST: br0: Multicast IPv6 to joined group                           [ OK ]
# TEST: br0: Multicast IPv6 to unknown group                          [FAIL]
#       reception succeeded, but should have failed
# TEST: br0: Multicast IPv6 to unknown group, promisc                 [FAIL]
#       reception failed
# TEST: br0: Multicast IPv6 to unknown group, allmulti                [ OK ]

Things doesn't look good to me or I am wrong?

> > (would also love to see what are the criteria to enable offload_fwd_mask
> > on the targget for rcv and eventually for xmit)
> 
> For RX, skb->offload_fwd_mark = true (mark not mask) means that the software
> bridge shouldn't flood packets received on lanX towards other lanY ports that
> are part of the same hwdom, because the hardware already took care of
> that.
> 
> [ the hardware domain is determined by dev_get_port_parent_id() ->
>   devlink_compat_switch_id_get() and populated by dsa_port_devlink_setup() ]
> 
> Obviously, the requirement is for the hardware to indeed take care of that :)
> Currently it doesn't flood to the other user ports that are part of the
> same bridge and have egress flooding enabled for that traffic type. It
> just floods to the CPU and software decides where to flood. It's a
> matter of implementing other brport flags, like BR_FLOOD and friends.
> 
> For TX, skb->offload_fwd_mark means that the driver should be able to
> send a skb potentially towards multiple TX ports at the same time, as a
> result of an FDB lookup. This makes the bridge avoid cloning that skb
> and calling dev_queue_xmit() towards every individual port that it must
> reach. I would concentrate on RX and leave TX for later.
> 

Sure.

> > Thanks for any response and sorry for the long comments.
> > 
> > 
> > [1] https://github.com/torvalds/linux/commit/15f7cfae912e
> > 
> >  drivers/net/dsa/qca/qca8k-8xxx.c   |  8 ++----
> >  drivers/net/dsa/qca/qca8k-common.c | 40 ++++++++++++++++++++++++++++++
> >  drivers/net/dsa/qca/qca8k.h        |  6 +++++
> >  3 files changed, 48 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> > index f08086ac2261..a9af270a03ce 100644
> > --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> > +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> > @@ -1963,12 +1963,6 @@ qca8k_setup(struct dsa_switch *ds)
> >  			if (ret)
> >  				return ret;
> >  
> > -			/* Enable ARP Auto-learning by default */
> > -			ret = regmap_set_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(i),
> > -					      QCA8K_PORT_LOOKUP_LEARN);
> > -			if (ret)
> > -				return ret;
> > -
> >  			/* For port based vlans to work we need to set the
> >  			 * default egress vid
> >  			 */
> > @@ -2071,6 +2065,8 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
> >  	.port_change_mtu	= qca8k_port_change_mtu,
> >  	.port_max_mtu		= qca8k_port_max_mtu,
> >  	.port_stp_state_set	= qca8k_port_stp_state_set,
> > +	.port_pre_bridge_flags	= qca8k_port_pre_bridge_flags,
> > +	.port_bridge_flags	= qca8k_port_bridge_flags,
> >  	.port_bridge_join	= qca8k_port_bridge_join,
> >  	.port_bridge_leave	= qca8k_port_bridge_leave,
> >  	.port_fast_age		= qca8k_port_fast_age,
> > diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
> > index 8c2dc0e48ff4..f93defbd8b66 100644
> > --- a/drivers/net/dsa/qca/qca8k-common.c
> > +++ b/drivers/net/dsa/qca/qca8k-common.c
> > @@ -559,8 +559,24 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
> >  	return 0;
> >  }
> >  
> > +static int qca8k_port_configure_learning(struct dsa_switch *ds, int port,
> > +					 bool learning)
> > +{
> > +	struct qca8k_priv *priv = ds->priv;
> > +
> > +	if (learning)
> > +		return regmap_set_bits(priv->regmap,
> > +				       QCA8K_PORT_LOOKUP_CTRL(port),
> > +				       QCA8K_PORT_LOOKUP_LEARN);
> > +	else
> > +		return regmap_clear_bits(priv->regmap,
> > +					 QCA8K_PORT_LOOKUP_CTRL(port),
> > +					 QCA8K_PORT_LOOKUP_LEARN);
> > +}
> > +
> >  void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
> >  {
> > +	struct dsa_port *dp = dsa_to_port(ds, port);
> >  	struct qca8k_priv *priv = ds->priv;
> >  	u32 stp_state;
> >  
> > @@ -585,6 +601,30 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
> >  
> >  	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
> >  		  QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);
> > +
> > +	qca8k_port_configure_learning(ds, port, dp->learning);
> 
> Learning should be enabled only if we're in an STP state compatible with
> learning: BR_STATE_LEARNING, BR_STATE_FORWARDING. The dp->learning flag
> does not follow the STP state, it is just an override for that.
> 
> So, the condition should be:
> "(state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING) && dp->learning"
>

Fixed.

> > +}
> > +
> > +int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
> > +				struct switchdev_brport_flags flags,
> > +				struct netlink_ext_ack *extack)
> > +{
> > +	if (flags.mask & ~BR_LEARNING)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
> > +			    struct switchdev_brport_flags flags,
> > +			    struct netlink_ext_ack *extack)
> > +{
> > +	int ret;
> > +
> > +	ret = qca8k_port_configure_learning(ds, port,
> > +					    flags.mask & ~BR_LEARNING);
> 
> flags.mask contains the bits that have changed.
> flags.val contains the current value of all bits.
> 
> Passing flags.mask & ~BR_LEARNING (the mask of changed flags except for
> BR_LEARNING) to qca8k_port_configure_learning() makes absolutely no sense.
> 

Very stupid of me.

> > +
> > +	return ret;
> >  }
> >  
> >  int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
> > diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
> > index c5cc8a172d65..8f88b7db384d 100644
> > --- a/drivers/net/dsa/qca/qca8k.h
> > +++ b/drivers/net/dsa/qca/qca8k.h
> > @@ -522,6 +522,12 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *e);
> >  
> >  /* Common bridge function */
> >  void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);
> > +int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
> > +				struct switchdev_brport_flags flags,
> > +				struct netlink_ext_ack *extack);
> > +int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
> > +			    struct switchdev_brport_flags flags,
> > +			    struct netlink_ext_ack *extack);
> >  int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
> >  			   struct dsa_bridge bridge,
> >  			   bool *tx_fwd_offload,
> > -- 
> > 2.40.1
> > 
> 

-- 
	Ansuel
