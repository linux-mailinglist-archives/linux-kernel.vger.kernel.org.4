Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDB06CA875
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjC0PCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjC0PBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:01:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA4B4EFB;
        Mon, 27 Mar 2023 08:01:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A717BB8160C;
        Mon, 27 Mar 2023 15:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67041C4339C;
        Mon, 27 Mar 2023 15:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679929302;
        bh=52DnpiK5+wbZheULc1ZM0vQEiyBCXv7N98OEzPalzlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNZwgN/CvBsPyJU/yTtE31oZpvbJOgR6hTQ4oUfRiIgkegXDhIUNn3Om0S6zdm9zk
         IQTM3HdyF9UWqxwJFbbZhRp1E/moCesnopdXWBi6ahYtV68fc68gzfNXxg6O6s0AG0
         BmUVwmAQ0aCf/p5aN+WuchtNwH7oJ8Eyjl7KKXq2RjJ+pjUHksV4B1CpYiNTvxzhiJ
         jJwLBl443WeyXOQP5EjhknhnUNdi2zy1zL7+QpiwOZUrTlGsV9pTuw4xtTWyiVcsBi
         bvnyXWQRVYDZXfhiTuZbRnhj9vnZh2sMlGAoZrMwPN0RqfEnPEaQNC2tNMLsjm8Pkx
         5+ZFBZENPAzYw==
From:   Will Deacon <will@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        mark.rutland@arm.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] perf: qcom: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 27 Mar 2023 16:01:18 +0100
Message-Id: <167992578245.3834259.11608007943578363119.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230315023108.36953-1-yang.lee@linux.alibaba.com>
References: <20230315023108.36953-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 10:31:08 +0800, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf: qcom: Use devm_platform_get_and_ioremap_resource()
      https://git.kernel.org/will/c/8540504c5136

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
