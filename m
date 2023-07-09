Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEADE74C451
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjGINYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 09:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGINYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:24:18 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41811103;
        Sun,  9 Jul 2023 06:24:17 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko.stuebner@vrull.eu>)
        id 1qIUOU-0002QX-Dk; Sun, 09 Jul 2023 15:24:06 +0200
From:   Heiko Stuebner <heiko.stuebner@vrull.eu>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     "Hongren (Zenithal) Zheng" <i@zenithal.me>, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Evan Green <evan@rivosinc.com>, devicetree@vger.kernel.org,
        Jiatai He <jiatai2021@iscas.ac.cn>,
        Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v3 1/4] RISC-V: Add Bitmanip/Scalar Crypto parsing from DT
Date:   Sun, 09 Jul 2023 15:24:05 +0200
Message-ID: <3171655.5fSG56mABF@phil>
In-Reply-To: <20230709115549.2666557-2-sameo@rivosinc.com>
References: <20230709115549.2666557-1-sameo@rivosinc.com>
 <20230709115549.2666557-2-sameo@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 9. Juli 2023, 13:55:43 CEST schrieb Samuel Ortiz:
> From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
> 
> Parse Zb/Zk related string from DT and output them to cpuinfo.
> 
> It is worth noting that the Scalar Crypto extension defines "zk" as a
> shorthand for the Zkn, Zkr and Zkt extensions. Since the Zkn one also
> implies the Zbkb, Zbkc and Zbkx extensions, simply passing the valid
> "zk" extension name through a DT will enable all of the  Zbkb, Zbkc,
> Zbkx, Zkn, Zkr and Zkt extensions.
> 
> Also, since there currently is no mechanism to merge all enabled
> extensions, the generated cpuinfo output could be relatively large.
> For example, setting the "riscv,isa" DT property to "rv64imafdc_zk_zks"
> will generate the following cpuinfo output:
> "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed_zksh_zkt".
> 
> Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
> Reviewed-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>

Signed-off-by lines should be the other way around (Hongren Zhen first,
then yours), otherwise

Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Tested-by: Heiko Stuebner <heiko.stuebner@vrull.eu>



