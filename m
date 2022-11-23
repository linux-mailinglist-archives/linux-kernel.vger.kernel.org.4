Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71E96367E1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbiKWR7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiKWR7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:59:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D83EE37;
        Wed, 23 Nov 2022 09:59:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51AF8B82215;
        Wed, 23 Nov 2022 17:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFFBC433D6;
        Wed, 23 Nov 2022 17:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669226371;
        bh=fo+5RajrLOWrgXzM+Dx5VV6uRU0lJQMAjI3KTS77p5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pOkPLTiR2ZiV9f0l+NjiZnJhsn0x52zY/ZL5PiWHoxrD2La5EXianO7ellh88t2WX
         hr166iVCyjUmSqY7LN01JwfRpROB2NbDSKS7qUz5hqJqV8g+7In3WlqgM3g7v5fOsV
         vkAQC6ZLl1vYZcywAnPMdFaULMpRSGAb7lBz18jXGp3kBtAIGKWL0Mt/LgLjv+bUxS
         HND3rRTW7oUGYkE/4THvnKBknxqeHAtAussMTvuN3ZujmAGtBrmFSW4lTkhGUYc2pq
         fZNFyWczoe1zbpsc/9c81jWcIZlXIBMvtBHAPaK/e4ZyIqRTW3reqgtV4UYRspKnsx
         kyVPfmSLfTiew==
Date:   Wed, 23 Nov 2022 17:59:25 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: Add optional DT property
 riscv,timer-can-wake-cpu
Message-ID: <Y35ffSHWy4B6v+Pc@spud>
References: <20220727114302.302201-1-apatel@ventanamicro.com>
 <20220727114302.302201-2-apatel@ventanamicro.com>
 <372e37bf-ac90-c371-ad9e-b9c18e1cc059@linaro.org>
 <CAK9=C2WjU+2cD7UZbja3TT++KCdRyWroT=50dw=fzi5mX30rcw@mail.gmail.com>
 <7a0477a0-9f0f-87d6-4070-30321745f4cc@linaro.org>
 <CAAhSdy20p5bkVanKGkGyArn94hWJhwncztnX7U+4WkN9-v7NsA@mail.gmail.com>
 <Y3zjQXqEHsaoVVvf@wendy>
 <Y34kM9TZ1FSqpeEB@wendy>
 <CAK9=C2UeUhMXmbMZzS4rnhS++DfsTYTCQ4y-LVu6QgL0c64=0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK9=C2UeUhMXmbMZzS4rnhS++DfsTYTCQ4y-LVu6QgL0c64=0A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 09:16:55PM +0530, Anup Patel wrote:
> On Wed, Nov 23, 2022 at 7:17 PM Conor Dooley <conor.dooley@microchip.com> wrote:

> > > Adding a new timer DT node would mean, the RISC-V timer driver
> > > will now be probed using the compatible to the new DT node whereas
> > > the RISC-V timer driver is currently probed using CPU DT nodes.
> >
> > In that case, we would have to retain the ability to match against the
> > "riscv". Spitballing:
> > - add a new timer node
> > - keep matching against "riscv"
> > - look up a timer node during init w/ of_find_matching_node() that
> >   contains any new timer properties
> >
> > I think it's unlikely that this will be the last time we have to add
> > some timer properties & we should avoid doing odd things in a DT to suit
> > an operating system?
> >
> > Would something along those lines work Anup, or am I, yet again, missing
> > something?
> 
> I was already working on v3 along these lines. I will try to post a v3 this
> week itself.

Cool, I'll keep my eyes peeled :)

Thanks Anup!

