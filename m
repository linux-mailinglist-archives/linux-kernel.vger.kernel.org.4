Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223A968EA49
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBHJAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBHJA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:00:28 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3AB458BC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:00:27 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id hv11-20020a17090ae40b00b002307b580d7eso1686737pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 01:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EAPETRKdYetooRbExn2aw4blxNS/4Qu6CmKVgBC1MgU=;
        b=drISNmQreCVkRTSu8p4+jH6CvionnNb0++vqRmAkk8Gu8Zu1s1Hnt5s/61cnCDAt64
         cWe4ykZU2tZy1km1jotZtQAPJZKr6RoS+F1TA/hlpaFqEE53AiOXy1i9gsb6n6ZIBxFw
         K+9ZLHswq8HNh0qhVHqHgVN4o+kuy275qjQtZ2kKjr1qm2es+EJYzKUCHewkv+Ksm+bI
         WsRpHPujBHzKdQ4kijWf3AX8hlya9b2BqJ1VPMj8HYHiFCWL+niznNmRo3yGBXpw/Y+w
         6x/AETV9ovzf6XvxHKgzNIpNWGHj9kaAhoTLADdqn21LB8ysYvxCV4xbDZ7qQmgk/aX4
         mt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAPETRKdYetooRbExn2aw4blxNS/4Qu6CmKVgBC1MgU=;
        b=j+qRJaMYke5gKlm92PhuC7LW8lUoteSW6JevfmhEWUgnHA/1b8SD3wLseDiQ5Eo+lS
         fviXkUbOP/RCVfyZr961DBR37OdJUwiR49cU5OrWZ7eFh5k8eq9WyStNJpB/nil9gfup
         tSR9AoI3ZgFE2wuCZPMOfUakqcn/X8uwEnKgg7Kz4h99By/oJ4SfvRKabGzzY4KLrbFS
         t/S7qvbRSb2Vs9zbzyeiigMdRxkCOp2ZcbPDHFb6nN/SPJbjmyHUhCTF9Dg4DjCJ5+gD
         ETzwkLngOiXLQvBovei5O6IC/stNNr3wENe91OMYvNZ7n6hRchpPJITDFA4oYL9emSVs
         jyWw==
X-Gm-Message-State: AO0yUKUvUQ4w/h6Wk4eqPU15WfekdIPRcUIHG4ErJiv59wKqUuMgrJOz
        +tc6rwiD0qJuufOfNsASzitQOgEdEsWlKBluhcbCZw==
X-Google-Smtp-Source: AK7set8T1MyhJ5/794hEAa0fI166hsMpG3E4dA1xxbQdUsstSNtn54g7NhKe++bybLuwWaSQqr/mut4qTmiayRfdrys=
X-Received: by 2002:a17:902:ec8e:b0:199:1e42:2963 with SMTP id
 x14-20020a170902ec8e00b001991e422963mr1662777plg.18.1675846826532; Wed, 08
 Feb 2023 01:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20230206142714.4151047-1-liumartin@google.com>
 <CAL_JsqKA8pBess-zLA_2n0p8q=NBuY0EGA7qALKabwJA8ZRwrA@mail.gmail.com>
 <CAASV4h5ANYTJUN3gQxuLxeKMknyoyt7-YTxRRMcjrQXRrVRi5Q@mail.gmail.com> <20230207210458.GA4142905-robh@kernel.org>
In-Reply-To: <20230207210458.GA4142905-robh@kernel.org>
From:   Martin Liu <liumartin@google.com>
Date:   Wed, 8 Feb 2023 16:59:50 +0800
Message-ID: <CAASV4h4u7FZGMJFscGMbY8nLaWzq2stPc3YxpSVmLCq52V=Gmg@mail.gmail.com>
Subject: Re: [PATCH] of: reserved-mem: expose reserved-mem details via debugfs
To:     Rob Herring <robh@kernel.org>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, surenb@google.com,
        minchan@kernel.org, tkjos@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023 at 5:05 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Feb 08, 2023 at 01:05:25AM +0800, Martin Liu wrote:
> > On Mon, Feb 6, 2023 at 11:12 PM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Mon, Feb 6, 2023 at 8:27 AM Martin Liu <liumartin@google.com> wrote:
> > > >
> > > > It's important to know reserved-mem information in mobile world
> > > > since reserved memory via device tree keeps increased in platform
> > > > (e.g., 45% in our platform). Therefore, it's crucial to know the
> > > > reserved memory sizes breakdown for the memory accounting.
> > > >
> > > > This patch shows the reserved memory breakdown under debugfs to
> > > > make them visible.
> > > >
> > > > Below is an example output:
> > > > cat $debugfs/reserved_mem/show
> > > > 0x00000009fc400000..0x00000009ffffffff (   61440 KB )   map     reusable test1
> > > > 0x00000009f9000000..0x00000009fc3fffff (   53248 KB )   map     reusable test2
> > > > 0x00000000ffdf0000..0x00000000ffffffff (    2112 KB )   map non-reusable test3
> > > > 0x00000009f6000000..0x00000009f8ffffff (   49152 KB )   map     reusable test4
> > > > ...
> > > > 0x00000000fd902000..0x00000000fd909fff (      32 KB ) nomap non-reusable test38
> > > > 0x00000000fd90a000..0x00000000fd90bfff (       8 KB ) nomap non-reusable test39
> > > > Total 39 regions, 1446140 KB
> > >
> > > This information is pretty much static, why not just print it during
> > > boot? It's also just spitting out information that's straight from the
> > > DT which is also available to userspace (flattened and unflattened).
> >
> > IIUC, for dynamic allocation cases, we can't get actual allocation layout
> > from DT.
>
> Right, so whomever does the allocation should print that out.
>
> >  Also, there could be some adjustment from memblock
> > (ex. alignment). Therefore, printing it out from the reserved_mem would
> > be more clear.
>
> If memblock is adjusting, then shouldn't memblock print out the
> addresses?

Yup, memblock can print out the address with _RET_IP_when the debug is on.
In our case, the _RET_IP_ will be early_init_dt_reserve_memory_arch so it's not
useful to find the memory owner. Thus, printing it out in of_reserved_mem
module will be more clear and simple.
>
> > However, as you mentioned, once the allocation is done, it should be pretty
> > static. Thus, printing it during boot should be reasonable. If so, we
> > could print
> > them out in fdt_init_reserved_mem() like below. Is my understanding correct?
>
> That looks mostly fine to me. If we can do it with the unflattened tree,
> that would be better. I'm not sure off hand if that works here and you
> are just incorrectly using of_get_flat_dt_prop() still, or if it is
> indeed too early.

Yup, it's too early when fdt_init_reserved_mem() is called. I thought
that is also
why nomap and prop values are using of_get_flat_dt_prop() to get the property
content in fdt_init_reserved_mem() as well.

Another thing is we should use pr_info() to print them out as they are not the
debug information. They're the memory layout we really want to know during
the boot.

Please let me know if there are any concerns. If not, I'll send a V2
patch. Thanks.

Martin
>
> Rob
