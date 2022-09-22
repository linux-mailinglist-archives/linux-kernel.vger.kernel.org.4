Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80A75E6C99
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiIVUC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiIVUCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:02:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D862EF1C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:01:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD83B614B7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 20:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BECC433C1;
        Thu, 22 Sep 2022 20:01:53 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: handle ARM64_KERNEL_USES_PMD_MAPS in vmemmap_populate()
Date:   Thu, 22 Sep 2022 21:01:46 +0100
Message-Id: <166387689171.428844.8846017248785700372.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920014951.196191-1-wangkefeng.wang@huawei.com>
References: <20220920014951.196191-1-wangkefeng.wang@huawei.com>
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

On Tue, 20 Sep 2022 09:49:51 +0800, Kefeng Wang wrote:
> Directly check ARM64_SWAPPER_USES_SECTION_MAPS to choose base page
> or PMD level huge page mapping in vmemmap_populate() to simplify
> code a bit.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: mm: handle ARM64_KERNEL_USES_PMD_MAPS in vmemmap_populate()
      https://git.kernel.org/arm64/c/739e49e0fc80

-- 
Catalin

