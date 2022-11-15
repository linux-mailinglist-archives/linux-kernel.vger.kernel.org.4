Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7C262AE69
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiKOWgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiKOWgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:36:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E4827931;
        Tue, 15 Nov 2022 14:34:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90ADF60C66;
        Tue, 15 Nov 2022 22:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF7DC433D6;
        Tue, 15 Nov 2022 22:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668551659;
        bh=76h3S74vm1zYx6md3wh9PEY2pfxWlGuA1XOIWM1Ej8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCQGmaC8E1eybY/odcwOwupHzv03jx6xqZRt6NQtxw0A02dG+GlWp+6u+vFSYn8Bc
         SnBQdosUT3PFr2By8Sa0wSP8xAMCz8GosfjCqLp7Cy4oFaf3ZokqfxowUb4VZFxNLO
         lPNMCCe+OllrBnf8hZnYzkpX12Qeo1cWNMQCXyYDK7fc4f9hhws3IikLqWWtTvYA2N
         zJWLdpjnBiWz/bRryhfdKrijjmNamYoUP3iV/1/gEpWGP+aJ4Ix15oKRA3X2HHMFH4
         A0AUn+yIauYJKeNCmBOOPvwTdTOK+EBxwXxTxNdpFWlrDCAmrxWs6dPfSy0fxrGsHb
         DJ0RKyeH1wa7w==
Date:   Tue, 15 Nov 2022 22:34:13 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/9] dt-bindings: Add RISC-V incoming MSI controller
 bindings
Message-ID: <Y3QT5Vy3RnIXobHz@spud>
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-5-apatel@ventanamicro.com>
 <Y3EDuaW0zQSSfiQ/@spud>
 <CAK9=C2WDQCnVnxKR6SFspdwope2KffyASLJDF_Ygo_417ekJ5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK9=C2WDQCnVnxKR6SFspdwope2KffyASLJDF_Ygo_417ekJ5w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:59:00PM +0530, Anup Patel wrote:
> On Sun, Nov 13, 2022 at 8:18 PM Conor Dooley <conor@kernel.org> wrote:

> > Also, the file name says "riscv,imsic", the description says "IMSIC" but
> > you've used "imsics" in the compatible. Is this a typo, or a plural?
> 
> Yes, the file name should be consistent. I will update the file name.

Is there a reason why the compatible is plural when all of the other
mentions etc do not have an "s"? It really did look like a typo to me.

It's the "incoming MSI controller", so I am unsure as to where the "s"
actually even comes from. Why not just use "riscv,imsic"?

Thanks,
Conor.

