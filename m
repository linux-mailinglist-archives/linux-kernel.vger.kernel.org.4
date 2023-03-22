Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC4E6C4C80
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCVNzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCVNzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:55:05 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B70B92CFF9;
        Wed, 22 Mar 2023 06:55:02 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 89FB6242DBF;
        Wed, 22 Mar 2023 14:55:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1679493301;
        bh=1eQlaoYG4ol+rgIXVofrvo79LHCnB/WFMCikWJJn0Eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=5FqEMTFL72tm98VVUyK0rPRv7dMEwPrqnzMh3HXYKyYp8UMQbeGVCbVMHi7L6f8cq
         wzmvW6Qg33vlc5mBxh4C06Z/kvfZKOa7Y7ChE67Sb3Hwc74Ao0Ucdij+OIo7PwsXTz
         AwITCo3rYI7GmfMhnUSYx9m9+D6BpIwfKYxKCnPtemccwwoUF3gkszwiKnBoNe9evZ
         +LgO0un/wQd1epGfV8jsrD2P1V5l7QOx4BIeD3+DikGQU+O6uBVuwyjmDpK4QtQP/N
         5YWP6OdOIq9tJbHkAEv8t5+i5TQD/9f4wsD+02Xl1q5sc4e472EfhwingHJRHHUH1k
         j/MydLsqmxkmw==
Date:   Wed, 22 Mar 2023 14:55:00 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Use of_property_present() for testing DT property
 presence
Message-ID: <ZBsItPDXGIWfPGNp@8bytes.org>
References: <20230310144709.1542910-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144709.1542910-1-robh@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:47:09AM -0600, Rob Herring wrote:
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
>  drivers/iommu/ipmmu-vmsa.c            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
