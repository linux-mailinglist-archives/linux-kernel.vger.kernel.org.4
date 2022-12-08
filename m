Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5352A6466F0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLHC1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiLHC1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:27:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F60F8E599;
        Wed,  7 Dec 2022 18:27:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDA6161D45;
        Thu,  8 Dec 2022 02:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC01C433D6;
        Thu,  8 Dec 2022 02:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670466441;
        bh=tYKB/4hRQmNJp7Bpc82wlwoNLccUXdf+TKbOHeIeGhM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MoryZRTF36q730ReOxY9dgBQWO5BcUUu/Z2tTyd2EsrMylGZ37eBLUREF6XYBsIOr
         Dl8hv6k/pCrTFxVKPlV+ik+q7tqHd9n9s03jxlmcsKl6zyMA5kdGuByBr1lzCLSPCD
         pQH7ls1j/dkZO5ZaoUWVML960Bpe1d0jOOwuW+GDuf5vfphij6AiqSHSvYw81fGb1U
         QpxuEECI8W1nTEhoWz68FugFTRdRmRIvf9K3q9MRVehRYzY4R8kOEfDCuN+jTgJ/p2
         HyNEXghl6U05yoE6iNKBG4VU2aazkD0LJKVWkPUREq3Fdgq4WxVATOo/AoO5lHdBRT
         pk+69KCs+7F3g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221122133614.184910-1-xiujianfeng@huawei.com>
References: <20221122133614.184910-1-xiujianfeng@huawei.com>
Subject: Re: [PATCH] clk: st: Fix memory leak in st_of_quadfs_setup()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, avolmat@me.com,
        mturquette@baylibre.com, patrice.chotard@foss.st.com,
        windhl@126.com
Date:   Wed, 07 Dec 2022 18:27:19 -0800
User-Agent: alot/0.10
Message-Id: <20221208022721.4DC01C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xiu Jianfeng (2022-11-22 05:36:14)
> If st_clk_register_quadfs_pll() fails, @lock should be freed before goto
> @err_exit, otherwise will cause meory leak issue, fix it.
>=20
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---

Applied to clk-next
