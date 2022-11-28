Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6603A63AB41
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbiK1OkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiK1OkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:40:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B5322501;
        Mon, 28 Nov 2022 06:40:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4729E611CF;
        Mon, 28 Nov 2022 14:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364F4C433C1;
        Mon, 28 Nov 2022 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669646403;
        bh=NvJorZr2n6+50Td4fDEE5U9WvCuKu2rwqwYX9x/uSbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b/T6loHbagLo3jI9KjpAzMEvqaMA39G7a7kCR9PSNmOV415m3vD5xGHcBKfZLE65L
         VxUHPPzZeSHRpNqv3kST7LSciy3QKcEKLPvH7XYWYvd6PClISSMtP2r51HTVkeaILk
         nwLSrUHhk1eT08SY6OsT6iXt7XGPd9F98L9d7GcovC1V02MEyr9IWGtfIPoW+Kqf6T
         6i86wJNWyaWMteBCloIOYtm5aK+KtGCsJD+CHsPRQcQYp6Fro5Lt3wkLHGe8BePSsy
         pX2hIgPYjB+/kdOwuU6B6sn135tJPksOCK9D4u/ofy1oWVKAI0PFiTwgt2UXwiCBxs
         hNVD0RHKICcgg==
Date:   Mon, 28 Nov 2022 22:30:08 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 8/9] MAINTAINERS: riscv: add entry for Bouffalolab SoC
Message-ID: <Y4TF8FzX19puws37@xhacker>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-9-jszhang@kernel.org>
 <Y4Of7s6UGpD0/Iga@spud>
 <Y4OgNW6uOe60Pi09@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4OgNW6uOe60Pi09@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 05:36:53PM +0000, Conor Dooley wrote:
> On Sun, Nov 27, 2022 at 05:35:48PM +0000, Conor Dooley wrote:
> > Hey Jisheng,
> > 
> > On Sun, Nov 27, 2022 at 09:24:47PM +0800, Jisheng Zhang wrote:
> > > Add Jisheng Zhang as Bouffalolab SoC maintainer.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  MAINTAINERS | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 00ff4a2949b8..a6b04249853c 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -17729,6 +17729,15 @@ F:	arch/riscv/
> > >  N:	riscv
> > >  K:	riscv
> > >  
> > > +RISC-V BOUFFALOLAB SOC SUPPORT
> > > +M:	Jisheng Zhang <jszhang@kernel.org>
> > > +L:	linux-riscv@lists.infradead.org
> > > +S:	Maintained
> > > +F:	Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> > > +F:	Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml
> > > +F:	arch/riscv/boot/dts/bouffalolab/
> > > +F:	drivers/tty/serial/bflb_uart.c
> > 
> > I think I asked last time but I didn't see an answer on lore or my
> > mailbox - if you intend sending Arnd PRs for this stuff, please add a

Per my past experience of synaptics/mrvl arm SoCs, I usually sent PRs to Arnd
if there are two or more commits/patches; If there's only one patch, I
asked Arnd for picking it up directly. So in bouffalolab SoC case, I
want to do similar, but with one difference -- if there's only one
patch, may I ask you for picking it up directly?

> > git tree here. Otherwise, LMK and I'll bundle it with the other "misc

Hmm, is "git tree" necessary?

> > riscv devicetree" stuff.
> 
> I forgot:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> > >  RISC-V MICROCHIP FPGA SUPPORT
> > >  M:	Conor Dooley <conor.dooley@microchip.com>
> > >  M:	Daire McNamara <daire.mcnamara@microchip.com>
> > > -- 
> > > 2.38.1
> > > 
> > > 
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
