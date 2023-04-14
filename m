Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2706C6E19CA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDNBhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDNBhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:37:52 -0400
Received: from utopia.booyaka.com (utopia.booyaka.com [74.50.51.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64FACA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 18:37:50 -0700 (PDT)
Received: (qmail 28873 invoked by uid 1019); 14 Apr 2023 01:37:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Apr 2023 01:37:49 -0000
Date:   Fri, 14 Apr 2023 01:37:49 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Evan Green <evan@rivosinc.com>
cc:     Palmer Dabbelt <palmer@rivosinc.com>, slewis@rivosinc.com,
        heiko@sntech.de, Conor Dooley <conor@kernel.org>,
        vineetg@rivosinc.com, Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 3/6] RISC-V: hwprobe: Add support for
 RISCV_HWPROBE_BASE_BEHAVIOR_IMA
In-Reply-To: <20230407231103.2622178-4-evan@rivosinc.com>
Message-ID: <alpine.DEB.2.21.999.2304140137250.26968@utopia.booyaka.com>
References: <20230407231103.2622178-1-evan@rivosinc.com> <20230407231103.2622178-4-evan@rivosinc.com>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023, Evan Green wrote:

> We have an implicit set of base behaviors that userspace depends on,
> which are mostly defined in various ISA specifications.
> 
> Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Tested-by: Heiko Stuebner <heiko.stuebner@vrull.eu>

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>


- Paul
