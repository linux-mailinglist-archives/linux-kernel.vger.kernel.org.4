Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EAC7376CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjFTVpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFTVpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:45:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCCD1985;
        Tue, 20 Jun 2023 14:45:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30fbf253dc7so4140554f8f.0;
        Tue, 20 Jun 2023 14:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687297519; x=1689889519;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bjFWolrp+M6VdHQye2nkm7pEpa5YufBJ9Hnmhmq+TOw=;
        b=IeDUENFa27UDZuXfr7Gb0kHyoG0WP4gmPGyyR7a26iYLrXZaNX8Jra7V/MNmq/CUb9
         v9seiTlW6r9xHZ6mUFjC+L84QOKNZTvBPlUxbC1b+NB2/8K5xJ39cqbK2ud1ooHZfGEd
         SU2wfNmfx+Q1kNmV8oStcfC+CV0LyjiUf+xyHzwYoaXQGc2I8ZZVDeEayCMYbjtHZ1m4
         p1Kq+qw+D5f6HDmM1cbqKOzXodjTDktRvbC+fR1flPAko7P9P6H+oKqH+KzSnnZe/Gyx
         4SDuudnAk/GLWiGBY+/vuM6TmljFz1ILhhr2VttgHR6ywOF/NBEHClVlDdTEV5+tOS9I
         JJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687297519; x=1689889519;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjFWolrp+M6VdHQye2nkm7pEpa5YufBJ9Hnmhmq+TOw=;
        b=XvWUREagjKsdjCy5b3oyhYwm9tKS8km6vt4ewkUNSCCOZT5f8jLKU3SnFUWFisxSgZ
         dpasPM0HcXG3qk2FGnIwZB5nL9VKcHMdNp5GV50zN+ARIXI6cd2dqQylNrapHndWgC4n
         bPA5OGX+ePSLzcnPCuj0p/EPYG7W1Sr2GhatuNXYs3OxNt050ugNMCK8zbcJVJXEpU1w
         mx8KkreoKz5v8NAbX+scKeCal+gCGbJuAg94hXHjV5od0o787yIEuT5A/sW4XqCIYRSj
         vnew7QiJCz3Hmfk97738BvVt6BggkKHvu4RPZFzAV6LoYPfN3WFKt5IsTIw1SZnrfhmC
         8MtA==
X-Gm-Message-State: AC+VfDzxd7eWo0+67SK1O/V+2CfY7ZwHmfs0MY2Dz7p9uwE4injUUweC
        7GX/ASf8iyiuMMlD4kFiwZw=
X-Google-Smtp-Source: ACHHUZ7nlMDdLtN8OT+F5kq/tIwd6foXtf8Xe9WsUQADEz2iesZ0qYY3m9C+JFHwM3jnvPzn8l1NmQ==
X-Received: by 2002:a5d:630c:0:b0:311:3554:bec9 with SMTP id i12-20020a5d630c000000b003113554bec9mr7766164wru.21.1687297519199;
        Tue, 20 Jun 2023 14:45:19 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id c1-20020adfed81000000b0030aedb8156esm2798460wro.102.2023.06.20.14.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 14:45:18 -0700 (PDT)
Message-ID: <64921dee.df0a0220.f64e1.72c7@mx.google.com>
X-Google-Original-Message-ID: <ZJGj3JFeTT0Yl7qr@Ansuel-xps.>
Date:   Tue, 20 Jun 2023 15:04:28 +0200
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620201227.7sdb3zmwutwtmt2e@skbuf>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 11:12:27PM +0300, Vladimir Oltean wrote:
> Hi Christian,
> 
> On Tue, Jun 20, 2023 at 08:37:47AM +0200, Christian Marangi wrote:
> > Add support for port_change_master to permit assigning an alternative
> > CPU port if the switch have both CPU port connected or create a LAG on
> > both CPU port and assign the LAG as DSA master.
> > 
> > On port change master request, we check if the master is a LAG.
> > With LAG we compose the cpu_port_mask with the CPU port in the LAG, if
> > master is a simple dsa_port, we derive the index.
> > 
> > Finally we apply the new cpu_port_mask to the LOOKUP MEMBER to permit
> > the port to receive packet by the new CPU port setup for the port and
> > we reenable the target port previously disabled.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/dsa/qca/qca8k-8xxx.c | 54 ++++++++++++++++++++++++++++++++
> >  drivers/net/dsa/qca/qca8k.h      |  1 +
> >  2 files changed, 55 insertions(+)
> > 
> > diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> > index dee7b6579916..435b69c1c552 100644
> > --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> > +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> > @@ -1713,6 +1713,59 @@ qca8k_get_tag_protocol(struct dsa_switch *ds, int port,
> >  	return DSA_TAG_PROTO_QCA;
> >  }
> >  
> > +static int qca8k_port_change_master(struct dsa_switch *ds, int port,
> > +				    struct net_device *master,
> > +				    struct netlink_ext_ack *extack)
> > +{
> > +	struct qca8k_priv *priv = ds->priv;
> > +	u32 val, cpu_port_mask = 0;
> > +	struct dsa_port *dp;
> > +	int ret;
> > +
> > +	/* With LAG of CPU port, compose the mask for LOOKUP MEMBER */
> > +	if (netif_is_lag_master(master)) {
> > +		struct dsa_lag *lag;
> > +		int id;
> > +
> > +		id = dsa_lag_id(ds->dst, master);
> > +		lag = dsa_lag_by_id(ds->dst, id);
> > +
> > +		dsa_lag_foreach_port(dp, ds->dst, lag)
> 
> I think you use ds->dst often enough that you could assign it to its own
> local variable.
>

Will do thanks!

> > +			if (dsa_port_is_cpu(dp))
> > +				cpu_port_mask |= BIT(dp->index);
> > +	} else {
> > +		dp = dsa_port_from_netdev(master);
> 
> dsa_port_from_netdev() is implemented by calling:
> 
> static inline struct dsa_port *dsa_slave_to_port(const struct net_device *dev)
> {
> 	struct dsa_slave_priv *p = netdev_priv(dev);
> 
> 	return p->dp;
> }
> 
> The "struct net_device *master" does not have a netdev_priv() of the
> type "struct dsa_slave_priv *". So, this function does not do what you
> want, but instead it messes through the guts of an unrelated private
> structure, treating whatever it finds at offset 16 as a pointer, and
> dereferincing that as a struct dsa_port *. I'm surprised it didn't
> crash, to be frank.
> 
> To find the cpu_dp behind the master, you need to dereference
> master->dsa_ptr (for which we don't have a helper).
> 

I was searching for an helper but no luck. Is it safe to access
master->dsa_ptr? In theory the caller of port_change_master should
already check that the passed master is a dsa port?

I see in other context that master->dsa_ptr is checked if not NULL.
Should I do the same check here?

> > +		cpu_port_mask |= BIT(dp->index);
> > +	}
> > +
> > +	/* Disable port */
> > +	qca8k_port_set_status(priv, port, 0);
> > +
> > +	/* Connect it to new cpu port */
> > +	ret = qca8k_read(priv, QCA8K_PORT_LOOKUP_CTRL(port), &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Reset connected CPU port in LOOKUP MEMBER */
> > +	val &= QCA8K_PORT_LOOKUP_USER_MEMBER;
> 
> val &= GENMASK(5, 1) practically has the effect of unsetting BIT(0) and BIT(6).
> I suppose those are the 2 possible CPU ports? If so, then use ~dsa_cpu_ports(ds),
> it's more readable at least for me as a fallback maintainer.
> 

Yes they are and yes I love this so I can also drop the stupid define.

> > +	/* Assign the new CPU port in LOOKUP MEMBER */
> > +	val |= cpu_port_mask;
> > +
> > +	ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
> > +			QCA8K_PORT_LOOKUP_MEMBER,
> > +			val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Fast Age the port to flush FDB table */
> > +	qca8k_port_fast_age(ds, port);
> 
> Why do you have to fast age the (user) port?
> 

The 2 CPU port have a different mac address, is it a problem?

> > +
> > +	/* Reenable port */
> > +	qca8k_port_set_status(priv, port, 1);
> 
> or disable/enable it, for that matter?
> 

The idea is sto stop any traffic flowing to one CPU to another before
doing the change.

> > +
> > +	return 0;
> > +}
> > +
> >  static void
> >  qca8k_master_change(struct dsa_switch *ds, const struct net_device *master,
> >  		    bool operational)
> > @@ -1996,6 +2049,7 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
> >  	.get_phy_flags		= qca8k_get_phy_flags,
> >  	.port_lag_join		= qca8k_port_lag_join,
> >  	.port_lag_leave		= qca8k_port_lag_leave,
> > +	.port_change_master	= qca8k_port_change_master,
> 
> From my notes in commit eca70102cfb1 ("net: dsa: felix: add support for
> changing DSA master"), I recall this:
> 
>     When we change the DSA master to a LAG device, DSA guarantees us that
>     the LAG has at least one lower interface as a physical DSA master.
>     But DSA masters can come and go as lowers of that LAG, and
>     ds->ops->port_change_master() will not get called, because the DSA
>     master is still the same (the LAG). So we need to hook into the
>     ds->ops->port_lag_{join,leave} calls on the CPU ports and update the
>     logical port ID of the LAG that user ports are assigned to.
> 
> Otherwise said:
> 
> $ ip link add bond0 type bond mode balance-xor && ip link set bond0 up
> $ ip link set eth0 down && ip link set eth0 master bond0 # .port_change_master() gets called
> $ ip link set eth1 down && ip link set eth1 master bond0 # .port_change_master() does not get called
> $ ip link set eth0 nomaster # .port_change_master() does not get called
> 
> Unless something has changed, I believe that you need to handle these as well,
> and update the QCA8K_PORT_LOOKUP_MEMBER field. In the case above, your
> CPU port association would remain towards eth0, but the bond's lower interface
> is eth1.
> 

Can you better describe this case?

In theory from the switch view, with a LAG we just set that an user port
can receive packet from both CPU port.

Or you are saying that when an additional memeber is added to the LAG,
port_change_master is not called and we could face a scenario where:

- dsa master is LAG
- LAG have the 2 CPU port
- user port have LAG as master but QCA8K_PORT_LOOKUP_MEMBER with only
  one CPU?

If I got this right, then I get what you mean with the fact that I
should update the lag_join/leave definition and refresh each
configuration.

> >  	.master_state_change	= qca8k_master_change,
> >  	.connect_tag_protocol	= qca8k_connect_tag_protocol,
> >  };
> > diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
> > index c5cc8a172d65..424f851db881 100644
> > --- a/drivers/net/dsa/qca/qca8k.h
> > +++ b/drivers/net/dsa/qca/qca8k.h
> > @@ -250,6 +250,7 @@
> >  #define   QCA8K_GLOBAL_FW_CTRL1_MC_DP_MASK		GENMASK(14, 8)
> >  #define   QCA8K_GLOBAL_FW_CTRL1_UC_DP_MASK		GENMASK(6, 0)
> >  #define QCA8K_PORT_LOOKUP_CTRL(_i)			(0x660 + (_i) * 0xc)
> > +#define   QCA8K_PORT_LOOKUP_USER_MEMBER			GENMASK(5, 1)
> >  #define   QCA8K_PORT_LOOKUP_MEMBER			GENMASK(6, 0)
> >  #define   QCA8K_PORT_LOOKUP_VLAN_MODE_MASK		GENMASK(9, 8)
> >  #define   QCA8K_PORT_LOOKUP_VLAN_MODE(x)		FIELD_PREP(QCA8K_PORT_LOOKUP_VLAN_MODE_MASK, x)
> > -- 
> > 2.40.1
> > 
> 

-- 
	Ansuel
