Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0B55F7BBD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJGQn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJGQnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:43:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1E08F258
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 09:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEECEB8229E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 16:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D61C433D7;
        Fri,  7 Oct 2022 16:43:41 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Neng Chen <nengchen@linux.alibaba.com>,
        Will Deacon <will@kernel.org>,
        Hongbo Yao <yaohongbo@linux.alibaba.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drivers/perf: ALIBABA_UNCORE_DRW_PMU should depend on ACPI
Date:   Fri,  7 Oct 2022 17:43:39 +0100
Message-Id: <166516099472.3824419.14858681398467671385.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2a4407bb598285660fa5e604e56823ddb12bb0aa.1664285774.git.geert+renesas@glider.be>
References: <2a4407bb598285660fa5e604e56823ddb12bb0aa.1664285774.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 15:37:16 +0200, Geert Uytterhoeven wrote:
> The Alibaba T-Head Yitian 710 DDR Sub-system Driveway PMU driver relies
> solely on ACPI for matching.  Hence add a dependency on ACPI, to prevent
> asking the user about this driver when configuring a kernel without ACPI
> support.
> 
> 

Applied to arm64 (for-next/core), thanks!

[1/1] drivers/perf: ALIBABA_UNCORE_DRW_PMU should depend on ACPI
      https://git.kernel.org/arm64/c/e08d07dd9f80

-- 
Catalin

