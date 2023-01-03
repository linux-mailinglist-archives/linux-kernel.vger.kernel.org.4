Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C249A65BC4D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbjACIfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbjACIfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:35:10 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01855DFB9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:35:08 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pCclC-00050A-Ej; Tue, 03 Jan 2023 09:35:02 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH RESEND 2/2] riscv: errata: prefix T-Head mnemonics with th.
Date:   Tue, 03 Jan 2023 09:35:01 +0100
Message-ID: <5641668.DvuYhMxLoT@diego>
In-Reply-To: <20230103062610.69704-2-uwu@icenowy.me>
References: <20230103062610.69704-1-uwu@icenowy.me> <20230103062610.69704-2-uwu@icenowy.me>
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

Am Dienstag, 3. Januar 2023, 07:26:10 CET schrieb Icenowy Zheng:
> T-Head now maintains some specification for their extended instructions
> at [1], in which all instructions are prefixed "th.".
> 
> Follow this practice in the kernel comments.
> 
> [1] https://github.com/T-head-Semi/thead-extension-spec
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



