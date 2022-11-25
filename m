Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AAD638B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiKYNZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKYNZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:25:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006F51055D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:25:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 910976240C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7A8C433B5;
        Fri, 25 Nov 2022 13:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669382703;
        bh=hMm0+jvcvpMLAY9/Wb9UOsOHUXhuAviUplimAAu0sP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4A3kcKF8xoICm6UDE1qvQyo5BwxnpQPgNC+eyh7osh9+brSwVhhB9y2gnFt7n0fp
         DhsUerQiEfasvFIPkIiL2IGffllJwAqHjZh9aAWrKoCRYdVgfMJsuvsq1IVqJYoUy+
         oKMBbbbjK/O4rnN7Ik+s539j+E/FvLHZEkpwxxBJtxI4cAx8Gs4QjjE+Jnjpj8W9WA
         4qhEfNOcU64YODF9IbZgHFBxMbVu/OA87zS6MJ354pVDg0IVKIQoGK/PO3dQdp9WUa
         tZWKtWRz///lmW7GU1D32XbVVYQlm3KG/Y88xSWb81X6IkpWZruOYs2HU0Y4DdkVtb
         iXc86H6wbkzmw==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, catalin.marinas@arm.com,
        Ren Zhijie <renzhijie2@huawei.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, yusongping@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: armv8_deprecated: fix unused-function error
Date:   Fri, 25 Nov 2022 13:24:51 +0000
Message-Id: <166937858286.3466279.16963233176044186633.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221124022429.19024-1-renzhijie2@huawei.com>
References: <20221124022429.19024-1-renzhijie2@huawei.com>
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

On Thu, 24 Nov 2022 02:24:29 +0000, Ren Zhijie wrote:
> If CONFIG_SWP_EMULATION is not set and
> CONFIG_CP15_BARRIER_EMULATION is not set,
> aarch64-linux-gnu complained about unused-function :
> 
> arch/arm64/kernel/armv8_deprecated.c:67:21: error: ‘aarch32_check_condition’ defined but not used [-Werror=unused-function]
>  static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
>                      ^~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> [...]

Applied to arm64 (for-next/undef-traps), thanks!

[1/1] arm64: armv8_deprecated: fix unused-function error
      https://git.kernel.org/arm64/c/223d3a0d30b6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
