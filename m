Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FD0680254
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 23:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbjA2WnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 17:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjA2WnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 17:43:14 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAE2E3AE;
        Sun, 29 Jan 2023 14:43:12 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pMGOD-0006av-40; Sun, 29 Jan 2023 23:43:09 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dan Johansen <strit@manjaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the rockchip tree
Date:   Sun, 29 Jan 2023 23:43:08 +0100
Message-ID: <4457262.LvFx2qVVIh@diego>
In-Reply-To: <20230130090233.67f2c5f1@canb.auug.org.au>
References: <20230130090233.67f2c5f1@canb.auug.org.au>
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

Am Sonntag, 29. Januar 2023, 23:02:33 CET schrieb Stephen Rothwell:
> Hi all,
> 
> In commit
> 
>   96e908b46e65 ("arm64: dts: rockchip: set sdmmc0 speed to sd-uhs-sdr50 on rock-3a")
> 
> Fixes tag
> 
>   Fixes: 22a442e6 ("arm64: dts: rockchip: add basic dts for the radxa rock3 model a")

[re-sending as I initially answered Dan's reply without realizing that the
 mailinglists weren't included there]

I've amended the commit with the better commit hash and also updated the
for-next branch.

Thanks for catching this
Heiko


