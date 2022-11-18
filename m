Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1642262FE23
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241896AbiKRTmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241915AbiKRTlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:41:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E1691C18;
        Fri, 18 Nov 2022 11:41:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ED1F62769;
        Fri, 18 Nov 2022 19:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE23C43140;
        Fri, 18 Nov 2022 19:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668800479;
        bh=+3EX58SiFaImStqvJ4r/d4PsMH6/0v2Cwfofas6RK3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P4WpzHo8y+JQNfimsmgcCDI07q4Ve15Hri1lw0PWWcMut4ZlaL0DQe28Pk/+zv3tC
         NF8djW/LcCjP8mGau2x1Vx7yEdLL/ZyaeNm3XRCmvNok3b3M66YTYovuoK8uJVkvEG
         9dX+xSYdhMMQ7PdibUHMtNxcG74Y6YQTONHQu6/+3QLWmcxgs0FBFH28Cn4TaGWBnq
         rfRIx601XTi/u+nYXoV9R+ShLqvfF2idEqBtBvGXNcREgnlPT//tQeCla31uwdh34Y
         T+lcgj94LMP/nznWgI/0HgpqC4rmIkF7gEA3U+JF1zOCymM6l5Llx6p6rSLxHAPVp2
         vum3etFRxpsww==
From:   Will Deacon <will@kernel.org>
To:     kexec@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 0/2] arm64: kdump: Function supplement and performance optimization
Date:   Fri, 18 Nov 2022 19:40:48 +0000
Message-Id: <166878087548.1783067.11242325570720961559.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221116121044.1690-1-thunder.leizhen@huawei.com>
References: <20221116121044.1690-1-thunder.leizhen@huawei.com>
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

On Wed, 16 Nov 2022 20:10:42 +0800, Zhen Lei wrote:
> v3 --> v4:
> 1. Set DEFAULT_CRASH_KERNEL_LOW_SIZE to a fixed 128M.
> 2. Some lightweight code adjustments based on Catalin Marinas's comments
> 
> v2 --> v3:
> 1. Discard patch 3 in v2, a cleanup patch.
> 
> [...]

Applied to arm64 (for-next/kdump), thanks!

[1/2] arm64: kdump: Provide default size when crashkernel=Y,low is not specified
      https://git.kernel.org/arm64/c/a149cf00b158
[2/2] arm64: kdump: Support crashkernel=X fall back to reserve region above DMA zones
      https://git.kernel.org/arm64/c/a9ae89df7377

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
