Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4381E73E520
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjFZQbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFZQbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:31:41 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE02C5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:31:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso1620462b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1687797099; x=1690389099;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ElVQSNFQeBSJ8cUDkz1CqixeRQkBNwJHNP3Ld++dWRY=;
        b=L07WBZsg3ebScE1i/zNFEVtycZ/Cvvp66e8wB7z4hPfIUswMI/WdEw5z/WdgU5mkZn
         d0OvXti2Xmjbvv9fedQ+t412YJdQ6aK4FAQoccn+wGuGGncH1IC0nurX7H2qH9iW5nLn
         AdonOzNMCcu63+dP2PgaSBqzWmWURx0ec/izohi6XZMIOgaN840Ng7KOoYrk1f8nremA
         cv2nlmyyKBCpuPIny6vqt2PPmtAgK+f9enyEpdwXazEGe3zQam9NlLz58VwF49jIB96Q
         4azUQ0QGRTQGYRXTVyNtAhjGyr5bBqoWmXDgy2cQe6ARXVslXFNcduTu7wZB7a32AkMM
         3cRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687797099; x=1690389099;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElVQSNFQeBSJ8cUDkz1CqixeRQkBNwJHNP3Ld++dWRY=;
        b=Q/QSoxSYKvliamW+XEmBEqtZzq33xWwl1L+lPfst+T6dR09MJcarZR9npNGPntQf5f
         JjHAJ+9rLcj8WY/ogiEmZ8nHn/vhptbF8J0SIElV2ZjoQJ/2S5pYJw2Lth+HFx3N9nOx
         D/TZ8qtCfQK0Yxd8ewVUNVKFZt7GnTN31YzPdxCJSOz9gEqp3iMP89osNkYER7C2cW2f
         Rhlxf+e9+SRXqG/kT4JQIi/M1fzThzTZy1i2+4f0oolhn6acouK/6VtBVisdOipWTuFZ
         /abui6y1cSkxwZ5bMTHoPTal1w+r3zq87Hk7S7M/oBzLimSxMX/SpA6KlmnvOrPEP6dA
         M7mw==
X-Gm-Message-State: AC+VfDxYjoLYOhUd8+cVaSxOJw534EVLp+tqTyiD1zD9cRrUvZuapSC0
        Q3fRDvhyrQGfQDbMT1QJOXJqxKD8tmpe+ryFNpbGog==
X-Google-Smtp-Source: ACHHUZ4e++rRgYbN2T01eKdUgjlpuJ0Wh4RimtVZlL+eqy3ga2KMAgCgwCHcoJVBLF/QsxP4ezyl3w==
X-Received: by 2002:a05:6a20:1054:b0:128:fce6:dd8b with SMTP id gt20-20020a056a20105400b00128fce6dd8bmr1104801pzc.39.1687797099496;
        Mon, 26 Jun 2023 09:31:39 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id a21-20020a63e855000000b0053ba104c113sm4398581pgk.72.2023.06.26.09.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:31:39 -0700 (PDT)
Date:   Mon, 26 Jun 2023 09:31:37 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iproute2 6.4.0 release
Message-ID: <20230626093137.2f302acc@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just released iproute2 corresponding to the 6.4 kernel.
Not much is new in this release heading into summer holidays.
The bridge utility added some new capabilities around multicast
forwarding database. Lots of cleanups and similar fixes. 

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.4.0.tar.gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions:

Andrea Claudi (5):
      ip: remove double space before 'allmulti' flag
      bridge: vni: remove useless checks on vni
      ipstats: fix message reporting error
      vdpa: propagate error from cmd_dev_vstats_show()
      iproute_lwtunnel: fix array boundary check

Bilal Khan (1):
      fixed the grammar in ip-rule(8) man page

David Ahern (4):
      Update kernel headers
      Update kernel headers
      Update kernel headers
      Update kernel headers

Davide Caratti (1):
      tc: m_tunnel_key: support code for "nofrag" tunnels

Herbert Xu (1):
      macvlan: Add bclim parameter

Ido Schimmel (8):
      bridge: mdb: Add underlay destination IP support
      bridge: mdb: Add UDP destination port support
      bridge: mdb: Add destination VNI support
      bridge: mdb: Add source VNI support
      bridge: mdb: Add outgoing interface support
      bridge: mdb: Document the catchall MDB entries
      bridge: vlan: Add support for neigh_suppress option
      bridge: link: Add support for neigh_vlan_suppress option

Luca Boccassi (1):
      man: fix typos found by Lintian

Nicolas Dichtel (1):
      ipnetns: fix fd leak with 'ip netns set'

Petr Machata (2):
      ip: Support IP address protocol
      man: man8: Add man page coverage for "ip address add ... proto"

Stephen Hemminger (32):
      uapi: update kernel headers 6.4-rc1
      uapi: add capability.h
      remove unnecessary checks for NULL before calling free()
      ip-rule: more manual page grammer fixes
      Add MAINTAINERS file
      lib/fs: fix file leak in task_get_name
      ipmaddr: fix dereference of NULL on malloc() failure
      iproute_lwtunnel: fix possible use of NULL when malloc() fails
      tc_filter: fix unitialized warning
      tc_util fix unitialized warning
      tc_exec: don't dereference NULL on calloc failure
      m_action: fix warning of overwrite of const string
      netem: fix NULL deref on allocation failure
      nstat: fix potential NULL deref
      rdma/utils: fix some analyzer warnings
      tc/prio: handle possible truncated kernel response
      CREDITS: add file
      ll_type_n2a: use ARRAY_SIZE
      vxlan: use print_nll for gbp and gpe
      vxlan: make option printing more consistent
      uapi: update headers to 6.4-rc4
      ipaddress: accept symbolic names
      utils: make local cmdline functions static
      libnetlink: drop unused rtnl_talk_iov
      bridge: make print_vlan_info static
      ip: make print_rta_gateway static
      xfrm: make xfrm_stat_print_nokeys static
      rdma: make rd_attr_check static
      whitespace cleanups
      rt_names: check for malloc() failure
      uapi: update to bpf.h
      v6.4.0

Vladimir Oltean (3):
      utils: add max() definition
      tc/mqprio: add support for preemptible traffic classes
      tc/taprio: add support for preemptible traffic classes

zhaoshuang (1):
      iproute2: optimize code and fix some mem-leak risk

