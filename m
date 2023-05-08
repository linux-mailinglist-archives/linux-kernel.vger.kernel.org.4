Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFAD6FB511
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbjEHQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjEHQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:29:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B340D9;
        Mon,  8 May 2023 09:29:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4989761D5B;
        Mon,  8 May 2023 16:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C252DC433EF;
        Mon,  8 May 2023 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683563339;
        bh=feGALERuqLirZfIT3bBs/N6JFRyyWW2IgyCwmw6yorY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYUk/Uc61HOkwT+RYeVVFRAzRzRgQy3R7D5RHJqObbFl2ZIU6xFemM2PeE3j3hT0+
         ARTGdJzCWUrm47hH77jsKLB4ZLJOTTKUbVZ3yUEL294sKN3SMuiN3mG4RCh2aRQObR
         dstunq5YVv7JssAX4likGVe1MTZOrxyvgEFmxIOyhnJ3/3fCcuhnPEoSS5+Qr/66OF
         uKjBAKO899/pkBjqN0NZ08pK615SbHrhFLXlrCaYyfOBaRsj3EEcnEy9Fv3k69R/Is
         mtuslIJgDaFO8hYyQh9yzrrNbQPtRCz4oIbdLULvkcjidBKvWt1kZlLwLPUwR5awtp
         KMtmTjGgbjGOw==
Date:   Tue, 9 May 2023 00:17:52 +0800
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
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 5/5] MAINTAINERS: add entry for T-HEAD RISC-V SoC
Message-ID: <ZFkgsHGvEIxGDxXv@xhacker>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507182304.2934-6-jszhang@kernel.org>
 <20230507-woof-eldercare-f1323b10bde6@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230507-woof-eldercare-f1323b10bde6@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2023 at 10:21:26PM +0100, Conor Dooley wrote:
> Hey Jisheng,

Hi Conor,

> 
> On Mon, May 08, 2023 at 02:23:04AM +0800, Jisheng Zhang wrote:
> > I would like to temporarily maintain the T-HEAD RISC-V SoC support.
> 
> What does "temporarily" mean?

I got a Lichee Pi 4A board, and want to mainline its support. Sending
the new dts patches needs to touch MAINTAINERS entry, so I added it.
But I expected an experienced people from T-HEAD, with many
kernel contribuitions in the past, will take the maintainership
finally, for example, Ren Guo. He knew this SoC better than me.
