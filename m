Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454A4729808
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjFILR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239400AbjFILRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:17:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D4426B3;
        Fri,  9 Jun 2023 04:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ADF065712;
        Fri,  9 Jun 2023 11:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90929C433EF;
        Fri,  9 Jun 2023 11:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686309417;
        bh=3hd1JDPuI7bTY5CKFMrp7RkYwZ6E30tdRT7wveSmnFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S37qQljKl/1n2bd6Cl97CKM7Aqn7McvVZfhsKLudP3IMNKcn+JFFX+M3RHrAGP0sQ
         y5oihn+U/MOfBNqBoSCmwirZ67a2IIW/N9t2WnC8E8S+wVEHH4uLraXRvrfzaFJr1o
         FYHxKihd34DX+yCtD7MUpf28+qFOOQv9fvVXHE48qx3oi6n3xlx5mRIDwnL4CY3FQo
         j6r9v53si3r1C9zmp7K9lwjGAF+ZgRZtJFrptfYq75xO98rNGlRA3s9MGahf+Mx3mn
         ezaSGGo3VZbWO2EbvwiG9FOvp7akbbeBhvAAAJ6uvZuTr+naERe4p9ywBDvJ5ufrQw
         lZtVtcGuHQ4VQ==
From:   Will Deacon <will@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_cspmu: Set irq affinitiy only if overflow interrupt is used
Date:   Fri,  9 Jun 2023 12:16:46 +0100
Message-Id: <168630635691.3062491.1731872740448219149.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230608203742.3503486-1-ilkka@os.amperecomputing.com>
References: <20230608203742.3503486-1-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 13:37:42 -0700, Ilkka Koskinen wrote:
> Don't try to set irq affinity if PMU doesn't have an overflow interrupt.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf: arm_cspmu: Set irq affinitiy only if overflow interrupt is used
      https://git.kernel.org/will/c/225d757012e0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
