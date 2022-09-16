Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10235BB1BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiIPRrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiIPRrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:47:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDD099B54
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEBEFB828C1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 17:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F2CC433D6;
        Fri, 16 Sep 2022 17:47:00 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH Resend] arm64: support huge vmalloc mappings
Date:   Fri, 16 Sep 2022 18:46:57 +0100
Message-Id: <166335041341.1745039.7832892375837792133.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220911044423.139229-1-wangkefeng.wang@huawei.com>
References: <Yxt6HbbWEqnteYHb@arm.com> <20220911044423.139229-1-wangkefeng.wang@huawei.com>
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

On Sun, 11 Sep 2022 12:44:23 +0800, Kefeng Wang wrote:
> As commit 559089e0a93d ("vmalloc: replace VM_NO_HUGE_VMAP with
> VM_ALLOW_HUGE_VMAP"), the use of hugepage mappings for vmalloc
> is an opt-in strategy, so it is saftly to support huge vmalloc
> mappings on arm64, for now, it is used in kvmalloc() and
> alloc_large_system_hash().
> 
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: support huge vmalloc mappings
      https://git.kernel.org/arm64/c/e92072237e6c

-- 
Catalin

