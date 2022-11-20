Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2926314AA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 15:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiKTO2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 09:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKTO2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 09:28:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998E413DD4;
        Sun, 20 Nov 2022 06:28:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15F1860C53;
        Sun, 20 Nov 2022 14:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6407C433D6;
        Sun, 20 Nov 2022 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668954491;
        bh=ZyTdR46YHnrIKCr3ypza1lyjyvfhcyJlCC9EQ4CL9Qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BKuUuq7ArZdPGwIubzAT9eJp3NWq8a5wOgtoZVkvi6AsDW4icVR/rmq/LsrMn3Frj
         jJ0IJolr731DBC7/lnH0xjK3IJ67Dl7HTA0+FBT2hM+etAQqdqJxwnAffT+Q1rm5w4
         CpD2SmRJbDcOznoeXE+f9RSYjoHT9ebONxG6Wr8zJo73jUgx6oIVnlwdXHWA+GouFs
         d423jE1Nl9KPg7YasDzlDTnE7n3WPxMqFuqI8SsNt4sx6Zv2qjeidSvDpOADjWqZwK
         vp1yKZO+xtFJCrGj5t7uumHs6dEfTgvPXCGlJyAPc7xiIvieNZ98vY4f+Kk6AHS0Nc
         6qjPrLFJbsWPg==
Date:   Sun, 20 Nov 2022 14:28:06 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 5/7] riscv: dts: bouffalolab: add the bl808 SoC base
 device tree
Message-ID: <Y3o5dqPX7ScTs9qj@spud>
References: <20221120082114.3030-1-jszhang@kernel.org>
 <20221120082114.3030-6-jszhang@kernel.org>
 <Y3oJSfsNFE9Cn0Al@spud>
 <32ffd3f857ce9c08462ce8a7b2e40871c2f2c275.camel@icenowy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32ffd3f857ce9c08462ce8a7b2e40871c2f2c275.camel@icenowy.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 07:58:56PM +0800, Icenowy Zheng wrote:
> 在 2022-11-20星期日的 11:02 +0000，Conor Dooley写道：
> > On Sun, Nov 20, 2022 at 04:21:12PM +0800, Jisheng Zhang wrote:
> > > Add a baisc dtsi for the bouffalolab bl808 SoC.

> > > +               plic: interrupt-controller@e0000000 {
> > > +                       compatible = "thead,c900-plic";
> > 
> > Hmm, this one fails validation too. Likely you need to add a
> > "bouffalolab,plic" to the plic dt-binding or otherwise modify the
> > binding such that thead,c900-plic on it's own is permitted. CC Samuel
> > on
> > that patch please in case he has an opinion on it.
> 
> Personally I prefer a single c900-plic in compatible, because the PLIC
> doesn't look so configurable in C906/C910 (the interrupt source number
> is really adjustable, but it's already in the riscv,ndev property).

Right, if all implementations are going to be identical (modulo the
riscv,ndev) allowing thead,c900-plic in isolation makes sense to me.
I had a bit of a check in the history & it looks like there was no 
explanation given for why the D1 needed a specific compatible (although
there's no harm in having one in case something comes up in the future
that'd require special handling for a given implementation).

