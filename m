Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A20A6D9CBF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbjDFPwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239269AbjDFPwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:52:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B0593EF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:52:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED607649B4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38C9C433D2;
        Thu,  6 Apr 2023 15:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680796328;
        bh=itjRrPUnDLptTgKtwsB/VQxf8oaTux6pNX6hwyv2EBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKbmkicE3z3ODudPsYwp2nShnp9UnisWHum6Iq4po8rfguoppnJZxvxl3sIyKpwWD
         wAld0A4Mi2FwbQU2scz7rs0rR5+Xnw/rEhwP6FCoC4auB5t+P+csOBePm+c86l/1Xc
         4BjrEeNkeL5+FVT0j9KC7Mk+O3/rgdgvu2c8zFiljgyS1D1ngw6kV2uM8+EaezMtwE
         UbPbsxXboeGQlpk/e76QQgKq2hJ30Ru9ENdl0Zuju6oJKxuZhZn6qfKXojVYC+tJrX
         dFd0tg7flwNoe9n80vwCSKPeWdOxG68TZzWkOvaXKrWe94jCF/kWuuspKI9nA9YOOC
         ZbIr9iTv2cA8g==
From:   Will Deacon <will@kernel.org>
To:     tomas.krcka@gmail.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Tomas Krcka <krckatom@amazon.de>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Acknowledge pri/event queue overflow if any
Date:   Thu,  6 Apr 2023 16:51:52 +0100
Message-Id: <168018870548.1679607.17364698825564495778.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230329123420.34641-1-tomas.krcka@gmail.com>
References: <20230329123420.34641-1-tomas.krcka@gmail.com>
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

On Wed, 29 Mar 2023 12:34:19 +0000, tomas.krcka@gmail.com wrote:
> From: Tomas Krcka <krckatom@amazon.de>
> 
> When an overflow occurs in the PRI queue, the SMMU toggles the overflow
> flag in the PROD register. To exit the overflow condition, the PRI thread
> is supposed to acknowledge it by toggling this flag in the CONS register.
> Unacknowledged overflow causes the queue to stop adding anything new.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Acknowledge pri/event queue overflow if any
      https://git.kernel.org/will/c/67ea0b7ce418

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
