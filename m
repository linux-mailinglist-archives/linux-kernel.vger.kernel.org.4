Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFC9669D08
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjAMP7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjAMP55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:57:57 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7328DC3F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:49:40 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Ntm7d6XlCz1s88x;
        Fri, 13 Jan 2023 16:49:33 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4Ntm7d5GYfz1qqlR;
        Fri, 13 Jan 2023 16:49:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id r243CuGzOFnD; Fri, 13 Jan 2023 16:49:31 +0100 (CET)
X-Auth-Info: 2BX/Bb7F44Mx5eZxELRkHAFq5wR3YQgE04gMWo440+/Tq6gxxvGmJwQW5R0GrOjK
Received: from igel.home (aftr-62-216-205-42.dynamic.mnet-online.de [62.216.205.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 13 Jan 2023 16:49:31 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 0810A2C14C7; Fri, 13 Jan 2023 16:49:31 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: Add "Code:" to RISC-V splats
References: <20230113144552.138081-1-bjorn@kernel.org>
        <20230113144552.138081-2-bjorn@kernel.org>
X-Yow:  Go on, EMOTE!  I was RAISED on thought balloons!!
Date:   Fri, 13 Jan 2023 16:49:30 +0100
In-Reply-To: <20230113144552.138081-2-bjorn@kernel.org> (=?utf-8?Q?=22Bj?=
 =?utf-8?Q?=C3=B6rn_T=C3=B6pel=22's?=
        message of "Fri, 13 Jan 2023 15:45:51 +0100")
Message-ID: <87h6wutoxh.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 13 2023, Björn Töpel wrote:

> From: Björn Töpel <bjorn@rivosinc.com>
>
> Add "Code:" output to RISC-V splats. Mimic x86-64's byte-for-byte
> dumps.

RISC-V insns are organised in 16-bit parcels, it probably make sense to
present them that way.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
