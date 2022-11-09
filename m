Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53546235B1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiKIVVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiKIVVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:21:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025BD31DCE;
        Wed,  9 Nov 2022 13:21:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C84161CF4;
        Wed,  9 Nov 2022 21:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FC6C433C1;
        Wed,  9 Nov 2022 21:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668028868;
        bh=pYOUc1BS7odG85FnGBnRIQ06I5+LA9EdxedOUyOFmIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rkJcHEHyn6lMw04x36p3Y6vrP+++bdC0/MvAaaLxzf7yeLVDaAC8+UzA4YVzOMTkE
         AENO6PZF3meTKmb3/S0Gqha4HT64KiVyz03dnM8tBfF6A9TjLfuvA8uSWfyYkQ6jyz
         j+YUqJNWlSAckT/fHaiz7jeUTQM3epCavo+B1O1lIPd/aT6E1FZpgS1etg2wZHdEpF
         YLV8jtR8eZCQMA1+3uLYa0DBQ0TiVr1iQQgWwUR4/Etub57OTqtq2SAWnyQrbCjq79
         /gIiNVVVQSSXrbcqEcu+ZTRc/dKkQPuZ2eM+hC+M1wYkU1DMLE4LXyoUEfmGc7J2FS
         xwSR+vQumW71g==
Date:   Wed, 9 Nov 2022 21:21:01 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>, geert+renesas@glider.be
Cc:     prabhakar.csengg@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, geert+renesas@glider.be,
        magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        Conor Dooley <conor.dooley@microchip.com>, guoren@kernel.org,
        anup@brainfault.org, Atish Patra <atishp@rivosinc.com>,
        heinrich.schuchardt@canonical.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH v5 0/7] Add support for Renesas RZ/Five SoC
Message-ID: <Y2wZvZLAENWh6qvs@spud>
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <mhng-563fb6cf-4505-4137-8da1-13f631e1c74f@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-563fb6cf-4505-4137-8da1-13f631e1c74f@palmer-ri-x1c9a>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:55:24AM -0800, Palmer Dabbelt wrote:
> On Fri, 28 Oct 2022 09:59:14 PDT (-0700), prabhakar.csengg@gmail.com wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > 

> > Lad Prabhakar (7):
> >   dt-bindings: riscv: Sort the CPU core list alphabetically
> >   dt-bindings: riscv: Add Andes AX45MP core to the list
> >   riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
> >   riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC
> >   riscv: dts: renesas: Add minimal DTS for Renesas RZ/Five SMARC EVK
> >   MAINTAINERS: Add entry for Renesas RISC-V
> >   riscv: configs: defconfig: Enable Renesas RZ/Five SoC

> Geert was mentioning taking these though one of his trees, that works for me
> so
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Happy to do a shared tag or whatever, but I think we can just skip that
> here.  The only conflicts would be defconfig and Kconfig.socs, but I don't
> think anything big is in the works for either -- unless Conor was planning
> on re-spinning that Kconfig.socs rework?

Uh, nah. I've got a wee bit (the removal of selects) that is "ready" but
there's zero urgency so it can wait for after v6.2-rc1. I don't think
it'd conflict anyway. The rest of it I need to sort out a v1 of, but I've
been distracted. Should be safe to take the defconfig & Kconfig.socs stuff
in terms of me doing anything.

Geert, would you be able to apply the first two patches on top of
v6.1-rc1 just in case, as you mentioned previously, it needs to become
part of a shared branch? Seems unlikely at this point in the cycle
though.

Thanks,
Conor.

