Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4D7729807
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbjFILR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239421AbjFILRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:17:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4502712
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:17:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC340618A9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42410C433D2;
        Fri,  9 Jun 2023 11:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686309420;
        bh=P3b6JYjQz4nC1aEL+8mq2f9O/N/1/2O0WqmS4JhckYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9Zg3Shah5/sULkNczeZUQdS/U/+OdAIw0sTrdW9ZZBBJMD+DU+lmnt53suLkwlu6
         uYLdU0yXRgtu6v7f4CRfVQMeylR/mQfLIjvrnys5lz75uGGa4jzAZpYF9Lcp6JHT+K
         ij5rHa/E5Kh8BpX3FqHbaQBmz0KRWBocpqUawn/hpw34S0qRb1u14r9kNmafhtEnXD
         u1GAPsEZx2q9UcD7opCr/Ejfq0CP1bkBVp//Sc5ndeKjYilw57WvK4XabEVuSSNw43
         MjFrRHBDuWFfG4IvF6DJHXa3W2dteNIO3OY5umC7wCL6RTmRJjyUZvcRpkCWjg9Wew
         pb2R/bq1jIQWA==
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bwicaksono@nvidia.com, ilkka@os.amperecomputing.com,
        suzuki.poulose@arm.com
Subject: Re: [PATCH v2 0/4] perf/arm_cspmu: Fixes and cleanups
Date:   Fri,  9 Jun 2023 12:16:47 +0100
Message-Id: <168630640845.3062687.2554490206521840847.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1685983270.git.robin.murphy@arm.com>
References: <cover.1685983270.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2023 18:01:30 +0100, Robin Murphy wrote:
> v1: https://lore.kernel.org/linux-arm-kernel/cover.1685619571.git.robin.murphy@arm.com/
> 
> Quick update fixing the issues in patch #4 pointed out by Ilkka.
> 
> Thanks,
> Robin.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/4] perf/arm_cspmu: Fix event attribute type
      https://git.kernel.org/will/c/71e0cb32d5fc
[2/4] ACPI/APMT: Don't register invalid resource
      https://git.kernel.org/will/c/87b3b6d53efc
[3/4] perf/arm_cspmu: Clean up ACPI dependency
      https://git.kernel.org/will/c/f9bd34e3753e
[4/4] perf/arm_cspmu: Decouple APMT dependency
      https://git.kernel.org/will/c/d2e3bb512818

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
