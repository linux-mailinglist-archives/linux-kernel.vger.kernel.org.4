Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94875BEF00
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 23:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiITVKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 17:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiITVKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 17:10:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECA140BD6;
        Tue, 20 Sep 2022 14:10:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A19C62DF5;
        Tue, 20 Sep 2022 21:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2BBC433D6;
        Tue, 20 Sep 2022 21:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663708237;
        bh=z6WUEQNYA+xcjFnfjJj5+YD85z46eUMoe3zhy3oMjac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=War/wuH6pmHKZbfFqZaZmGvi22WMrZXc0KzzKsVMGCrXgmdOW3vFx1OWwP9zwhi47
         9Z4+vIp0R0uSscynuVcKZYt+QQpU1+OHt2F2n0gbSwtGyEiXZWbftJ0ipsLYvKaBsJ
         DVEGg+e6PQ7IhI7nPCpoAVlwi7Rc93PKpnZBOiJw6vj9JFH6/19yyvHoOYu1aPsvWK
         ZABIWJeyZRwszmU6lwg05+fM0XqO8ZeXEigyytutQH5jhP5DhVmXD06OtYKI2ZXwqn
         WiNp6KzTr7UC7lL4ilRYbP4D44Mz0MsmMtpBCOQQu79Hg1KSVXassSSKQjeh8LQxWH
         kEMMfNZuLEJwA==
Date:   Tue, 20 Sep 2022 22:10:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 05/10] riscv: Kconfig.socs: Add ARCH_RENESAS kconfig
 option
Message-ID: <YyosR4jNFeY/YRaU@spud>
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220920184904.90495-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YyoOv9Jx+h0JzfX0@spud>
 <CA+V-a8s8Nr-RUabiLA5PhHLVQQxsBPpjX_7f7ANZoGGFfOGJVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8s8Nr-RUabiLA5PhHLVQQxsBPpjX_7f7ANZoGGFfOGJVQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 10:04:06PM +0100, Lad, Prabhakar wrote:
> To clarify, shall I add ARCH_RENESAS to the beginning of the file or
> after the SOC_MICROCHIP_POLARFIRE config?
> 
> As rest of the configs start with SOC and for Renesas it starts with
> ARCH, so to avoid another re-spin hence this query.

I'd say sort it based on Renesas so that everything else can be swapped
over in place. I don't care that much to be honest, was just an "if
you're already respinning" kind of thing.

Thanks,
Conor.

