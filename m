Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268E5729A53
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbjFIMsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjFIMrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:47:41 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DE632733
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:47:40 -0700 (PDT)
Received: from 8bytes.org (p4ff2bfbf.dip0.t-ipconnect.de [79.242.191.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id AD86D224B97;
        Fri,  9 Jun 2023 14:47:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1686314858;
        bh=YjGOnPYrTFPIBGBxwiHuHXw9n3uaZhsC76vfavl7xs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clA3Vb++35ioHDrkwWIlWTS+/dcZ/UDPUgvfHMWkHZ5LStS8FfPrzRmtZROK6z3Ws
         og88wDpTGAsZDXF3aeszN56sMi+YMGfkM/r4ZVmhmmXZDUmooGS7ZjoR24QA5Qh3AV
         6K5OVHVjTHV5KLjz7ofumxPL4cKAunZM0a4N1umSAjYftvpJcb6/2avSHOZS89w8I/
         C6dIT26zCErLU4tujCU2svbdbGKOI4ly3Hc7n6IWvszV71/aI/NOaYymN949NO3tmH
         zWsSGBzbgdxRs/FFt/gaoZq4iCad2ZeHy5aqbVuhX4LaTe7MBxtIcA348cV7YJqLu4
         FO3oILGDJoXAw==
Date:   Fri, 9 Jun 2023 14:47:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com,
        boris.ostrovsky@oracle.com, jon.grimm@amd.com,
        santosh.shukla@amd.com, vasant.hegde@amd.com,
        kishon.vijayabraham@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/5] iommu/amd: AVIC Interrupt Remapping Improvements
Message-ID: <ZIMfaVIoKlL-t8Sf@8bytes.org>
References: <20230530141137.14376-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530141137.14376-1-suravee.suthikulpanit@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 10:11:32AM -0400, Suravee Suthikulpanit wrote:
> Suravee Suthikulpanit (4):
>   iommu/amd: Remove the unused struct amd_ir_data.ref
>   iommu/amd: Introduce Disable IRTE Caching Support
>   iommu/amd: Do not Invalidate IRT when IRTE caching is disabled
>   iommu/amd: Improving Interrupt Remapping Table Invalidation
> 
>  .../admin-guide/kernel-parameters.txt         |  1 +
>  drivers/iommu/amd/amd_iommu_types.h           |  7 +-
>  drivers/iommu/amd/init.c                      | 38 +++++++-
>  drivers/iommu/amd/iommu.c                     | 97 ++++++++++---------
>  4 files changed, 94 insertions(+), 49 deletions(-)

Applied, thanks.
