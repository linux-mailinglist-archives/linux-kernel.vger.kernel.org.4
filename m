Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B1B6E4AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjDQOIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjDQOIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:08:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C19ED4C17
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:07:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ACFA1FC7;
        Mon, 17 Apr 2023 07:08:28 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9EB3D3F5A1;
        Mon, 17 Apr 2023 07:07:43 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/3] arch_topology: Pre-allocate cacheinfo from primary CPU
Date:   Mon, 17 Apr 2023 15:07:40 +0100
Message-Id: <168174033569.1898335.12120283777353899091.b4-ty@arm.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412185759.755408-1-rrendec@redhat.com>
References: <20230412185759.755408-1-rrendec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 14:57:56 -0400, Radu Rendec wrote:
> Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> tries to build the cacheinfo from the primary CPU prior to secondary
> CPUs boot, if the DT/ACPI description contains cache information.
> However, if such information is not present, it still reverts to the old
> behavior, which allocates the cacheinfo memory on each secondary CPU. On
> RT kernels, this triggers a "BUG: sleeping function called from invalid
> context" because the allocation is done before preemption is first
> enabled on the secondary CPU.
> 
> [...]

Applied to sudeep.holla/linux (for-next/cacheinfo), thanks!

[1/3] cacheinfo: Add arch specific early level initializer
      https://git.kernel.org/sudeep.holla/c/6539cffa9495
[2/3] cacheinfo: Add arm64 early level initializer implementation
      https://git.kernel.org/sudeep.holla/c/c931680cfa95
[3/3] cacheinfo: Allow early level detection when DT/ACPI info is missing/broken
      https://git.kernel.org/sudeep.holla/c/e103d55465db

--
Regards,
Sudeep

