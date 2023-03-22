Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717C46C4C93
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCVN5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjCVN5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:57:19 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3835762D9E;
        Wed, 22 Mar 2023 06:57:04 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 7AFD1242DBF;
        Wed, 22 Mar 2023 14:57:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1679493423;
        bh=Vb7ZiH4WrN7nhEeTSahG6w9edkD1EeU/gIytgAeWVhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=4Hy+KMJi4Hl2Ru7ECCjW6gi1yvgI+xcG+63qnEtGf9WM2O8KfR6U5rBQp3VZiNA8C
         krRfqLUzb1wjK87VLlz6A4E5y/JCvKEbjIo1FWrtQPruM4nryxDHwCQ0TjIVad5rRK
         L5cmUZ4DobCWlE8VOOAyEluQqvFhtjmHtrHzY2pc3owkYZFW8cy8mgL8Q+uiIe/dha
         +N2qd6nztykd8S6BiM+q5MTJnmexTS21+sS2w0M7f50F8MTMJCWJF1zlHF0ms3zMwp
         xrIxc5dgKBHeGJ/SYUxZMXzVJZ7Jxv3sOY2a7KFeIuGR/65ACmprBLdOoUIgItwYmI
         B+K54ABssbSHg==
Date:   Wed, 22 Mar 2023 14:57:02 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: omap: Use of_property_read_bool() for boolean
 properties
Message-ID: <ZBsJLkRjBsaVG/64@8bytes.org>
References: <20230310144709.1542980-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144709.1542980-1-robh@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:47:09AM -0600, Rob Herring wrote:
>  drivers/iommu/omap-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied with minor style fixes in the commit message.
