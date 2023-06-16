Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9258F732FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345350AbjFPLYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345635AbjFPLXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:23:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79A1211D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:23:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8000863708
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5219C433C8;
        Fri, 16 Jun 2023 11:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686914628;
        bh=9mbdAY+pYyxzQAPkE54jwPqprJ5nf6dSMexK8Noi6gA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TCl8VCXPgtRSOF8f8W3Bd8W2ZYbAAxgZgwUbbcsn8Px/hOA0tPUwyPIS+8h8anLWQ
         tuI1O6QR6dvmWKSbSao3WwdkImIhW6Pbc2XqfGxNl/SNvRm+kdjgPVIM1AevIRx+SV
         81B7TMEwCSWLznnGNHHOZM3Lup3jXv7yrKv/xb7Z4xnNWIbJR/m63y2CbsqI0nvJQ+
         ITa0ZlhsPm4UpRSMRcgzt3qkSRBA6Skg20J2/6J+fMOIhNexZiltgTTTTQPBMuT7uR
         4adM6xwupFNZKiaKIUz+e6bHRFXCzZBvqhYrMnTX8opqHGtCmYCmySEmS3bvhS2Z7q
         fJYyLOi7Z0xFA==
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        renyu.zj@linux.alibaba.com, john.g.garry@oracle.com,
        ilkka@os.amperecomputing.com
Subject: Re: [PATCH 0/2] perf/arm-cmn: Identifier support
Date:   Fri, 16 Jun 2023 12:23:39 +0100
Message-Id: <168690770231.3931852.3889863487920462263.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1686588640.git.robin.murphy@arm.com>
References: <cover.1686588640.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 18:16:31 +0100, Robin Murphy wrote:
> Following on from the disussion on Jing's proposal[1], I've had
> confirmation that we do actually have a reliable hardware identifier,
> so this mini-series does a bit of refactoring to wire that up and then
> expose a sysfs identifier based on it.
> 
> Thanks,
> Robin.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] perf/arm-cmn: Revamp model detection
      https://git.kernel.org/will/c/7819e05a0dce
[2/2] perf/arm-cmn: Add sysfs identifier
      https://git.kernel.org/will/c/a1c45d3ebd30

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
