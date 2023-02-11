Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4AC692BB1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBKAC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBKAC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:02:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3787D7CCA7;
        Fri, 10 Feb 2023 16:02:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C499261EE3;
        Sat, 11 Feb 2023 00:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA4CC433EF;
        Sat, 11 Feb 2023 00:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676073775;
        bh=mX7Xi4Tbx04ZlDGgD+em1tWKltogSuS9Jeq2iIpszHg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sJ1ieGPT2mdbx65r/IQfbdK7MRvjEcD1bocaPXIxSXy4z3lIQZzQ689hbkyhd8fjw
         PFFJWqpZ17D2/jtKfUvVd+32Uc55BE7GC98pGoM3Ai3nHbI+lkmDoF+fWyauFAOEh2
         WUWV8cyvPiRsN6BBSNzm5jC15MqxiK9+pb8I41Ehxb5NlOWdOMPAlytuPVJ/aWZX2C
         8S0attDu1GatXrxP+YwHfoUWzfWlUzoxlrU8cvmKeYJtmaLRdA06Jn3WNwi5QhUN31
         CvBbl1B50SB8Kb5tY825MiCCzQBaWCD+T1uTi6CpgDu0u/gJDam3/u+cbkHSkc4h7Y
         cEuLLl1iR/IOA==
Message-ID: <1a8a708ac51009110f403ac7ad5fb2ab.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230202010750.79515-1-yang.lee@linux.alibaba.com>
References: <20230202010750.79515-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] clk: mediatek: clk-mtk: Remove unneeded semicolon
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     matthias.bgg@gmail.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, mturquette@baylibre.com
Date:   Fri, 10 Feb 2023 16:02:52 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yang Li (2023-02-01 17:07:50)
> ./drivers/clk/mediatek/clk-mtk.c:518:2-3: Unneeded semicolon
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D3926
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---

Applied to clk-next
