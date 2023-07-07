Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9A074B090
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjGGMRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjGGMRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:17:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D25F1FE6;
        Fri,  7 Jul 2023 05:17:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-314172bac25so1724854f8f.3;
        Fri, 07 Jul 2023 05:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688732226; x=1691324226;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTz1K2zEa5O0rZFk72kNzqovbUvNASTGghr+QDM5Abk=;
        b=g1W7Sw0Sy/t8mRFCo08zd3QLZZ6GExmnbtZYatKEFXFrqh7FWSNZtLnPCczms/+2MC
         T+znQKHvWdBM+XIpxVnR9//SxB+b+tTq/U60Gv+adO3gznyqwwYdWSmOwiWLCnZPYq9e
         RbR5c02FTwxAa+hX788HpEczUQr7/VpzyXRh7gNi5fBk2B3j9M6rGMA8tD/23/NFlZsk
         8nXsAPIu0LmvsYLjjhePbrxUTiax3+B8XLRSnQ7gjb28BZPhpU0WYadjJ8JR/kZbrG3a
         1abpVi/ROAcdoX89ax2epsQBnEMR8LNosZ7y2ZiyOyWbqMi7fX5/9Im1I/3jTL6qMJnE
         L6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688732226; x=1691324226;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTz1K2zEa5O0rZFk72kNzqovbUvNASTGghr+QDM5Abk=;
        b=P7eTD4lYnaj6Yj1j8NHxxmYo0TMQmaCq0wjeJBccwrxwV3bNSKVPmEbDWhrmQA/Jpf
         FT9jIkL8Dx71L1BQEnklxkYjPJ4X3uxYtcFAH+noJFW1arQqaQJMJIpwpdjPhHHh94o/
         gx9EO8D0eUiy9z9cDuu0VTD5fLu1s09WLKOuXIhufm9P+vpuc0qdTBooNNPKtI3OmQek
         3z7kA93ziHr9CrBPlVx+x+uSXKhYw7lbnqno34Cgm7Lira0otb5sG8MtL3D8TSTQkQH3
         PLMAzLdcUHksAiaz0OUbCDy/Dv9gWhjDXIP+ftslqqG+4JfWdYxo3i6VY9VFXVvHLcA2
         w+gA==
X-Gm-Message-State: ABy/qLZ0wvykUr78xkntzutQOmIynjx/5RBblq59WQYIiKfR4ZVWSd23
        h4N88/0xBvYciO8JLLPMA/Q=
X-Google-Smtp-Source: APBJJlGHBXJUAwRNtB9mtV6sGByIqNbQdy3bMIQf/CflMFUCvZi8SakmDxdkBpwZcM1S8DWnQRskdg==
X-Received: by 2002:adf:f98b:0:b0:313:ee5b:d4bc with SMTP id f11-20020adff98b000000b00313ee5bd4bcmr4009152wrr.5.1688732225554;
        Fri, 07 Jul 2023 05:17:05 -0700 (PDT)
Received: from debian ([89.238.191.199])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d51c3000000b00313f7b077fesm4300749wrv.59.2023.07.07.05.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 05:17:05 -0700 (PDT)
Date:   Fri, 7 Jul 2023 14:16:55 +0200
From:   Richard Gobert <richardbgobert@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        dsahern@kernel.org, tom@herbertland.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gal@nvidia.com
Subject: [PATCH 0/1] net: gro: fix misuse of CB in udp socket lookup
Message-ID: <20230707121650.GA17677@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GRO stack uses `udp_lib_lookup_skb` which relies on IP/IPv6 CB's info, and
at the GRO stage, CB holds `napi_gro_cb` info.  Specifically,
`udp_lib_lookup_skb` tries to fetch `iff` and `flags` information from the
CB, to find the relevant udp tunnel socket (GENEVE/VXLAN/..).  Up until a
patch I submitted recently [0], it worked merely by luck, due
to the layouts of `napi_gro_cb` and IP6CB.

AFAIU it worked because: 
`IP6CB(skb)->flags` is at offset 16 inside IP6CB:
 - Before the patch: `flags` was mapped to `flush`.
 - After the patch: `flags` was mapped to `data_offset`.

`IP6CB(skb)->iff` is at offset 0 inside IP6CB:
 - Before the patch: `iif` was mapped to `frag0`.
 - After the patch: `iif` was mapped to a union of `frag0` and `last`.

After my patch, on the receive phase, while `data_offset` is 40 (since IPv6
header is 40 bytes), `inet_iif` calls `ipv6_l3mdev_skb`, which checks
whether `IP6CB(skb)->flags`'s `IP6SKB_L3SLAVE` bit is on or off (in our
case its off). If it is off, `inet_iif` returns `IP6CB(skb)->iif`, which is
mapped to `napi_gro_cb->frag0`, making `inet_iif` return 0 most of the
times. `inet_sdif` returns zero due to a similar reason caused by
`data_offset` being equal to 40 (and less than 64).

On the other hand, the complete phase behaves differently.
`data_offset` is usually greater than 64 and less than 128 so the
`IP6SKB_L3SLAVE` flag is on.  Thus, `inet_sdif` returns `IP6CB(skb)->iif`,
which is mapped to `last` which contains a pointer. This causes
`udp_sk_bound_dev_eq` to fail, which leads to `udp6_lib_lookup2` failing
and not returning a socket. This leads the receive phase of GRO
to find the right socket, and on the complete phase, it fails to find it and
makes the throughput go down to nearly zero.

Before [0] `flags` was mapped to `flush`. `flush`'s possible
values were 1 and 0, making `inet6_iff` always returning `skb->skb_iif` and
`inet6_sdif` returning 0, and leading to `udp_sk_bound_dev_eq` returning
true.

A fix is to not rely on CB, and get `iff` and `sdif` using skb->dev. l3mdev
case requires special attention since it has a master and a slave device.

[0] https://lore.kernel.org/netdev/20230601160924.GA9194@debian/

Richard Gobert (1):
  net: gro: fix misuse of CB in udp socket lookup

 include/net/udp.h      |  2 ++
 net/ipv4/udp.c         | 21 +++++++++++++++++++--
 net/ipv4/udp_offload.c |  7 +++++--
 net/ipv6/udp.c         | 21 +++++++++++++++++++--
 net/ipv6/udp_offload.c |  7 +++++--
 5 files changed, 50 insertions(+), 8 deletions(-)

--
2.36.1

