Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084D46E25FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjDNOmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjDNOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:42:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E140C144
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ABE0643D9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5A8C433EF;
        Fri, 14 Apr 2023 14:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681483294;
        bh=rJzCROYUrVNKZPW1baUFYoh3TmF9NILst0eFGNQTQ9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCJECLEnvwvN9AwufKSW1noktWGvbknphh4ZISEnW6p7dlCFQbVl5dG8WKE/yy7Vv
         mlKofDKvx8aCzM6ppASB/NkQyh1q/3d//mzMCmJBr4Bso2QW2RqNHN2hSDyMjk1hDf
         AMZHpCMuqhaC1znqyGM6kleZNT6RhbfMOsIidvT1uCB1nAM38rnZEcZ7kKX6ToCDYK
         TYwv/aRLu8XW0Rj/KG8tB7sd3q45dUczgw7d1hDuHsAouuXSNi5n5664J72W58M9MG
         ezVm1qIPEpeYhMksMnGJK9r84LQFdRGdDtWpqHvjsHUkfhZfBH3BJ3DrPDH5qPxMWr
         fpMQuDwuQpbwA==
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ilkka@os.amperecomputing.com
Subject: Re: [PATCH v2] perf/arm-cmn: Fix port detection for CMN-700
Date:   Fri, 14 Apr 2023 15:38:38 +0100
Message-Id: <168147630105.2392292.8274353847304643416.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <71d129241d4d7923cde72a0e5b4c8d2f6084525f.1681295193.git.robin.murphy@arm.com>
References: <71d129241d4d7923cde72a0e5b4c8d2f6084525f.1681295193.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 11:29:40 +0100, Robin Murphy wrote:
> When the "extra device ports" configuration was first added, the
> additional mxp_device_port_connect_info registers were added around the
> existing mxp_mesh_port_connect_info registers. What I missed about
> CMN-700 is that it shuffled them around to remove this discontinuity.
> As such, tweak the definitions and factor out a helper for reading these
> registers so we can deal with this discrepancy easily, which does at
> least allow nicely tidying up the callsites. With this we can then also
> do the nice thing and skip accesses completely rather than relying on
> RES0 behaviour where we know the extra registers aren't defined.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Fix port detection for CMN-700
      https://git.kernel.org/will/c/2ad91e44e6b0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
