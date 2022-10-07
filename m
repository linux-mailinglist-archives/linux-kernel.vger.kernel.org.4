Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B15C5F7A57
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiJGPM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJGPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:12:57 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59F1102525
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:12:54 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ogp1q-000850-95; Fri, 07 Oct 2022 17:12:46 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH 8/8] riscv: remove riscv_isa_ext_keys[] array and related usage
Date:   Fri, 07 Oct 2022 17:12:44 +0200
Message-ID: <16326987.geO5KgaWL5@diego>
In-Reply-To: <20221006070818.3616-9-jszhang@kernel.org>
References: <20221006070818.3616-1-jszhang@kernel.org> <20221006070818.3616-9-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 6. Oktober 2022, 09:08:18 CEST schrieb Jisheng Zhang:
> All users have switched to riscv_has_extension_*, removed unused
> definitions, vars and related setting code.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


