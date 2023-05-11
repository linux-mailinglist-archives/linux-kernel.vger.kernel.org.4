Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CD26FEE47
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbjEKJDL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 May 2023 05:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbjEKJDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:03:09 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287C0AF
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:03:08 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1px2CU-001Jma-3W; Thu, 11 May 2023 11:03:02 +0200
Received: from p5b13addc.dip0.t-ipconnect.de ([91.19.173.220] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1px2CT-003nto-Sr; Thu, 11 May 2023 11:03:02 +0200
Message-ID: <7e58646d7ae4cad32ae30e2e7b54806cc1272d63.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] irqchip/jcore-aic: Fix missing allocation of IRQ
 descriptors
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org
Date:   Thu, 11 May 2023 11:03:01 +0200
In-Reply-To: <86zg6bmezz.wl-maz@kernel.org>
References: <20230510163343.43090-1-glaubitz@physik.fu-berlin.de>
         <479a18513b9d8c6e8ccb96093a0f0dd7@kernel.org>
         <3c76bea5e45a5ae9ea58b3ff87f9971955a3a021.camel@physik.fu-berlin.de>
         <86zg6bmezz.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.173.220
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-05-11 at 09:47 +0100, Marc Zyngier wrote:
> On Thu, 11 May 2023 08:22:20 +0100,
> John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:
> > 
> > Hi Jason!
> 
> ???

Sorry, I was confused by this:

> > > [- Jason]
> > > 
> > > It really begs the question: how has it ever been working before?
> > 
> > Users already used a locally patched kernel to work around this problem.
> 
> You're not answering my question. Does it mean JCore never worked
> upstream?

It did still work which is why the previously suggested change was to make a
failing call to irq_alloc_descs() non-fatal. The boards still booted up.

> > > Is there any plan to modernise the port and get it to allocate
> > > irq_descs on demand, as we do on most architectures?
> > 
> > Yes, there are plans to modernize the port. We're first working on
> > upstreaming all kinds of patches that have been queuing up over the
> > time.
> 
> I'd rather you skip that step and focus on making it work as a modern
> architecture. This really looks like ARM circa 2007... :-/

We have a patch-set for switching it to device tree in the pipeline.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
