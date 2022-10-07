Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D165F7BBF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJGQoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiJGQoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:44:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D728F24F;
        Fri,  7 Oct 2022 09:44:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B688B82407;
        Fri,  7 Oct 2022 16:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5486CC433B5;
        Fri,  7 Oct 2022 16:43:59 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Neng Chen <nengchen@linux.alibaba.com>,
        Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Hongbo Yao <yaohongbo@linux.alibaba.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: rectify file entry in ALIBABA PMU DRIVER
Date:   Fri,  7 Oct 2022 17:43:57 +0100
Message-Id: <166516099472.3824419.3049640317096051284.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220929122937.20132-1-lukas.bulwahn@gmail.com>
References: <20220929122937.20132-1-lukas.bulwahn@gmail.com>
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

On Thu, 29 Sep 2022 14:29:37 +0200, Lukas Bulwahn wrote:
> Commit cf7b61073e45 ("drivers/perf: add DDR Sub-System Driveway PMU driver
> for Yitian 710 SoC") adds the DDR Sub-System Driveway PMU driver here:
> 
>   drivers/perf/alibaba_uncore_drw_pmu.c
> 
> The file entry in MAINTAINERS for the ALIBABA PMU DRIVER, introduced with
> commit d813a19e7d2e ("MAINTAINERS: add maintainers for Alibaba' T-Head PMU
> driver"), however refers to:
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] MAINTAINERS: rectify file entry in ALIBABA PMU DRIVER
      https://git.kernel.org/arm64/c/5f4853e81094

-- 
Catalin

