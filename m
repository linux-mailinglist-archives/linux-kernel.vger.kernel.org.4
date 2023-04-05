Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC286D7E32
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbjDEN51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbjDEN5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:57:20 -0400
X-Greylist: delayed 290 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Apr 2023 06:57:18 PDT
Received: from utopia.booyaka.com (utopia.booyaka.com [74.50.51.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4025272
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:57:17 -0700 (PDT)
Received: (qmail 20339 invoked by uid 1019); 5 Apr 2023 13:57:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Apr 2023 13:57:16 -0000
Date:   Wed, 5 Apr 2023 13:57:16 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Evan Green <evan@rivosinc.com>
cc:     Palmer Dabbelt <palmer@rivosinc.com>, slewis@rivosinc.com,
        vineetg@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 2/6] RISC-V: Add a syscall for HW probing
In-Reply-To: <20230327163203.2918455-3-evan@rivosinc.com>
Message-ID: <alpine.DEB.2.21.999.2304051354280.19052@utopia.booyaka.com>
References: <20230327163203.2918455-1-evan@rivosinc.com> <20230327163203.2918455-3-evan@rivosinc.com>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023, Evan Green wrote:

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
> Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Tested-by: Heiko Stuebner <heiko.stuebner@vrull.eu>

Folks are already building RISC-V systems with cores that have different 
feature sets inside the same Linux system image - just like some ARM 
vendors are - so it makes sense to pass this information onto userspace.

By the way, Evan, did you intend to update the copyright dates to include 
2023?

Beyond that, 

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>


- Paul
