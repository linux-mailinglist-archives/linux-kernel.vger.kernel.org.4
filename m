Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D8D6D9CBA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbjDFPwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239210AbjDFPwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:52:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEE2A5DA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:52:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 170DF649A9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5F1C433AA;
        Thu,  6 Apr 2023 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680796323;
        bh=ERS1YpeepvOufPE8Rdz1Grvp76972MyDOg7BR8UNQH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5sKgSdESXxXeIfaXRdTQ7WKSN4j4U9lF3eo8SCMvGLIkWaSyDc03Ae5wYPHRT7lL
         pHbjw8j7EsEmcVUM0XSJX3TpUtBsmt3i4r4B6kpTLictPJQjoMvX3n8cj2McKPBz4g
         lPa16cp/kHoDHoL1CjYtOQAM5WR7qc9/lbiqfB5q3+9Ir0vKQSHzsY0nRYpaFhX7Dj
         QsRoefiwYtCkPmGXzWXZEM5OfbE/3qkyWqbYN2Mfv0fpgp5YeVXw1ZPOQOSoQ50lIS
         t/lV66sjwdK6eAycGY/Osxj9YGQFNjBu2dBvBslLsIWuGUZzdan5+8SVCMNABNN3FG
         Dehl3jR8umgNg==
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Validate cycles events fully
Date:   Thu,  6 Apr 2023 16:51:50 +0100
Message-Id: <168079367146.1637504.4760001819973823388.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <3124e8c276a1f513c1a415dc839ca4181b3c8bc8.1680522545.git.robin.murphy@arm.com>
References: <3124e8c276a1f513c1a415dc839ca4181b3c8bc8.1680522545.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 12:49:05 +0100, Robin Murphy wrote:
> DTC cycle count events don't have anything to validate or initialise in
> themselves, but we should not forget to still validate their whole group
> context. Otherwise, we may fail to correctly reject a contrived group
> containing an impossible number of cycles events.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Validate cycles events fully
      https://git.kernel.org/will/c/23b2fd839489

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
