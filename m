Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF80E5F16EE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiJAAGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJAAGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:06:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D382A273;
        Fri, 30 Sep 2022 17:06:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEC5F62561;
        Sat,  1 Oct 2022 00:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6C8C433D6;
        Sat,  1 Oct 2022 00:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664582798;
        bh=6h0/WOD0NjyIuQeIvVYf0HlwwBVxyfofNLXZkKFjlLA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dbUCXa4OTeQkpemuU+6hMqwTsiuj6DpQAwB8xx0xdcmRKagflGKWU72/y5uzOvMMf
         Uuz0VaojFfDG2RlJYsWZGz+eVY1FDDGXV43zb/avwCdt09vq5b05fz1t8Wys2EFZ90
         qLdA6rUgqX1zyY+fHsegdMpVTtBm9ZHgPaJc/Bjgytq2B9/tavZ1JyH7bpSK8SDXu0
         BFVGeeLxmYJEtyUvZdneXxpg6EF6j1YP/uqrWS55z9SL+A8VH+awMvJOBenqGth4dN
         RwUDU9+ar/BM0tCoh92j/5x4cBZdFqtSj/r8/1ELrtnW5eJWS13pdJLtacD939libA
         DM53ZKlMLIT5g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220914033206.98046-1-linyujun809@huawei.com>
References: <20220914033206.98046-1-linyujun809@huawei.com>
Subject: Re: [PATCH -next] clk: imx: scu: fix memleak on platform_device_add() fails
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Lin Yujun <linyujun809@huawei.com>, abelvesa@kernel.org,
        aisheng.dong@nxp.com, festevam@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, mturquette@baylibre.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org
Date:   Fri, 30 Sep 2022 17:06:36 -0700
User-Agent: alot/0.10
Message-Id: <20221001000638.2E6C8C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lin Yujun (2022-09-13 20:32:06)
> No error handling is performed when platform_device_add()
> fails. Add error processing before return, and modified
> the return value.
>=20
> Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells binding support")
> Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
