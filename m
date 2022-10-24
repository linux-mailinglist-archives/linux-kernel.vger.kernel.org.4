Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B618560B967
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiJXUKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiJXUIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:08:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF6C92F43;
        Mon, 24 Oct 2022 11:28:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1196F612FF;
        Mon, 24 Oct 2022 14:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77820C433D7;
        Mon, 24 Oct 2022 14:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666621913;
        bh=TCf/Sb2bwuViNIHauQr3XnVm1weJb/MMx5OkM+xD63I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C4vYVZEU/A8k/LOWSK4rbgvKzq7AG+hhsVtyURrzIYzv748VUhC9lLENgt2LzkOPY
         kJtj4hr/T4pt45ZUpJRvWpfp5hc8Y1RETPVAa6GNk4WDbeUVFZNjU6aHHCCIH3/CTg
         z6077kWgLm2myGJmQLHSKZ88F5BWEjPLZIQS6+yBC05kxbakkjoRKg6MWOUmwcz5f5
         3Au5GzNeaQor78C4a2KMQ5J6BqY2coTM4dPU8yxsS8X5lkkgM9vjSbS2NtxROGGPPh
         FR5MSjCTb+NILkWe9ObrJtFS5wj4rQ212lvbtb6kFCOoA3FaQMHydUnFdkXtMfA1Mc
         3MespaheGArsg==
Received: by mail-lj1-f175.google.com with SMTP id z24so3038091ljn.4;
        Mon, 24 Oct 2022 07:31:53 -0700 (PDT)
X-Gm-Message-State: ACrzQf3srHvQZyYS86heYa/NCPSdNn3/IBx2+m8d0YeP9huSO/pfOxE5
        77iIsrFR/QPs9mFqgNJ3k7Z+VfcV3uVecG0Blg==
X-Google-Smtp-Source: AMsMyM4CJSlR3mZVJmuXccU+cGW5kbY1Mm+IPztnS6tTuG0WzFbrUzOJEOTd2q3WTThLgJKfcn2aHzF9sE50vxLZuvw=
X-Received: by 2002:a05:651c:d2:b0:277:43d:3b23 with SMTP id
 18-20020a05651c00d200b00277043d3b23mr3346833ljr.102.1666621911447; Mon, 24
 Oct 2022 07:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221021203928.286169-1-robh@kernel.org> <20221024101405.3c2e163a@xps-13>
In-Reply-To: <20221024101405.3c2e163a@xps-13>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 24 Oct 2022 09:31:41 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+C903Syo-buYvC5=jtvhtvhwerEbz9wkd6nRFs7aB8LQ@mail.gmail.com>
Message-ID: <CAL_Jsq+C903Syo-buYvC5=jtvhtvhwerEbz9wkd6nRFs7aB8LQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: memory-controllers: arm,pl353-smc: Extend to
 support 'arm,pl354' SMC
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 3:14 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Rob,
>
> robh@kernel.org wrote on Fri, 21 Oct 2022 15:39:28 -0500:
>
> > Add support for the Arm PL354 static memory controller to the existing
> > Arm PL353 binding. Both are different configurations of the same IP with
> > support for different types of memory interfaces.
> >
> > The 'arm,pl354' binding has already been in use upstream for a long time
> > in Arm development boards. The existing users have only the controller
> > without any child devices, so drop the required address properties
> > (ranges, #address-cells, #size-cells). The schema for 'ranges' is too
> > constrained as the order is not important and the PL354 has 8
> > chipselects (And the PL353 actually has up to 8 too).
>
> I'm not convinced the ranges constraint should be soften. For me
> the order was important (and the description in the yaml useful, but
> that's a personal opinion). What makes you think the ranges order is
> not relevant on PL353?

Address translation looks for a matching entry, so order doesn't
matter. However, we have seen cases in PCI hosts where the driver
populates registers based on the order of ranges. That's a driver
problem IMO. For PCI, it was multiple entries of the same type. For
this, we have the chip select number in the entry, so we shouldn't
have the same sort of problem. Except there is another issue that the
SRAM interface chipselects are numbered 1 and 2. The PL353 can have 4
NAND chipselects, I don't think the host addresses are necessarily in
order or contiguous either, so you could need 4 entries for NAND. The
existing description doesn't handle that, and the chipselects for the
SRAM interface should have been numbered 4-7. I don't mind saying the
entries should be in order by chipselect, but we can't define indices
of the entries as was done. It's all kind of academic because we don't
have any h/w needing anything else though the Arm boards would if the
child nodes actually got defined (not likely at this point).

Rob
