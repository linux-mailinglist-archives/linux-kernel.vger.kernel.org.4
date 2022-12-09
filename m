Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C864A647B35
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLIBQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLIBQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:16:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FB0D2C0;
        Thu,  8 Dec 2022 17:16:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9FB4B82666;
        Fri,  9 Dec 2022 01:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870F5C433EF;
        Fri,  9 Dec 2022 01:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670548605;
        bh=CI61NyzwcCkls1g53GLenK1urd7NEQsO+Z2Miu0mupA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=t/u/EGa+Mbasaxz7el86ZubkX9wTeBV7sAOFPOkR+3YbEUb0XxmKTPs2yPshQq7Z2
         QL8GyyGl4ZXg7Cmgq3lNRYQgN4gqgyTbMAgEiqmUctkeVD4gVysh7IASPVuypEPF6b
         3rQITCgDRf50/0vq0PJJ05e+XJgIDFe0f6zvyVBJIkVcW3OOcGdALO7PxpEqmHUtvz
         /Y0fEEUFl8oDO0sHFRgWPL8vY1GJO5FYxySmzyv+RCgQrYathU2QFxH7Gzl4mjCsGU
         PNim3fTcuDIDDEkzU7BTBDNJ86Xmg6k1a64YCsZa0QKxre96OhKvxvOZDmZGauykBI
         NRoaq0fPH1WsA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221123031622.63171-1-xiujianfeng@huawei.com>
References: <20221123031622.63171-1-xiujianfeng@huawei.com>
Subject: Re: [PATCH] clk: socfpga: Fix memory leak in socfpga_gate_init()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, dinguyen@kernel.org,
        mturquette@baylibre.com
Date:   Thu, 08 Dec 2022 17:16:43 -0800
User-Agent: alot/0.10
Message-Id: <20221209011645.870F5C433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xiu Jianfeng (2022-11-22 19:16:22)
> Free @socfpga_clk and @ops on the error path to avoid memory leak issue.
>=20
> Fixes: a30a67be7b6e ("clk: socfpga: Don't have get_parent for single pare=
nt ops")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---

Applied to clk-next
