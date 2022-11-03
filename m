Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1322B617E4E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiKCNqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiKCNp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:45:58 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E1A92629
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:45:57 -0700 (PDT)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 37959260071;
        Thu,  3 Nov 2022 14:45:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1667483155;
        bh=Iaiwo7D9Rrw+sA+ig2mBhOxAtfQms7zTRxU6Y1I83wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZIZarNibES9GXaW2YPZMWbtBZX38/M2lt66BfCckVxHK0D/MRIWKwqgSPtXfrcyZ
         uqBz6uZxR9RfhM6h45WAznECc6bGef64KgCS50GwUWE4c0cFsfLjcCByMzZpkMCbtB
         kFyyOoTlN6r4hYnzJ+4Vl9fQ9nfi9xNnKjRiMzIhuXlHufmnWxhJYwEkSa5mCq7fHV
         Im32yC+2FFPuVqa8tTCYAyNzSHSY3WBzqRt9yUPHd7JcLu8DTu1ccGYa9oR3sO8GWU
         QxO3dCJhKOT18+CuJ98cJj/LA8M7C0U4OUaO68W5XHtBmeovEvG/tNSZ/T+SkSOtB6
         WQEkLz97G1lWA==
Date:   Thu, 3 Nov 2022 14:45:53 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH] iommu: fsl_pamu: Replace NO_IRQ by 0
Message-ID: <Y2PGEbh9zFtRqrPP@8bytes.org>
References: <2a2570a8d12c80a7d36837b6c586daa708ca09d7.1665033732.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a2570a8d12c80a7d36837b6c586daa708ca09d7.1665033732.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 07:24:03AM +0200, Christophe Leroy wrote:
>  drivers/iommu/fsl_pamu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
