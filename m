Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277DE683293
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjAaQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjAaQ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:28:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E6910C6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:28:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D595661484
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06EBC433D2;
        Tue, 31 Jan 2023 16:28:40 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] arm64/mm: Intercept pfn changes in set_pte_at()
Date:   Tue, 31 Jan 2023 16:28:38 +0000
Message-Id: <167518251203.582976.5407379627860091879.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130121457.1607675-1-anshuman.khandual@arm.com>
References: <20230130121457.1607675-1-anshuman.khandual@arm.com>
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

On Mon, 30 Jan 2023 17:44:57 +0530, Anshuman Khandual wrote:
> Changing pfn on a user page table mapped entry, without first going through
> break-before-make (BBM) procedure is unsafe. This just updates set_pte_at()
> to intercept such changes, via an updated pgattr_change_is_safe(). This new
> check happens via __check_racy_pte_update(), which has now been renamed as
> __check_safe_pte_update().
> 
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Intercept pfn changes in set_pte_at()
      https://git.kernel.org/arm64/c/004fc58f917c

-- 
Catalin

