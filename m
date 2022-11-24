Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261A3638013
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiKXUKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXUKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:10:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D577E74602;
        Thu, 24 Nov 2022 12:10:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86C12B828D7;
        Thu, 24 Nov 2022 20:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5F9C433D6;
        Thu, 24 Nov 2022 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669320604;
        bh=KXjgMIIzjeBW/b+BUU54O+6KKHdrQhBefEjGsi6yglo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cLqbwLT9iKMsr/p6RHja2vOPufX12lQdda6T8mJ2ZBs8QBk3Nhk3Wuf66gJb9g2Tx
         2nEjXa+iLfmRrHKAHvekmLWRBZv94L/ZYWK9Ew02qhtNOI809EhL7dgYbLnXFcs6Pf
         UXrvC8yJNGK5353IZYRlwFhRq3u1oavGLfphLrwgbCWBxxRvOSiRPtRJOtKvpw9Yln
         g/dnoGdQpbUzL24ceWtL3dv70oId893FdsCcENJ5jNMGr3jD2aOVKwQOb/H+p63yY0
         baG6REtzXE2PyCUNK5M7BihLKrmsh0PqLDQmYOknoinb5r1t9emixY88T3+FcGwTLO
         8LmMZAHYNOssw==
Date:   Thu, 24 Nov 2022 20:09:57 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
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
Subject: Re: [PATCH v4 2/7] riscv: asm: vendorid_list: Add Andes Technology
 to the vendors list
Message-ID: <Y3/PlXJqJZzWN7Qz@spud>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124172207.153718-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
