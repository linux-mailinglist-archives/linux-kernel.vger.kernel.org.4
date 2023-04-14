Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98336E25ED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjDNOjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjDNOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:38:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD380B478
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:38:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 578E06430D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C235C433EF;
        Fri, 14 Apr 2023 14:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681483125;
        bh=/OovAPZ9HIMjwufITzr8jJDA6XTyga9ZcjI4Tvgv5tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivmij2YWTLho1n5to1n1Ac+REKdJfp7tdqUDuNnZxrUws2XRq0W6CHAHI0h72MjAx
         YapnlLuw6ec3+tp45Z5FxXvxSH79g4VUjcaEmAO5O3LeHvZhDTtiTrdXWG8jgw5IC+
         YM/PV2j5QhstJXkBnK8PTNl//CPkiiTrZv3FrnSIxKFuM0eq85W9ENG1pi8oC+nY7G
         O0bijNLYHT7aXMckjOoBCFoTmm6FWCkDlBrjYahua9c7Qwk9DdymcVxvp1ZWGKUMwR
         9CtGcpmMnS48Gxt4bHPb6/PgCv2vSx0FkrdOPvVET0h3HzezJAhEMnWQF2ds5oieGF
         lAtqekjWAcVsw==
From:   Will Deacon <will@kernel.org>
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: kernel: Fix kernel warning when nokaslr is passed to commandline
Date:   Fri, 14 Apr 2023 15:38:37 +0100
Message-Id: <168147912496.2462123.4140971249497607315.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230412043258.397455-1-quic_pkondeti@quicinc.com>
References: <20230412043258.397455-1-quic_pkondeti@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 10:02:58 +0530, Pavankumar Kondeti wrote:
> 'Unknown kernel command line parameters "nokaslr", will be passed to
> user space' message is noticed in the dmesg when nokaslr is passed to
> the kernel commandline on ARM64 platform. This is because nokaslr param
> is handled by early cpufeature detection infrastructure and the parameter
> is never consumed by a kernel param handler. Fix this warning by
> providing a dummy kernel param handler for nokaslr.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: kernel: Fix kernel warning when nokaslr is passed to commandline
      https://git.kernel.org/arm64/c/a2a83eb40fbd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
