Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237866D7E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbjDEN7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbjDEN7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:59:48 -0400
Received: from utopia.booyaka.com (utopia.booyaka.com [74.50.51.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07D4F3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:59:47 -0700 (PDT)
Received: (qmail 19522 invoked by uid 1019); 5 Apr 2023 13:52:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Apr 2023 13:52:24 -0000
Date:   Wed, 5 Apr 2023 13:52:24 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Evan Green <evan@rivosinc.com>
cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>, heiko@sntech.de,
        Atish Patra <atishp@rivosinc.com>,
        Randy Dunlap <rdunlap@infradead.org>, vineetg@rivosinc.com,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, slewis@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Dao Lu <daolu@rivosinc.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v5 1/6] RISC-V: Move struct riscv_cpuinfo to new header
In-Reply-To: <20230327163203.2918455-2-evan@rivosinc.com>
Message-ID: <alpine.DEB.2.21.999.2304051352060.19052@utopia.booyaka.com>
References: <20230327163203.2918455-1-evan@rivosinc.com> <20230327163203.2918455-2-evan@rivosinc.com>
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

> In preparation for tracking and exposing microarchitectural details to
> userspace (like whether or not unaligned accesses are fast), move the
> riscv_cpuinfo struct out to its own new cpufeatures.h header. It will
> need to be used by more than just cpu.c.
> 
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Tested-by: Heiko Stuebner <heiko.stuebner@vrull.eu>

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>

- Paul
