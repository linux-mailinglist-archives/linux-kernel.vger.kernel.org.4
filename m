Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5CD612A80
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 13:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJ3MCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 08:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3MCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 08:02:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A78C771;
        Sun, 30 Oct 2022 05:02:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81F87B80DA7;
        Sun, 30 Oct 2022 12:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE1CC433D6;
        Sun, 30 Oct 2022 12:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667131335;
        bh=HRszhxNcL2xa9zIHaXT7CIUphxF72yX5b9TQHNkKxnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJuv/zABSSkBJJ3P9HwYtusgSfxCzmrjBDhvS9BTNEp8KVcZrhE2nvgQTF5DaLoxo
         zHIBIA3g7z9TcJlfw5aAk5UhK+9CLletD7tWH5AYzKZFhUYzHB8pBV/6K+TkZrIEf5
         7iu4d89NMBD293J3ijZ8/srtsjaCNryGPL25mvGRvleWAgZE5+Ek5R5sTCMJziN8S6
         JFKjKJBG9aOqwUhgbk0qs0IIkgNL2UISvQ9B6e+9W8nGbYfmBb/h9qhmz4Ycm1Bb0p
         j1Bdw0Kpp03KKAVzR4YvY3DwiSLf8W9Bo9XDNGB1gpBMooctV7QE2dv3xfam0hfff/
         ivUN0dmq48Mxg==
Date:   Sun, 30 Oct 2022 12:02:09 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/6] RISC-V: stop selecting device drivers in Kconfig.socs
Message-ID: <Y15nwXmn7rToJkH2@spud>
References: <20221005171348.167476-1-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005171348.167476-1-conor@kernel.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 06:13:43PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> As my RFC [0] series doing the symbol name changes has not yet reached
> consensus, I've split out the removal of device driver selects into a
> new series. I kept the plic as a direct select - although given how Maz
> is treating the SiFive plic driver as the RISC-V plic driver, maybe that
> should just be selected by default at an arch level...
> 
> I assume the individual patches can go via their subsystems & I'll
> resubmit the arch/riscv patches a cycle later? I'm not in any rush.

Hey,

What's the story here with the two serial patches, they just waiting for
an Ack? I think these are archived on the riscv patchwork, so if that is
the case I'll unarchive them and mark as needing one.

Thanks,
Conor.

> 
> 0 - https://lore.kernel.org/linux-riscv/20220923185605.1900083-1-conor@kernel.org/
> 
> Conor Dooley (6):
>   clk: sifive: select by default if SOC_SIFIVE
>   serial: sifive: select by default if SOC_SIFIVE
>   serial: sifive: select by default if SOC_CANAAN
>   riscv: stop selecting the PolarFire SoC clock driver
>   riscv: stop selecting SiFive clock and serial drivers directly
>   riscv: stop directly selecting drivers for SOC_CANAAN
> 
>  arch/riscv/Kconfig.socs    | 8 --------
>  drivers/clk/sifive/Kconfig | 4 +++-
>  drivers/tty/serial/Kconfig | 2 ++
>  3 files changed, 5 insertions(+), 9 deletions(-)
> 
> -- 
> 2.37.3
> 
