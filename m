Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687E5667DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbjALSTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbjALSSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:18:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D27BA2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:49:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2343A620DE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 17:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7475FC433D2;
        Thu, 12 Jan 2023 17:49:13 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: make ARCH_FORCE_MAX_ORDER selectable
Date:   Thu, 12 Jan 2023 17:49:11 +0000
Message-Id: <167354574775.3644043.16920899642629074830.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230104130000.69806-1-wangkefeng.wang@huawei.com>
References: <20230104130000.69806-1-wangkefeng.wang@huawei.com>
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

On Wed, 04 Jan 2023 21:00:00 +0800, Kefeng Wang wrote:
> The other architectures with ARCH_FORCE_MAX_ORDER are selectable,
> but not for ARM64, this is to make it selectable on ARM64, which
> is useful for user that need to allocate more than 4MB of physically
> contiguous memory with 4K pagesize, also more bigger on 16K pagesize
> too, the max value of MAX_ORDER is calculated bellow,
> 
> see include/linux/mmzone.h,
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: make ARCH_FORCE_MAX_ORDER selectable
      https://git.kernel.org/arm64/c/5a4c2a314083

-- 
Catalin

