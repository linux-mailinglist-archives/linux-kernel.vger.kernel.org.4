Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC32632D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKUTf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKUTfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:35:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8189CB9F5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:35:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EB93B80FAC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55530C433D6;
        Mon, 21 Nov 2022 19:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669059351;
        bh=Ydai0dK5/lA9XsnNpEEKTSKHyWesOJQz+aHZGyTNcyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YkSlNMOfijh48oFzDf9jLR0k2E1O47vr+ZI0KV9FNZmEHbLxIE9oPkRvFqZAHEpUJ
         8SsBwuVn9j2PKIknKUs7G3kPiFDsIZTv9RHFVak3efCjvtfhyhCx/8LXNVh6VRPvhn
         /GYsGMwyLvExZnjXvasuVpdjLDeuNeIvxicZIrko287zZV6s8AkGu83wmRZMataxpY
         1IvXfEmJiwmGgp8tQz7S4GrnH8dWlfbj+6SutLBrPvtm4ehTOT/9VJ86ZZryuk9MUI
         3VjiXopqK+nV3D12H2MVQDebRJ048wGn2EjQLGTaAuZk7CDuG+LlHUwy8KjxWJHD86
         WyFQrTf8kwWRA==
From:   Will Deacon <will@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, Chris Healy <cphealy@gmail.com>,
        Chris Healy <healych@amazon.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>
Subject: Re: [PATCH v12 1/3] perf/amlogic: Add support for Amlogic meson G12 SoC DDR PMU driver
Date:   Mon, 21 Nov 2022 19:35:13 +0000
Message-Id: <166905532981.1405312.273554952969305840.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221121021602.3306998-1-jiucheng.xu@amlogic.com>
References: <20221121021602.3306998-1-jiucheng.xu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 10:15:58 +0800, Jiucheng Xu wrote:
> Add support for Amlogic Meson G12 Series SOC - DDR bandwidth PMU driver
> framework and interfaces. The PMU can not only monitor the total DDR
> bandwidth, but also individual IP module bandwidth.
> 
> 

Applied to will (for-next/perf), thanks!

[1/3] perf/amlogic: Add support for Amlogic meson G12 SoC DDR PMU driver
      https://git.kernel.org/will/c/2016e2113d35
[2/3] docs/perf: Add documentation for the Amlogic G12 DDR PMU
      https://git.kernel.org/will/c/537216e59f0c
[3/3] dt-binding: perf: Add Amlogic DDR PMU
      https://git.kernel.org/will/c/fd9678d3beaa

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
