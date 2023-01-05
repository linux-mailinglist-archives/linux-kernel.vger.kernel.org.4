Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D48C65F360
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjAESFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbjAESEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:04:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD2C5AC7D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 10:04:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 503C061BE2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 18:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E90CC433F0;
        Thu,  5 Jan 2023 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672941852;
        bh=E3OLHyHgyECy/127K/qEsfQA40BB+zu22j2CI9yuN3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pe0VixV+lqS9wne/zeXki0aneMwy/YsQiXGsnwAiqi4A0Zj7aVYNUmCLMqvbjzRWu
         PF6efDDu55qOwVqYdRXP64RjAD3pPOk6uKXA0msaFgDAKh60qw0ucT1RANl1E2AsHr
         br9OTeQiNqDRwvzdKXDJGvfhSGiXWkqgsJtQqJEGmU9tUgEskTCL3ESFi4IgeS1Pia
         u1djQ3r/eC/fxFQEWyK3sj3Nx2uvcEfK1REDKVuctdQVU/vd/+5eHD61p0GtWLiWun
         o7wVra5rP6NPe6ajgvuJVNtyU81Zyx/zt+S2MFvfHejQ4pnc5TVryV9jVGsvqfT5oV
         /d15tX5WYm9BA==
From:   Will Deacon <will@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/mm: add pud_user_exec() check in pud_user_accessible_page()
Date:   Thu,  5 Jan 2023 18:03:58 +0000
Message-Id: <167293112314.1463291.1068267375917494044.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221122123137.429686-1-liushixin2@huawei.com>
References: <20221122123137.429686-1-liushixin2@huawei.com>
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

On Tue, 22 Nov 2022 20:31:37 +0800, Liu Shixin wrote:
> Add check for the executable case in pud_user_accessible_page() too
> like what we did for pte and pmd.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/mm: add pud_user_exec() check in pud_user_accessible_page()
      https://git.kernel.org/arm64/c/730a11f982e6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
