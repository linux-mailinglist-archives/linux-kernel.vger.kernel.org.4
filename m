Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E08D6C3BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCUUZA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Mar 2023 16:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjCUUYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:24:50 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6432EEB68;
        Tue, 21 Mar 2023 13:23:57 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1peiWF-0003yL-0g; Tue, 21 Mar 2023 21:23:43 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Evan Green <evan@rivosinc.com>
Cc:     slewis@rivosinc.com, Conor Dooley <conor@kernel.org>,
        vineetg@rivosinc.com, Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 2/6] RISC-V: Add a syscall for HW probing
Date:   Tue, 21 Mar 2023 21:23:41 +0100
Message-ID: <10720737.nUPlyArG6x@diego>
In-Reply-To: <20230314183220.513101-3-evan@rivosinc.com>
References: <20230314183220.513101-1-evan@rivosinc.com>
 <20230314183220.513101-3-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 14. März 2023, 19:32:16 CET schrieb Evan Green:
> We don't have enough space for these all in ELF_HWCAP{,2} and there's no
> system call that quite does this, so let's just provide an arch-specific
> one to probe for hardware capabilities.  This currently just provides
> m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
> the future.
> 
> Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>


