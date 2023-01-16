Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E95366BB90
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjAPKTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjAPKTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:19:22 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22ED10E6;
        Mon, 16 Jan 2023 02:19:18 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pHMaB-00069d-0v; Mon, 16 Jan 2023 11:19:15 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lucas Tanure <lucas.tanure@collabora.com>
Subject: Re: linux-next: Fixes tag needs some work in the rockchip tree
Date:   Mon, 16 Jan 2023 11:19:14 +0100
Message-ID: <1840312.tdWV9SEqCh@diego>
In-Reply-To: <20230116080947.2dcddeee@canb.auug.org.au>
References: <20230116080947.2dcddeee@canb.auug.org.au>
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

Hi Stephen,

Am Sonntag, 15. Januar 2023, 22:09:47 CET schrieb Stephen Rothwell:
> In commit
> 
>   0b86f9570e77 ("arm64: dts: rockchip: Fix RX delay for ethernet phy on rk3588s-rock5a")
> 
> Fixes tag
> 
>   Fixes: 55fa4c2a7a912 ("arm64: dts: rockchip: Add rock-5a board")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: d1824cf95799 ("arm64: dts: rockchip: Add rock-5a board")

thanks for noticing. I've checked this and amended the commit with the
correct id.

Thanks
Heiko


