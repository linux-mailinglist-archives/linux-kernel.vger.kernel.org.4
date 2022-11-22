Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36BF6337EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiKVJHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiKVJHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:07:00 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FBD5E0B9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:06:59 -0800 (PST)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 4444E2A00C3;
        Tue, 22 Nov 2022 10:06:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1669108018;
        bh=YMzGWhPNHQSsEJrQRHTYm0kZQxVf9iVfWhpNy5I0aes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RI5lX9gu2h4vtZuRY7i78sVI3FQHuZGk4hHBg1ignvAqgLZFAgVt7TG98/CEHTsCq
         WqjfNIicE8F0ZT0KNm0Wqs66x5hXHrsVzr/kzJt8+4bl0o2hWa0AJAQ/Rs7aQZUkNY
         JAvxcRTTuJDlovD2b98Fzcga8xmzQMVEZ6N5jNsPcG9zH9AWj9Ssm3MDGed1G3dteX
         n844OcgA9SwITw2SRFhkaxqV9LMpS2ORa2ZfvPcwntOgp/9iZMwE4OPtLiqqzBd111
         uQsyTAMtwXWTf56FH1b6oPHSRrVlOh93l/PgR3aW1W4uie9jm1jzhtomo0rnRY5d8V
         Gpoq2lp2CeZiQ==
Date:   Tue, 22 Nov 2022 10:06:57 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] [PULL REQUEST] Intel IOMMU updates for Linux v6.2
Message-ID: <Y3yRMXGPcYbXH9uL@8bytes.org>
References: <20221122002949.148140-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122002949.148140-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Tue, Nov 22, 2022 at 08:29:42AM +0800, Lu Baolu wrote:
> Lu Baolu (7):
>   iommu/vt-d: Allocate pasid table in device probe path
>   iommu/vt-d: Add device_block_translation() helper
>   iommu/vt-d: Add blocking domain support
>   iommu/vt-d: Rename iommu_disable_dev_iotlb()
>   iommu/vt-d: Rename domain_add_dev_info()
>   iommu/vt-d: Remove unnecessary domain_context_mapped()
>   iommu/vt-d: Use real field for indication of first level

Applied the first 6 patches. The last one has conflicts and doesn't
apply on top of my x86/vt-d branch. Could you please have a look please?

Thanks,

	Joerg
