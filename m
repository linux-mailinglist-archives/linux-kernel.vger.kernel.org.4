Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B9963FC23
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiLAXgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiLAXga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:36:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E13BE100;
        Thu,  1 Dec 2022 15:36:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72E36621B1;
        Thu,  1 Dec 2022 23:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511E5C433D6;
        Thu,  1 Dec 2022 23:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669937785;
        bh=VqnsrWM0Vo9n3c7N8+McUIw2HirTpnKJAftxv+kRgs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uLy9Z3Y4Km1xs94oZ2ESTUJXcVCpjQk8O3w1yvHQQsuFACf30OnlEH9hGh6HWlhkx
         UVkv7qlRYsO77M1GGSe3YCmG2q6euMuUqYKGAq6UtOP4m5Hx1dSiv1uB8TQdZ18XqR
         09SlcnDMTWH7DRJWZH70c5Zu5jtGOkOY6FNl27qskx1smSN4fM+8901gVceMiXXg+w
         Gqrv72aSDc+M23KE7kZIuCbED6gNxafnowUJW+9atlo2frZ/9gXywYPeEKgXXZiT7/
         +vfvvIWS2ThLlzK0iKVHceIUnMYdk8Mrvkona/TsJu23WXI9kMaZEmdNkMTSbidpVq
         CokV6334wg6Hw==
Date:   Thu, 1 Dec 2022 23:36:18 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>, palmer@dabbelt.com
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
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
Subject: Re: [PATCH v4 0/7] AX45MP: Add support to non-coherent DMA
Message-ID: <Y4k6ct+iA4j0NZgR@spud>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

I'm going to mark this series as "Changes Requested" in patchwork since
there's been quite a lot of commentary and it looks like Samuel & Heiko
have both suggested some changes.
Scream if you think that's not appropriate :)

Thanks,
Conor.
