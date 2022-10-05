Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD115F4FA5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 08:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiJEGDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 02:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJEGDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 02:03:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B3325EB3;
        Tue,  4 Oct 2022 23:03:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l8so10126734wmi.2;
        Tue, 04 Oct 2022 23:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XfuxcPrid/1Sd5yZYeCEG8zmqxixUVmuQ/H/2tn2BcI=;
        b=k/klt2/b89hFNe78TQbXNeja/IdMpcZiYrjnKfvP2z+814E+oizkM/8ElFrkUb/05R
         YidX2Si8BVq0VWVPoWBvWve7ZSUQANllVUqjY5eLPbGIQBzi4mw88JovZ1v3WP94q6w7
         Zpw1iNmnnU24C23jT0+++yDCG6xP33OHLtCXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XfuxcPrid/1Sd5yZYeCEG8zmqxixUVmuQ/H/2tn2BcI=;
        b=SGKLu0KfCIxp242tn8VAK6FstKZGgi0Wfv5alwlnjHYzF1aHWXR+0MYQCFpMmwNhmP
         gAh640dr0IuaJTIHA0V5cP9heDACaiuFKOKGR/Cz0S97v5G/OkmY1zSOjDHdX+ukjwt/
         gnRLhML7LY/NFtx8t+OWsYO3m15PaoFEULZhOpnKQKD+DMsBUxVdTVnH4Qb5ZYRagE65
         fkZjxUPfgQxNzMP/6Xc8eCodXnrNS6gI7ktVAcY530HiGQBY3WW6UgsVVUQmkmsyq9dS
         dmlrVts3xNeGgeDwkBUNHvfflPULgDDAR599ejcpfvgGpL9Xr7USvKGQhQItQuXjxaoW
         DQxQ==
X-Gm-Message-State: ACrzQf1N9S6UxBi2wuSRGZ1NvHYqfacWeCKUgoSeaj0JursKCOkr7N6d
        dJyRqtAUE8m1WSIHi6czhz0G1C0x4Iqvt0sRi7M=
X-Google-Smtp-Source: AMsMyM4NbL/FH0L/HZzNVSH872uO46cq4sujSzw/KArLDXyK3aSWFIteAMEN5sWrZHSYS5Cm7JOPuWE+QMKgjyP0yhg=
X-Received: by 2002:a05:600c:1906:b0:3b4:c979:e639 with SMTP id
 j6-20020a05600c190600b003b4c979e639mr2079663wmq.10.1664949782844; Tue, 04 Oct
 2022 23:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220725095913.31e859ec@canb.auug.org.au> <df8f4765-a804-cb50-bbb5-475925ba2036@milecki.pl>
 <20220815105419.4df1005b@canb.auug.org.au> <20220831091654.45d5ed41@canb.auug.org.au>
 <20221005114841.4540d325@canb.auug.org.au> <abbe10d1-4c2a-5fad-3f92-e55c514d3ce2@gmail.com>
In-Reply-To: <abbe10d1-4c2a-5fad-3f92-e55c514d3ce2@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 5 Oct 2022 06:02:50 +0000
Message-ID: <CACPK8Xecn8ZREAqcLcuZHjA=NhaanRMKu4W39okAkBFX4aaOnw@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the broadcom tree
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2022 at 03:01, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >> I am still seeing these warnings.
> >>
> >> The above commit is now
> >>
> >>    61dc1e3850a6 ("ARM: dts: BCM5301X: Add basic PCI controller properties")
> >
> > Has any progress been made with this?  This commit is now in the
> > arm-soc tree.
>
> Yes, I was hoping to get some feedback on this patch:
>
> https://lore.kernel.org/all/20220920210213.3268525-1-f.fainelli@gmail.com/
>
> but I suppose being the ARM SoC maintainer I can just go ahead and push it.

I'd send a revert of the change. Rafal can then re-submit a series
that fixes the dtc warnings as well as the yaml warning once they have
been tested and reviewed.

The yaml warnings aren't seen by other developers, as they require the
tools to be installed, but those from dtc are.

Cheers,

Joel
