Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34D663800B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKXUF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXUFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:05:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98B16CE4F;
        Thu, 24 Nov 2022 12:05:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8752EB82756;
        Thu, 24 Nov 2022 20:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A56BC433D7;
        Thu, 24 Nov 2022 20:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669320350;
        bh=f8Kaz8pUEg/+dRz3JXsCoWQ/hDv43xbv8M6GJX2jTMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9PIyi1b28nJcBVnbuB52YKFjX9SgXxrw/smc+QNBcHKHwpDR0exAb/cuFUCBr9CQ
         MwCHQnRO9ji2xHo6iJuFh0pSygN9gg7YkB0KGwiaX2XgVLPCO63PD3k/ygS4kAMvgg
         EpWwmr4ABoTnMwLExgMauElADrxobvRX+7F+ziAjdRYOY1E/2xXiBX02CxJ63jdVta
         QPWLG4PjEb9Td+S6E/payr/UPALGtERLV60ckexfjm9j2yRNPLuc9NE1AJOCJCOd1E
         2zfZ884cqIbqZMVraME45p1jw/abfNa4Py1/mM1ObtSm5d/ULhLMkcLx20f6qWzulP
         APCR+icwPFKqA==
Date:   Thu, 24 Nov 2022 20:05:40 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 1/7] riscv: asm: alternative-macros: Introduce
 ALTERNATIVE_3() macro
Message-ID: <Y3/OlKI1jyi0eoCJ@spud>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y3/LgZkR1hkblJ8D@spud>
 <4801607.MHq7AAxBmi@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4801607.MHq7AAxBmi@diego>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 08:58:41PM +0100, Heiko Stübner wrote:
> Am Donnerstag, 24. November 2022, 20:52:33 CET schrieb Conor Dooley:
> > On Thu, Nov 24, 2022 at 05:22:01PM +0000, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > 
> > > Introduce ALTERNATIVE_3() macro.
> > 
> > Bit perfunctory I think! There's a lovely comment down below that would
> > make for a better commit message if you were to yoink it.
> > Content looks about what I'd expect to see though.
> 
> Also both the comment on the original ALTERNATIVE_2 and the new ALTERNATIVE_3
> should probably be merged into a single comment explaining this once for all
> ALTERNATIVE_x variants.
> 
> Especially with the dma stuff, I'm pretty sure we'll get at least an ALTERNATIVE_4
> if not even more ;-) . So we defnitly don't want to repeat this multiple times.

Oh I can promise you that there'll be a #4 ;) I do find the comment's
wording to be quite odd though..

> + * A vendor wants to replace an old_content, but another vendor has used
> + * ALTERNATIVE_2() to patch its customized content at the same location. In

In particular this bit about "at the same location" does not make all
that much sense. What "at the same location" means in this context
should be expanded on imo. Effectively it boils down to someone else is
already replacing the same things you want to replace - it's just the
word "location" that might make sense if you're an old hand but not
otherwise?

> + * this case, this vendor can create a new macro ALTERNATIVE_3() based

Also, using the word "can". Is it not a "must" rather than a "can",
since this stuff needs to be multiplatform?

> + * on the following sample code and then replace ALTERNATIVE_2() with
> + * ALTERNATIVE_3() to append its customized content.


