Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DEE633B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiKVL10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiKVL0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:26:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C99D63CCA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:20:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2448CB8190C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AAEC433D6;
        Tue, 22 Nov 2022 11:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669116005;
        bh=i4J5FHDHK6FCBPcJTTxl/xqJydn58nU4CXF1PjVmZ24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LYxVKte3hIvg7TkmtGRk56llE9V3S2o4MVgEhFlGstyN+bAeP5XMNn07DhhnkmgK4
         PVRQ6K10gXzWsIN+jg7JuENVCCiZ/1AHLnistLhHrQ+Aqw4aa4i1xf1jAyecYY0f/v
         w4uZdfGTCsARRwlXCPNu1PxQT/QTxGHp4jEdo5dDEJI2IWCVXCv5VVHHRRDEu4kRIr
         PEi1/6P1yxOIWenkPXHFYnliXBni6oAhd6uJFPJ7HU3gSc1TBJJBDTbff0J6i+a7zb
         BQhqd5Xu2R/6hErwsy0KCoKMWUOQh+3AHCYQNwh42DQZxGNjazEv+yNAq8SJ/An+Zi
         M9RcaxAZD/qrQ==
From:   Will Deacon <will@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-amlogic@lists.infradead.org,
        Chris Healy <healych@amazon.com>, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf/amlogic: Fix build error for x86_64 allmodconfig
Date:   Tue, 22 Nov 2022 11:19:57 +0000
Message-Id: <166911295884.1006209.12453209108880298807.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221122084028.572494-1-jiucheng.xu@amlogic.com>
References: <20221122084028.572494-1-jiucheng.xu@amlogic.com>
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

On Tue, 22 Nov 2022 16:40:28 +0800, Jiucheng Xu wrote:
> The driver misses including <linux/io.h>. It causes
> compiling error "implicit declaration of function
> 'readl' and 'writel'" when make X86_64 allmodconfig.
> 
> Amlogic meson G12 SoC DDR PMU driver")'
> 
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/amlogic: Fix build error for x86_64 allmodconfig
      https://git.kernel.org/will/c/9d1d5cb32314

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
