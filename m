Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A85469F99C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjBVRHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjBVRHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:07:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0FC3B0F5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:07:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A491E6131F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC30AC433D2;
        Wed, 22 Feb 2023 17:07:17 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>,
        Sangmoon Kim <sangmoon.kim@samsung.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: pass ESR_ELx to die() of cfi_handler
Date:   Wed, 22 Feb 2023 17:07:15 +0000
Message-Id: <167708562870.511237.8370507077208413338.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230220073441.2753-1-sangmoon.kim@samsung.com>
References: <CGME20230220073527epcas1p1e901bfa667b8c51551d26478013131e6@epcas1p1.samsung.com> <20230220073441.2753-1-sangmoon.kim@samsung.com>
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

On Mon, 20 Feb 2023 16:34:41 +0900, Sangmoon Kim wrote:
> Commit 0f2cb928a154 ("arm64: consistently pass ESR_ELx to die()") caused
> all callers to pass the ESR_ELx value to die().
> 
> For consistency, this patch also adds esr to die() call of cfi_handler.
> Also, when CFI error occurs, die handlers can use ESR_ELx value.
> 
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: pass ESR_ELx to die() of cfi_handler
      https://git.kernel.org/arm64/c/b61b82f81e09

-- 
Catalin

