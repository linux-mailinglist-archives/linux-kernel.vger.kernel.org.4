Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEE87412E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjF1Nog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjF1NoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:44:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6DD10D5;
        Wed, 28 Jun 2023 06:44:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-313f3a6db22so3355406f8f.3;
        Wed, 28 Jun 2023 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687959858; x=1690551858;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pkZ4Zk9tAZpHeEqo4A+NgvCmbBndm0e9GG6xIrH5rjE=;
        b=dYl5OQyHPiC73mFKbGw4iyDezvBYIsSa+UfNh9oob2WV+a6XY9grfH5d8Uzl244D3V
         vCRLW4s3Hbl+IGLBdW9kJlSWHyizOEU+0C1Ngqmh7C/MLM/qxZXvNrbA7ixHg6opyNMi
         9R9PUx5kRUj8JzOrNEEXzZ0ThzD2ISWZLG5ejrVgi86TQbWqQpvzx9XumrUXv/Yrd3b/
         CFbHheugUzq+AOnLpFhjOgX78uqVTDmtYWqP3umi03ir5CuP9QtrvBGNIYHbNel08erZ
         w/qKCx83kGn6twiHMyL9TSoiuZ90obwxubStVEuEWlBHcthqZbomzooynZbRPfKoi/em
         rTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959858; x=1690551858;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkZ4Zk9tAZpHeEqo4A+NgvCmbBndm0e9GG6xIrH5rjE=;
        b=JOwU4GDfe1zc1UsuKtEjCNB5xJtckZdoPvn1p3QFB1R6F9Ra+fxCSfk3d7fua9CgRw
         GYZuT7kzNE9pYTTBAc6hmYQoye/C/TWLKDzTIuyxDkAQ20NJq0C4Mxhbc5AuD31FilUn
         SS+guHQLdyqKfSwNRajQ/HEYUzIG85N3hzIMAcq7jRrCndDb752Uiv8uVw+ND27f+IEm
         rOKZBRchQUbXow+44zb/CGmoqkDTEIWCiGA3b+2u0XjQwFiBM5KV0wlYABWYEsOUE5RB
         vDkF9dPinkhXsJ/4LI2uNDztkFjzavcjLy7VxWAqMtk2AriqahtikiTEX8SDcBrxK8Va
         hHjQ==
X-Gm-Message-State: AC+VfDzf6pUXF+JmXDmkXuppYPJ4cRl0CZbtL3H8beepWxdl8wKFshuk
        6xQ0PCYVuDhKRhwpP+4f+a4=
X-Google-Smtp-Source: ACHHUZ4yoZuCEXCbzh2LtK2M3mTGFYYuTeSht2OyGAH3ft0/DXeF0obKLM4NYBEpjmH6O2NQ3kk8YQ==
X-Received: by 2002:a5d:4851:0:b0:313:f4b9:99cc with SMTP id n17-20020a5d4851000000b00313f4b999ccmr6567903wrs.68.1687959858188;
        Wed, 28 Jun 2023 06:44:18 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id x11-20020adfdd8b000000b00313ecd3714csm10551969wrl.19.2023.06.28.06.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:44:17 -0700 (PDT)
Message-ID: <649c3931.df0a0220.136ab.2fb7@mx.google.com>
X-Google-Original-Message-ID: <ZJuDsafM60FbylKy@Ansuel-xps.>
Date:   Wed, 28 Jun 2023 02:49:53 +0200
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627094916.maywojwztzdek5y2@skbuf>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 12:49:16PM +0300, Vladimir Oltean wrote:
> On Mon, Jun 26, 2023 at 07:59:41PM +0200, Christian Marangi wrote:
> > > Hmm, so ping works but this doesn't? That's strange, because send_uc_ipv4()
> > > also pings. Have you run with bash -x to see why it fails?
> > > 
> > 
> > I just run with bash -x and I also mod the script to not delete the
> > tcpdump. Limiting the script to only this test the dump is just 2 ICMPv6
> > packet and no output from tcpdump aside from
> > 
> > tcpdump: listening on lan1, link-type EN10MB (Ethernet), snapshot length 65535 bytes
> > 3 packets captured
> > 5 packets received by filter
> > 0 packets dropped by kernel
> > 
> > I feel like this is important so I think I should focus on understanding
> > why this doesn't work? Any clue?
> 
> No clue. I'd put a "bash" instruction in send_uc_ipv4(), which would act
> as a sort of break point for the script (opens an interactive sub-shell),
> then run it again with bash -x, manually repeat the command that failed,
> investigate why it failed and hit Ctrl-d when I'm done.

Hi, I wasted a day to only notice that the problem was in busybox not
supporting 0.x value and that is what selfttest script use. Another
thing to check. Also the confusing part of this is that we don't check
if ping_do return error and the test just fails (while in reality the
ping command was never executed)

Anyway I'm fixing all kind of bugs and I even found an even hw
limitation with the FDB table with mgmt packet...

Also I implemented fdb_insolation following the implementation done on
felix with reserving VID at the end...
About this I wonder if it might be a good idea to expose some generic
API from DSA?

qca8k require a reserved VID for VLAN unaware port and with
fdb_isolation even more VID are reserved. DSA have no idea about this so
I wonder if there is a chance of VID clash? I feel like we need
something to declare a range of reserved VID so that they gets rejected
when applied. (about this I think I should return -EINVAL if fdb/mbd
insert are asked with a reserved VID)

Anyway by fixing that interval problem (enabling support in busybox as
it's disabled by default in a OpenWRT system)
This is the new output of the local_termination.sh 

TAP version 13
1..1
# selftests: drivers/net/dsa: local_termination.sh
# TEST: lan1: Unicast IPv4 to primary MAC address                     [ OK ]
# TEST: lan1: Unicast IPv4 to macvlan MAC address                     [ OK ]
# TEST: lan1: Unicast IPv4 to unknown MAC address                     [FAIL]
#       reception succeeded, but should have failed
# TEST: lan1: Unicast IPv4 to unknown MAC address, promisc            [ OK ]
# TEST: lan1: Unicast IPv4 to unknown MAC address, allmulti           [FAIL]
#       reception succeeded, but should have failed
# TEST: lan1: Multicast IPv4 to joined group                          [ OK ]
# TEST: lan1: Multicast IPv4 to unknown group                         [FAIL]
#       reception succeeded, but should have failed
# TEST: lan1: Multicast IPv4 to unknown group, promisc                [ OK ]
# TEST: lan1: Multicast IPv4 to unknown group, allmulti               [ OK ]
# TEST: lan1: Multicast IPv6 to joined group                          [ OK ]
# TEST: lan1: Multicast IPv6 to unknown group                         [FAIL]
#       reception succeeded, but should have failed
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

Seems good aside from the reception secceeded that I think the kernel
just drops right?

The switch have a way to control FLOOD per port but maybe the correct
feature to use is the VLAN leaky? Where the setting can be set by both
FDB/MBD and per port.

Sorry if I described some fix and implementation without proposing the
patch but I would like some comments on what the tool returned.

-- 
	Ansuel
