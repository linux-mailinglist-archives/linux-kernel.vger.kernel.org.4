Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447B274BC6F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 08:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjGHGwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 02:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGHGwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 02:52:20 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26406BC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 23:52:19 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76547539775so209836585a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 23:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688799138; x=1691391138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=06SNSjdxh6Hrnn46VdSeb5C8lLEFzzjmzVVrAhdJUDA=;
        b=HFeuIU2Vc6cmCTISOA4bl+L7yKbDSSHWx70RU/X+BCQzjFeJ7xW1DsXprPdPLqn5D0
         3mcSlxyBwBVPKnhtL+WaKDh5F1fOpPZuqKQiEb10caE5vCVmS9daNdDGvtx2ktOlKJRw
         kSKCsRCaQ9q2PX6PSflKsRd4LdAOA8qHtlmyqelGXVwnilZo4NJ3PWXxpnxXCMLJpnCy
         TH7CNKmZqWZZ5+mpFWtF5ROvxZbk2XJjJowl3WTxcS50E7IVm42rZBMScJjwFdGCFnkG
         TxZPiTDsnFQI0Hwgzk1CWv8UMfAyYHRR7nSlbf5UjrBB4cVSog8rhF8NtGUJ6Jd6p9kH
         rPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688799138; x=1691391138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06SNSjdxh6Hrnn46VdSeb5C8lLEFzzjmzVVrAhdJUDA=;
        b=f0sVPqlT6mFnCUsMonlPSk2pguqX5gWeH4jE2V1ggt1PJ5hCPhSWLr8/VjCBN57P6f
         LE1BvYev/u5iVVETtkT5epmFSMxC+Sxb0CngggldjBpuqHz9dzO5VSIARcRM1PNI/PmA
         nFgfNlO/ExTD+QyEo59r0ZYF7Cdrpfypj0RfaX310UqqAQOd6+lMMYEasLXKeNTvmqQb
         aiBNO0GS1L58I07U0MLvLHZFFlo3SbdtOVwPu/T0TIPB1aL+DJcANE4/4Gyp38yFkuFJ
         bpGlAnug7fKr/bFONQHJiSHfHpPgS/KoWQ6WmMU4iukETO2vTXXC6wBx/GLeXC5gA53q
         T1Fg==
X-Gm-Message-State: ABy/qLaAO2Ti7WyL98etduKwCaeJ1opKsX2CFcD9zBDsPPhT51Bf2n2S
        Kazr++XxL468Grxksk5z3YUXGa4CKzBDAXILpUf8mT4h3tM=
X-Google-Smtp-Source: APBJJlE9F0GAu/l6+2oNqlxveAEixciKojSM5EvyFrqd7e1g6qPggy0J1I7dxAJcnNVwLGHCtU2cpjxGPbC0Jbc7gNU=
X-Received: by 2002:a37:2c81:0:b0:767:3f2a:cfe7 with SMTP id
 s123-20020a372c81000000b007673f2acfe7mr5942828qkh.56.1688799138184; Fri, 07
 Jul 2023 23:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <1688668070-8408-1-git-send-email-quic_pintu@quicinc.com>
 <1688668414-12350-1-git-send-email-quic_pintu@quicinc.com>
 <26816f0a-7f55-f5ce-b71d-769011f9230f@arm.com> <ZKgJIlqZk8cw4MBa@casper.infradead.org>
 <CAOuPNLiOO_Pa=J_-0RhDBQ0auL0rgCjmpCZHtH3ngv6D1OhW6Q@mail.gmail.com>
 <ZKgctnmuVbLvYb9d@casper.infradead.org> <CAOuPNLjcBe7iEdJUhLS-kJuCc-uxXarh6o=JiTirGixq+tj+jg@mail.gmail.com>
 <ZKgfkhOMNT1xDjk+@casper.infradead.org> <CAOuPNLgwRugBZg7UB+jvW5Q1K2Bk2cJwz1svUP7XscLW18ttFg@mail.gmail.com>
In-Reply-To: <CAOuPNLgwRugBZg7UB+jvW5Q1K2Bk2cJwz1svUP7XscLW18ttFg@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Sat, 8 Jul 2023 12:22:06 +0530
Message-ID: <CAOuPNLi9zcLF_mpjxUR6fOjQ0q0BGoauaofpptuFi+mkkxXSKQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: cma: print cma name as well in cma_alloc debug
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Pintu Kumar <quic_pintu@quicinc.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 at 20:03, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Fri, 7 Jul 2023 at 19:52, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Jul 07, 2023 at 07:46:31PM +0530, Pintu Agarwal wrote:
> > > On Fri, 7 Jul 2023 at 19:40, Matthew Wilcox <willy@infradead.org> wrote:
> > > > > One more question from here:
> > > > > pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
> > > > >                 (void *)cma, cma->name, count, align);
> > > > >
> > > > > Do we really need this "cma %p" printing ?
> > > > > I hardly check it and simply rely on name and count.
> > > >
> > > > Printing pointers is almost always a bad idea.  Printing the base_pfn
> > > > might be a good idea to distinguish CMAs which happen to have the
> > > > same name?
> > > >
> > > No there is no name there, it's just a ptrval
> > > cma: cma_alloc(cma (ptrval), name: reserved, count 64, align 6)
> >
> > You misunderstand me.  I don't know how CMAs get their name.  Is it not
> > possible for two CMAs to have the same name as each other?
> >
> Oh yah that is possible, for example multiple players can use the same
> global cma region.

Yes, I think it's a good idea to include base_pfn instead of printing pointers.
Let's complete the cma->name inclusion first.
Later I will check about base_pfn and push in another patch.
Thanks
