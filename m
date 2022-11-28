Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2FC63AE2C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiK1Q5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiK1Q53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:57:29 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE2A20198
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:57:29 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 6so10449678pgm.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ivan-computer.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N6OhLlFi8ozmHLPRySaIAeogD5ZelvXE92J+b5DNQxc=;
        b=vgVTjesr+9HZ/5Oz1M7G+xtgXK3Rat5iRcxIfjMIxG7/5h9r4OsUM3/T8+TmRONIMP
         fizpEZcOikI0v9ixw+cfsc/Ll+C09CeGhVu3PAyNFS+TaYW323zV/w6iSVSKzArJ8F+6
         XJzOFzseiUEhs06iqPlLpcw3fE5VGJXQ8g/Y0PGyqyqHlyZGjtlzo0IbvXHCTe6lHXX7
         i6MFOJm49nkyli+RQLpm+x/rcoAE/L8L/rYIkv2QKeAyo01qlsY2N98QoQqCnntGor1P
         nEboZ5sTJG8oyDfNk3BCC56H8eX3YVtfwIOGOGJjwfKpgwz3vd3aad7nA7JWLXjE5EQK
         07TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6OhLlFi8ozmHLPRySaIAeogD5ZelvXE92J+b5DNQxc=;
        b=H37h7J/xIbW1GIe76eFPlfQciKsZ5KZvl8noY1XFCN7mfCK/bLTLQspSK1xS6v8j3x
         mijbpEIgQgKDD0oCNL7r5IiOXik+Nrf4M2741vdv5fZMWWEGqT8BfA6vvnKB7T03NDbR
         i6C+I0UIOdqdFoLaoDYo2kwLOZZUeVvQRbT3CGNGR2RxPFQyzZu8ko+Ne9VeOgFmyX9R
         RW+hykmeC3U+5lNDl3r+lPP0c0dzFX1A/G/0ciP3Ls1/vt+1mZ8A7cCS2G/alj4sGMdB
         7NDPcVHHly9IDz9YcqGURZ7JFSmJxVtTKjdd5oV6G3toqy8Pwcb1eV1u9jWjcDVZT0Jf
         aQvw==
X-Gm-Message-State: ANoB5pnZYHSIBVdTqyzIvd5PmOTLs1UJq2JGaTL0rTHZF7jXL1mHyouh
        OANmmFTk10nydG8zQukhhIJ/6kDVBvt3EI6mEfrb2w==
X-Google-Smtp-Source: AA0mqf7V2DvX+F9hrF3w6CNxnkNp4Uo8+XLmUBQKNzav0AzysdMDnA0Vcj+QDwW6MvuhPFq8f0k7DTTtn42iQuZgzZ4=
X-Received: by 2002:a63:554a:0:b0:44c:bfe:9b1c with SMTP id
 f10-20020a63554a000000b0044c0bfe9b1cmr34796043pgm.103.1669654648480; Mon, 28
 Nov 2022 08:57:28 -0800 (PST)
MIME-Version: 1.0
References: <CAGjnhw_2oSWfMjNPZMneJXxdvT+qoqhKV8787NYuHnOauhSVyw@mail.gmail.com>
 <Y4SGv3W+TtAiizwi@salvia>
In-Reply-To: <Y4SGv3W+TtAiizwi@salvia>
From:   Ivan Babrou <ivan@ivan.computer>
Date:   Mon, 28 Nov 2022 08:57:17 -0800
Message-ID: <CAGjnhw_tUOAnsYDT-pmpT4Ev5O_SkgCNiS4Tg-KCZi+wTgimCg@mail.gmail.com>
Subject: Re: Unused variable 'mark' in v6.1-rc7
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 2:00 AM Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>
> Hi,
>
> On Sun, Nov 27, 2022 at 05:30:47PM -0800, Ivan Babrou wrote:
> > There's 52d1aa8b8249 in v6.1-rc7:
> >
> > * netfilter: conntrack: Fix data-races around ct mark
> >
> > It triggers an error:
> >
> > #19 355.8 /build/linux-source/net/netfilter/nf_conntrack_netlink.c: In
> > function '__ctnetlink_glue_build':
> > #19 355.8 /build/linux-source/net/netfilter/nf_conntrack_netlink.c:2674:13:
> > error: unused variable 'mark' [-Werror=unused-variable]
> > #19 355.8  2674 |         u32 mark;
> > #19 355.8       |             ^~~~
> > #19 355.8 cc1: all warnings being treated as errors
> >
> > If CONFIG_NF_CONNTRACK_MARK is not enabled, as mark is declared
> > unconditionally, but used under ifdef:
> >
> >  #ifdef CONFIG_NF_CONNTRACK_MARK
> > -       if ((events & (1 << IPCT_MARK) || ct->mark)
> > -           && ctnetlink_dump_mark(skb, ct) < 0)
> > +       mark = READ_ONCE(ct->mark);
> > +       if ((events & (1 << IPCT_MARK) || mark) &&
> > +           ctnetlink_dump_mark(skb, mark) < 0)
> >                 goto nla_put_failure;
> >  #endif
> >
> > To have NF_CONNTRACK_MARK one needs NETFILTER_ADVANCED:
> >
> > config NF_CONNTRACK_MARK
> >         bool  'Connection mark tracking support'
> >         depends on NETFILTER_ADVANCED
> >
> > It's supposed to be enabled by default:
> >
> > config NETFILTER_ADVANCED
> >         bool "Advanced netfilter configuration"
> >         depends on NETFILTER
> >         default y
> >
> > But it's not in defconfig (it's missing from arm64 completely):
> >
> > $ rg NETFILTER_ADVANCED arch/x86/configs/x86_64_defconfig
> > 93:# CONFIG_NETFILTER_ADVANCED is not set
> >
> > I think the solution is to enclose mark definition into ifdef as well
> > and I'm happy to send a patch if you agree and would like me to.
>
> Thanks for reporting and offering a patch:
>
> Could you give a try to this one? I'll be glad to get a Tested-by:
> tag if this is correct to you.
>
> https://patchwork.ozlabs.org/project/netfilter-devel/patch/20221128095853.10589-1-pablo@netfilter.org/
>
> Thanks.

LGTM, it builds. Tested-by: Ivan Babrou <ivan@ivan.computer>
