Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474CF6DE408
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjDKShi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDKShf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:37:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A219C4C31
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:37:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D22C62AE3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 18:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C93CC4339B;
        Tue, 11 Apr 2023 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681238253;
        bh=cuJkj0gXqgGwRRDX0gNvDxHkCZkNFXT4t3hB/stfPCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1G6irrGVfNL90UxP1t0WrtEGZbgdV+tWzqng1wAWqO0r59xZNWHtnkgg539fvGJO
         AEmKO/XJozgjgp2q+A1QEl2Fogn3TIDKbG4tXz2isL3QUqAmJ9ToB8WgVQj4bjAHMG
         3u1tRSXi1eJ1rIKkWJPte0lE3qR6UYdqLA3Mg93nP2L7MKuya9F65woEpAgUroQad0
         4FbSH/5mNEUjtB0t2+MiEz8/rrD/MoHzOeJESDEjIIX1H6CX5oroADhwBdRgs5cBsO
         o5nJYMoaRX4qLVzr7WpX+cZNvQTuzbxZmulZvuy/1Ay6tInt8IDA8rMmMFy636Lcrf
         nq9wDX5YH3Sdw==
From:   Will Deacon <will@kernel.org>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, thunder.leizhen@huawei.com,
        horms@kernel.org, John.p.donnelly@oracle.com,
        linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        rppt@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v2 0/3] arm64: kdump : take off the protection on crashkernel memory region
Date:   Tue, 11 Apr 2023 19:37:24 +0100
Message-Id: <168123748697.3041682.15156562269597498270.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230407011507.17572-1-bhe@redhat.com>
References: <20230407011507.17572-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023 09:15:04 +0800, Baoquan He wrote:
> Problem:
> =======
> On arm64, block and section mapping is supported to build page tables.
> However, currently it enforces to take base page mapping for the whole
> linear mapping if CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled and
> crashkernel kernel parameter is set. This will cause longer time of the
> linear mapping process during bootup and severe performance degradation
> during running time.
> 
> [...]

Applied to arm64 (for-next/kdump), thanks!

[1/3] arm64: kdump : take off the protection on crashkernel memory region
      https://git.kernel.org/arm64/c/0d124e96051b
[2/3] arm64: kdump: do not map crashkernel region specifically
      https://git.kernel.org/arm64/c/04a2a7af3d97
[3/3] arm64: kdump: defer the crashkernel reservation for platforms with no DMA memory zones
      https://git.kernel.org/arm64/c/504cae453f82

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
