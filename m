Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F2E640216
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiLBI37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiLBI3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:29:12 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4A8A9CFF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:26:40 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so2496866otl.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 00:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BX5+MEEseekCjj2jUHYbfIzY5jOJRklKg97H+PQks68=;
        b=OVzPNFpeqRPpm2Sdd/f9dyIxjlS7vt9MVTzzyd6r85ie2ehKngICz0UrOwttda4ssx
         BJxvyqhN8GSxz3FBn0X6pjXStHnPNHsUzCCoB0KbriWxxpGcCCtix8XTe3yRvVm2EWfT
         GlX1NqmYmo1QZmC+7rJnfe4AsG0wOStcDnxaFs+hUSiuf3RuK8gTJaZrPexFvxitA15o
         gvqQgQRTyZn5vFZ+xzz03pfVHl5Ad8nPzubS5pfiE0n+5O7HohGLXb5qHyzVAufA0OLr
         4f+B3ugzqjNitv3XTVblAQTjqFPltWnv1g5VKohanq46WaNNhJcLIOjIU7aVsPIegKvn
         AZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BX5+MEEseekCjj2jUHYbfIzY5jOJRklKg97H+PQks68=;
        b=ug8Ue+ym8vbeT/nI7iYdIMknTqfYnGLRSaICSpbcU8YfhV3vO+4q0D4wEAfKoXfQPE
         RiiRRcQx4hJe4SXWwu7WzQ2aN32LbNEMlwKIzP423kD9gokbKeV2qeYL+rNA3e5JglFA
         1QTUvbDPOB+ypVHH7cp4QLFWwytQ2yKSwzxQG/im0tXxg2wxCWUKBgpMYrzlRdD/Bq64
         H4PfRTpKJR0/YlLV6pXxx7EHd7ED865BX+ZZW5wi1Id42RrefEEcnfiNb3Ebx6OeFibe
         FledngENWMlNY506gNQYi1P8yDB4/KImdTFVWbTxgA5sZJZkNRM3aPykhWuhlS39JJyb
         HhoQ==
X-Gm-Message-State: ANoB5pmhXOMWN3yoItHi2rgqjCynVqTYI7+LdpHylcRwx55efrXdMsCs
        hqv0xuf8+UMeAf/Scy0IKGQ2DQbJ4CKjoa37d0YfEA==
X-Google-Smtp-Source: AA0mqf44KccBETiwP8cR42tdieoh2XIyfwVble6BCh+8Slrcw23IhVuC0hOFaWY1mJnjptMOrsTRYwH0ivmee3+D9vw=
X-Received: by 2002:a05:6830:1007:b0:66e:7583:ab4c with SMTP id
 a7-20020a056830100700b0066e7583ab4cmr3395774otp.332.1669969599378; Fri, 02
 Dec 2022 00:26:39 -0800 (PST)
MIME-Version: 1.0
References: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
 <20221114141109.GG30263@willie-the-truck> <1659929b-1372-cea6-5840-c58369a4252d@arm.com>
 <Y3J8+O7Y3f3onH0P@arm.com> <20221118105402.GA184726@thinkpad>
 <20221118123349.GC3697@willie-the-truck> <20221121064224.GB11945@thinkpad>
 <018517b8-0ae0-54f5-f342-dcf1b3330a13@quicinc.com> <Y39blgEueyegkz6C@arm.com>
 <6d637906-e1d5-c481-a73d-2b2b845e223b@leemhuis.info> <Y4joR2sQMMjIt+yE@arm.com>
In-Reply-To: <Y4joR2sQMMjIt+yE@arm.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Fri, 2 Dec 2022 13:56:03 +0530
Message-ID: <CAMi1Hd2wM5MLsjkx0HAWKkswzTDACb0C4tsPymNrRa0ariWsww@mail.gmail.com>
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()"
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, andersson@kernel.org,
        sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022 at 23:15, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Dec 01, 2022 at 10:29:39AM +0100, Thorsten Leemhuis wrote:
> > Has any progress been made to fix this regression? It afaics is not a
> > release critical issue, but well, it still would be nice to get this
> > fixed before 6.1 is released.
>
> The only (nearly) risk-free "fix" for 6.1 would be to revert the commit
> that exposed the driver bug. It doesn't fix the actual bug, it only
> makes it less likely to happen.
>
> I like the original commit removing the cache invalidation as it shows
> drivers not behaving properly but, as a workaround, we could add a
> command line option to force back the old behaviour (defaulting to the
> new one) until the driver is fixed.

We use DB845c extensively for mainline and android-mainline[1] testing
with AOSP, and it is broken for weeks now. So be it a temporary
workaround or a proper driver fix in place, we'd really appreciate a
quick fix here.

I understand that the revert doesn't fix the actual driver bug, but we
were very very lucky so far that we had never hit this issue before.
So at this point I'll take the revert of the upstream commit as well,
while a proper fix is being worked upon.

Regards,
Amit Pundir
[1] https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline




>
> --
> Catalin
