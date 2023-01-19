Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556AF673FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjASRVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjASRVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:21:38 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDAD903A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:21:35 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pIYbR-0005F1-HO; Thu, 19 Jan 2023 18:21:29 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH] riscv: alternative: proceed one more instruction for auipc/jalr
 pair
Date:   Thu, 19 Jan 2023 18:21:28 +0100
Message-ID: <1748643.VLH7GnMWUR@diego>
In-Reply-To: <20230115162811.3146-1-jszhang@kernel.org>
References: <20230115162811.3146-1-jszhang@kernel.org>
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

Am Sonntag, 15. Januar 2023, 17:28:11 CET schrieb Jisheng Zhang:
> If we patched auipc + jalr pair, we'd better proceed one more
> instruction. Andrew pointed out "There's not a problem now, since
> we're only adding a fixup for jal, not jalr, but we should
> future-proof this and there's no reason to revisit an already fixed-up
> instruction anyway."
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


