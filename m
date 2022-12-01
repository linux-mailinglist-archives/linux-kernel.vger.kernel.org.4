Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39FD63EE65
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiLAKtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiLAKsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:48:52 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ABE8C688;
        Thu,  1 Dec 2022 02:48:43 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p0h7F-0000rr-68; Thu, 01 Dec 2022 11:48:29 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>, ajones@ventanamicro.com,
        aou@eecs.berkeley.edu, conor@kernel.org, corbet@lwn.net,
        guoren@kernel.org, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 2/3] RISC-V: resort all extensions in consistent orders
Date:   Thu, 01 Dec 2022 11:48:28 +0100
Message-ID: <113066935.nniJfEyVGO@diego>
In-Reply-To: <20221130234125.2722364-3-conor@kernel.org>
References: <20221130234125.2722364-1-conor@kernel.org> <20221130234125.2722364-3-conor@kernel.org>
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

Am Donnerstag, 1. Dezember 2022, 00:41:25 CET schrieb Conor Dooley:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Ordering between each and every list of extensions is wildly
> inconsistent. Per discussion on the lists pick the following policy:
> 
> - The array defining order in /proc/cpuinfo follows a narrow
>   interpretation of the ISA specifications, described in a comment
>   immediately presiding it.
> 
> - All other lists of extensions are sorted alphabetically.
> 
> This will hopefully allow for easier review & future additions, and
> reduce conflicts between patchsets as the number of extensions grows.
> 
> Link: https://lore.kernel.org/all/20221129144742.2935581-2-conor.dooley@microchip.com/
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>


