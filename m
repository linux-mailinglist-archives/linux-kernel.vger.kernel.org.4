Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA5A6CAE79
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjC0TW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjC0TW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:22:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577F7C2;
        Mon, 27 Mar 2023 12:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3EA5614A7;
        Mon, 27 Mar 2023 19:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E4DC433D2;
        Mon, 27 Mar 2023 19:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679944974;
        bh=fMuF76hCf3xIdNYzMoDMNZlhgXHUJC+l8bYr8xz5Ofs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=g8SdnVGd1OLHBfXF6K9rKG0Gz0cIeX6dxl19xqIGq6jk6GKcswE+RGT7HGTqfh1tY
         4qNU73++3r58RC5IrNcnOXQBLBItO/DERzLrDOB0xWkPxeAS0fTK1nZNHVKpftbMuH
         F+nGH9ahQ/mQWabzqVZHpQIrZhpEfgcYK0rBkOluNIJ2jfm7EtXZeLlGWUYsrsgBNS
         jnvuialK28dpgZEGo9D8k9Ghx0pv52aj1KTsIJfuNiKjU/3CC6MHX9xmFxhEDNzswe
         1rqSE1ZVP5s65giKJdmGvevP7IDQTNrNcal+mj4mAYI/fHNrQ9DpYEKmenDrixPTAA
         gOz+7iSdAe0pA==
Message-ID: <1b9f86fce565b1476072f4f5711f5ee9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230323025229.2971-2-zhuyinbo@loongson.cn>
References: <20230323025229.2971-1-zhuyinbo@loongson.cn> <20230323025229.2971-2-zhuyinbo@loongson.cn>
Subject: Re: [PATCH v16 2/2] clk: clk-loongson2: add clock controller driver support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Mar 2023 12:22:52 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yinbo Zhu (2023-03-22 19:52:29)
> This driver provides support for clock controller on Loongson-2 SoC,
> the Loongson-2 SoC uses a 100MHz clock as the PLL reference clock,
> there are five independent PLLs inside, each of which PLL can
> provide up to three sets of frequency dependent clock outputs.
>=20
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---

Applied to clk-next
