Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7207085B1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjERQLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjERQLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:11:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F24CE5E;
        Thu, 18 May 2023 09:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD05B6509D;
        Thu, 18 May 2023 16:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016A4C43443;
        Thu, 18 May 2023 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684426268;
        bh=+yx8G76DZdMcQ+TOxR1LsNaIds3YTBmYDcoIcqhWsms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INaiwJ6j1tWXc5PRvt9VriLPtLdS9H81vHAsM9ZDlTdydZXBPHmt3M6ceJ5xLjqFO
         Nojk+sFVSHWX8ZjQqLjMCfbXQ9OijzZd3gTposYHqCEjIrW/gK4AGPAiJTVp9BxkGk
         z4Q6MH732znret5C9S4HqnP5dJU2+2DKFJvJaSE9plYy7zY2s88YW3YRC/2y+xPaRg
         GGFvmRUMpCGSf4rIRjnqQB5fhCb51nKDxbmA0XNy6XTQ6NO5eGCi773gkLyAOF6eZk
         LayUvRWAQuub7QklE4Kif3bo5WPekXmqPvbTA0744i22Lho4cTsprYgQEegkuCfOcV
         ZI4Dv9i95al/g==
Date:   Thu, 18 May 2023 23:59:55 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v3 06/10] dt-bindings: riscv: Add bouffalolab bl808 board
 compatibles
Message-ID: <ZGZLe6kGaD7HWQJ3@xhacker>
References: <20230514165651.2199-1-jszhang@kernel.org>
 <20230514165651.2199-7-jszhang@kernel.org>
 <20230514-kinetic-backlog-b9573ae06507@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230514-kinetic-backlog-b9573ae06507@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 07:39:28PM +0100, Conor Dooley wrote:
> On Mon, May 15, 2023 at 12:56:47AM +0800, Jisheng Zhang wrote:
> 
> > +title: Bouffalo Lab Technology SoC-based boards
> 
> I know you're only propagating an existing pattern, but the "SoC-based"
> looks rather odd!
> 
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - description: Carrier boards for the Sipeed M1s SoM
> > +        items:
> > +          - enum:
> > +              - sipeed,m1s-dock
> 
> BTW, do you know of any other m1s compatible docks?
> I couldn't find any other ones via Google, so maybe it is just worth

FWICT, there's no other m1s compatible docks, but in theory the SoM
can be used to build different docks, I just keep it as is since you
are fine with it too ;)

> swapping the enum here for another const.
> Either is fine by me though.
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.


