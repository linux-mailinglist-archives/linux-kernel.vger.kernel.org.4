Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E03720253
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjFBMn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjFBMn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:43:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BDD1B1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:43:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f7024e66adso50705e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 05:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685709798; x=1688301798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRXpWCFDEJuFO+sgap5Gq9jFXAcAG+6Y5CPTtnqvosQ=;
        b=HgyMQgDK0VLmj5VwU1m4cMsJeVTDKjrin1Y7NCOXW0eXEKwgB5b4vqFhkcv/NMlRi6
         TADoh1uh/dN7xMGNHNT8q/w4PdTGuaIWeCRjbkMDUOupFy8lAf3g12h79RDDmz9XsCb/
         /SBOunWu8t6rJIGuaiZUKMPGFsQDV24n9PfN0Cn6bC7vzy9x8PatddFxCY5OsnpOzRiZ
         wD8uiNY/fyDqwtPziz03ayQRYHBmGTBrlTL9/SLoGurtOb4JkLpoLmVGHL2XXy1SNjI0
         3tI2rP0VRRNMeXgsbIStgMVLNcm1NfvL4yIxF/pGiKRf1t1DwPiNC+VqFxg0vNOd4/VU
         +3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685709798; x=1688301798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRXpWCFDEJuFO+sgap5Gq9jFXAcAG+6Y5CPTtnqvosQ=;
        b=cIWPvHylE/QinaVxzWWuKyCU9iWInrP+2aFDNArmfEkatMmQv0aY1T9jk3WpPt4g3d
         3NjGmFuG0gJWhG8mZUhH2IWoqVYXvI70ka9UAmx5wQC71nf6s4Rg51pm9tuFxjeDcMYw
         sPJKQ7tTyT6vO4Vbqn6Xk0OQBiljaEuRicceYVnze6L9hustuMy8aWjMezE+4P0zSQ0I
         HKPRYGrDJ/KKK76JMmd79Kzjbw/iGQALI6FFZaZfPx0UJjizpWBP98VLDGbWHQvS+9ot
         0aYlJIKKRnaIO88t2YzZuF4lapEk2Rw4O6F2jAz6nS+cgdkhOelyAeFQBIayPRseA6YU
         0rIQ==
X-Gm-Message-State: AC+VfDxzWlbSv6B4VJii3jYFDLRAUT1g4oMJBWvmATpoWSycCQOmIPDU
        KQEqFPG+gdJ13DyUmJJAoK33gcArpor9TQjWdKGdcn/5gAg2/wvJccE=
X-Google-Smtp-Source: ACHHUZ71kbqY05Q45BEhjVeKEoDQw6BA+JYl5z60gPhCXFtqcUlevfebxuImf199eurulm8psbO/xNTo8DTU+jyynII=
X-Received: by 2002:a05:600c:3b97:b0:3f1:6839:74a1 with SMTP id
 n23-20020a05600c3b9700b003f1683974a1mr192782wms.6.1685709798352; Fri, 02 Jun
 2023 05:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230601-net-next-skip_print_link_becomes_ready-v1-1-7ff2b88dc9b8@tessares.net>
In-Reply-To: <20230601-net-next-skip_print_link_becomes_ready-v1-1-7ff2b88dc9b8@tessares.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 2 Jun 2023 14:43:06 +0200
Message-ID: <CANn89iKrpE7TVb8pTC+pWFDPJ2xcL3s9BhFB6DPxjK34he5RwQ@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: lower "link become ready"'s level message
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 11:36=E2=80=AFAM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> This following message is printed in the console each time a network
> device configured with an IPv6 addresses is ready to be used:
>
>   ADDRCONF(NETDEV_CHANGE): <iface>: link becomes ready
>
> When netns are being extensively used -- e.g. by re-creating netns' with
> veth to discuss with each others for testing purposes like mptcp_join.sh
> selftest does -- it generates a lot of messages like that: more than 700
> when executing mptcp_join.sh with the latest version.
>
> It looks like this message is not that helpful after all: maybe it can
> be used as a sign to know if there is something wrong, e.g. if a device
> is being regularly reconfigured by accident? But even then, there are
> better ways to monitor and diagnose such issues.
>
> When looking at commit 3c21edbd1137 ("[IPV6]: Defer IPv6 device
> initialization until the link becomes ready.") which introduces this new
> message, it seems it had been added to verify that the new feature was
> working as expected. It could have then used a lower level than "info"
> from the beginning but it was fine like that back then: 17 years ago.
>
> It seems then OK today to simply lower its level, similar to commit
> 7c62b8dd5ca8 ("net/ipv6: lower the level of "link is not ready" messages"=
)
> and as suggested by Mat [1], Stephen and David [2].
>
> Link: https://lore.kernel.org/mptcp/614e76ac-184e-c553-af72-084f792e60b0@=
kernel.org/T/ [1]
> Link: https://lore.kernel.org/netdev/68035bad-b53e-91cb-0e4a-007f27d62b05=
@tessares.net/T/ [2]
> Suggested-by: Mat Martineau <martineau@kernel.org>
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> Suggested-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
